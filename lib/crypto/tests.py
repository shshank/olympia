# -*- coding: utf-8 -*-
import os
import zipfile

from django.test.utils import override_settings

import pytest

import amo
import amo.tests
from lib.crypto import packaged


def is_signed(filename):
    """Return True if the file has been signed."""
    zf = zipfile.ZipFile(filename, mode='r')
    filenames = zf.namelist()
    return ('META-INF/zigbert.rsa' in filenames and
            'META-INF/zigbert.sf' in filenames and
            'META-INF/manifest.mf' in filenames)


@override_settings(SIGNING_SERVER='http://full',
                   PRELIMINARY_SIGNING_SERVER='http://prelim')
class TestPackaged(amo.tests.TestCase):

    def setUp(self):
        super(TestPackaged, self).setUp()

        # Change addon file name
        self.addon = amo.tests.addon_factory()
        self.addon.update(guid='xxxxx')
        self.version = self.addon.current_version
        self.file1 = self.version.all_files[0]
        self.file1.update(filename='addon-a.xpi')

        self.file2 = amo.tests.file_factory(version=self.version)
        self.file2.update(filename='addon-b.xpi')
        # Update the "all_files" cached property.
        self.version.all_files.append(self.file2)

        # Add actual file to addons
        if not os.path.exists(os.path.dirname(self.file1.file_path)):
            os.makedirs(os.path.dirname(self.file1.file_path))

        for f in (self.file1, self.file2):
            fp = zipfile.ZipFile(f.file_path, 'w')
            fp.writestr('install.rdf', '<?xml version="1.0"?><RDF></RDF>')
            fp.close()

    def tearDown(self):
        for f in (self.file1, self.file2):
            if os.path.exists(f.file_path):
                os.unlink(f.file_path)
        super(TestPackaged, self).tearDown()

    @pytest.fixture(autouse=True)
    def mock_post(self, monkeypatch):
        """Fake a standard trunion response."""
        class FakeResponse:
            status_code = 200
            content = '{"zigbert.rsa": ""}'

        monkeypatch.setattr(
            'requests.post', lambda url, timeout, data, files: FakeResponse)

    @pytest.fixture(autouse=True)
    def mock_get_signature_serial_number(self, monkeypatch):
        """Fake a standard signing-client response."""
        monkeypatch.setattr('lib.crypto.packaged.get_signature_serial_number',
                            lambda pkcs7: 'serial number')

    def test_get_endpoint(self):
        # self.file1 is fully reviewed, self.file2 is preliminary reviewed.
        self.file2.update(status=amo.STATUS_LITE)
        with self.settings(PRELIMINARY_SIGNING_SERVER=''):
            assert packaged.get_endpoint(self.file1)
            assert not packaged.get_endpoint(self.file2)
        with self.settings(SIGNING_SERVER=''):
            assert not packaged.get_endpoint(self.file1)
            assert packaged.get_endpoint(self.file2)

    def test_no_file(self):
        [f.delete() for f in self.addon.current_version.all_files]
        with pytest.raises(packaged.SigningError):
            packaged.sign(self.version)

    def test_non_xpi(self):
        self.file1.update(filename='foo.txt')
        with pytest.raises(packaged.SigningError):
            packaged.sign_file(self.file1)

    def test_no_server_full(self):
        with self.settings(SIGNING_SERVER=''):
            packaged.sign(self.version)
        # Make sure the files weren't signed.
        assert not is_signed(self.file1.file_path)
        assert not is_signed(self.file2.file_path)
        assert not self.file1.cert_serial_num
        assert not self.file2.cert_serial_num

    def test_no_server_prelim(self):
        self.file1.update(status=amo.STATUS_LITE)
        self.file2.update(status=amo.STATUS_LITE)
        with self.settings(PRELIMINARY_SIGNING_SERVER=''):
            packaged.sign(self.version)
        # Make sure the files weren't signed.
        assert not is_signed(self.file1.file_path)
        assert not is_signed(self.file2.file_path)
        assert not self.file1.cert_serial_num
        assert not self.file2.cert_serial_num

    def test_sign_file(self):
        packaged.sign(self.version)
        assert is_signed(self.file1.file_path)
        assert is_signed(self.file2.file_path)
        assert self.file1.cert_serial_num
        assert self.file2.cert_serial_num
