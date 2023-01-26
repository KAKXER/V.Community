ALTER TABLE `players` ADD IF NOT EXISTS `apps` TEXT;
ALTER TABLE `players` ADD IF NOT EXISTS `widget` TEXT;
ALTER TABLE `players` ADD IF NOT EXISTS `bt` TEXT;
ALTER TABLE `players` ADD IF NOT EXISTS `charinfo` TEXT;
ALTER TABLE `players` ADD IF NOT EXISTS `metadata` mediumtext;
ALTER TABLE `players` ADD IF NOT EXISTS `cryptocurrency` longtext;
ALTER TABLE `players` ADD IF NOT EXISTS `cryptocurrencytransfers` TEXT;
ALTER TABLE `players` ADD IF NOT EXISTS `phonePos` TEXT;
ALTER TABLE `players` ADD IF NOT EXISTS `spotify` TEXT;
ALTER TABLE `players` ADD IF NOT EXISTS `ringtone` TEXT
ALTER TABLE `players` ADD IF NOT EXISTS `first_screen_showed` INT(11) DEFAULT NULL;