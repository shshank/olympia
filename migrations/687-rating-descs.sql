CREATE TABLE `webapps_rating_descriptors` (
    `id` int(11) unsigned AUTO_INCREMENT NOT NULL PRIMARY KEY,
    `created` datetime NOT NULL,
    `modified` datetime NOT NULL,
    `addon_id` int(11) unsigned NOT NULL UNIQUE,
    `has_usk_no_descs` bool NOT NULL,
    `has_usk_scary` bool NOT NULL,
    `has_usk_sex_content` bool NOT NULL,
    `has_usk_lang` bool NOT NULL,
    `has_usk_discrimination` bool NOT NULL,
    `has_usk_drugs` bool NOT NULL,
    `has_usk_violence` bool NOT NULL,
    `has_esrb_alcohol` bool NOT NULL,
    `has_esrb_blood` bool NOT NULL,
    `has_esrb_blood_gore` bool NOT NULL,
    `has_esrb_crude_humor` bool NOT NULL,
    `has_esrb_drug_ref` bool NOT NULL,
    `has_esrb_fantasy_violence` bool NOT NULL,
    `has_esrb_intense_violence` bool NOT NULL,
    `has_esrb_lang` bool NOT NULL,
    `has_esrb_mild_blood` bool NOT NULL,
    `has_esrb_mild_fantasy_violence` bool NOT NULL,
    `has_esrb_mild_lang` bool NOT NULL,
    `has_esrb_mild_violence` bool NOT NULL,
    `has_esrb_nudity` bool NOT NULL,
    `has_esrb_partial_nudity` bool NOT NULL,
    `has_esrb_real_gambling` bool NOT NULL,
    `has_esrb_sex_content` bool NOT NULL,
    `has_esrb_sex_themes` bool NOT NULL,
    `has_esrb_sim_gambling` bool NOT NULL,
    `has_esrb_strong_lang` bool NOT NULL,
    `has_esrb_strong_sex_content` bool NOT NULL,
    `has_esrb_suggestive` bool NOT NULL,
    `has_esrb_tobacco_ref` bool NOT NULL,
    `has_esrb_alcohol_use` bool NOT NULL,
    `has_esrb_drug_use` bool NOT NULL,
    `has_esrb_tobacco_use` bool NOT NULL,
    `has_esrb_violence` bool NOT NULL,
    `has_esrb_violence_ref` bool NOT NULL,
    `has_esrb_no_descs` bool NOT NULL,
    `has_esrb_comic_mischief` bool NOT NULL,
    `has_esrb_alcohol_tobacco_ref` bool NOT NULL,
    `has_esrb_drug_alcohol_ref` bool NOT NULL,
    `has_esrb_alcohol_tobacco_use` bool NOT NULL,
    `has_esrb_drug_alcohol_use` bool NOT NULL,
    `has_esrb_drug_tobacco_ref` bool NOT NULL,
    `has_esrb_drug_alcohol_tobacco_ref` bool NOT NULL,
    `has_esrb_drug_tobacco_use` bool NOT NULL,
    `has_esrb_drug_alcohol_tobacco_use` bool NOT NULL,
    `has_esrb_scary` bool NOT NULL,
    `has_esrb_hate_speech` bool NOT NULL,
    `has_esrb_crime` bool NOT NULL,
    `has_esrb_crime_instruct` bool NOT NULL,
    `has_pegi_violence` bool NOT NULL,
    `has_pegi_lang` bool NOT NULL,
    `has_pegi_scary` bool NOT NULL,
    `has_pegi_sex_content` bool NOT NULL,
    `has_pegi_drugs` bool NOT NULL,
    `has_pegi_discrimination` bool NOT NULL,
    `has_pegi_gambling` bool NOT NULL,
    `has_pegi_online` bool NOT NULL,
    `has_pegi_no_descs` bool NOT NULL,
    `has_classind_violence` bool NOT NULL,
    `has_classind_violence_extreme` bool NOT NULL,
    `has_classind_sexual_content` bool NOT NULL,
    `has_classind_sex_content` bool NOT NULL,
    `has_classind_sex_explicit` bool NOT NULL,
    `has_classind_drugs` bool NOT NULL,
    `has_classind_drugs_legal` bool NOT NULL,
    `has_classind_drugs_illegal` bool NOT NULL,
    `has_classind_lang` bool NOT NULL,
    `has_classind_criminal_acts` bool NOT NULL,
    `has_classind_shocking` bool NOT NULL,
    `has_classind_no_descs` bool NOT NULL,
    `has_generic_alcohol_ref` bool NOT NULL,
    `has_generic_blood` bool NOT NULL,
    `has_generic_blood_gore` bool NOT NULL,
    `has_generic_crude_humor` bool NOT NULL,
    `has_generic_drug_ref` bool NOT NULL,
    `has_generic_fantasy_violence` bool NOT NULL,
    `has_generic_intense_violence` bool NOT NULL,
    `has_generic_lang` bool NOT NULL,
    `has_generic_mild_blood` bool NOT NULL,
    `has_generic_mild_fantasy_violence` bool NOT NULL,
    `has_generic_mild_lang` bool NOT NULL,
    `has_generic_mild_violence` bool NOT NULL,
    `has_generic_nudity` bool NOT NULL,
    `has_generic_partial_nudity` bool NOT NULL,
    `has_generic_real_gambling` bool NOT NULL,
    `has_generic_sex_content` bool NOT NULL,
    `has_generic_sex_themes` bool NOT NULL,
    `has_generic_sim_gambling` bool NOT NULL,
    `has_generic_strong_lang` bool NOT NULL,
    `has_generic_strong_sex_content` bool NOT NULL,
    `has_generic_suggestive` bool NOT NULL
) ENGINE=InnoDB CHARACTER SET utf8 COLLATE utf8_general_ci;

ALTER TABLE `webapps_rating_descriptors` ADD CONSTRAINT `rating_descriptors_addon_id_key`
FOREIGN KEY (`addon_id`) REFERENCES `addons` (`id`) ON DELETE CASCADE;
