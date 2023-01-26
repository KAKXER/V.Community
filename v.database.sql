-- --------------------------------------------------------
-- Host:                         127.0.0.1
-- Server version:               10.4.27-MariaDB - mariadb.org binary distribution
-- Server OS:                    Win64
-- HeidiSQL Version:             9.5.0.5315
-- --------------------------------------------------------

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET NAMES utf8 */;
/*!50503 SET NAMES utf8mb4 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;


-- Dumping database structure for essential
CREATE DATABASE IF NOT EXISTS `essential` /*!40100 DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci */;
USE `essential`;

-- Dumping structure for table essential.addon_account
CREATE TABLE IF NOT EXISTS `addon_account` (
  `name` varchar(60) NOT NULL,
  `label` varchar(100) NOT NULL,
  `shared` int(11) NOT NULL,
  PRIMARY KEY (`name`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_persian_ci ROW_FORMAT=DYNAMIC;

-- Dumping data for table essential.addon_account: ~13 rows (approximately)
/*!40000 ALTER TABLE `addon_account` DISABLE KEYS */;
INSERT INTO `addon_account` (`name`, `label`, `shared`) VALUES
	('society_ambulance', 'ambulance', 1);
INSERT INTO `addon_account` (`name`, `label`, `shared`) VALUES
	('society_cardealer', 'cardealer', 1);
INSERT INTO `addon_account` (`name`, `label`, `shared`) VALUES
	('society_dadgostari', 'dadgostari', 1);
INSERT INTO `addon_account` (`name`, `label`, `shared`) VALUES
	('society_doc', 'Doc', 1);
INSERT INTO `addon_account` (`name`, `label`, `shared`) VALUES
	('society_fbi', 'fbi', 1);
INSERT INTO `addon_account` (`name`, `label`, `shared`) VALUES
	('society_government', 'Government', 1);
INSERT INTO `addon_account` (`name`, `label`, `shared`) VALUES
	('society_mecano', 'Mechanic', 1);
INSERT INTO `addon_account` (`name`, `label`, `shared`) VALUES
	('society_nightclub', 'nightclub', 1);
INSERT INTO `addon_account` (`name`, `label`, `shared`) VALUES
	('society_nojob', 'nojob', 1);
INSERT INTO `addon_account` (`name`, `label`, `shared`) VALUES
	('society_police', 'police', 1);
INSERT INTO `addon_account` (`name`, `label`, `shared`) VALUES
	('society_sheriff', 'sheriff', 1);
INSERT INTO `addon_account` (`name`, `label`, `shared`) VALUES
	('society_taxi', 'taxi', 1);
INSERT INTO `addon_account` (`name`, `label`, `shared`) VALUES
	('society_uwu', 'UwU Cafe', 1);
INSERT INTO `addon_account` (`name`, `label`, `shared`) VALUES
	('society_weazel', 'Weazel News', 1);
/*!40000 ALTER TABLE `addon_account` ENABLE KEYS */;

-- Dumping structure for table essential.addon_account_data
CREATE TABLE IF NOT EXISTS `addon_account_data` (
  `account_name` varchar(100) DEFAULT NULL,
  `money` int(11) NOT NULL,
  `owner` varchar(100) DEFAULT NULL,
  UNIQUE KEY `index_addon_account_data_account_name_owner` (`account_name`,`owner`) USING BTREE,
  KEY `index_addon_account_data_account_name` (`account_name`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_persian_ci ROW_FORMAT=DYNAMIC;

-- Dumping data for table essential.addon_account_data: ~15 rows (approximately)
/*!40000 ALTER TABLE `addon_account_data` DISABLE KEYS */;
INSERT INTO `addon_account_data` (`account_name`, `money`, `owner`) VALUES
	('society_police', 0, NULL);
INSERT INTO `addon_account_data` (`account_name`, `money`, `owner`) VALUES
	('society_taxi', 0, NULL);
INSERT INTO `addon_account_data` (`account_name`, `money`, `owner`) VALUES
	('society_sheriff', 0, NULL);
INSERT INTO `addon_account_data` (`account_name`, `money`, `owner`) VALUES
	('society_fbi', 0, NULL);
INSERT INTO `addon_account_data` (`account_name`, `money`, `owner`) VALUES
	('society_artesh', 0, NULL);
INSERT INTO `addon_account_data` (`account_name`, `money`, `owner`) VALUES
	('society_dadgostari', 0, NULL);
INSERT INTO `addon_account_data` (`account_name`, `money`, `owner`) VALUES
	('society_ambulance', 0, NULL);
INSERT INTO `addon_account_data` (`account_name`, `money`, `owner`) VALUES
	('society_mecano', 0, NULL);
INSERT INTO `addon_account_data` (`account_name`, `money`, `owner`) VALUES
	('society_nojob', 0, NULL);
INSERT INTO `addon_account_data` (`account_name`, `money`, `owner`) VALUES
	('society_nightclub', 0, NULL);
INSERT INTO `addon_account_data` (`account_name`, `money`, `owner`) VALUES
	('society_weazel', 0, NULL);
INSERT INTO `addon_account_data` (`account_name`, `money`, `owner`) VALUES
	('society_doc', 0, NULL);
INSERT INTO `addon_account_data` (`account_name`, `money`, `owner`) VALUES
	('society_government', 0, NULL);
INSERT INTO `addon_account_data` (`account_name`, `money`, `owner`) VALUES
	('society_cardealer', 1264000, NULL);
INSERT INTO `addon_account_data` (`account_name`, `money`, `owner`) VALUES
	('society_uwu', 1000, NULL);
/*!40000 ALTER TABLE `addon_account_data` ENABLE KEYS */;

-- Dumping structure for table essential.addon_inventory
CREATE TABLE IF NOT EXISTS `addon_inventory` (
  `name` varchar(60) NOT NULL,
  `label` varchar(100) NOT NULL,
  `shared` int(11) NOT NULL,
  PRIMARY KEY (`name`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_persian_ci ROW_FORMAT=DYNAMIC;

-- Dumping data for table essential.addon_inventory: ~13 rows (approximately)
/*!40000 ALTER TABLE `addon_inventory` DISABLE KEYS */;
INSERT INTO `addon_inventory` (`name`, `label`, `shared`) VALUES
	('property', 'Property', 0);
INSERT INTO `addon_inventory` (`name`, `label`, `shared`) VALUES
	('society_ambulance', 'Ambulance', 1);
INSERT INTO `addon_inventory` (`name`, `label`, `shared`) VALUES
	('society_cardealer', 'cardealer', 1);
INSERT INTO `addon_inventory` (`name`, `label`, `shared`) VALUES
	('society_dadgostari', 'dadgostari', 1);
INSERT INTO `addon_inventory` (`name`, `label`, `shared`) VALUES
	('society_doc', 'Doc', 1);
INSERT INTO `addon_inventory` (`name`, `label`, `shared`) VALUES
	('society_fbi', 'fbi', 1);
INSERT INTO `addon_inventory` (`name`, `label`, `shared`) VALUES
	('society_government', 'Government', 1);
INSERT INTO `addon_inventory` (`name`, `label`, `shared`) VALUES
	('society_mecano', 'Mechanic', 1);
INSERT INTO `addon_inventory` (`name`, `label`, `shared`) VALUES
	('society_nightclub', 'nightclub', 1);
INSERT INTO `addon_inventory` (`name`, `label`, `shared`) VALUES
	('society_police', 'police', 1);
INSERT INTO `addon_inventory` (`name`, `label`, `shared`) VALUES
	('society_sheriff', 'sheriff', 1);
INSERT INTO `addon_inventory` (`name`, `label`, `shared`) VALUES
	('society_taxi', 'taxi', 1);
INSERT INTO `addon_inventory` (`name`, `label`, `shared`) VALUES
	('society_uwu', 'UwU Cafe', 1);
INSERT INTO `addon_inventory` (`name`, `label`, `shared`) VALUES
	('society_weazel', 'Weazel News', 1);
/*!40000 ALTER TABLE `addon_inventory` ENABLE KEYS */;

-- Dumping structure for table essential.addon_inventory_items
CREATE TABLE IF NOT EXISTS `addon_inventory_items` (
  `inventory_name` varchar(100) NOT NULL,
  `name` varchar(100) NOT NULL,
  `count` int(11) NOT NULL,
  `owner` varchar(60) DEFAULT NULL,
  KEY `index_addon_inventory_items_inventory_name_name` (`inventory_name`,`name`) USING BTREE,
  KEY `index_addon_inventory_items_inventory_name_name_owner` (`inventory_name`,`name`,`owner`) USING BTREE,
  KEY `index_addon_inventory_inventory_name` (`inventory_name`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_persian_ci ROW_FORMAT=DYNAMIC;

-- Dumping data for table essential.addon_inventory_items: ~0 rows (approximately)
/*!40000 ALTER TABLE `addon_inventory_items` DISABLE KEYS */;
/*!40000 ALTER TABLE `addon_inventory_items` ENABLE KEYS */;

-- Dumping structure for table essential.adminjaillog
CREATE TABLE IF NOT EXISTS `adminjaillog` (
  `id` int(100) NOT NULL AUTO_INCREMENT,
  `identifier` varchar(50) NOT NULL,
  `name` varchar(50) NOT NULL,
  `jailreason` varchar(50) NOT NULL,
  `jailtime` int(50) NOT NULL,
  `punisher` varchar(100) NOT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci ROW_FORMAT=DYNAMIC;

-- Dumping data for table essential.adminjaillog: ~0 rows (approximately)
/*!40000 ALTER TABLE `adminjaillog` DISABLE KEYS */;
/*!40000 ALTER TABLE `adminjaillog` ENABLE KEYS */;

-- Dumping structure for table essential.alias
CREATE TABLE IF NOT EXISTS `alias` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `identifier` varchar(50) NOT NULL,
  `text` varchar(200) NOT NULL,
  `target` varchar(50) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=47 DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

-- Dumping data for table essential.alias: ~0 rows (approximately)
/*!40000 ALTER TABLE `alias` DISABLE KEYS */;
/*!40000 ALTER TABLE `alias` ENABLE KEYS */;

-- Dumping structure for table essential.allhousing
CREATE TABLE IF NOT EXISTS `allhousing` (
  `id` int(11) NOT NULL,
  `owner` varchar(50) NOT NULL,
  `ownername` varchar(50) NOT NULL,
  `owned` tinyint(4) NOT NULL,
  `price` int(11) NOT NULL,
  `resalepercent` int(11) NOT NULL,
  `resalejob` varchar(50) NOT NULL,
  `entry` longtext DEFAULT NULL,
  `garage` longtext DEFAULT NULL,
  `furniture` longtext DEFAULT NULL,
  `shell` varchar(50) NOT NULL,
  `interior` varchar(50) NOT NULL,
  `shells` longtext DEFAULT NULL,
  `doors` longtext DEFAULT NULL,
  `housekeys` longtext DEFAULT NULL,
  `wardrobe` longtext DEFAULT NULL,
  `inventory` longtext DEFAULT NULL,
  `inventorylocation` longtext DEFAULT NULL,
  `mortgage_owed` int(11) NOT NULL DEFAULT 0,
  `last_repayment` int(11) NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Dumping data for table essential.allhousing: ~0 rows (approximately)
/*!40000 ALTER TABLE `allhousing` DISABLE KEYS */;
/*!40000 ALTER TABLE `allhousing` ENABLE KEYS */;

-- Dumping structure for table essential.bansql
CREATE TABLE IF NOT EXISTS `bansql` (
  `ID` int(11) NOT NULL AUTO_INCREMENT,
  `Steam` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL,
  `License` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL,
  `IP` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL,
  `Discord` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL,
  `Xbox` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL,
  `Live` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL,
  `Tokens` varchar(5000) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL DEFAULT '[]',
  `Reason` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL,
  `isBanned` int(11) NOT NULL DEFAULT 0,
  `Expire` int(11) NOT NULL DEFAULT 0,
  KEY `ID` (`ID`)
) ENGINE=InnoDB AUTO_INCREMENT=274 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Dumping data for table essential.bansql: ~0 rows (approximately)
/*!40000 ALTER TABLE `bansql` DISABLE KEYS */;
/*!40000 ALTER TABLE `bansql` ENABLE KEYS */;

-- Dumping structure for table essential.billing
CREATE TABLE IF NOT EXISTS `billing` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `identifier` varchar(255) NOT NULL,
  `sender` varchar(255) NOT NULL,
  `target_type` varchar(50) NOT NULL,
  `target` varchar(255) NOT NULL,
  `label` varchar(255) NOT NULL,
  `amount` int(11) NOT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  KEY `identifier` (`identifier`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=256 DEFAULT CHARSET=utf8 COLLATE=utf8_persian_ci ROW_FORMAT=DYNAMIC;

-- Dumping data for table essential.billing: ~0 rows (approximately)
/*!40000 ALTER TABLE `billing` DISABLE KEYS */;
/*!40000 ALTER TABLE `billing` ENABLE KEYS */;

-- Dumping structure for table essential.counter
CREATE TABLE IF NOT EXISTS `counter` (
  `owner` varchar(255) NOT NULL,
  `type` varchar(50) NOT NULL,
  `job` varchar(50) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Dumping data for table essential.counter: ~0 rows (approximately)
/*!40000 ALTER TABLE `counter` DISABLE KEYS */;
/*!40000 ALTER TABLE `counter` ENABLE KEYS */;

-- Dumping structure for table essential.crypto_transactions
CREATE TABLE IF NOT EXISTS `crypto_transactions` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `identifier` varchar(46) DEFAULT NULL,
  `title` varchar(50) DEFAULT NULL,
  `message` varchar(50) DEFAULT NULL,
  `date` timestamp NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`id`),
  KEY `identifier` (`identifier`)
) ENGINE=InnoDB AUTO_INCREMENT=753 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Dumping data for table essential.crypto_transactions: ~0 rows (approximately)
/*!40000 ALTER TABLE `crypto_transactions` DISABLE KEYS */;
/*!40000 ALTER TABLE `crypto_transactions` ENABLE KEYS */;

-- Dumping structure for table essential.darkchat_messages
CREATE TABLE IF NOT EXISTS `darkchat_messages` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `password` text NOT NULL,
  `owner` varchar(50) DEFAULT NULL,
  `name` varchar(50) DEFAULT '',
  `messages` text DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  KEY `id` (`id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Dumping data for table essential.darkchat_messages: ~0 rows (approximately)
/*!40000 ALTER TABLE `darkchat_messages` DISABLE KEYS */;
/*!40000 ALTER TABLE `darkchat_messages` ENABLE KEYS */;

-- Dumping structure for table essential.datastore
CREATE TABLE IF NOT EXISTS `datastore` (
  `name` varchar(60) NOT NULL,
  `label` varchar(100) NOT NULL,
  `shared` int(11) NOT NULL,
  PRIMARY KEY (`name`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_persian_ci ROW_FORMAT=DYNAMIC;

-- Dumping data for table essential.datastore: ~17 rows (approximately)
/*!40000 ALTER TABLE `datastore` DISABLE KEYS */;
INSERT INTO `datastore` (`name`, `label`, `shared`) VALUES
	('housing', 'Housing', 0);
INSERT INTO `datastore` (`name`, `label`, `shared`) VALUES
	('property', 'Property', 0);
INSERT INTO `datastore` (`name`, `label`, `shared`) VALUES
	('society_ambulance', 'ambulance', 1);
INSERT INTO `datastore` (`name`, `label`, `shared`) VALUES
	('society_cardealer', 'cardealer', 1);
INSERT INTO `datastore` (`name`, `label`, `shared`) VALUES
	('society_dadgostari', 'dadgostari', 1);
INSERT INTO `datastore` (`name`, `label`, `shared`) VALUES
	('society_fbi', 'fbi', 1);
INSERT INTO `datastore` (`name`, `label`, `shared`) VALUES
	('society_government', 'government', 1);
INSERT INTO `datastore` (`name`, `label`, `shared`) VALUES
	('society_nightclub', 'nightclub', 1);
INSERT INTO `datastore` (`name`, `label`, `shared`) VALUES
	('society_police', 'police', 1);
INSERT INTO `datastore` (`name`, `label`, `shared`) VALUES
	('society_sheriff', 'Sheriff Department', 1);
INSERT INTO `datastore` (`name`, `label`, `shared`) VALUES
	('society_taxi', 'taxi', 1);
INSERT INTO `datastore` (`name`, `label`, `shared`) VALUES
	('society_uwu', 'Uwu Cafe', 1);
INSERT INTO `datastore` (`name`, `label`, `shared`) VALUES
	('society_weazel', 'reporterr', 1);
INSERT INTO `datastore` (`name`, `label`, `shared`) VALUES
	('user_bag', 'Bag', 0);
INSERT INTO `datastore` (`name`, `label`, `shared`) VALUES
	('user_ears', 'Ears', 0);
INSERT INTO `datastore` (`name`, `label`, `shared`) VALUES
	('user_glasses', 'Glasses', 0);
INSERT INTO `datastore` (`name`, `label`, `shared`) VALUES
	('user_helmet', 'Helmet', 0);
INSERT INTO `datastore` (`name`, `label`, `shared`) VALUES
	('user_mask', 'Mask', 0);
/*!40000 ALTER TABLE `datastore` ENABLE KEYS */;

-- Dumping structure for table essential.datastore_data
CREATE TABLE IF NOT EXISTS `datastore_data` (
  `name` varchar(60) NOT NULL,
  `owner` varchar(60) DEFAULT NULL,
  `data` longtext DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Dumping data for table essential.datastore_data: ~18 rows (approximately)
/*!40000 ALTER TABLE `datastore_data` DISABLE KEYS */;
INSERT INTO `datastore_data` (`name`, `owner`, `data`) VALUES
	('society_ambulance', NULL, '{}');
INSERT INTO `datastore_data` (`name`, `owner`, `data`) VALUES
	('society_cardealer', NULL, '{}');
INSERT INTO `datastore_data` (`name`, `owner`, `data`) VALUES
	('society_dadgostari', NULL, '{}');
INSERT INTO `datastore_data` (`name`, `owner`, `data`) VALUES
	('society_fbi', NULL, '{}');
INSERT INTO `datastore_data` (`name`, `owner`, `data`) VALUES
	('society_government', NULL, '{}');
INSERT INTO `datastore_data` (`name`, `owner`, `data`) VALUES
	('society_nightclub', NULL, '{}');
INSERT INTO `datastore_data` (`name`, `owner`, `data`) VALUES
	('society_police', NULL, '{}');
INSERT INTO `datastore_data` (`name`, `owner`, `data`) VALUES
	('society_sheriff', NULL, '{}');
INSERT INTO `datastore_data` (`name`, `owner`, `data`) VALUES
	('society_taxi', NULL, '{}');
INSERT INTO `datastore_data` (`name`, `owner`, `data`) VALUES
	('society_weazel', NULL, '{}');
INSERT INTO `datastore_data` (`name`, `owner`, `data`) VALUES
	('society_uwu', NULL, '{}');
INSERT INTO `datastore_data` (`name`, `owner`, `data`) VALUES
	('housing', 'steam:1100001452540bf', '{}');
INSERT INTO `datastore_data` (`name`, `owner`, `data`) VALUES
	('property', 'steam:1100001452540bf', '{}');
INSERT INTO `datastore_data` (`name`, `owner`, `data`) VALUES
	('user_ears', 'steam:1100001452540bf', '{}');
INSERT INTO `datastore_data` (`name`, `owner`, `data`) VALUES
	('user_bag', 'steam:1100001452540bf', '{}');
INSERT INTO `datastore_data` (`name`, `owner`, `data`) VALUES
	('user_glasses', 'steam:1100001452540bf', '{}');
INSERT INTO `datastore_data` (`name`, `owner`, `data`) VALUES
	('user_helmet', 'steam:1100001452540bf', '{}');
INSERT INTO `datastore_data` (`name`, `owner`, `data`) VALUES
	('user_mask', 'steam:1100001452540bf', '{}');
/*!40000 ALTER TABLE `datastore_data` ENABLE KEYS */;

-- Dumping structure for table essential.divisions
CREATE TABLE IF NOT EXISTS `divisions` (
  `owner` varchar(50) NOT NULL,
  `name` varchar(50) NOT NULL,
  `label` varchar(50) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Dumping data for table essential.divisions: ~22 rows (approximately)
/*!40000 ALTER TABLE `divisions` DISABLE KEYS */;
INSERT INTO `divisions` (`owner`, `name`, `label`) VALUES
	('police', 'hr', 'Human Resources');
INSERT INTO `divisions` (`owner`, `name`, `label`) VALUES
	('police', 'fa', 'Fire Arms');
INSERT INTO `divisions` (`owner`, `name`, `label`) VALUES
	('police', 'dispatch', 'Dispatch');
INSERT INTO `divisions` (`owner`, `name`, `label`) VALUES
	('police', 'gc2', 'Gun Class 2');
INSERT INTO `divisions` (`owner`, `name`, `label`) VALUES
	('police', 'thwm', 'The Highwaymen');
INSERT INTO `divisions` (`owner`, `name`, `label`) VALUES
	('police', 'hvtu', 'High Value Target Unit');
INSERT INTO `divisions` (`owner`, `name`, `label`) VALUES
	('police', 'interceptor', 'Inter Ceptor');
INSERT INTO `divisions` (`owner`, `name`, `label`) VALUES
	('police', 'dea', 'Drug Enforcement Administration');
INSERT INTO `divisions` (`owner`, `name`, `label`) VALUES
	('police', 'coroner', 'Coroner');
INSERT INTO `divisions` (`owner`, `name`, `label`) VALUES
	('police', 'mary', 'Mary');
INSERT INTO `divisions` (`owner`, `name`, `label`) VALUES
	('police', 'to', ' Training Officer');
INSERT INTO `divisions` (`owner`, `name`, `label`) VALUES
	('police', 'scu', 'SCU');
INSERT INTO `divisions` (`owner`, `name`, `label`) VALUES
	('police', 'sru', 'SRU');
INSERT INTO `divisions` (`owner`, `name`, `label`) VALUES
	('police', 'ib', 'IB');
INSERT INTO `divisions` (`owner`, `name`, `label`) VALUES
	('police', 'mcd', 'MCD');
INSERT INTO `divisions` (`owner`, `name`, `label`) VALUES
	('police', 'air1', 'Airship');
INSERT INTO `divisions` (`owner`, `name`, `label`) VALUES
	('police', 'swat', 'Swat');
INSERT INTO `divisions` (`owner`, `name`, `label`) VALUES
	('police', 'gtf', 'GTF');
INSERT INTO `divisions` (`owner`, `name`, `label`) VALUES
	('police', 'te', 'TE');
INSERT INTO `divisions` (`owner`, `name`, `label`) VALUES
	('police', 'fto', 'FTO');
INSERT INTO `divisions` (`owner`, `name`, `label`) VALUES
	('police', 'k9', 'K9');
INSERT INTO `divisions` (`owner`, `name`, `label`) VALUES
	('police', 'ia', 'IA');
/*!40000 ALTER TABLE `divisions` ENABLE KEYS */;

-- Dumping structure for table essential.division_grades
CREATE TABLE IF NOT EXISTS `division_grades` (
  `division_owner` varchar(50) NOT NULL,
  `division` varchar(50) NOT NULL,
  `grade` int(11) NOT NULL,
  `name` varchar(50) NOT NULL,
  `label` varchar(50) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Dumping data for table essential.division_grades: ~21 rows (approximately)
/*!40000 ALTER TABLE `division_grades` DISABLE KEYS */;
INSERT INTO `division_grades` (`division_owner`, `division`, `grade`, `name`, `label`) VALUES
	('police', 'hr', 0, ' Human Resource', ' Human Resource');
INSERT INTO `division_grades` (`division_owner`, `division`, `grade`, `name`, `label`) VALUES
	('police', 'hr', 1, ' Human Resource+', ' Human Resource+');
INSERT INTO `division_grades` (`division_owner`, `division`, `grade`, `name`, `label`) VALUES
	('police', 'fa', 0, 'Fire Arms', 'Fire Arms');
INSERT INTO `division_grades` (`division_owner`, `division`, `grade`, `name`, `label`) VALUES
	('police', 'dispatch', 0, 'Dispatch', 'Dispatch');
INSERT INTO `division_grades` (`division_owner`, `division`, `grade`, `name`, `label`) VALUES
	('police', 'gc2', 0, 'Gun Class 2', 'Gun Class 2');
INSERT INTO `division_grades` (`division_owner`, `division`, `grade`, `name`, `label`) VALUES
	('police', 'thwm', 0, 'The Highwaymen', 'The Highwaymen');
INSERT INTO `division_grades` (`division_owner`, `division`, `grade`, `name`, `label`) VALUES
	('police', 'hvtu', 0, 'High Value Target Unit', 'High Value Target Unit');
INSERT INTO `division_grades` (`division_owner`, `division`, `grade`, `name`, `label`) VALUES
	('police', 'interceptor', 0, 'Inter Ceptor', 'Inter Ceptor');
INSERT INTO `division_grades` (`division_owner`, `division`, `grade`, `name`, `label`) VALUES
	('police', 'dea', 0, 'Drug Enforcement Administration', 'Drug Enforcement Administration');
INSERT INTO `division_grades` (`division_owner`, `division`, `grade`, `name`, `label`) VALUES
	('police', 'coroner', 0, 'Coroner', 'Coroner');
INSERT INTO `division_grades` (`division_owner`, `division`, `grade`, `name`, `label`) VALUES
	('police', 'mary', 0, 'Mary', 'Mary');
INSERT INTO `division_grades` (`division_owner`, `division`, `grade`, `name`, `label`) VALUES
	('police', 'to', 0, ' Training Officer', ' Training Officer');
INSERT INTO `division_grades` (`division_owner`, `division`, `grade`, `name`, `label`) VALUES
	('police', 'scu', 0, 'SCU', 'SCU');
INSERT INTO `division_grades` (`division_owner`, `division`, `grade`, `name`, `label`) VALUES
	('police', 'sru', 0, 'SRU', 'SRU');
INSERT INTO `division_grades` (`division_owner`, `division`, `grade`, `name`, `label`) VALUES
	('police', 'ib', 0, 'IB', 'IB');
INSERT INTO `division_grades` (`division_owner`, `division`, `grade`, `name`, `label`) VALUES
	('police', 'mcd', 0, 'MCD', 'MCD');
INSERT INTO `division_grades` (`division_owner`, `division`, `grade`, `name`, `label`) VALUES
	('police', 'air1', 0, 'Airship', 'Airship');
INSERT INTO `division_grades` (`division_owner`, `division`, `grade`, `name`, `label`) VALUES
	('police', 'swat', 0, 'Swat', 'Swat');
INSERT INTO `division_grades` (`division_owner`, `division`, `grade`, `name`, `label`) VALUES
	('police', 'gtf', 0, 'GTF', 'GTF');
INSERT INTO `division_grades` (`division_owner`, `division`, `grade`, `name`, `label`) VALUES
	('police', 'te', 0, 'TE', 'TE');
INSERT INTO `division_grades` (`division_owner`, `division`, `grade`, `name`, `label`) VALUES
	('police', 'fto', 0, 'FTO', 'FTO');
INSERT INTO `division_grades` (`division_owner`, `division`, `grade`, `name`, `label`) VALUES
	('police', 'k9', 0, 'K9', 'K9');
INSERT INTO `division_grades` (`division_owner`, `division`, `grade`, `name`, `label`) VALUES
	('police', 'ia', 0, 'IA', 'IA');
/*!40000 ALTER TABLE `division_grades` ENABLE KEYS */;

-- Dumping structure for table essential.dpkeybinds
CREATE TABLE IF NOT EXISTS `dpkeybinds` (
  `id` varchar(50) DEFAULT NULL,
  `keybind1` varchar(50) DEFAULT 'num4',
  `emote1` varchar(255) DEFAULT '',
  `keybind2` varchar(50) DEFAULT 'num5',
  `emote2` varchar(255) DEFAULT '',
  `keybind3` varchar(50) DEFAULT 'num6',
  `emote3` varchar(255) DEFAULT '',
  `keybind4` varchar(50) DEFAULT 'num7',
  `emote4` varchar(255) DEFAULT '',
  `keybind5` varchar(50) DEFAULT 'num8',
  `emote5` varchar(255) DEFAULT '',
  `keybind6` varchar(50) DEFAULT 'num9',
  `emote6` varchar(255) DEFAULT ''
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

-- Dumping data for table essential.dpkeybinds: ~12 rows (approximately)
/*!40000 ALTER TABLE `dpkeybinds` DISABLE KEYS */;
INSERT INTO `dpkeybinds` (`id`, `keybind1`, `emote1`, `keybind2`, `emote2`, `keybind3`, `emote3`, `keybind4`, `emote4`, `keybind5`, `emote5`, `keybind6`, `emote6`) VALUES
	('steam:11000011bf03921', 'num4', '', 'num5', '', 'num6', '', 'num7', '', 'num8', '', 'num9', '');
INSERT INTO `dpkeybinds` (`id`, `keybind1`, `emote1`, `keybind2`, `emote2`, `keybind3`, `emote3`, `keybind4`, `emote4`, `keybind5`, `emote5`, `keybind6`, `emote6`) VALUES
	('steam:1100001452540bf', 'num4', '', 'num5', '', 'num6', '', 'num7', '', 'num8', '', 'num9', '');
INSERT INTO `dpkeybinds` (`id`, `keybind1`, `emote1`, `keybind2`, `emote2`, `keybind3`, `emote3`, `keybind4`, `emote4`, `keybind5`, `emote5`, `keybind6`, `emote6`) VALUES
	('steam:110000144c6a3b8', 'num4', '', 'num5', '', 'num6', '', 'num7', '', 'num8', '', 'num9', '');
INSERT INTO `dpkeybinds` (`id`, `keybind1`, `emote1`, `keybind2`, `emote2`, `keybind3`, `emote3`, `keybind4`, `emote4`, `keybind5`, `emote5`, `keybind6`, `emote6`) VALUES
	('steam:1100001480d24d4', 'num4', '', 'num5', '', 'num6', '', 'num7', '', 'num8', '', 'num9', '');
INSERT INTO `dpkeybinds` (`id`, `keybind1`, `emote1`, `keybind2`, `emote2`, `keybind3`, `emote3`, `keybind4`, `emote4`, `keybind5`, `emote5`, `keybind6`, `emote6`) VALUES
	('steam:1100001341c207b', 'num4', '', 'num5', '', 'num6', '', 'num7', '', 'num8', '', 'num9', 'shrug');
INSERT INTO `dpkeybinds` (`id`, `keybind1`, `emote1`, `keybind2`, `emote2`, `keybind3`, `emote3`, `keybind4`, `emote4`, `keybind5`, `emote5`, `keybind6`, `emote6`) VALUES
	('steam:110000141b999f2', 'num4', '', 'num5', '', 'num6', '', 'num7', '', 'num8', '', 'num9', '');
INSERT INTO `dpkeybinds` (`id`, `keybind1`, `emote1`, `keybind2`, `emote2`, `keybind3`, `emote3`, `keybind4`, `emote4`, `keybind5`, `emote5`, `keybind6`, `emote6`) VALUES
	('steam:11000014af841ec', 'num4', '', 'num5', '', 'num6', '', 'num7', '', 'num8', '', 'num9', '');
INSERT INTO `dpkeybinds` (`id`, `keybind1`, `emote1`, `keybind2`, `emote2`, `keybind3`, `emote3`, `keybind4`, `emote4`, `keybind5`, `emote5`, `keybind6`, `emote6`) VALUES
	('steam:1100001356ed847', 'num4', '', 'num5', '', 'num6', '', 'num7', '', 'num8', '', 'num9', '');
INSERT INTO `dpkeybinds` (`id`, `keybind1`, `emote1`, `keybind2`, `emote2`, `keybind3`, `emote3`, `keybind4`, `emote4`, `keybind5`, `emote5`, `keybind6`, `emote6`) VALUES
	('steam:11000014a773fca', 'num4', '', 'num5', '', 'num6', '', 'num7', '', 'num8', '', 'num9', '');
INSERT INTO `dpkeybinds` (`id`, `keybind1`, `emote1`, `keybind2`, `emote2`, `keybind3`, `emote3`, `keybind4`, `emote4`, `keybind5`, `emote5`, `keybind6`, `emote6`) VALUES
	('steam:110000134186c02', 'num4', '', 'num5', '', 'num6', '', 'num7', '', 'num8', '', 'num9', '');
INSERT INTO `dpkeybinds` (`id`, `keybind1`, `emote1`, `keybind2`, `emote2`, `keybind3`, `emote3`, `keybind4`, `emote4`, `keybind5`, `emote5`, `keybind6`, `emote6`) VALUES
	('steam:1100001440a9ff9', 'num4', '', 'num5', '', 'num6', '', 'num7', '', 'num8', '', 'num9', '');
INSERT INTO `dpkeybinds` (`id`, `keybind1`, `emote1`, `keybind2`, `emote2`, `keybind3`, `emote3`, `keybind4`, `emote4`, `keybind5`, `emote5`, `keybind6`, `emote6`) VALUES
	('steam:1100001470c625d', 'num4', '', 'num5', '', 'num6', '', 'num7', '', 'num8', '', 'num9', '');
/*!40000 ALTER TABLE `dpkeybinds` ENABLE KEYS */;

-- Dumping structure for table essential.finelog
CREATE TABLE IF NOT EXISTS `finelog` (
  `id` int(100) NOT NULL AUTO_INCREMENT,
  `identifier` varchar(50) NOT NULL,
  `name` varchar(50) NOT NULL,
  `oocname` varchar(255) NOT NULL,
  `reason` varchar(50) NOT NULL,
  `fineamount` int(50) NOT NULL,
  `punisher` varchar(100) NOT NULL,
  `date` int(32) NOT NULL DEFAULT 0,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=27 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Dumping data for table essential.finelog: ~11 rows (approximately)
/*!40000 ALTER TABLE `finelog` DISABLE KEYS */;
INSERT INTO `finelog` (`id`, `identifier`, `name`, `oocname`, `reason`, `fineamount`, `punisher`, `date`) VALUES
	(15, 'steam:11000014461fd21', 'senior_sezar', 'LORDSEZAR', 'fear rp', 100000, 'HEDVUCK', 1636540002);
INSERT INTO `finelog` (`id`, `identifier`, `name`, `oocname`, `reason`, `fineamount`, `punisher`, `date`) VALUES
	(16, 'steam:110000145ab2def', 'FARAZ_KIANI', 'farazFT', 'bad harf zadn ba admin', 50000, 'Majid', 1636548239);
INSERT INTO `finelog` (`id`, `identifier`, `name`, `oocname`, `reason`, `fineamount`, `punisher`, `date`) VALUES
	(17, 'steam:110000145ab2def', 'FARAZ_KIANI', 'farazFT', 'bad harf zadn ba admin', 100000, 'Majid', 1636548293);
INSERT INTO `finelog` (`id`, `identifier`, `name`, `oocname`, `reason`, `fineamount`, `punisher`, `date`) VALUES
	(18, 'steam:110000145ab2def', 'FARAZ_KIANI', 'farazFT', 'bad harf zadn', 100000, 'Majid', 1636548311);
INSERT INTO `finelog` (`id`, `identifier`, `name`, `oocname`, `reason`, `fineamount`, `punisher`, `date`) VALUES
	(19, 'steam:110000145ab2def', 'Kiarash_gi', 'Kiarash_sh', 'dorogh be admin', 100000, 'Majid', 1636565592);
INSERT INTO `finelog` (`id`, `identifier`, `name`, `oocname`, `reason`, `fineamount`, `punisher`, `date`) VALUES
	(20, 'steam:110000149be774c', 'Amir_Tirike', '~r~Amir~u~Tirike~bl~™', 'Emote Abuse', 100000, 'Arshia', 1636627594);
INSERT INTO `finelog` (`id`, `identifier`, `name`, `oocname`, `reason`, `fineamount`, `punisher`, `date`) VALUES
	(21, 'steam:110000145ab2def', 'ddd_sss', 'reza dolian', '115', 100000, 'Majid', 1636821980);
INSERT INTO `finelog` (`id`, `identifier`, `name`, `oocname`, `reason`, `fineamount`, `punisher`, `date`) VALUES
	(22, 'steam:1100001440a9ff9', 'arman_as', 'armanasb.7d1', 'tohin', 10000, 'daniyal', 1636889414);
INSERT INTO `finelog` (`id`, `identifier`, `name`, `oocname`, `reason`, `fineamount`, `punisher`, `date`) VALUES
	(23, 'steam:11000013642fe48', 'kiarash_rezaii', 'zakhar', 'DM', 2600, 'Araz Ogloo', 1636913865);
INSERT INTO `finelog` (`id`, `identifier`, `name`, `oocname`, `reason`, `fineamount`, `punisher`, `date`) VALUES
	(24, 'steam:11000013642fe48', 'ARSHIYA_KILLER', 'arshiya(KILLER)', 'dm', 500000, 'Araz Ogloo', 1636978509);
INSERT INTO `finelog` (`id`, `identifier`, `name`, `oocname`, `reason`, `fineamount`, `punisher`, `date`) VALUES
	(25, 'steam:11000014160e709', 'S_D', 'sobhanrhymy10', 'vaqt admin ra gerefran', 100000, 'hajj elias', 1638198439);
INSERT INTO `finelog` (`id`, `identifier`, `name`, `oocname`, `reason`, `fineamount`, `punisher`, `date`) VALUES
	(26, 'steam:1100001452540bf', 'KAKXER BELA', 'KAKXER', 'ds', 10, 'KAKXER', 1672082869);
/*!40000 ALTER TABLE `finelog` ENABLE KEYS */;

-- Dumping structure for table essential.fines
CREATE TABLE IF NOT EXISTS `fines` (
  `id` int(100) NOT NULL AUTO_INCREMENT,
  `identifier` varchar(50) NOT NULL,
  `name` varchar(50) NOT NULL,
  `fineamount` int(100) NOT NULL,
  `reason` varchar(50) NOT NULL,
  `punisher` varchar(50) NOT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci ROW_FORMAT=DYNAMIC;

-- Dumping data for table essential.fines: ~0 rows (approximately)
/*!40000 ALTER TABLE `fines` DISABLE KEYS */;
/*!40000 ALTER TABLE `fines` ENABLE KEYS */;

-- Dumping structure for table essential.fine_types
CREATE TABLE IF NOT EXISTS `fine_types` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `label` varchar(255) DEFAULT NULL,
  `amount` int(11) DEFAULT NULL,
  `category` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=55 DEFAULT CHARSET=utf8 COLLATE=utf8_persian_ci ROW_FORMAT=DYNAMIC;

-- Dumping data for table essential.fine_types: ~54 rows (approximately)
/*!40000 ALTER TABLE `fine_types` DISABLE KEYS */;
INSERT INTO `fine_types` (`id`, `label`, `amount`, `category`) VALUES
	(1, 'Aloodegi soti', 200, 0);
INSERT INTO `fine_types` (`id`, `label`, `amount`, `category`) VALUES
	(2, 'Oboor az cheraghe ghermez', 500, 0);
INSERT INTO `fine_types` (`id`, `label`, `amount`, `category`) VALUES
	(3, 'Vorood mamnoo', 500, 0);
INSERT INTO `fine_types` (`id`, `label`, `amount`, `category`) VALUES
	(4, 'Dor zadan gheyr e mojaz', 400, 0);
INSERT INTO `fine_types` (`id`, `label`, `amount`, `category`) VALUES
	(5, 'Ranandegi dar line mokhalef', 500, 0);
INSERT INTO `fine_types` (`id`, `label`, `amount`, `category`) VALUES
	(6, 'Ranandegi khatarnak', 700, 0);
INSERT INTO `fine_types` (`id`, `label`, `amount`, `category`) VALUES
	(7, 'Tavaghof mamnoo', 200, 0);
INSERT INTO `fine_types` (`id`, `label`, `amount`, `category`) VALUES
	(8, 'Park e bad', 300, 0);
INSERT INTO `fine_types` (`id`, `label`, `amount`, `category`) VALUES
	(9, 'Adam tavajoh be hagh e taghadom', 200, 0);
INSERT INTO `fine_types` (`id`, `label`, `amount`, `category`) VALUES
	(10, 'Adam tavajo be fasele tooli', 100, 0);
INSERT INTO `fine_types` (`id`, `label`, `amount`, `category`) VALUES
	(11, 'Adam tavajoh be tavaghof', 500, 0);
INSERT INTO `fine_types` (`id`, `label`, `amount`, `category`) VALUES
	(12, 'Adam e tavajoh be alayeme ranandegi', 400, 0);
INSERT INTO `fine_types` (`id`, `label`, `amount`, `category`) VALUES
	(13, 'Harakat e khatarnak', 700, 0);
INSERT INTO `fine_types` (`id`, `label`, `amount`, `category`) VALUES
	(14, 'tajavoz be harime khososi', 600, 0);
INSERT INTO `fine_types` (`id`, `label`, `amount`, `category`) VALUES
	(15, 'Ranandegi bedoone govahinam', 700, 0);
INSERT INTO `fine_types` (`id`, `label`, `amount`, `category`) VALUES
	(16, 'Zadan o dar raftan', 700, 0);
INSERT INTO `fine_types` (`id`, `label`, `amount`, `category`) VALUES
	(17, 'Sorat e kamtar az 60Km/h', 200, 0);
INSERT INTO `fine_types` (`id`, `label`, `amount`, `category`) VALUES
	(18, 'Soraat mojaz 60Km/h', 200, 0);
INSERT INTO `fine_types` (`id`, `label`, `amount`, `category`) VALUES
	(19, 'Soraat mojaz 80Km/h', 400, 0);
INSERT INTO `fine_types` (`id`, `label`, `amount`, `category`) VALUES
	(20, 'Soraat mojaz 120Km/h', 600, 0);
INSERT INTO `fine_types` (`id`, `label`, `amount`, `category`) VALUES
	(21, 'Ijad e traffic', 250, 1);
INSERT INTO `fine_types` (`id`, `label`, `amount`, `category`) VALUES
	(22, 'Bastan e khiyaboon', 700, 1);
INSERT INTO `fine_types` (`id`, `label`, `amount`, `category`) VALUES
	(23, 'Beham rikhtan e nazm ', 450, 1);
INSERT INTO `fine_types` (`id`, `label`, `amount`, `category`) VALUES
	(24, 'Bi tavajohi be ekhtar e police', 800, 1);
INSERT INTO `fine_types` (`id`, `label`, `amount`, `category`) VALUES
	(25, 'Bi ehterami', 300, 1);
INSERT INTO `fine_types` (`id`, `label`, `amount`, `category`) VALUES
	(26, 'Tohin be mamoor e police', 500, 1);
INSERT INTO `fine_types` (`id`, `label`, `amount`, `category`) VALUES
	(27, 'Tahdid shahrvandan', 950, 1);
INSERT INTO `fine_types` (`id`, `label`, `amount`, `category`) VALUES
	(28, 'Tahdid Police', 1200, 1);
INSERT INTO `fine_types` (`id`, `label`, `amount`, `category`) VALUES
	(29, 'Eteraz be ghanoon', 300, 1);
INSERT INTO `fine_types` (`id`, `label`, `amount`, `category`) VALUES
	(30, 'Ijad e fesad', 1500, 1);
INSERT INTO `fine_types` (`id`, `label`, `amount`, `category`) VALUES
	(31, 'Estefade az selahe sard dar shahr', 400, 2);
INSERT INTO `fine_types` (`id`, `label`, `amount`, `category`) VALUES
	(32, 'Estefade az selahe garm dar shahr', 800, 2);
INSERT INTO `fine_types` (`id`, `label`, `amount`, `category`) VALUES
	(33, 'Hamle aslahe bedoon e mojavez', 1500, 2);
INSERT INTO `fine_types` (`id`, `label`, `amount`, `category`) VALUES
	(34, 'Dashtan e aslahe gheyre mojaz', 5500, 2);
INSERT INTO `fine_types` (`id`, `label`, `amount`, `category`) VALUES
	(35, 'hamkari nakardan ba mamore ghanon', 2500, 2);
INSERT INTO `fine_types` (`id`, `label`, `amount`, `category`) VALUES
	(36, 'Dozdi khodro', 5000, 2);
INSERT INTO `fine_types` (`id`, `label`, `amount`, `category`) VALUES
	(37, 'Foroosh e mavad e mokhader', 2000, 2);
INSERT INTO `fine_types` (`id`, `label`, `amount`, `category`) VALUES
	(38, 'Tolid e mavad e mokhader', 3500, 2);
INSERT INTO `fine_types` (`id`, `label`, `amount`, `category`) VALUES
	(39, 'Dashtan e mavad e mokhader', 2500, 2);
INSERT INTO `fine_types` (`id`, `label`, `amount`, `category`) VALUES
	(40, 'Majrooh kardan shahrvand', 3500, 2);
INSERT INTO `fine_types` (`id`, `label`, `amount`, `category`) VALUES
	(41, 'Majrooh kardan e mamoor e ghanoon', 5000, 2);
INSERT INTO `fine_types` (`id`, `label`, `amount`, `category`) VALUES
	(42, 'Dozdi', 1500, 2);
INSERT INTO `fine_types` (`id`, `label`, `amount`, `category`) VALUES
	(43, 'Dozdi az maghaze', 5000, 2);
INSERT INTO `fine_types` (`id`, `label`, `amount`, `category`) VALUES
	(44, 'Dozdi az bank', 10000, 2);
INSERT INTO `fine_types` (`id`, `label`, `amount`, `category`) VALUES
	(45, 'Shelik be shahrvandan', 4000, 3);
INSERT INTO `fine_types` (`id`, `label`, `amount`, `category`) VALUES
	(46, 'Shelik be samte mamoor e ghanoon', 7500, 3);
INSERT INTO `fine_types` (`id`, `label`, `amount`, `category`) VALUES
	(47, 'Eghdam be ghatle shahrvand', 5000, 3);
INSERT INTO `fine_types` (`id`, `label`, `amount`, `category`) VALUES
	(48, 'Eghdam be ghatle mamoor e ghanoon', 10000, 3);
INSERT INTO `fine_types` (`id`, `label`, `amount`, `category`) VALUES
	(49, 'Koshtan e shahrvand', 7500, 3);
INSERT INTO `fine_types` (`id`, `label`, `amount`, `category`) VALUES
	(50, 'Koshtan e mamoor e ghanoon', 12500, 3);
INSERT INTO `fine_types` (`id`, `label`, `amount`, `category`) VALUES
	(51, 'Ghatl e gheyre amd', 5000, 3);
INSERT INTO `fine_types` (`id`, `label`, `amount`, `category`) VALUES
	(52, 'Kolah bardari kari', 2500, 2);
INSERT INTO `fine_types` (`id`, `label`, `amount`, `category`) VALUES
	(53, 'Mojavez Aslahe', 15000, 1);
/*!40000 ALTER TABLE `fine_types` ENABLE KEYS */;

-- Dumping structure for table essential.gangs
CREATE TABLE IF NOT EXISTS `gangs` (
  `name` varchar(254) DEFAULT NULL,
  `label` varchar(254) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_persian_ci ROW_FORMAT=DYNAMIC;

-- Dumping data for table essential.gangs: ~4 rows (approximately)
/*!40000 ALTER TABLE `gangs` DISABLE KEYS */;
INSERT INTO `gangs` (`name`, `label`) VALUES
	('nogang', 'nogang');
INSERT INTO `gangs` (`name`, `label`) VALUES
	('asghar', 'gang');
INSERT INTO `gangs` (`name`, `label`) VALUES
	('BAx_va_baradar', 'gang');
INSERT INTO `gangs` (`name`, `label`) VALUES
	('BAx', 'gang');
/*!40000 ALTER TABLE `gangs` ENABLE KEYS */;

-- Dumping structure for table essential.gangs_data
CREATE TABLE IF NOT EXISTS `gangs_data` (
  `ID` int(11) NOT NULL AUTO_INCREMENT,
  `logo` longtext NOT NULL DEFAULT '0',
  `gang_name` varchar(254) DEFAULT NULL,
  `blip` varchar(254) DEFAULT NULL,
  `armory` varchar(254) DEFAULT NULL,
  `locker` varchar(254) DEFAULT NULL,
  `boss` varchar(254) DEFAULT NULL,
  `vehicles` longtext DEFAULT NULL,
  `veh` varchar(254) DEFAULT NULL,
  `vehprop` varchar(254) DEFAULT NULL,
  `vehdel` varchar(254) DEFAULT NULL,
  `vehspawn` varchar(254) DEFAULT NULL,
  `webhook` varchar(255) DEFAULT NULL,
  `bulletproof` int(100) DEFAULT 0,
  `search` varchar(254) DEFAULT NULL,
  `expire_time` date DEFAULT NULL,
  `register_time` date DEFAULT NULL,
  `vest_access` int(11) DEFAULT 0,
  `invite_access` int(11) DEFAULT 6,
  `blip_sprite` int(110) DEFAULT 1,
  `blip_color` int(100) DEFAULT 1,
  `armory_access` int(11) DEFAULT 0,
  `gangsblip` int(11) DEFAULT 0,
  `invperm` int(11) DEFAULT 6,
  `icon` varchar(255) DEFAULT 'https://cdn.discordapp.com/attachments/996093699060678677/1017286980276600842/Mafia.png?size=4096',
  `garage_access` int(11) DEFAULT 0,
  `logpower` int(11) DEFAULT 0,
  `slot` int(255) DEFAULT 10,
  `gps` tinyint(4) DEFAULT NULL,
  `gps_color` int(100) DEFAULT 1,
  `xp` int(11) DEFAULT 0,
  `rank` int(11) DEFAULT 0,
  PRIMARY KEY (`ID`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=41 DEFAULT CHARSET=utf8 COLLATE=utf8_persian_ci ROW_FORMAT=DYNAMIC;

-- Dumping data for table essential.gangs_data: ~3 rows (approximately)
/*!40000 ALTER TABLE `gangs_data` DISABLE KEYS */;
INSERT INTO `gangs_data` (`ID`, `logo`, `gang_name`, `blip`, `armory`, `locker`, `boss`, `vehicles`, `veh`, `vehprop`, `vehdel`, `vehspawn`, `webhook`, `bulletproof`, `search`, `expire_time`, `register_time`, `vest_access`, `invite_access`, `blip_sprite`, `blip_color`, `armory_access`, `gangsblip`, `invperm`, `icon`, `garage_access`, `logpower`, `slot`, `gps`, `gps_color`, `xp`, `rank`) VALUES
	(38, '0', 'asghar', '{"y":81.76506805419922,"x":-1294.924560546875,"z":55.42139434814453}', '{"y":79.64086151123047,"x":-1287.6600341796876,"z":53.9058609008789}', '{"y":78.6995849609375,"x":-1283.153076171875,"z":53.90567398071289}', '{"y":81.04525756835938,"x":-1280.75830078125,"z":53.91144943237305}', '[]', '{"y":84.84817504882813,"x":-1282.8814697265626,"z":53.90581512451172}', '[]', '{"y":87.18743896484375,"x":-1286.041015625,"z":53.9156379699707}', '{"a":66.96993255615235,"x":-1292.577392578125,"y":90.85733032226563,"z":54.91376113891601}', NULL, 0, '1', '2032-10-19', NULL, 0, 6, 1, 1, 0, 0, 6, 'https://cdn.discordapp.com/attachments/996093699060678677/1017286980276600842/Mafia.png?size=4096', 0, 0, 10, NULL, 1, 0, 0);
INSERT INTO `gangs_data` (`ID`, `logo`, `gang_name`, `blip`, `armory`, `locker`, `boss`, `vehicles`, `veh`, `vehprop`, `vehdel`, `vehspawn`, `webhook`, `bulletproof`, `search`, `expire_time`, `register_time`, `vest_access`, `invite_access`, `blip_sprite`, `blip_color`, `armory_access`, `gangsblip`, `invperm`, `icon`, `garage_access`, `logpower`, `slot`, `gps`, `gps_color`, `xp`, `rank`) VALUES
	(39, '0', 'BAx_va_baradar', NULL, NULL, NULL, NULL, '[]', NULL, '[]', NULL, NULL, NULL, 0, NULL, '2023-02-14', NULL, 0, 6, 1, 1, 0, 0, 6, 'https://cdn.discordapp.com/attachments/996093699060678677/1017286980276600842/Mafia.png?size=4096', 0, 0, 10, NULL, 1, 0, 0);
INSERT INTO `gangs_data` (`ID`, `logo`, `gang_name`, `blip`, `armory`, `locker`, `boss`, `vehicles`, `veh`, `vehprop`, `vehdel`, `vehspawn`, `webhook`, `bulletproof`, `search`, `expire_time`, `register_time`, `vest_access`, `invite_access`, `blip_sprite`, `blip_color`, `armory_access`, `gangsblip`, `invperm`, `icon`, `garage_access`, `logpower`, `slot`, `gps`, `gps_color`, `xp`, `rank`) VALUES
	(40, '0', 'BAx', NULL, NULL, NULL, NULL, '[]', NULL, '[]', NULL, NULL, NULL, 0, NULL, '2023-02-14', NULL, 0, 6, 1, 1, 0, 0, 6, 'https://cdn.discordapp.com/attachments/996093699060678677/1017286980276600842/Mafia.png?size=4096', 0, 0, 10, NULL, 1, 0, 0);
/*!40000 ALTER TABLE `gangs_data` ENABLE KEYS */;

-- Dumping structure for table essential.gang_account
CREATE TABLE IF NOT EXISTS `gang_account` (
  `name` varchar(254) DEFAULT NULL,
  `label` varchar(254) DEFAULT NULL,
  `shared` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_persian_ci ROW_FORMAT=DYNAMIC;

-- Dumping data for table essential.gang_account: ~3 rows (approximately)
/*!40000 ALTER TABLE `gang_account` DISABLE KEYS */;
INSERT INTO `gang_account` (`name`, `label`, `shared`) VALUES
	('gang_asghar', 'gang', 1);
INSERT INTO `gang_account` (`name`, `label`, `shared`) VALUES
	('gang_bax_va_baradar', 'gang', 1);
INSERT INTO `gang_account` (`name`, `label`, `shared`) VALUES
	('gang_bax', 'gang', 1);
/*!40000 ALTER TABLE `gang_account` ENABLE KEYS */;

-- Dumping structure for table essential.gang_account_data
CREATE TABLE IF NOT EXISTS `gang_account_data` (
  `ID` int(11) NOT NULL AUTO_INCREMENT,
  `gang_name` varchar(254) DEFAULT NULL,
  `money` double DEFAULT NULL,
  `pay` int(11) DEFAULT NULL,
  `owner` varchar(254) DEFAULT NULL,
  PRIMARY KEY (`ID`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=25 DEFAULT CHARSET=utf8 COLLATE=utf8_persian_ci ROW_FORMAT=DYNAMIC;

-- Dumping data for table essential.gang_account_data: ~3 rows (approximately)
/*!40000 ALTER TABLE `gang_account_data` DISABLE KEYS */;
INSERT INTO `gang_account_data` (`ID`, `gang_name`, `money`, `pay`, `owner`) VALUES
	(22, 'gang_asghar', 0, NULL, NULL);
INSERT INTO `gang_account_data` (`ID`, `gang_name`, `money`, `pay`, `owner`) VALUES
	(23, 'gang_bax_va_baradar', 0, NULL, NULL);
INSERT INTO `gang_account_data` (`ID`, `gang_name`, `money`, `pay`, `owner`) VALUES
	(24, 'gang_bax', 0, NULL, NULL);
/*!40000 ALTER TABLE `gang_account_data` ENABLE KEYS */;

-- Dumping structure for table essential.gang_grades
CREATE TABLE IF NOT EXISTS `gang_grades` (
  `ID` int(11) NOT NULL,
  `gang_name` varchar(50) DEFAULT NULL,
  `grade` int(11) NOT NULL,
  `name` varchar(50) NOT NULL,
  `label` varchar(50) NOT NULL,
  `salary` int(11) NOT NULL,
  `skin_male` longtext NOT NULL,
  `skin_female` longtext NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_persian_ci ROW_FORMAT=DYNAMIC;

-- Dumping data for table essential.gang_grades: ~19 rows (approximately)
/*!40000 ALTER TABLE `gang_grades` DISABLE KEYS */;
INSERT INTO `gang_grades` (`ID`, `gang_name`, `grade`, `name`, `label`, `salary`, `skin_male`, `skin_female`) VALUES
	(0, 'nogang', 0, 'nogang', 'nogang', 0, '[]', '[]');
INSERT INTO `gang_grades` (`ID`, `gang_name`, `grade`, `name`, `label`, `salary`, `skin_male`, `skin_female`) VALUES
	(0, 'asghar', 1, 'Rank 1', 'Thug', 100, '[]', '[]');
INSERT INTO `gang_grades` (`ID`, `gang_name`, `grade`, `name`, `label`, `salary`, `skin_male`, `skin_female`) VALUES
	(0, 'asghar', 2, 'Rank 2', 'Hustler', 200, '[]', '[]');
INSERT INTO `gang_grades` (`ID`, `gang_name`, `grade`, `name`, `label`, `salary`, `skin_male`, `skin_female`) VALUES
	(0, 'asghar', 4, 'Rank 4', 'Trigger', 400, '[]', '[]');
INSERT INTO `gang_grades` (`ID`, `gang_name`, `grade`, `name`, `label`, `salary`, `skin_male`, `skin_female`) VALUES
	(0, 'asghar', 3, 'Rank 3', 'Soldier', 300, '[]', '[]');
INSERT INTO `gang_grades` (`ID`, `gang_name`, `grade`, `name`, `label`, `salary`, `skin_male`, `skin_female`) VALUES
	(0, 'asghar', 5, 'Rank 5', 'Street Boss', 500, '[]', '[]');
INSERT INTO `gang_grades` (`ID`, `gang_name`, `grade`, `name`, `label`, `salary`, `skin_male`, `skin_female`) VALUES
	(0, 'asghar', 6, 'Rank 6', 'Kingpin', 600, '[]', '[]');
INSERT INTO `gang_grades` (`ID`, `gang_name`, `grade`, `name`, `label`, `salary`, `skin_male`, `skin_female`) VALUES
	(0, 'BAx_va_baradar', 1, 'Rank 1', 'Thug', 100, '[]', '[]');
INSERT INTO `gang_grades` (`ID`, `gang_name`, `grade`, `name`, `label`, `salary`, `skin_male`, `skin_female`) VALUES
	(0, 'BAx_va_baradar', 2, 'Rank 2', 'Hustler', 200, '[]', '[]');
INSERT INTO `gang_grades` (`ID`, `gang_name`, `grade`, `name`, `label`, `salary`, `skin_male`, `skin_female`) VALUES
	(0, 'BAx_va_baradar', 3, 'Rank 3', 'Soldier', 300, '[]', '[]');
INSERT INTO `gang_grades` (`ID`, `gang_name`, `grade`, `name`, `label`, `salary`, `skin_male`, `skin_female`) VALUES
	(0, 'BAx_va_baradar', 6, 'Rank 6', 'Kingpin', 600, '[]', '[]');
INSERT INTO `gang_grades` (`ID`, `gang_name`, `grade`, `name`, `label`, `salary`, `skin_male`, `skin_female`) VALUES
	(0, 'BAx_va_baradar', 5, 'Rank 5', 'Street Boss', 500, '[]', '[]');
INSERT INTO `gang_grades` (`ID`, `gang_name`, `grade`, `name`, `label`, `salary`, `skin_male`, `skin_female`) VALUES
	(0, 'BAx_va_baradar', 4, 'Rank 4', 'Trigger', 400, '[]', '[]');
INSERT INTO `gang_grades` (`ID`, `gang_name`, `grade`, `name`, `label`, `salary`, `skin_male`, `skin_female`) VALUES
	(0, 'BAx', 1, 'Rank 1', 'Thug', 100, '[]', '[]');
INSERT INTO `gang_grades` (`ID`, `gang_name`, `grade`, `name`, `label`, `salary`, `skin_male`, `skin_female`) VALUES
	(0, 'BAx', 2, 'Rank 2', 'Hustler', 200, '[]', '[]');
INSERT INTO `gang_grades` (`ID`, `gang_name`, `grade`, `name`, `label`, `salary`, `skin_male`, `skin_female`) VALUES
	(0, 'BAx', 3, 'Rank 3', 'Soldier', 300, '[]', '[]');
INSERT INTO `gang_grades` (`ID`, `gang_name`, `grade`, `name`, `label`, `salary`, `skin_male`, `skin_female`) VALUES
	(0, 'BAx', 4, 'Rank 4', 'Trigger', 400, '[]', '[]');
INSERT INTO `gang_grades` (`ID`, `gang_name`, `grade`, `name`, `label`, `salary`, `skin_male`, `skin_female`) VALUES
	(0, 'BAx', 5, 'Rank 5', 'Street Boss', 500, '[]', '[]');
INSERT INTO `gang_grades` (`ID`, `gang_name`, `grade`, `name`, `label`, `salary`, `skin_male`, `skin_female`) VALUES
	(0, 'BAx', 6, 'Rank 6', 'Kingpin', 600, '[]', '[]');
/*!40000 ALTER TABLE `gang_grades` ENABLE KEYS */;

-- Dumping structure for table essential.instagram_account
CREATE TABLE IF NOT EXISTS `instagram_account` (
  `id` varchar(90) NOT NULL,
  `name` varchar(50) NOT NULL,
  `phone` varchar(50) NOT NULL,
  `username` varchar(50) NOT NULL,
  `password` varchar(50) NOT NULL,
  `avatar` text DEFAULT NULL,
  `description` text DEFAULT NULL,
  `verify` int(11) NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Dumping data for table essential.instagram_account: ~0 rows (approximately)
/*!40000 ALTER TABLE `instagram_account` DISABLE KEYS */;
/*!40000 ALTER TABLE `instagram_account` ENABLE KEYS */;

-- Dumping structure for table essential.instagram_followers
CREATE TABLE IF NOT EXISTS `instagram_followers` (
  `username` varchar(50) NOT NULL,
  `followed` varchar(50) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Dumping data for table essential.instagram_followers: ~0 rows (approximately)
/*!40000 ALTER TABLE `instagram_followers` DISABLE KEYS */;
/*!40000 ALTER TABLE `instagram_followers` ENABLE KEYS */;

-- Dumping structure for table essential.instagram_posts
CREATE TABLE IF NOT EXISTS `instagram_posts` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `username` varchar(50) NOT NULL,
  `image` text NOT NULL,
  `description` varchar(255) NOT NULL,
  `location` varchar(50) NOT NULL DEFAULT 'Los Santos',
  `filter` varchar(50) NOT NULL,
  `created` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `likes` text DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=14 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Dumping data for table essential.instagram_posts: ~0 rows (approximately)
/*!40000 ALTER TABLE `instagram_posts` DISABLE KEYS */;
/*!40000 ALTER TABLE `instagram_posts` ENABLE KEYS */;

-- Dumping structure for table essential.instagram_stories
CREATE TABLE IF NOT EXISTS `instagram_stories` (
  `owner` varchar(50) NOT NULL,
  `data` text DEFAULT NULL,
  PRIMARY KEY (`owner`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=armscii8 COLLATE=armscii8_bin;

-- Dumping data for table essential.instagram_stories: ~0 rows (approximately)
/*!40000 ALTER TABLE `instagram_stories` DISABLE KEYS */;
/*!40000 ALTER TABLE `instagram_stories` ENABLE KEYS */;

-- Dumping structure for table essential.insta_stories
CREATE TABLE IF NOT EXISTS `insta_stories` (
  `username` varchar(50) DEFAULT NULL,
  `location` varchar(50) DEFAULT NULL,
  `filter` varchar(50) DEFAULT NULL,
  `description` varchar(50) DEFAULT NULL,
  `image` text DEFAULT NULL,
  `created` time DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Dumping data for table essential.insta_stories: ~0 rows (approximately)
/*!40000 ALTER TABLE `insta_stories` DISABLE KEYS */;
/*!40000 ALTER TABLE `insta_stories` ENABLE KEYS */;

-- Dumping structure for table essential.items
CREATE TABLE IF NOT EXISTS `items` (
  `name` varchar(50) NOT NULL,
  `label` varchar(255) NOT NULL,
  `limit` int(11) NOT NULL DEFAULT -1,
  `rare` int(11) NOT NULL DEFAULT 0,
  `can_remove` int(11) NOT NULL DEFAULT 1
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin ROW_FORMAT=DYNAMIC;

-- Dumping data for table essential.items: ~346 rows (approximately)
/*!40000 ALTER TABLE `items` DISABLE KEYS */;
INSERT INTO `items` (`name`, `label`, `limit`, `rare`, `can_remove`) VALUES
	('bandage', 'Bandage', 20, 0, 1);
INSERT INTO `items` (`name`, `label`, `limit`, `rare`, `can_remove`) VALUES
	('gazbottle', 'Ghooti gaz', 11, 0, 1);
INSERT INTO `items` (`name`, `label`, `limit`, `rare`, `can_remove`) VALUES
	('fixtool', 'Abzar e tamir', 6, 0, 1);
INSERT INTO `items` (`name`, `label`, `limit`, `rare`, `can_remove`) VALUES
	('carotool', 'Abzar e badane', 4, 0, 1);
INSERT INTO `items` (`name`, `label`, `limit`, `rare`, `can_remove`) VALUES
	('blowpipe', 'Mash`al', 10, 0, 1);
INSERT INTO `items` (`name`, `label`, `limit`, `rare`, `can_remove`) VALUES
	('fixkit', 'Kit Tamir', 5, 0, 1);
INSERT INTO `items` (`name`, `label`, `limit`, `rare`, `can_remove`) VALUES
	('bread', 'Noon', 10, 0, 1);
INSERT INTO `items` (`name`, `label`, `limit`, `rare`, `can_remove`) VALUES
	('water', 'Ab', 5, 0, 1);
INSERT INTO `items` (`name`, `label`, `limit`, `rare`, `can_remove`) VALUES
	('cannabis', 'Hashish', 50, 0, 1);
INSERT INTO `items` (`name`, `label`, `limit`, `rare`, `can_remove`) VALUES
	('marijuana', 'Marijuana', 250, 0, 1);
INSERT INTO `items` (`name`, `label`, `limit`, `rare`, `can_remove`) VALUES
	('coca', 'Tokhm Kokayin', 150, 0, 1);
INSERT INTO `items` (`name`, `label`, `limit`, `rare`, `can_remove`) VALUES
	('cocaine', 'Kokayin', 50, 0, 1);
INSERT INTO `items` (`name`, `label`, `limit`, `rare`, `can_remove`) VALUES
	('ephedra', 'Ephedra', 100, 0, 1);
INSERT INTO `items` (`name`, `label`, `limit`, `rare`, `can_remove`) VALUES
	('ephedrine', 'Ephedrine', 100, 0, 1);
INSERT INTO `items` (`name`, `label`, `limit`, `rare`, `can_remove`) VALUES
	('poppy', 'KhashKhaash', 100, 0, 1);
INSERT INTO `items` (`name`, `label`, `limit`, `rare`, `can_remove`) VALUES
	('opium', 'Teryak', 50, 0, 1);
INSERT INTO `items` (`name`, `label`, `limit`, `rare`, `can_remove`) VALUES
	('meth', 'Shishe', 25, 0, 1);
INSERT INTO `items` (`name`, `label`, `limit`, `rare`, `can_remove`) VALUES
	('heroine', 'Heroine', 10, 0, 1);
INSERT INTO `items` (`name`, `label`, `limit`, `rare`, `can_remove`) VALUES
	('beer', 'Beer', 30, 0, 1);
INSERT INTO `items` (`name`, `label`, `limit`, `rare`, `can_remove`) VALUES
	('tequila', 'Tequila', 10, 0, 1);
INSERT INTO `items` (`name`, `label`, `limit`, `rare`, `can_remove`) VALUES
	('vodka', 'Vodka', 10, 0, 1);
INSERT INTO `items` (`name`, `label`, `limit`, `rare`, `can_remove`) VALUES
	('whiskey', 'Whiskey', 10, 0, 1);
INSERT INTO `items` (`name`, `label`, `limit`, `rare`, `can_remove`) VALUES
	('crack', 'Crack', 25, 0, 1);
INSERT INTO `items` (`name`, `label`, `limit`, `rare`, `can_remove`) VALUES
	('drugtest', 'Test Mavad', 10, 0, 1);
INSERT INTO `items` (`name`, `label`, `limit`, `rare`, `can_remove`) VALUES
	('breathalyzer', 'Test Alchol', 10, 0, 1);
INSERT INTO `items` (`name`, `label`, `limit`, `rare`, `can_remove`) VALUES
	('fakepee', 'Fake Pee', 5, 0, 1);
INSERT INTO `items` (`name`, `label`, `limit`, `rare`, `can_remove`) VALUES
	('pcp', 'PCP', 25, 0, 1);
INSERT INTO `items` (`name`, `label`, `limit`, `rare`, `can_remove`) VALUES
	('dabs', 'Dabs', 50, 0, 1);
INSERT INTO `items` (`name`, `label`, `limit`, `rare`, `can_remove`) VALUES
	('painkiller', 'Painkiller', 10, 0, 1);
INSERT INTO `items` (`name`, `label`, `limit`, `rare`, `can_remove`) VALUES
	('narcan', 'Narcan', 10, 0, 1);
INSERT INTO `items` (`name`, `label`, `limit`, `rare`, `can_remove`) VALUES
	('gps', 'GPS', 1, 0, 1);
INSERT INTO `items` (`name`, `label`, `limit`, `rare`, `can_remove`) VALUES
	('pizza', 'Pitza', 8, 0, 1);
INSERT INTO `items` (`name`, `label`, `limit`, `rare`, `can_remove`) VALUES
	('lighter', 'Fandak', 1, 0, 1);
INSERT INTO `items` (`name`, `label`, `limit`, `rare`, `can_remove`) VALUES
	('creditcard', 'Cart Banki', 1, 0, 1);
INSERT INTO `items` (`name`, `label`, `limit`, `rare`, `can_remove`) VALUES
	('alive_chicken', 'Morgh zende', 20, 0, 1);
INSERT INTO `items` (`name`, `label`, `limit`, `rare`, `can_remove`) VALUES
	('slaughtered_chicken', 'Morgh', 20, 0, 1);
INSERT INTO `items` (`name`, `label`, `limit`, `rare`, `can_remove`) VALUES
	('packaged_chicken', 'Morgh baste bandi shode', 100, 0, 1);
INSERT INTO `items` (`name`, `label`, `limit`, `rare`, `can_remove`) VALUES
	('fish', 'Mahi', 100, 0, 1);
INSERT INTO `items` (`name`, `label`, `limit`, `rare`, `can_remove`) VALUES
	('stone', 'Sang', 7, 0, 1);
INSERT INTO `items` (`name`, `label`, `limit`, `rare`, `can_remove`) VALUES
	('washed_stone', 'Sange boresh khorde', 7, 0, 1);
INSERT INTO `items` (`name`, `label`, `limit`, `rare`, `can_remove`) VALUES
	('copper', 'Mes', 56, 0, 1);
INSERT INTO `items` (`name`, `label`, `limit`, `rare`, `can_remove`) VALUES
	('iron', 'Ahan', 42, 0, 1);
INSERT INTO `items` (`name`, `label`, `limit`, `rare`, `can_remove`) VALUES
	('gold', 'Tala', 21, 0, 1);
INSERT INTO `items` (`name`, `label`, `limit`, `rare`, `can_remove`) VALUES
	('diamond', 'Diamant', 50, 0, 1);
INSERT INTO `items` (`name`, `label`, `limit`, `rare`, `can_remove`) VALUES
	('wood', 'Choob', 20, 0, 1);
INSERT INTO `items` (`name`, `label`, `limit`, `rare`, `can_remove`) VALUES
	('cutted_wood', 'Choobe boresh khorde', 20, 0, 1);
INSERT INTO `items` (`name`, `label`, `limit`, `rare`, `can_remove`) VALUES
	('packaged_plank', 'Choobe baste bandi shode', 100, 0, 1);
INSERT INTO `items` (`name`, `label`, `limit`, `rare`, `can_remove`) VALUES
	('petrol', 'Benzin', 24, 0, 1);
INSERT INTO `items` (`name`, `label`, `limit`, `rare`, `can_remove`) VALUES
	('petrol_raffin', 'Rafin', 24, 0, 1);
INSERT INTO `items` (`name`, `label`, `limit`, `rare`, `can_remove`) VALUES
	('essence', 'Asans', 24, 0, 1);
INSERT INTO `items` (`name`, `label`, `limit`, `rare`, `can_remove`) VALUES
	('wool', 'Pashm', 40, 0, 1);
INSERT INTO `items` (`name`, `label`, `limit`, `rare`, `can_remove`) VALUES
	('fabric', 'Parche', 80, 0, 1);
INSERT INTO `items` (`name`, `label`, `limit`, `rare`, `can_remove`) VALUES
	('clothe', 'Lebas', 40, 0, 1);
INSERT INTO `items` (`name`, `label`, `limit`, `rare`, `can_remove`) VALUES
	('phone', 'Goshi', 1, 0, 1);
INSERT INTO `items` (`name`, `label`, `limit`, `rare`, `can_remove`) VALUES
	('blowtorch', 'Blowtorch', 1, 0, 1);
INSERT INTO `items` (`name`, `label`, `limit`, `rare`, `can_remove`) VALUES
	('drill', 'Drill', 1, 0, 1);
INSERT INTO `items` (`name`, `label`, `limit`, `rare`, `can_remove`) VALUES
	('loole', 'Loole', 3, 0, 1);
INSERT INTO `items` (`name`, `label`, `limit`, `rare`, `can_remove`) VALUES
	('fanar', 'Fanar', 3, 0, 1);
INSERT INTO `items` (`name`, `label`, `limit`, `rare`, `can_remove`) VALUES
	('capsul', 'Capsul', 3, 0, 1);
INSERT INTO `items` (`name`, `label`, `limit`, `rare`, `can_remove`) VALUES
	('lockpick', 'Sanjagh', 3, 0, 1);
INSERT INTO `items` (`name`, `label`, `limit`, `rare`, `can_remove`) VALUES
	('drillsharji', 'Drill Sharji', 3, 0, 1);
INSERT INTO `items` (`name`, `label`, `limit`, `rare`, `can_remove`) VALUES
	('mattezakhim', 'Matte Zakhim', 3, 0, 1);
INSERT INTO `items` (`name`, `label`, `limit`, `rare`, `can_remove`) VALUES
	('battrey', 'Battery', 3, 0, 1);
INSERT INTO `items` (`name`, `label`, `limit`, `rare`, `can_remove`) VALUES
	('carokit', 'Kit e badane', 3, 0, 1);
INSERT INTO `items` (`name`, `label`, `limit`, `rare`, `can_remove`) VALUES
	('yusuf', 'Skin Talaee', 1, 0, 1);
INSERT INTO `items` (`name`, `label`, `limit`, `rare`, `can_remove`) VALUES
	('grip', 'Grip', 3, 0, 1);
INSERT INTO `items` (`name`, `label`, `limit`, `rare`, `can_remove`) VALUES
	('flashlight', 'FlashLight', 3, 0, 1);
INSERT INTO `items` (`name`, `label`, `limit`, `rare`, `can_remove`) VALUES
	('silencer', 'Silencer', 3, 0, 1);
INSERT INTO `items` (`name`, `label`, `limit`, `rare`, `can_remove`) VALUES
	('clip', 'Kheshab', 6, 0, 1);
INSERT INTO `items` (`name`, `label`, `limit`, `rare`, `can_remove`) VALUES
	('bag', 'Bag', 1, 0, 1);
INSERT INTO `items` (`name`, `label`, `limit`, `rare`, `can_remove`) VALUES
	('blank_plate', 'Blank License Plate', -1, 0, 1);
INSERT INTO `items` (`name`, `label`, `limit`, `rare`, `can_remove`) VALUES
	('mahigoli', 'Mahigoli', -1, 0, 1);
INSERT INTO `items` (`name`, `label`, `limit`, `rare`, `can_remove`) VALUES
	('ghezelala', 'ghezelala\'', -1, 0, 1);
INSERT INTO `items` (`name`, `label`, `limit`, `rare`, `can_remove`) VALUES
	('hamoor', 'hamoor', -1, 0, 1);
INSERT INTO `items` (`name`, `label`, `limit`, `rare`, `can_remove`) VALUES
	('salomon', 'salomon', -1, 0, 1);
INSERT INTO `items` (`name`, `label`, `limit`, `rare`, `can_remove`) VALUES
	('dampaii', 'Dampaii', -1, 0, 1);
INSERT INTO `items` (`name`, `label`, `limit`, `rare`, `can_remove`) VALUES
	('meygoo', 'Meygoo', -1, 0, 1);
INSERT INTO `items` (`name`, `label`, `limit`, `rare`, `can_remove`) VALUES
	('fishingrod', 'Gholab', -1, 0, 1);
INSERT INTO `items` (`name`, `label`, `limit`, `rare`, `can_remove`) VALUES
	('cocacola', 'Coca Cola', -1, 0, 1);
INSERT INTO `items` (`name`, `label`, `limit`, `rare`, `can_remove`) VALUES
	('fanta', 'Fanta', -1, 0, 1);
INSERT INTO `items` (`name`, `label`, `limit`, `rare`, `can_remove`) VALUES
	('sprite', 'Sprite', -1, 0, 1);
INSERT INTO `items` (`name`, `label`, `limit`, `rare`, `can_remove`) VALUES
	('loka', 'Abmive', -1, 0, 1);
INSERT INTO `items` (`name`, `label`, `limit`, `rare`, `can_remove`) VALUES
	('cheesebows', 'Snack', -1, 0, 1);
INSERT INTO `items` (`name`, `label`, `limit`, `rare`, `can_remove`) VALUES
	('chips', 'Chips', -1, 0, 1);
INSERT INTO `items` (`name`, `label`, `limit`, `rare`, `can_remove`) VALUES
	('marabou', 'Shokolat', -1, 0, 1);
INSERT INTO `items` (`name`, `label`, `limit`, `rare`, `can_remove`) VALUES
	('burger', 'Burger', -1, 0, 1);
INSERT INTO `items` (`name`, `label`, `limit`, `rare`, `can_remove`) VALUES
	('pastacarbonara', 'Paste', -1, 0, 1);
INSERT INTO `items` (`name`, `label`, `limit`, `rare`, `can_remove`) VALUES
	('macka', 'Sandwitch', -1, 0, 1);
INSERT INTO `items` (`name`, `label`, `limit`, `rare`, `can_remove`) VALUES
	('cigarett', 'Cigar', -1, 0, 1);
INSERT INTO `items` (`name`, `label`, `limit`, `rare`, `can_remove`) VALUES
	('lotteryticket', 'Blit Bakht Azmayi', -1, 0, 1);
INSERT INTO `items` (`name`, `label`, `limit`, `rare`, `can_remove`) VALUES
	('silencieux', 'Silencieux', -1, 0, 1);
INSERT INTO `items` (`name`, `label`, `limit`, `rare`, `can_remove`) VALUES
	('radio', 'Bisim', 5, 0, 1);
INSERT INTO `items` (`name`, `label`, `limit`, `rare`, `can_remove`) VALUES
	('bandage', 'Bandage', 20, 0, 1);
INSERT INTO `items` (`name`, `label`, `limit`, `rare`, `can_remove`) VALUES
	('gazbottle', 'Ghooti gaz', 11, 0, 1);
INSERT INTO `items` (`name`, `label`, `limit`, `rare`, `can_remove`) VALUES
	('fixtool', 'Abzar e tamir', 6, 0, 1);
INSERT INTO `items` (`name`, `label`, `limit`, `rare`, `can_remove`) VALUES
	('carotool', 'Abzar e badane', 4, 0, 1);
INSERT INTO `items` (`name`, `label`, `limit`, `rare`, `can_remove`) VALUES
	('blowpipe', 'Mash`al', 10, 0, 1);
INSERT INTO `items` (`name`, `label`, `limit`, `rare`, `can_remove`) VALUES
	('fixkit', 'Kit Tamir', 5, 0, 1);
INSERT INTO `items` (`name`, `label`, `limit`, `rare`, `can_remove`) VALUES
	('bread', 'Noon', 10, 0, 1);
INSERT INTO `items` (`name`, `label`, `limit`, `rare`, `can_remove`) VALUES
	('water', 'Ab', 5, 0, 1);
INSERT INTO `items` (`name`, `label`, `limit`, `rare`, `can_remove`) VALUES
	('cannabis', 'Hashish', 50, 0, 1);
INSERT INTO `items` (`name`, `label`, `limit`, `rare`, `can_remove`) VALUES
	('marijuana', 'Marijuana', 250, 0, 1);
INSERT INTO `items` (`name`, `label`, `limit`, `rare`, `can_remove`) VALUES
	('coca', 'Tokhm Kokayin', 150, 0, 1);
INSERT INTO `items` (`name`, `label`, `limit`, `rare`, `can_remove`) VALUES
	('cocaine', 'Kokayin', 50, 0, 1);
INSERT INTO `items` (`name`, `label`, `limit`, `rare`, `can_remove`) VALUES
	('ephedra', 'Ephedra', 100, 0, 1);
INSERT INTO `items` (`name`, `label`, `limit`, `rare`, `can_remove`) VALUES
	('ephedrine', 'Ephedrine', 100, 0, 1);
INSERT INTO `items` (`name`, `label`, `limit`, `rare`, `can_remove`) VALUES
	('poppy', 'KhashKhaash', 100, 0, 1);
INSERT INTO `items` (`name`, `label`, `limit`, `rare`, `can_remove`) VALUES
	('opium', 'Teryak', 50, 0, 1);
INSERT INTO `items` (`name`, `label`, `limit`, `rare`, `can_remove`) VALUES
	('meth', 'Shishe', 25, 0, 1);
INSERT INTO `items` (`name`, `label`, `limit`, `rare`, `can_remove`) VALUES
	('heroine', 'Heroine', 10, 0, 1);
INSERT INTO `items` (`name`, `label`, `limit`, `rare`, `can_remove`) VALUES
	('beer', 'Beer', 30, 0, 1);
INSERT INTO `items` (`name`, `label`, `limit`, `rare`, `can_remove`) VALUES
	('tequila', 'Tequila', 10, 0, 1);
INSERT INTO `items` (`name`, `label`, `limit`, `rare`, `can_remove`) VALUES
	('vodka', 'Vodka', 10, 0, 1);
INSERT INTO `items` (`name`, `label`, `limit`, `rare`, `can_remove`) VALUES
	('whiskey', 'Whiskey', 10, 0, 1);
INSERT INTO `items` (`name`, `label`, `limit`, `rare`, `can_remove`) VALUES
	('crack', 'Crack', 25, 0, 1);
INSERT INTO `items` (`name`, `label`, `limit`, `rare`, `can_remove`) VALUES
	('drugtest', 'Test Mavad', 10, 0, 1);
INSERT INTO `items` (`name`, `label`, `limit`, `rare`, `can_remove`) VALUES
	('breathalyzer', 'Test Alchol', 10, 0, 1);
INSERT INTO `items` (`name`, `label`, `limit`, `rare`, `can_remove`) VALUES
	('fakepee', 'Fake Pee', 5, 0, 1);
INSERT INTO `items` (`name`, `label`, `limit`, `rare`, `can_remove`) VALUES
	('pcp', 'PCP', 25, 0, 1);
INSERT INTO `items` (`name`, `label`, `limit`, `rare`, `can_remove`) VALUES
	('dabs', 'Dabs', 50, 0, 1);
INSERT INTO `items` (`name`, `label`, `limit`, `rare`, `can_remove`) VALUES
	('painkiller', 'Painkiller', 10, 0, 1);
INSERT INTO `items` (`name`, `label`, `limit`, `rare`, `can_remove`) VALUES
	('narcan', 'Narcan', 10, 0, 1);
INSERT INTO `items` (`name`, `label`, `limit`, `rare`, `can_remove`) VALUES
	('gps', 'GPS', 1, 0, 1);
INSERT INTO `items` (`name`, `label`, `limit`, `rare`, `can_remove`) VALUES
	('pizza', 'Pitza', 8, 0, 1);
INSERT INTO `items` (`name`, `label`, `limit`, `rare`, `can_remove`) VALUES
	('lighter', 'Fandak', 1, 0, 1);
INSERT INTO `items` (`name`, `label`, `limit`, `rare`, `can_remove`) VALUES
	('creditcard', 'Cart Banki', 1, 0, 1);
INSERT INTO `items` (`name`, `label`, `limit`, `rare`, `can_remove`) VALUES
	('alive_chicken', 'Morgh zende', 20, 0, 1);
INSERT INTO `items` (`name`, `label`, `limit`, `rare`, `can_remove`) VALUES
	('slaughtered_chicken', 'Morgh', 20, 0, 1);
INSERT INTO `items` (`name`, `label`, `limit`, `rare`, `can_remove`) VALUES
	('packaged_chicken', 'Morgh baste bandi shode', 100, 0, 1);
INSERT INTO `items` (`name`, `label`, `limit`, `rare`, `can_remove`) VALUES
	('fish', 'Mahi', 100, 0, 1);
INSERT INTO `items` (`name`, `label`, `limit`, `rare`, `can_remove`) VALUES
	('stone', 'Sang', 7, 0, 1);
INSERT INTO `items` (`name`, `label`, `limit`, `rare`, `can_remove`) VALUES
	('washed_stone', 'Sange boresh khorde', 7, 0, 1);
INSERT INTO `items` (`name`, `label`, `limit`, `rare`, `can_remove`) VALUES
	('copper', 'Mes', 56, 0, 1);
INSERT INTO `items` (`name`, `label`, `limit`, `rare`, `can_remove`) VALUES
	('iron', 'Ahan', 42, 0, 1);
INSERT INTO `items` (`name`, `label`, `limit`, `rare`, `can_remove`) VALUES
	('gold', 'Tala', 21, 0, 1);
INSERT INTO `items` (`name`, `label`, `limit`, `rare`, `can_remove`) VALUES
	('diamond', 'Diamant', 50, 0, 1);
INSERT INTO `items` (`name`, `label`, `limit`, `rare`, `can_remove`) VALUES
	('wood', 'Choob', 20, 0, 1);
INSERT INTO `items` (`name`, `label`, `limit`, `rare`, `can_remove`) VALUES
	('cutted_wood', 'Choobe boresh khorde', 20, 0, 1);
INSERT INTO `items` (`name`, `label`, `limit`, `rare`, `can_remove`) VALUES
	('packaged_plank', 'Choobe baste bandi shode', 100, 0, 1);
INSERT INTO `items` (`name`, `label`, `limit`, `rare`, `can_remove`) VALUES
	('petrol', 'Benzin', 24, 0, 1);
INSERT INTO `items` (`name`, `label`, `limit`, `rare`, `can_remove`) VALUES
	('petrol_raffin', 'Rafin', 24, 0, 1);
INSERT INTO `items` (`name`, `label`, `limit`, `rare`, `can_remove`) VALUES
	('essence', 'Asans', 24, 0, 1);
INSERT INTO `items` (`name`, `label`, `limit`, `rare`, `can_remove`) VALUES
	('wool', 'Pashm', 40, 0, 1);
INSERT INTO `items` (`name`, `label`, `limit`, `rare`, `can_remove`) VALUES
	('fabric', 'Parche', 80, 0, 1);
INSERT INTO `items` (`name`, `label`, `limit`, `rare`, `can_remove`) VALUES
	('clothe', 'Lebas', 40, 0, 1);
INSERT INTO `items` (`name`, `label`, `limit`, `rare`, `can_remove`) VALUES
	('phone', 'Goshi', 1, 0, 1);
INSERT INTO `items` (`name`, `label`, `limit`, `rare`, `can_remove`) VALUES
	('blowtorch', 'Blowtorch', 1, 0, 1);
INSERT INTO `items` (`name`, `label`, `limit`, `rare`, `can_remove`) VALUES
	('drill', 'Drill', 1, 0, 1);
INSERT INTO `items` (`name`, `label`, `limit`, `rare`, `can_remove`) VALUES
	('loole', 'Loole', 3, 0, 1);
INSERT INTO `items` (`name`, `label`, `limit`, `rare`, `can_remove`) VALUES
	('fanar', 'Fanar', 3, 0, 1);
INSERT INTO `items` (`name`, `label`, `limit`, `rare`, `can_remove`) VALUES
	('capsul', 'Capsul', 3, 0, 1);
INSERT INTO `items` (`name`, `label`, `limit`, `rare`, `can_remove`) VALUES
	('lockpick', 'Sanjagh', 3, 0, 1);
INSERT INTO `items` (`name`, `label`, `limit`, `rare`, `can_remove`) VALUES
	('drillsharji', 'Drill Sharji', 3, 0, 1);
INSERT INTO `items` (`name`, `label`, `limit`, `rare`, `can_remove`) VALUES
	('mattezakhim', 'Matte Zakhim', 3, 0, 1);
INSERT INTO `items` (`name`, `label`, `limit`, `rare`, `can_remove`) VALUES
	('battrey', 'Battery', 3, 0, 1);
INSERT INTO `items` (`name`, `label`, `limit`, `rare`, `can_remove`) VALUES
	('carokit', 'Kit e badane', 3, 0, 1);
INSERT INTO `items` (`name`, `label`, `limit`, `rare`, `can_remove`) VALUES
	('yusuf', 'Skin Talaee', 1, 0, 1);
INSERT INTO `items` (`name`, `label`, `limit`, `rare`, `can_remove`) VALUES
	('grip', 'Grip', 3, 0, 1);
INSERT INTO `items` (`name`, `label`, `limit`, `rare`, `can_remove`) VALUES
	('flashlight', 'FlashLight', 3, 0, 1);
INSERT INTO `items` (`name`, `label`, `limit`, `rare`, `can_remove`) VALUES
	('silencer', 'Silencer', 3, 0, 1);
INSERT INTO `items` (`name`, `label`, `limit`, `rare`, `can_remove`) VALUES
	('clip', 'Kheshab', 6, 0, 1);
INSERT INTO `items` (`name`, `label`, `limit`, `rare`, `can_remove`) VALUES
	('bag', 'Bag', 1, 0, 1);
INSERT INTO `items` (`name`, `label`, `limit`, `rare`, `can_remove`) VALUES
	('blank_plate', 'Blank License Plate', -1, 0, 1);
INSERT INTO `items` (`name`, `label`, `limit`, `rare`, `can_remove`) VALUES
	('mahigoli', 'Mahigoli', -1, 0, 1);
INSERT INTO `items` (`name`, `label`, `limit`, `rare`, `can_remove`) VALUES
	('ghezelala', 'ghezelala\'', -1, 0, 1);
INSERT INTO `items` (`name`, `label`, `limit`, `rare`, `can_remove`) VALUES
	('hamoor', 'hamoor', -1, 0, 1);
INSERT INTO `items` (`name`, `label`, `limit`, `rare`, `can_remove`) VALUES
	('salomon', 'salomon', -1, 0, 1);
INSERT INTO `items` (`name`, `label`, `limit`, `rare`, `can_remove`) VALUES
	('dampaii', 'Dampaii', -1, 0, 1);
INSERT INTO `items` (`name`, `label`, `limit`, `rare`, `can_remove`) VALUES
	('meygoo', 'Meygoo', -1, 0, 1);
INSERT INTO `items` (`name`, `label`, `limit`, `rare`, `can_remove`) VALUES
	('fishingrod', 'Gholab', -1, 0, 1);
INSERT INTO `items` (`name`, `label`, `limit`, `rare`, `can_remove`) VALUES
	('cocacola', 'Coca Cola', -1, 0, 1);
INSERT INTO `items` (`name`, `label`, `limit`, `rare`, `can_remove`) VALUES
	('fanta', 'Fanta', -1, 0, 1);
INSERT INTO `items` (`name`, `label`, `limit`, `rare`, `can_remove`) VALUES
	('sprite', 'Sprite', -1, 0, 1);
INSERT INTO `items` (`name`, `label`, `limit`, `rare`, `can_remove`) VALUES
	('loka', 'Abmive', -1, 0, 1);
INSERT INTO `items` (`name`, `label`, `limit`, `rare`, `can_remove`) VALUES
	('cheesebows', 'Snack', -1, 0, 1);
INSERT INTO `items` (`name`, `label`, `limit`, `rare`, `can_remove`) VALUES
	('chips', 'Chips', -1, 0, 1);
INSERT INTO `items` (`name`, `label`, `limit`, `rare`, `can_remove`) VALUES
	('marabou', 'Shokolat', -1, 0, 1);
INSERT INTO `items` (`name`, `label`, `limit`, `rare`, `can_remove`) VALUES
	('burger', 'Burger', -1, 0, 1);
INSERT INTO `items` (`name`, `label`, `limit`, `rare`, `can_remove`) VALUES
	('pastacarbonara', 'Paste', -1, 0, 1);
INSERT INTO `items` (`name`, `label`, `limit`, `rare`, `can_remove`) VALUES
	('macka', 'Sandwitch', -1, 0, 1);
INSERT INTO `items` (`name`, `label`, `limit`, `rare`, `can_remove`) VALUES
	('cigarett', 'Cigar', -1, 0, 1);
INSERT INTO `items` (`name`, `label`, `limit`, `rare`, `can_remove`) VALUES
	('lotteryticket', 'Blit Bakht Azmayi', -1, 0, 1);
INSERT INTO `items` (`name`, `label`, `limit`, `rare`, `can_remove`) VALUES
	('silencieux', 'Silencieux', -1, 0, 1);
INSERT INTO `items` (`name`, `label`, `limit`, `rare`, `can_remove`) VALUES
	('radio', 'Bisim', 5, 0, 1);
INSERT INTO `items` (`name`, `label`, `limit`, `rare`, `can_remove`) VALUES
	('bandage', 'Bandage', 20, 0, 1);
INSERT INTO `items` (`name`, `label`, `limit`, `rare`, `can_remove`) VALUES
	('medikit', 'Medikit', 20, 0, 1);
INSERT INTO `items` (`name`, `label`, `limit`, `rare`, `can_remove`) VALUES
	('gazbottle', 'Ghooti gaz', 11, 0, 1);
INSERT INTO `items` (`name`, `label`, `limit`, `rare`, `can_remove`) VALUES
	('fixtool', 'Abzar e tamir', 6, 0, 1);
INSERT INTO `items` (`name`, `label`, `limit`, `rare`, `can_remove`) VALUES
	('carotool', 'Abzar e badane', 4, 0, 1);
INSERT INTO `items` (`name`, `label`, `limit`, `rare`, `can_remove`) VALUES
	('blowpipe', 'Mash`al', 10, 0, 1);
INSERT INTO `items` (`name`, `label`, `limit`, `rare`, `can_remove`) VALUES
	('fixkit', 'Kit Tamir', 5, 0, 1);
INSERT INTO `items` (`name`, `label`, `limit`, `rare`, `can_remove`) VALUES
	('bread', 'Noon', 10, 0, 1);
INSERT INTO `items` (`name`, `label`, `limit`, `rare`, `can_remove`) VALUES
	('water', 'Ab', 5, 0, 1);
INSERT INTO `items` (`name`, `label`, `limit`, `rare`, `can_remove`) VALUES
	('cannabis', 'Hashish', 50, 0, 1);
INSERT INTO `items` (`name`, `label`, `limit`, `rare`, `can_remove`) VALUES
	('marijuana', 'Marijuana', 250, 0, 1);
INSERT INTO `items` (`name`, `label`, `limit`, `rare`, `can_remove`) VALUES
	('coca', 'Tokhm Kokayin', 150, 0, 1);
INSERT INTO `items` (`name`, `label`, `limit`, `rare`, `can_remove`) VALUES
	('cocaine', 'Kokayin', 50, 0, 1);
INSERT INTO `items` (`name`, `label`, `limit`, `rare`, `can_remove`) VALUES
	('ephedra', 'Ephedra', 100, 0, 1);
INSERT INTO `items` (`name`, `label`, `limit`, `rare`, `can_remove`) VALUES
	('ephedrine', 'Ephedrine', 100, 0, 1);
INSERT INTO `items` (`name`, `label`, `limit`, `rare`, `can_remove`) VALUES
	('poppy', 'KhashKhaash', 100, 0, 1);
INSERT INTO `items` (`name`, `label`, `limit`, `rare`, `can_remove`) VALUES
	('opium', 'Teryak', 50, 0, 1);
INSERT INTO `items` (`name`, `label`, `limit`, `rare`, `can_remove`) VALUES
	('meth', 'Shishe', 25, 0, 1);
INSERT INTO `items` (`name`, `label`, `limit`, `rare`, `can_remove`) VALUES
	('heroine', 'Heroine', 10, 0, 1);
INSERT INTO `items` (`name`, `label`, `limit`, `rare`, `can_remove`) VALUES
	('beer', 'Beer', 30, 0, 1);
INSERT INTO `items` (`name`, `label`, `limit`, `rare`, `can_remove`) VALUES
	('tequila', 'Tequila', 10, 0, 1);
INSERT INTO `items` (`name`, `label`, `limit`, `rare`, `can_remove`) VALUES
	('vodka', 'Vodka', 10, 0, 1);
INSERT INTO `items` (`name`, `label`, `limit`, `rare`, `can_remove`) VALUES
	('whiskey', 'Whiskey', 10, 0, 1);
INSERT INTO `items` (`name`, `label`, `limit`, `rare`, `can_remove`) VALUES
	('crack', 'Crack', 25, 0, 1);
INSERT INTO `items` (`name`, `label`, `limit`, `rare`, `can_remove`) VALUES
	('drugtest', 'Test Mavad', 10, 0, 1);
INSERT INTO `items` (`name`, `label`, `limit`, `rare`, `can_remove`) VALUES
	('breathalyzer', 'Test Alchol', 10, 0, 1);
INSERT INTO `items` (`name`, `label`, `limit`, `rare`, `can_remove`) VALUES
	('fakepee', 'Fake Pee', 5, 0, 1);
INSERT INTO `items` (`name`, `label`, `limit`, `rare`, `can_remove`) VALUES
	('pcp', 'PCP', 25, 0, 1);
INSERT INTO `items` (`name`, `label`, `limit`, `rare`, `can_remove`) VALUES
	('dabs', 'Dabs', 50, 0, 1);
INSERT INTO `items` (`name`, `label`, `limit`, `rare`, `can_remove`) VALUES
	('painkiller', 'Painkiller', 10, 0, 1);
INSERT INTO `items` (`name`, `label`, `limit`, `rare`, `can_remove`) VALUES
	('narcan', 'Narcan', 10, 0, 1);
INSERT INTO `items` (`name`, `label`, `limit`, `rare`, `can_remove`) VALUES
	('gps', 'GPS', 1, 0, 1);
INSERT INTO `items` (`name`, `label`, `limit`, `rare`, `can_remove`) VALUES
	('pizza', 'Pitza', 8, 0, 1);
INSERT INTO `items` (`name`, `label`, `limit`, `rare`, `can_remove`) VALUES
	('lighter', 'Fandak', 1, 0, 1);
INSERT INTO `items` (`name`, `label`, `limit`, `rare`, `can_remove`) VALUES
	('creditcard', 'Cart Banki', 1, 0, 1);
INSERT INTO `items` (`name`, `label`, `limit`, `rare`, `can_remove`) VALUES
	('alive_chicken', 'Morgh zende', 20, 0, 1);
INSERT INTO `items` (`name`, `label`, `limit`, `rare`, `can_remove`) VALUES
	('slaughtered_chicken', 'Morgh', 20, 0, 1);
INSERT INTO `items` (`name`, `label`, `limit`, `rare`, `can_remove`) VALUES
	('packaged_chicken', 'Morgh baste bandi shode', 100, 0, 1);
INSERT INTO `items` (`name`, `label`, `limit`, `rare`, `can_remove`) VALUES
	('fish', 'Mahi', 100, 0, 1);
INSERT INTO `items` (`name`, `label`, `limit`, `rare`, `can_remove`) VALUES
	('stone', 'Sang', 7, 0, 1);
INSERT INTO `items` (`name`, `label`, `limit`, `rare`, `can_remove`) VALUES
	('washed_stone', 'Sange boresh khorde', 7, 0, 1);
INSERT INTO `items` (`name`, `label`, `limit`, `rare`, `can_remove`) VALUES
	('copper', 'Mes', 56, 0, 1);
INSERT INTO `items` (`name`, `label`, `limit`, `rare`, `can_remove`) VALUES
	('iron', 'Ahan', 42, 0, 1);
INSERT INTO `items` (`name`, `label`, `limit`, `rare`, `can_remove`) VALUES
	('gold', 'Tala', 21, 0, 1);
INSERT INTO `items` (`name`, `label`, `limit`, `rare`, `can_remove`) VALUES
	('diamond', 'Diamant', 50, 0, 1);
INSERT INTO `items` (`name`, `label`, `limit`, `rare`, `can_remove`) VALUES
	('wood', 'Choob', 20, 0, 1);
INSERT INTO `items` (`name`, `label`, `limit`, `rare`, `can_remove`) VALUES
	('cutted_wood', 'Choobe boresh khorde', 20, 0, 1);
INSERT INTO `items` (`name`, `label`, `limit`, `rare`, `can_remove`) VALUES
	('packaged_plank', 'Choobe baste bandi shode', 100, 0, 1);
INSERT INTO `items` (`name`, `label`, `limit`, `rare`, `can_remove`) VALUES
	('petrol', 'Benzin', 24, 0, 1);
INSERT INTO `items` (`name`, `label`, `limit`, `rare`, `can_remove`) VALUES
	('petrol_raffin', 'Rafin', 24, 0, 1);
INSERT INTO `items` (`name`, `label`, `limit`, `rare`, `can_remove`) VALUES
	('essence', 'Asans', 24, 0, 1);
INSERT INTO `items` (`name`, `label`, `limit`, `rare`, `can_remove`) VALUES
	('wool', 'Pashm', 40, 0, 1);
INSERT INTO `items` (`name`, `label`, `limit`, `rare`, `can_remove`) VALUES
	('fabric', 'Parche', 80, 0, 1);
INSERT INTO `items` (`name`, `label`, `limit`, `rare`, `can_remove`) VALUES
	('clothe', 'Lebas', 40, 0, 1);
INSERT INTO `items` (`name`, `label`, `limit`, `rare`, `can_remove`) VALUES
	('phone', 'Goshi', 1, 0, 1);
INSERT INTO `items` (`name`, `label`, `limit`, `rare`, `can_remove`) VALUES
	('blowtorch', 'Blowtorch', 1, 0, 1);
INSERT INTO `items` (`name`, `label`, `limit`, `rare`, `can_remove`) VALUES
	('drill', 'Drill', 1, 0, 1);
INSERT INTO `items` (`name`, `label`, `limit`, `rare`, `can_remove`) VALUES
	('loole', 'Loole', 3, 0, 1);
INSERT INTO `items` (`name`, `label`, `limit`, `rare`, `can_remove`) VALUES
	('fanar', 'Fanar', 3, 0, 1);
INSERT INTO `items` (`name`, `label`, `limit`, `rare`, `can_remove`) VALUES
	('capsul', 'Capsul', 3, 0, 1);
INSERT INTO `items` (`name`, `label`, `limit`, `rare`, `can_remove`) VALUES
	('lockpick', 'Sanjagh', 3, 0, 1);
INSERT INTO `items` (`name`, `label`, `limit`, `rare`, `can_remove`) VALUES
	('drillsharji', 'Drill Sharji', 3, 0, 1);
INSERT INTO `items` (`name`, `label`, `limit`, `rare`, `can_remove`) VALUES
	('mattezakhim', 'Matte Zakhim', 3, 0, 1);
INSERT INTO `items` (`name`, `label`, `limit`, `rare`, `can_remove`) VALUES
	('battrey', 'Battery', 3, 0, 1);
INSERT INTO `items` (`name`, `label`, `limit`, `rare`, `can_remove`) VALUES
	('carokit', 'Kit e badane', 3, 0, 1);
INSERT INTO `items` (`name`, `label`, `limit`, `rare`, `can_remove`) VALUES
	('yusuf', 'Skin Talaee', 1, 0, 1);
INSERT INTO `items` (`name`, `label`, `limit`, `rare`, `can_remove`) VALUES
	('grip', 'Grip', 3, 0, 1);
INSERT INTO `items` (`name`, `label`, `limit`, `rare`, `can_remove`) VALUES
	('flashlight', 'FlashLight', 3, 0, 1);
INSERT INTO `items` (`name`, `label`, `limit`, `rare`, `can_remove`) VALUES
	('silencer', 'Silencer', 3, 0, 1);
INSERT INTO `items` (`name`, `label`, `limit`, `rare`, `can_remove`) VALUES
	('clip', 'Kheshab', 6, 0, 1);
INSERT INTO `items` (`name`, `label`, `limit`, `rare`, `can_remove`) VALUES
	('bag', 'Bag', 1, 0, 1);
INSERT INTO `items` (`name`, `label`, `limit`, `rare`, `can_remove`) VALUES
	('blank_plate', 'Blank License Plate', -1, 0, 1);
INSERT INTO `items` (`name`, `label`, `limit`, `rare`, `can_remove`) VALUES
	('mahigoli', 'Mahigoli', -1, 0, 1);
INSERT INTO `items` (`name`, `label`, `limit`, `rare`, `can_remove`) VALUES
	('ghezelala', 'ghezelala\'', -1, 0, 1);
INSERT INTO `items` (`name`, `label`, `limit`, `rare`, `can_remove`) VALUES
	('hamoor', 'hamoor', -1, 0, 1);
INSERT INTO `items` (`name`, `label`, `limit`, `rare`, `can_remove`) VALUES
	('salomon', 'salomon', -1, 0, 1);
INSERT INTO `items` (`name`, `label`, `limit`, `rare`, `can_remove`) VALUES
	('dampaii', 'Dampaii', -1, 0, 1);
INSERT INTO `items` (`name`, `label`, `limit`, `rare`, `can_remove`) VALUES
	('meygoo', 'Meygoo', -1, 0, 1);
INSERT INTO `items` (`name`, `label`, `limit`, `rare`, `can_remove`) VALUES
	('fishingrod', 'Gholab', -1, 0, 1);
INSERT INTO `items` (`name`, `label`, `limit`, `rare`, `can_remove`) VALUES
	('cocacola', 'Coca Cola', -1, 0, 1);
INSERT INTO `items` (`name`, `label`, `limit`, `rare`, `can_remove`) VALUES
	('fanta', 'Fanta', -1, 0, 1);
INSERT INTO `items` (`name`, `label`, `limit`, `rare`, `can_remove`) VALUES
	('sprite', 'Sprite', -1, 0, 1);
INSERT INTO `items` (`name`, `label`, `limit`, `rare`, `can_remove`) VALUES
	('loka', 'Abmive', -1, 0, 1);
INSERT INTO `items` (`name`, `label`, `limit`, `rare`, `can_remove`) VALUES
	('cheesebows', 'Snack', -1, 0, 1);
INSERT INTO `items` (`name`, `label`, `limit`, `rare`, `can_remove`) VALUES
	('chips', 'Chips', -1, 0, 1);
INSERT INTO `items` (`name`, `label`, `limit`, `rare`, `can_remove`) VALUES
	('marabou', 'Shokolat', -1, 0, 1);
INSERT INTO `items` (`name`, `label`, `limit`, `rare`, `can_remove`) VALUES
	('burger', 'Burger', -1, 0, 1);
INSERT INTO `items` (`name`, `label`, `limit`, `rare`, `can_remove`) VALUES
	('pastacarbonara', 'Paste', -1, 0, 1);
INSERT INTO `items` (`name`, `label`, `limit`, `rare`, `can_remove`) VALUES
	('macka', 'Sandwitch', -1, 0, 1);
INSERT INTO `items` (`name`, `label`, `limit`, `rare`, `can_remove`) VALUES
	('cigarett', 'Cigar', -1, 0, 1);
INSERT INTO `items` (`name`, `label`, `limit`, `rare`, `can_remove`) VALUES
	('lotteryticket', 'Blit Bakht Azmayi', -1, 0, 1);
INSERT INTO `items` (`name`, `label`, `limit`, `rare`, `can_remove`) VALUES
	('silencieux', 'Silencieux', -1, 0, 1);
INSERT INTO `items` (`name`, `label`, `limit`, `rare`, `can_remove`) VALUES
	('radio', 'Bisim', 5, 0, 1);
INSERT INTO `items` (`name`, `label`, `limit`, `rare`, `can_remove`) VALUES
	('picklock', 'PickLock', 3, 0, 1);
INSERT INTO `items` (`name`, `label`, `limit`, `rare`, `can_remove`) VALUES
	('net_cracker', 'Net Cracker', 2, 0, 1);
INSERT INTO `items` (`name`, `label`, `limit`, `rare`, `can_remove`) VALUES
	('thermite', 'Thermite Bomb', 5, 0, 1);
INSERT INTO `items` (`name`, `label`, `limit`, `rare`, `can_remove`) VALUES
	('levonorgestrel', 'Ghors Emergency', 2, 0, 1);
INSERT INTO `items` (`name`, `label`, `limit`, `rare`, `can_remove`) VALUES
	('condom', 'Condom Khardar', 3, 0, 1);
INSERT INTO `items` (`name`, `label`, `limit`, `rare`, `can_remove`) VALUES
	('mifepristone', 'mifepristone', 4, 0, 1);
INSERT INTO `items` (`name`, `label`, `limit`, `rare`, `can_remove`) VALUES
	('testpack', 'Baby Check', 1, 0, 1);
INSERT INTO `items` (`name`, `label`, `limit`, `rare`, `can_remove`) VALUES
	('viagra', 'Taghviyat Jensi', 6, 0, 1);
INSERT INTO `items` (`name`, `label`, `limit`, `rare`, `can_remove`) VALUES
	('powiekszonymagazynek', 'Extended Clip', 20, 0, 1);
INSERT INTO `items` (`name`, `label`, `limit`, `rare`, `can_remove`) VALUES
	('kompensator', 'Compensator', -1, 0, 1);
INSERT INTO `items` (`name`, `label`, `limit`, `rare`, `can_remove`) VALUES
	('MountedScope', 'Scope Pistols MK2', -1, 0, 1);
INSERT INTO `items` (`name`, `label`, `limit`, `rare`, `can_remove`) VALUES
	('yusuf', 'Gold Skin', -1, 0, 1);
INSERT INTO `items` (`name`, `label`, `limit`, `rare`, `can_remove`) VALUES
	('celownikdluga', 'Scope Rifles', -1, 0, 1);
INSERT INTO `items` (`name`, `label`, `limit`, `rare`, `can_remove`) VALUES
	('vipskinmotyl', 'VIP Skin Butterfly', -1, 0, 1);
INSERT INTO `items` (`name`, `label`, `limit`, `rare`, `can_remove`) VALUES
	('jewelry', 'Javaheri', 250, 0, 1);
INSERT INTO `items` (`name`, `label`, `limit`, `rare`, `can_remove`) VALUES
	('powiekszonymagazynek', 'Extended Clip', -1, 0, 1);
INSERT INTO `items` (`name`, `label`, `limit`, `rare`, `can_remove`) VALUES
	('powiekszonymagazynek', 'Extended Clip', -1, 0, 1);
INSERT INTO `items` (`name`, `label`, `limit`, `rare`, `can_remove`) VALUES
	('powiekszonymagazynek', 'Extended Clip', -1, 0, 1);
INSERT INTO `items` (`name`, `label`, `limit`, `rare`, `can_remove`) VALUES
	('vipskinmotyl', 'VIP Skin Butterfly', -1, 0, 1);
INSERT INTO `items` (`name`, `label`, `limit`, `rare`, `can_remove`) VALUES
	('kastetpink', 'Knuckle Skin LOVE', -1, 0, 1);
INSERT INTO `items` (`name`, `label`, `limit`, `rare`, `can_remove`) VALUES
	('mediumscope', 'Medium Scope', -1, 0, 1);
INSERT INTO `items` (`name`, `label`, `limit`, `rare`, `can_remove`) VALUES
	('mediumscope', 'Medium Scope', -1, 0, 1);
INSERT INTO `items` (`name`, `label`, `limit`, `rare`, `can_remove`) VALUES
	('mediumscope', 'Medium Scope', -1, 0, 1);
INSERT INTO `items` (`name`, `label`, `limit`, `rare`, `can_remove`) VALUES
	('vipskinmotyl', 'VIP Skin Butterfly', -1, 0, 1);
INSERT INTO `items` (`name`, `label`, `limit`, `rare`, `can_remove`) VALUES
	('kastetpink', 'Knuckle Skin LOVE', -1, 0, 1);
INSERT INTO `items` (`name`, `label`, `limit`, `rare`, `can_remove`) VALUES
	('mediumscope', 'Medium Scope', -1, 0, 1);
INSERT INTO `items` (`name`, `label`, `limit`, `rare`, `can_remove`) VALUES
	('largescope', 'Large Scope', -1, 0, 1);
INSERT INTO `items` (`name`, `label`, `limit`, `rare`, `can_remove`) VALUES
	('holografik', 'Holographic Sight', -1, 0, 1);
INSERT INTO `items` (`name`, `label`, `limit`, `rare`, `can_remove`) VALUES
	('holografik', 'Holographic Sight', -1, 0, 1);
INSERT INTO `items` (`name`, `label`, `limit`, `rare`, `can_remove`) VALUES
	('platin50', 'Platinium Pistol 50 Skin', -1, 0, 1);
INSERT INTO `items` (`name`, `label`, `limit`, `rare`, `can_remove`) VALUES
	('platin50', 'Platinium Pistol 50 Skin', -1, 0, 1);
INSERT INTO `items` (`name`, `label`, `limit`, `rare`, `can_remove`) VALUES
	('woodheavyp', 'Wood Heavy Pistol Skin', -1, 0, 1);
INSERT INTO `items` (`name`, `label`, `limit`, `rare`, `can_remove`) VALUES
	('wooddlugie', 'Wood Rifles Skin', -1, 0, 1);
INSERT INTO `items` (`name`, `label`, `limit`, `rare`, `can_remove`) VALUES
	('czaszkidlugie', 'Skull Rifles Skin', -1, 0, 1);
INSERT INTO `items` (`name`, `label`, `limit`, `rare`, `can_remove`) VALUES
	('zebradlugie', 'Zebra Rifles Skin', -1, 0, 1);
INSERT INTO `items` (`name`, `label`, `limit`, `rare`, `can_remove`) VALUES
	('boomdlugie', 'Boom Rifles Skin', -1, 0, 1);
INSERT INTO `items` (`name`, `label`, `limit`, `rare`, `can_remove`) VALUES
	('tactitalmuzle', 'Tactical Muzzle Brake', -1, 0, 1);
INSERT INTO `items` (`name`, `label`, `limit`, `rare`, `can_remove`) VALUES
	('tactitalmuzle', 'Tactical Muzzle Brake', -1, 0, 1);
INSERT INTO `items` (`name`, `label`, `limit`, `rare`, `can_remove`) VALUES
	('tactitalmuzle', 'Tactical Muzzle Brake', -1, 0, 1);
INSERT INTO `items` (`name`, `label`, `limit`, `rare`, `can_remove`) VALUES
	('kastetpimp', 'Knuckle Skin PIMP', -1, 0, 1);
INSERT INTO `items` (`name`, `label`, `limit`, `rare`, `can_remove`) VALUES
	('kastethate', 'Knuckle Skin Hate', -1, 0, 1);
INSERT INTO `items` (`name`, `label`, `limit`, `rare`, `can_remove`) VALUES
	('kastetplayer', 'Knuckle Skin Player', -1, 0, 1);
INSERT INTO `items` (`name`, `label`, `limit`, `rare`, `can_remove`) VALUES
	('kastethate', 'Knuckle Skin Hate', -1, 0, 1);
INSERT INTO `items` (`name`, `label`, `limit`, `rare`, `can_remove`) VALUES
	('kastetplayer', 'Knuckle Skin Player', -1, 0, 1);
INSERT INTO `items` (`name`, `label`, `limit`, `rare`, `can_remove`) VALUES
	('kastetplayer', 'Knuckle Skin Player', -1, 0, 1);
INSERT INTO `items` (`name`, `label`, `limit`, `rare`, `can_remove`) VALUES
	('kastetvagos', 'Knuckle Skin Vagos', -1, 0, 1);
INSERT INTO `items` (`name`, `label`, `limit`, `rare`, `can_remove`) VALUES
	('kastetvagos', 'Knuckle Skin Vagos', -1, 0, 1);
INSERT INTO `items` (`name`, `label`, `limit`, `rare`, `can_remove`) VALUES
	('Suppressor', 'Suppressor', -1, 0, 1);
INSERT INTO `items` (`name`, `label`, `limit`, `rare`, `can_remove`) VALUES
	('gasmask', 'Mask', 1, 0, 1);
INSERT INTO `items` (`name`, `label`, `limit`, `rare`, `can_remove`) VALUES
	('cutter', 'Tizi', 1, 0, 1);
INSERT INTO `items` (`name`, `label`, `limit`, `rare`, `can_remove`) VALUES
	('bag', 'Kif', 1, 0, 1);
INSERT INTO `items` (`name`, `label`, `limit`, `rare`, `can_remove`) VALUES
	('rolex', 'Rolex', 200, 0, 1);
INSERT INTO `items` (`name`, `label`, `limit`, `rare`, `can_remove`) VALUES
	('ring', 'Halghe', 250, 0, 1);
INSERT INTO `items` (`name`, `label`, `limit`, `rare`, `can_remove`) VALUES
	('necklace', 'Gardan Band', 250, 0, 1);
INSERT INTO `items` (`name`, `label`, `limit`, `rare`, `can_remove`) VALUES
	('paintingg', 'Tablo', 100, 0, 1);
INSERT INTO `items` (`name`, `label`, `limit`, `rare`, `can_remove`) VALUES
	('Diamond', 'almas', 250, 0, 1);
INSERT INTO `items` (`name`, `label`, `limit`, `rare`, `can_remove`) VALUES
	('vanPanther', 'Panther', 80, 0, 1);
INSERT INTO `items` (`name`, `label`, `limit`, `rare`, `can_remove`) VALUES
	('vanNecklace', 'gardan band', 250, 0, 1);
INSERT INTO `items` (`name`, `label`, `limit`, `rare`, `can_remove`) VALUES
	('vanBottle', 'botri', 100, 0, 1);
INSERT INTO `items` (`name`, `label`, `limit`, `rare`, `can_remove`) VALUES
	('drill', 'Mate', 3, 0, 1);
INSERT INTO `items` (`name`, `label`, `limit`, `rare`, `can_remove`) VALUES
	('c4_bomb', 'C4', 8, 0, 1);
INSERT INTO `items` (`name`, `label`, `limit`, `rare`, `can_remove`) VALUES
	('thermite', 'Bomb Thermite', 8, 0, 1);
INSERT INTO `items` (`name`, `label`, `limit`, `rare`, `can_remove`) VALUES
	('laptop', 'Laptop', 8, 0, 1);
INSERT INTO `items` (`name`, `label`, `limit`, `rare`, `can_remove`) VALUES
	('hack_usb', 'USB HACK', 8, 0, 1);
INSERT INTO `items` (`name`, `label`, `limit`, `rare`, `can_remove`) VALUES
	('gold', 'Tala', 250, 0, 1);
INSERT INTO `items` (`name`, `label`, `limit`, `rare`, `can_remove`) VALUES
	('diamond', 'Almas', 250, 0, 1);
INSERT INTO `items` (`name`, `label`, `limit`, `rare`, `can_remove`) VALUES
	('platinum', 'Noghre', 250, 0, 1);
INSERT INTO `items` (`name`, `label`, `limit`, `rare`, `can_remove`) VALUES
	('vanDiamond', 'Almas', 250, 0, 1);
INSERT INTO `items` (`name`, `label`, `limit`, `rare`, `can_remove`) VALUES
	('vanPogo', 'Pogo', 120, 0, 1);
/*!40000 ALTER TABLE `items` ENABLE KEYS */;

-- Dumping structure for table essential.jobs
CREATE TABLE IF NOT EXISTS `jobs` (
  `name` varchar(50) NOT NULL,
  `label` varchar(255) DEFAULT NULL,
  `whitelisted` tinyint(1) NOT NULL DEFAULT 0,
  PRIMARY KEY (`name`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin ROW_FORMAT=DYNAMIC;

-- Dumping data for table essential.jobs: ~30 rows (approximately)
/*!40000 ALTER TABLE `jobs` DISABLE KEYS */;
INSERT INTO `jobs` (`name`, `label`, `whitelisted`) VALUES
	('ambulance', 'Ambulance', 1);
INSERT INTO `jobs` (`name`, `label`, `whitelisted`) VALUES
	('cardealer', 'Car Dealer', 1);
INSERT INTO `jobs` (`name`, `label`, `whitelisted`) VALUES
	('coffee', 'Coffee Shop', 1);
INSERT INTO `jobs` (`name`, `label`, `whitelisted`) VALUES
	('doc', 'Zendan Ban', 1);
INSERT INTO `jobs` (`name`, `label`, `whitelisted`) VALUES
	('fbi', 'FBI', 1);
INSERT INTO `jobs` (`name`, `label`, `whitelisted`) VALUES
	('fisherman', 'Mahigir', 0);
INSERT INTO `jobs` (`name`, `label`, `whitelisted`) VALUES
	('fueler', 'Sherkat naft', 0);
INSERT INTO `jobs` (`name`, `label`, `whitelisted`) VALUES
	('government', 'Dolat', 1);
INSERT INTO `jobs` (`name`, `label`, `whitelisted`) VALUES
	('lumberjack', 'Choob Bor', 0);
INSERT INTO `jobs` (`name`, `label`, `whitelisted`) VALUES
	('mecano', 'Mechanic', 1);
INSERT INTO `jobs` (`name`, `label`, `whitelisted`) VALUES
	('miner', 'Maadanchi', 0);
INSERT INTO `jobs` (`name`, `label`, `whitelisted`) VALUES
	('moneytransfer', 'Hamle Pool', 1);
INSERT INTO `jobs` (`name`, `label`, `whitelisted`) VALUES
	('nightclub', 'Night Club', 1);
INSERT INTO `jobs` (`name`, `label`, `whitelisted`) VALUES
	('nojob', 'nojob', 0);
INSERT INTO `jobs` (`name`, `label`, `whitelisted`) VALUES
	('offambulance', 'Off-Duty', 1);
INSERT INTO `jobs` (`name`, `label`, `whitelisted`) VALUES
	('offcoffee', 'Off-Duty', 1);
INSERT INTO `jobs` (`name`, `label`, `whitelisted`) VALUES
	('offdoc', 'Off-Duty', 1);
INSERT INTO `jobs` (`name`, `label`, `whitelisted`) VALUES
	('offgovernment', 'Off-Duty', 1);
INSERT INTO `jobs` (`name`, `label`, `whitelisted`) VALUES
	('offmecano', 'Off-Duty', 1);
INSERT INTO `jobs` (`name`, `label`, `whitelisted`) VALUES
	('offpolice', 'Off-Duty', 1);
INSERT INTO `jobs` (`name`, `label`, `whitelisted`) VALUES
	('offtaxi', 'Off-Duty', 1);
INSERT INTO `jobs` (`name`, `label`, `whitelisted`) VALUES
	('offweazel', 'Off-Duty', 1);
INSERT INTO `jobs` (`name`, `label`, `whitelisted`) VALUES
	('police', 'Police', 1);
INSERT INTO `jobs` (`name`, `label`, `whitelisted`) VALUES
	('reporter', 'Khabarnegar', 1);
INSERT INTO `jobs` (`name`, `label`, `whitelisted`) VALUES
	('sheriff', 'sheriff', 1);
INSERT INTO `jobs` (`name`, `label`, `whitelisted`) VALUES
	('slaughterer', 'Ghassab', 0);
INSERT INTO `jobs` (`name`, `label`, `whitelisted`) VALUES
	('tailor', 'Khayat', 0);
INSERT INTO `jobs` (`name`, `label`, `whitelisted`) VALUES
	('taxi', 'Taxi', 1);
INSERT INTO `jobs` (`name`, `label`, `whitelisted`) VALUES
	('uwu', 'Uwu Cafe', 1);
INSERT INTO `jobs` (`name`, `label`, `whitelisted`) VALUES
	('weazel', 'Weazel News', 1);
/*!40000 ALTER TABLE `jobs` ENABLE KEYS */;

-- Dumping structure for table essential.job_grades
CREATE TABLE IF NOT EXISTS `job_grades` (
  `job_name` varchar(255) DEFAULT NULL,
  `grade` int(11) NOT NULL,
  `name` varchar(255) NOT NULL,
  `label` varchar(255) NOT NULL,
  `salary` int(11) NOT NULL,
  `skin_male` longtext NOT NULL,
  `skin_male2` longtext NOT NULL,
  `skin_female` longtext NOT NULL,
  `skin_female2` longtext NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin ROW_FORMAT=DYNAMIC;

-- Dumping data for table essential.job_grades: ~159 rows (approximately)
/*!40000 ALTER TABLE `job_grades` DISABLE KEYS */;
INSERT INTO `job_grades` (`job_name`, `grade`, `name`, `label`, `salary`, `skin_male`, `skin_male2`, `skin_female`, `skin_female2`) VALUES
	('nojob', 0, 'nojob', 'nojob', 0, '{}', '{}', '{}', '{}');
INSERT INTO `job_grades` (`job_name`, `grade`, `name`, `label`, `salary`, `skin_male`, `skin_male2`, `skin_female`, `skin_female2`) VALUES
	('cardealer', 0, 'recruit', 'Recrue', 0, '{}', '{}', '{}', '{}');
INSERT INTO `job_grades` (`job_name`, `grade`, `name`, `label`, `salary`, `skin_male`, `skin_male2`, `skin_female`, `skin_female2`) VALUES
	('cardealer', 1, 'novice', 'Novice', 0, '{}', '{}', '{}', '{}');
INSERT INTO `job_grades` (`job_name`, `grade`, `name`, `label`, `salary`, `skin_male`, `skin_male2`, `skin_female`, `skin_female2`) VALUES
	('cardealer', 2, 'experienced', 'Experimente', 0, '{}', '{}', '{}', '{}');
INSERT INTO `job_grades` (`job_name`, `grade`, `name`, `label`, `salary`, `skin_male`, `skin_male2`, `skin_female`, `skin_female2`) VALUES
	('cardealer', 3, 'boss', 'Patron', 0, '{}', '{}', '{}', '{}');
INSERT INTO `job_grades` (`job_name`, `grade`, `name`, `label`, `salary`, `skin_male`, `skin_male2`, `skin_female`, `skin_female2`) VALUES
	('taxi', 0, 'recrue', 'Kar amooz', 0, '{"hair_2":0,"hair_color_2":0,"torso_1":32,"bags_1":0,"helmet_2":0,"chain_2":0,"eyebrows_3":0,"makeup_3":0,"makeup_2":0,"tshirt_1":31,"makeup_1":0,"bags_2":0,"makeup_4":0,"eyebrows_4":0,"chain_1":0,"lipstick_4":0,"bproof_2":0,"hair_color_1":0,"decals_2":0,"pants_2":0,"age_2":0,"glasses_2":0,"ears_2":0,"arms":27,"lipstick_1":0,"ears_1":-1,"mask_2":0,"sex":0,"lipstick_3":0,"helmet_1":-1,"shoes_2":0,"beard_2":0,"beard_1":0,"lipstick_2":0,"beard_4":0,"glasses_1":0,"bproof_1":0,"mask_1":0,"decals_1":1,"hair_1":0,"eyebrows_2":0,"beard_3":0,"age_1":0,"tshirt_2":0,"skin":0,"torso_2":0,"eyebrows_1":0,"face":0,"shoes_1":10,"pants_1":24}', '{}', '{"hair_2":0,"hair_color_2":0,"torso_1":57,"bags_1":0,"helmet_2":0,"chain_2":0,"eyebrows_3":0,"makeup_3":0,"makeup_2":0,"tshirt_1":38,"makeup_1":0,"bags_2":0,"makeup_4":0,"eyebrows_4":0,"chain_1":0,"lipstick_4":0,"bproof_2":0,"hair_color_1":0,"decals_2":0,"pants_2":1,"age_2":0,"glasses_2":0,"ears_2":0,"arms":21,"lipstick_1":0,"ears_1":-1,"mask_2":0,"sex":1,"lipstick_3":0,"helmet_1":-1,"shoes_2":0,"beard_2":0,"beard_1":0,"lipstick_2":0,"beard_4":0,"glasses_1":5,"bproof_1":0,"mask_1":0,"decals_1":1,"hair_1":0,"eyebrows_2":0,"beard_3":0,"age_1":0,"tshirt_2":0,"skin":0,"torso_2":0,"eyebrows_1":0,"face":0,"shoes_1":49,"pants_1":11}', '{}');
INSERT INTO `job_grades` (`job_name`, `grade`, `name`, `label`, `salary`, `skin_male`, `skin_male2`, `skin_female`, `skin_female2`) VALUES
	('taxi', 1, 'novice', 'Taze kar', 0, '{"hair_2":0,"hair_color_2":0,"torso_1":32,"bags_1":0,"helmet_2":0,"chain_2":0,"eyebrows_3":0,"makeup_3":0,"makeup_2":0,"tshirt_1":31,"makeup_1":0,"bags_2":0,"makeup_4":0,"eyebrows_4":0,"chain_1":0,"lipstick_4":0,"bproof_2":0,"hair_color_1":0,"decals_2":0,"pants_2":0,"age_2":0,"glasses_2":0,"ears_2":0,"arms":27,"lipstick_1":0,"ears_1":-1,"mask_2":0,"sex":0,"lipstick_3":0,"helmet_1":-1,"shoes_2":0,"beard_2":0,"beard_1":0,"lipstick_2":0,"beard_4":0,"glasses_1":0,"bproof_1":0,"mask_1":0,"decals_1":1,"hair_1":0,"eyebrows_2":0,"beard_3":0,"age_1":0,"tshirt_2":0,"skin":0,"torso_2":0,"eyebrows_1":0,"face":0,"shoes_1":10,"pants_1":24}', '{}', '{"hair_2":0,"hair_color_2":0,"torso_1":57,"bags_1":0,"helmet_2":0,"chain_2":0,"eyebrows_3":0,"makeup_3":0,"makeup_2":0,"tshirt_1":38,"makeup_1":0,"bags_2":0,"makeup_4":0,"eyebrows_4":0,"chain_1":0,"lipstick_4":0,"bproof_2":0,"hair_color_1":0,"decals_2":0,"pants_2":1,"age_2":0,"glasses_2":0,"ears_2":0,"arms":21,"lipstick_1":0,"ears_1":-1,"mask_2":0,"sex":1,"lipstick_3":0,"helmet_1":-1,"shoes_2":0,"beard_2":0,"beard_1":0,"lipstick_2":0,"beard_4":0,"glasses_1":5,"bproof_1":0,"mask_1":0,"decals_1":1,"hair_1":0,"eyebrows_2":0,"beard_3":0,"age_1":0,"tshirt_2":0,"skin":0,"torso_2":0,"eyebrows_1":0,"face":0,"shoes_1":49,"pants_1":11}', '{}');
INSERT INTO `job_grades` (`job_name`, `grade`, `name`, `label`, `salary`, `skin_male`, `skin_male2`, `skin_female`, `skin_female2`) VALUES
	('taxi', 2, 'experimente', 'Ba tajrobe', 0, '{"hair_2":0,"hair_color_2":0,"torso_1":26,"bags_1":0,"helmet_2":0,"chain_2":0,"eyebrows_3":0,"makeup_3":0,"makeup_2":0,"tshirt_1":57,"makeup_1":0,"bags_2":0,"makeup_4":0,"eyebrows_4":0,"chain_1":0,"lipstick_4":0,"bproof_2":0,"hair_color_1":0,"decals_2":0,"pants_2":4,"age_2":0,"glasses_2":0,"ears_2":0,"arms":11,"lipstick_1":0,"ears_1":-1,"mask_2":0,"sex":0,"lipstick_3":0,"helmet_1":-1,"shoes_2":0,"beard_2":0,"beard_1":0,"lipstick_2":0,"beard_4":0,"glasses_1":0,"bproof_1":0,"mask_1":0,"decals_1":0,"hair_1":0,"eyebrows_2":0,"beard_3":0,"age_1":0,"tshirt_2":0,"skin":0,"torso_2":0,"eyebrows_1":0,"face":0,"shoes_1":10,"pants_1":24}', '{}', '{"hair_2":0,"hair_color_2":0,"torso_1":57,"bags_1":0,"helmet_2":0,"chain_2":0,"eyebrows_3":0,"makeup_3":0,"makeup_2":0,"tshirt_1":38,"makeup_1":0,"bags_2":0,"makeup_4":0,"eyebrows_4":0,"chain_1":0,"lipstick_4":0,"bproof_2":0,"hair_color_1":0,"decals_2":0,"pants_2":1,"age_2":0,"glasses_2":0,"ears_2":0,"arms":21,"lipstick_1":0,"ears_1":-1,"mask_2":0,"sex":1,"lipstick_3":0,"helmet_1":-1,"shoes_2":0,"beard_2":0,"beard_1":0,"lipstick_2":0,"beard_4":0,"glasses_1":5,"bproof_1":0,"mask_1":0,"decals_1":1,"hair_1":0,"eyebrows_2":0,"beard_3":0,"age_1":0,"tshirt_2":0,"skin":0,"torso_2":0,"eyebrows_1":0,"face":0,"shoes_1":49,"pants_1":11}', '{}');
INSERT INTO `job_grades` (`job_name`, `grade`, `name`, `label`, `salary`, `skin_male`, `skin_male2`, `skin_female`, `skin_female2`) VALUES
	('taxi', 3, 'uber', 'Snapp', 0, '{"hair_2":0,"hair_color_2":0,"torso_1":26,"bags_1":0,"helmet_2":0,"chain_2":0,"eyebrows_3":0,"makeup_3":0,"makeup_2":0,"tshirt_1":57,"makeup_1":0,"bags_2":0,"makeup_4":0,"eyebrows_4":0,"chain_1":0,"lipstick_4":0,"bproof_2":0,"hair_color_1":0,"decals_2":0,"pants_2":4,"age_2":0,"glasses_2":0,"ears_2":0,"arms":11,"lipstick_1":0,"ears_1":-1,"mask_2":0,"sex":0,"lipstick_3":0,"helmet_1":-1,"shoes_2":0,"beard_2":0,"beard_1":0,"lipstick_2":0,"beard_4":0,"glasses_1":0,"bproof_1":0,"mask_1":0,"decals_1":0,"hair_1":0,"eyebrows_2":0,"beard_3":0,"age_1":0,"tshirt_2":0,"skin":0,"torso_2":0,"eyebrows_1":0,"face":0,"shoes_1":10,"pants_1":24}', '{}', '{"hair_2":0,"hair_color_2":0,"torso_1":57,"bags_1":0,"helmet_2":0,"chain_2":0,"eyebrows_3":0,"makeup_3":0,"makeup_2":0,"tshirt_1":38,"makeup_1":0,"bags_2":0,"makeup_4":0,"eyebrows_4":0,"chain_1":0,"lipstick_4":0,"bproof_2":0,"hair_color_1":0,"decals_2":0,"pants_2":1,"age_2":0,"glasses_2":0,"ears_2":0,"arms":21,"lipstick_1":0,"ears_1":-1,"mask_2":0,"sex":1,"lipstick_3":0,"helmet_1":-1,"shoes_2":0,"beard_2":0,"beard_1":0,"lipstick_2":0,"beard_4":0,"glasses_1":5,"bproof_1":0,"mask_1":0,"decals_1":1,"hair_1":0,"eyebrows_2":0,"beard_3":0,"age_1":0,"tshirt_2":0,"skin":0,"torso_2":0,"eyebrows_1":0,"face":0,"shoes_1":49,"pants_1":11}', '{}');
INSERT INTO `job_grades` (`job_name`, `grade`, `name`, `label`, `salary`, `skin_male`, `skin_male2`, `skin_female`, `skin_female2`) VALUES
	('taxi', 4, 'boss', 'Rais', 0, '{"hair_2":0,"hair_color_2":0,"torso_1":29,"bags_1":0,"helmet_2":0,"chain_2":0,"eyebrows_3":0,"makeup_3":0,"makeup_2":0,"tshirt_1":31,"makeup_1":0,"bags_2":0,"makeup_4":0,"eyebrows_4":0,"chain_1":0,"lipstick_4":0,"bproof_2":0,"hair_color_1":0,"decals_2":0,"pants_2":4,"age_2":0,"glasses_2":0,"ears_2":0,"arms":1,"lipstick_1":0,"ears_1":-1,"mask_2":0,"sex":0,"lipstick_3":0,"helmet_1":-1,"shoes_2":0,"beard_2":0,"beard_1":0,"lipstick_2":0,"beard_4":0,"glasses_1":0,"bproof_1":0,"mask_1":0,"decals_1":0,"hair_1":0,"eyebrows_2":0,"beard_3":0,"age_1":0,"tshirt_2":0,"skin":0,"torso_2":4,"eyebrows_1":0,"face":0,"shoes_1":10,"pants_1":24}', '{}', '{"hair_2":0,"hair_color_2":0,"torso_1":57,"bags_1":0,"helmet_2":0,"chain_2":0,"eyebrows_3":0,"makeup_3":0,"makeup_2":0,"tshirt_1":38,"makeup_1":0,"bags_2":0,"makeup_4":0,"eyebrows_4":0,"chain_1":0,"lipstick_4":0,"bproof_2":0,"hair_color_1":0,"decals_2":0,"pants_2":1,"age_2":0,"glasses_2":0,"ears_2":0,"arms":21,"lipstick_1":0,"ears_1":-1,"mask_2":0,"sex":1,"lipstick_3":0,"helmet_1":-1,"shoes_2":0,"beard_2":0,"beard_1":0,"lipstick_2":0,"beard_4":0,"glasses_1":5,"bproof_1":0,"mask_1":0,"decals_1":1,"hair_1":0,"eyebrows_2":0,"beard_3":0,"age_1":0,"tshirt_2":0,"skin":0,"torso_2":0,"eyebrows_1":0,"face":0,"shoes_1":49,"pants_1":11}', '{}');
INSERT INTO `job_grades` (`job_name`, `grade`, `name`, `label`, `salary`, `skin_male`, `skin_male2`, `skin_female`, `skin_female2`) VALUES
	('lumberjack', 0, 'employee', 'Taze kar', 0, '{}', '{}', '{}', '{}');
INSERT INTO `job_grades` (`job_name`, `grade`, `name`, `label`, `salary`, `skin_male`, `skin_male2`, `skin_female`, `skin_female2`) VALUES
	('fisherman', 0, 'employee', 'Taze kar', 0, '{}', '{}', '{}', '{}');
INSERT INTO `job_grades` (`job_name`, `grade`, `name`, `label`, `salary`, `skin_male`, `skin_male2`, `skin_female`, `skin_female2`) VALUES
	('fueler', 0, 'employee', 'Taze kar', 0, '{}', '{}', '{}', '{}');
INSERT INTO `job_grades` (`job_name`, `grade`, `name`, `label`, `salary`, `skin_male`, `skin_male2`, `skin_female`, `skin_female2`) VALUES
	('reporter', 0, 'employee', 'Taze kar', 0, '{}', '{}', '{}', '{}');
INSERT INTO `job_grades` (`job_name`, `grade`, `name`, `label`, `salary`, `skin_male`, `skin_male2`, `skin_female`, `skin_female2`) VALUES
	('tailor', 0, 'employee', 'Taze kar', 0, '{"mask_1":0,"arms":1,"glasses_1":0,"hair_color_2":4,"makeup_1":0,"face":19,"glasses":0,"mask_2":0,"makeup_3":0,"skin":29,"helmet_2":0,"lipstick_4":0,"sex":0,"torso_1":24,"makeup_2":0,"bags_2":0,"chain_2":0,"ears_1":-1,"bags_1":0,"bproof_1":0,"shoes_2":0,"lipstick_2":0,"chain_1":0,"tshirt_1":0,"eyebrows_3":0,"pants_2":0,"beard_4":0,"torso_2":0,"beard_2":6,"ears_2":0,"hair_2":0,"shoes_1":36,"tshirt_2":0,"beard_3":0,"hair_1":2,"hair_color_1":0,"pants_1":48,"helmet_1":-1,"bproof_2":0,"eyebrows_4":0,"eyebrows_2":0,"decals_1":0,"age_2":0,"beard_1":5,"shoes":10,"lipstick_1":0,"eyebrows_1":0,"glasses_2":0,"makeup_4":0,"decals_2":0,"lipstick_3":0,"age_1":0}', '{}', '{"mask_1":0,"arms":5,"glasses_1":5,"hair_color_2":4,"makeup_1":0,"face":19,"glasses":0,"mask_2":0,"makeup_3":0,"skin":29,"helmet_2":0,"lipstick_4":0,"sex":1,"torso_1":52,"makeup_2":0,"bags_2":0,"chain_2":0,"ears_1":-1,"bags_1":0,"bproof_1":0,"shoes_2":1,"lipstick_2":0,"chain_1":0,"tshirt_1":23,"eyebrows_3":0,"pants_2":0,"beard_4":0,"torso_2":0,"beard_2":6,"ears_2":0,"hair_2":0,"shoes_1":42,"tshirt_2":4,"beard_3":0,"hair_1":2,"hair_color_1":0,"pants_1":36,"helmet_1":-1,"bproof_2":0,"eyebrows_4":0,"eyebrows_2":0,"decals_1":0,"age_2":0,"beard_1":5,"shoes":10,"lipstick_1":0,"eyebrows_1":0,"glasses_2":0,"makeup_4":0,"decals_2":0,"lipstick_3":0,"age_1":0}', '{}');
INSERT INTO `job_grades` (`job_name`, `grade`, `name`, `label`, `salary`, `skin_male`, `skin_male2`, `skin_female`, `skin_female2`) VALUES
	('miner', 0, 'employee', 'Taze kar', 0, '{"tshirt_2":1,"ears_1":8,"glasses_1":15,"torso_2":0,"ears_2":2,"glasses_2":3,"shoes_2":1,"pants_1":75,"shoes_1":51,"bags_1":0,"helmet_2":0,"pants_2":7,"torso_1":71,"tshirt_1":59,"arms":2,"bags_2":0,"helmet_1":0}', '{}', '{}', '{}');
INSERT INTO `job_grades` (`job_name`, `grade`, `name`, `label`, `salary`, `skin_male`, `skin_male2`, `skin_female`, `skin_female2`) VALUES
	('slaughterer', 0, 'employee', 'Taze kar', 0, '{"age_1":0,"glasses_2":0,"beard_1":5,"decals_2":0,"beard_4":0,"shoes_2":0,"tshirt_2":0,"lipstick_2":0,"hair_2":0,"arms":67,"pants_1":36,"skin":29,"eyebrows_2":0,"shoes":10,"helmet_1":-1,"lipstick_1":0,"helmet_2":0,"hair_color_1":0,"glasses":0,"makeup_4":0,"makeup_1":0,"hair_1":2,"bproof_1":0,"bags_1":0,"mask_1":0,"lipstick_3":0,"chain_1":0,"eyebrows_4":0,"sex":0,"torso_1":56,"beard_2":6,"shoes_1":12,"decals_1":0,"face":19,"lipstick_4":0,"tshirt_1":15,"mask_2":0,"age_2":0,"eyebrows_3":0,"chain_2":0,"glasses_1":0,"ears_1":-1,"bags_2":0,"ears_2":0,"torso_2":0,"bproof_2":0,"makeup_2":0,"eyebrows_1":0,"makeup_3":0,"pants_2":0,"beard_3":0,"hair_color_2":4}', '{}', '{"age_1":0,"glasses_2":0,"beard_1":5,"decals_2":0,"beard_4":0,"shoes_2":0,"tshirt_2":0,"lipstick_2":0,"hair_2":0,"arms":72,"pants_1":45,"skin":29,"eyebrows_2":0,"shoes":10,"helmet_1":-1,"lipstick_1":0,"helmet_2":0,"hair_color_1":0,"glasses":0,"makeup_4":0,"makeup_1":0,"hair_1":2,"bproof_1":0,"bags_1":0,"mask_1":0,"lipstick_3":0,"chain_1":0,"eyebrows_4":0,"sex":1,"torso_1":49,"beard_2":6,"shoes_1":24,"decals_1":0,"face":19,"lipstick_4":0,"tshirt_1":9,"mask_2":0,"age_2":0,"eyebrows_3":0,"chain_2":0,"glasses_1":5,"ears_1":-1,"bags_2":0,"ears_2":0,"torso_2":0,"bproof_2":0,"makeup_2":0,"eyebrows_1":0,"makeup_3":0,"pants_2":0,"beard_3":0,"hair_color_2":4}', '{}');
INSERT INTO `job_grades` (`job_name`, `grade`, `name`, `label`, `salary`, `skin_male`, `skin_male2`, `skin_female`, `skin_female2`) VALUES
	('offtaxi', 0, 'recrue', 'Kar amooz', 0, '{}', '{}', '{}', '{}');
INSERT INTO `job_grades` (`job_name`, `grade`, `name`, `label`, `salary`, `skin_male`, `skin_male2`, `skin_female`, `skin_female2`) VALUES
	('offtaxi', 1, 'novice', 'Taze kar', 0, '{}', '{}', '{}', '{}');
INSERT INTO `job_grades` (`job_name`, `grade`, `name`, `label`, `salary`, `skin_male`, `skin_male2`, `skin_female`, `skin_female2`) VALUES
	('offtaxi', 2, 'experimente', 'Ba tajrobe', 0, '{}', '{}', '{}', '{}');
INSERT INTO `job_grades` (`job_name`, `grade`, `name`, `label`, `salary`, `skin_male`, `skin_male2`, `skin_female`, `skin_female2`) VALUES
	('offtaxi', 3, 'uber', 'Snapp', 0, '{}', '{}', '{}', '{}');
INSERT INTO `job_grades` (`job_name`, `grade`, `name`, `label`, `salary`, `skin_male`, `skin_male2`, `skin_female`, `skin_female2`) VALUES
	('offtaxi', 4, 'boss', 'Rais', 0, '{}', '{}', '{}', '{}');
INSERT INTO `job_grades` (`job_name`, `grade`, `name`, `label`, `salary`, `skin_male`, `skin_male2`, `skin_female`, `skin_female2`) VALUES
	('moneytransfer', 0, 'driver', 'Hamle Pool', 0, '{}', '{}', '{}', '{}');
INSERT INTO `job_grades` (`job_name`, `grade`, `name`, `label`, `salary`, `skin_male`, `skin_male2`, `skin_female`, `skin_female2`) VALUES
	('ambulance', 0, 'emtb', 'EMT B', 0, '{}', '{}', '{}', '{}');
INSERT INTO `job_grades` (`job_name`, `grade`, `name`, `label`, `salary`, `skin_male`, `skin_male2`, `skin_female`, `skin_female2`) VALUES
	('ambulance', 1, 'emti', 'EMT I', 0, '{}', '{}', '{}', '{}');
INSERT INTO `job_grades` (`job_name`, `grade`, `name`, `label`, `salary`, `skin_male`, `skin_male2`, `skin_female`, `skin_female2`) VALUES
	('ambulance', 2, 'emta', 'EMT A', 0, '{}', '{}', '{}', '{}');
INSERT INTO `job_grades` (`job_name`, `grade`, `name`, `label`, `salary`, `skin_male`, `skin_male2`, `skin_female`, `skin_female2`) VALUES
	('ambulance', 3, 'paramedic', 'Paramedic', 0, '{}', '{}', '{}', '{}');
INSERT INTO `job_grades` (`job_name`, `grade`, `name`, `label`, `salary`, `skin_male`, `skin_male2`, `skin_female`, `skin_female2`) VALUES
	('ambulance', 4, 'paramedics', 'Senior Paramedic', 0, '{}', '{}', '{}', '{}');
INSERT INTO `job_grades` (`job_name`, `grade`, `name`, `label`, `salary`, `skin_male`, `skin_male2`, `skin_female`, `skin_female2`) VALUES
	('ambulance', 5, 'commander', 'Commander', 0, '{}', '{}', '{}', '{}');
INSERT INTO `job_grades` (`job_name`, `grade`, `name`, `label`, `salary`, `skin_male`, `skin_male2`, `skin_female`, `skin_female2`) VALUES
	('ambulance', 6, 'boss', 'Deputy Chief', 0, '{}', '{}', '{}', '{}');
INSERT INTO `job_grades` (`job_name`, `grade`, `name`, `label`, `salary`, `skin_male`, `skin_male2`, `skin_female`, `skin_female2`) VALUES
	('ambulance', 7, 'boss', 'Chief', 0, '{}', '{}', '{}', '{}');
INSERT INTO `job_grades` (`job_name`, `grade`, `name`, `label`, `salary`, `skin_male`, `skin_male2`, `skin_female`, `skin_female2`) VALUES
	('offambulance', 0, 'emtb', 'EMT B', 0, '{}', '{}', '{}', '{}');
INSERT INTO `job_grades` (`job_name`, `grade`, `name`, `label`, `salary`, `skin_male`, `skin_male2`, `skin_female`, `skin_female2`) VALUES
	('offambulance', 1, 'emti', 'EMT I', 0, '{}', '{}', '{}', '{}');
INSERT INTO `job_grades` (`job_name`, `grade`, `name`, `label`, `salary`, `skin_male`, `skin_male2`, `skin_female`, `skin_female2`) VALUES
	('offambulance', 2, 'emta', 'EMT A', 0, '{}', '{}', '{}', '{}');
INSERT INTO `job_grades` (`job_name`, `grade`, `name`, `label`, `salary`, `skin_male`, `skin_male2`, `skin_female`, `skin_female2`) VALUES
	('offambulance', 3, 'paramedic', 'Paramedic', 0, '{}', '{}', '{}', '{}');
INSERT INTO `job_grades` (`job_name`, `grade`, `name`, `label`, `salary`, `skin_male`, `skin_male2`, `skin_female`, `skin_female2`) VALUES
	('offambulance', 4, 'paramedics', 'Senior Paramedic', 0, '{}', '{}', '{}', '{}');
INSERT INTO `job_grades` (`job_name`, `grade`, `name`, `label`, `salary`, `skin_male`, `skin_male2`, `skin_female`, `skin_female2`) VALUES
	('offambulance', 5, 'commander', 'Commander', 0, '{}', '{}', '{}', '{}');
INSERT INTO `job_grades` (`job_name`, `grade`, `name`, `label`, `salary`, `skin_male`, `skin_male2`, `skin_female`, `skin_female2`) VALUES
	('offambulance', 6, 'boss', 'Deputy Chief', 0, '{}', '{}', '{}', '{}');
INSERT INTO `job_grades` (`job_name`, `grade`, `name`, `label`, `salary`, `skin_male`, `skin_male2`, `skin_female`, `skin_female2`) VALUES
	('offambulance', 7, 'boss', 'Chief', 0, '{}', '{}', '{}', '{}');
INSERT INTO `job_grades` (`job_name`, `grade`, `name`, `label`, `salary`, `skin_male`, `skin_male2`, `skin_female`, `skin_female2`) VALUES
	('mecano', 0, 'recrue', 'Tazekar', 0, '{}', '{}', '{}', '{}');
INSERT INTO `job_grades` (`job_name`, `grade`, `name`, `label`, `salary`, `skin_male`, `skin_male2`, `skin_female`, `skin_female2`) VALUES
	('mecano', 1, 'novice', 'Safkar', 0, '{}', '{}', '{}', '{}');
INSERT INTO `job_grades` (`job_name`, `grade`, `name`, `label`, `salary`, `skin_male`, `skin_male2`, `skin_female`, `skin_female2`) VALUES
	('mecano', 2, 'experimente', 'Mechanic', 0, '{}', '{}', '{}', '{}');
INSERT INTO `job_grades` (`job_name`, `grade`, `name`, `label`, `salary`, `skin_male`, `skin_male2`, `skin_female`, `skin_female2`) VALUES
	('mecano', 3, 'chief', 'Dastyare Osta', 0, '{}', '{}', '{}', '{}');
INSERT INTO `job_grades` (`job_name`, `grade`, `name`, `label`, `salary`, `skin_male`, `skin_male2`, `skin_female`, `skin_female2`) VALUES
	('mecano', 4, 'boss', 'Osta', 0, '{}', '{}', '{}', '{}');
INSERT INTO `job_grades` (`job_name`, `grade`, `name`, `label`, `salary`, `skin_male`, `skin_male2`, `skin_female`, `skin_female2`) VALUES
	('offmecano', 0, 'recrue', 'Tazekar', 0, '{}', '{}', '{}', '{}');
INSERT INTO `job_grades` (`job_name`, `grade`, `name`, `label`, `salary`, `skin_male`, `skin_male2`, `skin_female`, `skin_female2`) VALUES
	('offmecano', 1, 'novice', 'Safkar', 0, '{}', '{}', '{}', '{}');
INSERT INTO `job_grades` (`job_name`, `grade`, `name`, `label`, `salary`, `skin_male`, `skin_male2`, `skin_female`, `skin_female2`) VALUES
	('offmecano', 2, 'experimente', 'Mechanic', 0, '{}', '{}', '{}', '{}');
INSERT INTO `job_grades` (`job_name`, `grade`, `name`, `label`, `salary`, `skin_male`, `skin_male2`, `skin_female`, `skin_female2`) VALUES
	('offmecano', 3, 'chief', 'Dastyare Osta', 0, '{}', '{}', '{}', '{}');
INSERT INTO `job_grades` (`job_name`, `grade`, `name`, `label`, `salary`, `skin_male`, `skin_male2`, `skin_female`, `skin_female2`) VALUES
	('offmecano', 4, 'boss', 'Osta', 0, '{}', '{}', '{}', '{}');
INSERT INTO `job_grades` (`job_name`, `grade`, `name`, `label`, `salary`, `skin_male`, `skin_male2`, `skin_female`, `skin_female2`) VALUES
	('weazel', 0, 'secutiry', 'Amniat', 0, '{}', '{}', '{}', '{}');
INSERT INTO `job_grades` (`job_name`, `grade`, `name`, `label`, `salary`, `skin_male`, `skin_male2`, `skin_female`, `skin_female2`) VALUES
	('weazel', 1, 'reporter', 'Reporter', 0, '{}', '{}', '{}', '{}');
INSERT INTO `job_grades` (`job_name`, `grade`, `name`, `label`, `salary`, `skin_male`, `skin_male2`, `skin_female`, `skin_female2`) VALUES
	('weazel', 2, 'investigator', 'investigator', 0, '{}', '{}', '{}', '{}');
INSERT INTO `job_grades` (`job_name`, `grade`, `name`, `label`, `salary`, `skin_male`, `skin_male2`, `skin_female`, `skin_female2`) VALUES
	('weazel', 3, 'administrator', 'Administraior', 0, '{}', '{}', '{}', '{}');
INSERT INTO `job_grades` (`job_name`, `grade`, `name`, `label`, `salary`, `skin_male`, `skin_male2`, `skin_female`, `skin_female2`) VALUES
	('weazel', 4, 'boss', 'CEO', 0, '{}', '{}', '{}', '{}');
INSERT INTO `job_grades` (`job_name`, `grade`, `name`, `label`, `salary`, `skin_male`, `skin_male2`, `skin_female`, `skin_female2`) VALUES
	('offweazel', 0, 'secutiry', 'secutiry', 0, '{}', '{}', '{}', '{}');
INSERT INTO `job_grades` (`job_name`, `grade`, `name`, `label`, `salary`, `skin_male`, `skin_male2`, `skin_female`, `skin_female2`) VALUES
	('offweazel', 1, 'reporter', 'Reporter', 0, '{}', '{}', '{}', '{}');
INSERT INTO `job_grades` (`job_name`, `grade`, `name`, `label`, `salary`, `skin_male`, `skin_male2`, `skin_female`, `skin_female2`) VALUES
	('offweazel', 2, 'investigator', 'investigator', 0, '{}', '{}', '{}', '{}');
INSERT INTO `job_grades` (`job_name`, `grade`, `name`, `label`, `salary`, `skin_male`, `skin_male2`, `skin_female`, `skin_female2`) VALUES
	('offweazel', 3, 'administrator', 'administrator', 0, '{}', '{}', '{}', '{}');
INSERT INTO `job_grades` (`job_name`, `grade`, `name`, `label`, `salary`, `skin_male`, `skin_male2`, `skin_female`, `skin_female2`) VALUES
	('offweazel', 4, 'boss', 'CEO', 0, '{}', '{}', '{}', '{}');
INSERT INTO `job_grades` (`job_name`, `grade`, `name`, `label`, `salary`, `skin_male`, `skin_male2`, `skin_female`, `skin_female2`) VALUES
	('coffee', 0, 'nezafat', 'Nezafat Chi', 0, '{}', '{}', '{}', '{}');
INSERT INTO `job_grades` (`job_name`, `grade`, `name`, `label`, `salary`, `skin_male`, `skin_male2`, `skin_female`, `skin_female2`) VALUES
	('coffee', 1, 'garson', 'Garson', 0, '{}', '{}', '{}', '{}');
INSERT INTO `job_grades` (`job_name`, `grade`, `name`, `label`, `salary`, `skin_male`, `skin_male2`, `skin_female`, `skin_female2`) VALUES
	('coffee', 2, 'ashpaz', 'Ashpaz', 0, '{}', '{}', '{}', '{}');
INSERT INTO `job_grades` (`job_name`, `grade`, `name`, `label`, `salary`, `skin_male`, `skin_male2`, `skin_female`, `skin_female2`) VALUES
	('coffee', 3, 'sandoghdar', 'Sandoghdar', 0, '{}', '{}', '{}', '{}');
INSERT INTO `job_grades` (`job_name`, `grade`, `name`, `label`, `salary`, `skin_male`, `skin_male2`, `skin_female`, `skin_female2`) VALUES
	('coffee', 4, 'boss', 'Rais', 0, '{}', '{}', '{}', '{}');
INSERT INTO `job_grades` (`job_name`, `grade`, `name`, `label`, `salary`, `skin_male`, `skin_male2`, `skin_female`, `skin_female2`) VALUES
	('offcoffee', 0, 'nezafat', 'Nezafat Chi', 0, '{}', '{}', '{}', '{}');
INSERT INTO `job_grades` (`job_name`, `grade`, `name`, `label`, `salary`, `skin_male`, `skin_male2`, `skin_female`, `skin_female2`) VALUES
	('offcoffee', 1, 'garson', 'Garson', 0, '{}', '{}', '{}', '{}');
INSERT INTO `job_grades` (`job_name`, `grade`, `name`, `label`, `salary`, `skin_male`, `skin_male2`, `skin_female`, `skin_female2`) VALUES
	('offcoffee', 2, 'ashpaz', 'Ashpaz', 0, '{}', '{}', '{}', '{}');
INSERT INTO `job_grades` (`job_name`, `grade`, `name`, `label`, `salary`, `skin_male`, `skin_male2`, `skin_female`, `skin_female2`) VALUES
	('offcoffee', 3, 'sandoghdar', 'Sandoghdar', 0, '{}', '{}', '{}', '{}');
INSERT INTO `job_grades` (`job_name`, `grade`, `name`, `label`, `salary`, `skin_male`, `skin_male2`, `skin_female`, `skin_female2`) VALUES
	('offcoffee', 4, 'boss', 'Rais', 0, '{}', '{}', '{}', '{}');
INSERT INTO `job_grades` (`job_name`, `grade`, `name`, `label`, `salary`, `skin_male`, `skin_male2`, `skin_female`, `skin_female2`) VALUES
	('doc', 0, 'trainee', 'Jarokesh', 0, '{}', '{}', '{}', '{}');
INSERT INTO `job_grades` (`job_name`, `grade`, `name`, `label`, `salary`, `skin_male`, `skin_male2`, `skin_female`, `skin_female2`) VALUES
	('doc', 1, 'cofficer', 'Zendan Bane |', 0, '{}', '{}', '{}', '{}');
INSERT INTO `job_grades` (`job_name`, `grade`, `name`, `label`, `salary`, `skin_male`, `skin_male2`, `skin_female`, `skin_female2`) VALUES
	('doc', 2, 'cofficer2', 'Zendan Bane ||', 0, '{}', '{}', '{}', '{}');
INSERT INTO `job_grades` (`job_name`, `grade`, `name`, `label`, `salary`, `skin_male`, `skin_male2`, `skin_female`, `skin_female2`) VALUES
	('doc', 3, 'cofficer3', 'Zendan Bane |||', 0, '{}', '{}', '{}', '{}');
INSERT INTO `job_grades` (`job_name`, `grade`, `name`, `label`, `salary`, `skin_male`, `skin_male2`, `skin_female`, `skin_female2`) VALUES
	('doc', 4, 'guardian', 'Negahban', 0, '{}', '{}', '{}', '{}');
INSERT INTO `job_grades` (`job_name`, `grade`, `name`, `label`, `salary`, `skin_male`, `skin_male2`, `skin_female`, `skin_female2`) VALUES
	('doc', 5, 'mguardian', 'Negahbane Borj', 0, '{}', '{}', '{}', '{}');
INSERT INTO `job_grades` (`job_name`, `grade`, `name`, `label`, `salary`, `skin_male`, `skin_male2`, `skin_female`, `skin_female2`) VALUES
	('doc', 6, 'lieutenant', 'Behiar', 0, '{}', '{}', '{}', '{}');
INSERT INTO `job_grades` (`job_name`, `grade`, `name`, `label`, `salary`, `skin_male`, `skin_male2`, `skin_female`, `skin_female2`) VALUES
	('doc', 7, 'boss', 'Raiis', 0, '{}', '{}', '{}', '{}');
INSERT INTO `job_grades` (`job_name`, `grade`, `name`, `label`, `salary`, `skin_male`, `skin_male2`, `skin_female`, `skin_female2`) VALUES
	('offdoc', 0, 'trainee', 'Jarokesh', 0, '{}', '{}', '{}', '{}');
INSERT INTO `job_grades` (`job_name`, `grade`, `name`, `label`, `salary`, `skin_male`, `skin_male2`, `skin_female`, `skin_female2`) VALUES
	('offdoc', 1, 'cofficer', 'Zendan Bane |', 0, '{}', '{}', '{}', '{}');
INSERT INTO `job_grades` (`job_name`, `grade`, `name`, `label`, `salary`, `skin_male`, `skin_male2`, `skin_female`, `skin_female2`) VALUES
	('offdoc', 2, 'cofficer2', 'Zendan Bane ||', 0, '{}', '{}', '{}', '{}');
INSERT INTO `job_grades` (`job_name`, `grade`, `name`, `label`, `salary`, `skin_male`, `skin_male2`, `skin_female`, `skin_female2`) VALUES
	('offdoc', 3, 'cofficer3', 'Zendan Bane |||', 0, '{}', '{}', '{}', '{}');
INSERT INTO `job_grades` (`job_name`, `grade`, `name`, `label`, `salary`, `skin_male`, `skin_male2`, `skin_female`, `skin_female2`) VALUES
	('offdoc', 4, 'guardian', 'Negahban', 0, '{}', '{}', '{}', '{}');
INSERT INTO `job_grades` (`job_name`, `grade`, `name`, `label`, `salary`, `skin_male`, `skin_male2`, `skin_female`, `skin_female2`) VALUES
	('offdoc', 5, 'mguardian', 'Negahbane Borj', 0, '{}', '{}', '{}', '{}');
INSERT INTO `job_grades` (`job_name`, `grade`, `name`, `label`, `salary`, `skin_male`, `skin_male2`, `skin_female`, `skin_female2`) VALUES
	('offdoc', 6, 'lieutenant', 'Behiar', 0, '{}', '{}', '{}', '{}');
INSERT INTO `job_grades` (`job_name`, `grade`, `name`, `label`, `salary`, `skin_male`, `skin_male2`, `skin_female`, `skin_female2`) VALUES
	('offdoc', 7, 'boss', 'Raiis', 0, '{}', '{}', '{}', '{}');
INSERT INTO `job_grades` (`job_name`, `grade`, `name`, `label`, `salary`, `skin_male`, `skin_male2`, `skin_female`, `skin_female2`) VALUES
	('government', 0, 'agent', 'Abdarchi', 0, '{}', '{}', '{}', '{}');
INSERT INTO `job_grades` (`job_name`, `grade`, `name`, `label`, `salary`, `skin_male`, `skin_male2`, `skin_female`, `skin_female2`) VALUES
	('government', 1, 'sagent', 'Daftardar', 0, '{}', '{}', '{}', '{}');
INSERT INTO `job_grades` (`job_name`, `grade`, `name`, `label`, `salary`, `skin_male`, `skin_male2`, `skin_female`, `skin_female2`) VALUES
	('government', 2, 'supervisor', 'Baigani', 0, '{}', '{}', '{}', '{}');
INSERT INTO `job_grades` (`job_name`, `grade`, `name`, `label`, `salary`, `skin_male`, `skin_male2`, `skin_female`, `skin_female2`) VALUES
	('government', 3, 'speaker', 'Herasat', 0, '{}', '{}', '{}', '{}');
INSERT INTO `job_grades` (`job_name`, `grade`, `name`, `label`, `salary`, `skin_male`, `skin_male2`, `skin_female`, `skin_female2`) VALUES
	('government', 4, 'ddirector', 'Moaven', 0, '{}', '{}', '{}', '{}');
INSERT INTO `job_grades` (`job_name`, `grade`, `name`, `label`, `salary`, `skin_male`, `skin_male2`, `skin_female`, `skin_female2`) VALUES
	('government', 5, 'director', 'Ghazi', 0, '{}', '{}', '{}', '{}');
INSERT INTO `job_grades` (`job_name`, `grade`, `name`, `label`, `salary`, `skin_male`, `skin_male2`, `skin_female`, `skin_female2`) VALUES
	('government', 6, 'boss', 'Raiis Jomhor', 0, '{}', '{}', '{}', '{}');
INSERT INTO `job_grades` (`job_name`, `grade`, `name`, `label`, `salary`, `skin_male`, `skin_male2`, `skin_female`, `skin_female2`) VALUES
	('offgovernment', 0, 'agent', 'Abdarchi', 0, '{}', '{}', '{}', '{}');
INSERT INTO `job_grades` (`job_name`, `grade`, `name`, `label`, `salary`, `skin_male`, `skin_male2`, `skin_female`, `skin_female2`) VALUES
	('offgovernment', 1, 'sagent', 'Daftardar', 0, '{}', '{}', '{}', '{}');
INSERT INTO `job_grades` (`job_name`, `grade`, `name`, `label`, `salary`, `skin_male`, `skin_male2`, `skin_female`, `skin_female2`) VALUES
	('offgovernment', 2, 'supervisor', 'Baigani', 0, '{}', '{}', '{}', '{}');
INSERT INTO `job_grades` (`job_name`, `grade`, `name`, `label`, `salary`, `skin_male`, `skin_male2`, `skin_female`, `skin_female2`) VALUES
	('offgovernment', 3, 'speaker', 'Herasat', 0, '{}', '{}', '{}', '{}');
INSERT INTO `job_grades` (`job_name`, `grade`, `name`, `label`, `salary`, `skin_male`, `skin_male2`, `skin_female`, `skin_female2`) VALUES
	('offgovernment', 4, 'ddirector', 'Moaven', 0, '{}', '{}', '{}', '{}');
INSERT INTO `job_grades` (`job_name`, `grade`, `name`, `label`, `salary`, `skin_male`, `skin_male2`, `skin_female`, `skin_female2`) VALUES
	('offgovernment', 5, 'director', 'Ghazi', 0, '{}', '{}', '{}', '{}');
INSERT INTO `job_grades` (`job_name`, `grade`, `name`, `label`, `salary`, `skin_male`, `skin_male2`, `skin_female`, `skin_female2`) VALUES
	('offgovernment', 6, 'boss', 'Rais', 0, '{}', '{}', '{}', '{}');
INSERT INTO `job_grades` (`job_name`, `grade`, `name`, `label`, `salary`, `skin_male`, `skin_male2`, `skin_female`, `skin_female2`) VALUES
	('nightclub', 0, 'baeman', 'Khedmatkar', 0, '{}', '{}', '{}', '{}');
INSERT INTO `job_grades` (`job_name`, `grade`, `name`, `label`, `salary`, `skin_male`, `skin_male2`, `skin_female`, `skin_female2`) VALUES
	('nightclub', 1, 'dancer', 'Raghaas', 0, '{}', '{}', '{}', '{}');
INSERT INTO `job_grades` (`job_name`, `grade`, `name`, `label`, `salary`, `skin_male`, `skin_male2`, `skin_female`, `skin_female2`) VALUES
	('nightclub', 2, 'viceboss', 'Dastyare Raiis', 0, '{}', '{}', '{}', '{}');
INSERT INTO `job_grades` (`job_name`, `grade`, `name`, `label`, `salary`, `skin_male`, `skin_male2`, `skin_female`, `skin_female2`) VALUES
	('nightclub', 3, 'boss', 'Rais', 0, '{}', '{}', '{}', '{}');
INSERT INTO `job_grades` (`job_name`, `grade`, `name`, `label`, `salary`, `skin_male`, `skin_male2`, `skin_female`, `skin_female2`) VALUES
	('fbi', 0, 'agent', 'Agent', 0, '{}', '{}', '{}', '{}');
INSERT INTO `job_grades` (`job_name`, `grade`, `name`, `label`, `salary`, `skin_male`, `skin_male2`, `skin_female`, `skin_female2`) VALUES
	('fbi', 1, 'special', 'Experienced Agent', 0, '{}', '{}', '{}', '{}');
INSERT INTO `job_grades` (`job_name`, `grade`, `name`, `label`, `salary`, `skin_male`, `skin_male2`, `skin_female`, `skin_female2`) VALUES
	('fbi', 2, 'supervisor', 'Supervisor', 0, '{}', '{}', '{}', '{}');
INSERT INTO `job_grades` (`job_name`, `grade`, `name`, `label`, `salary`, `skin_male`, `skin_male2`, `skin_female`, `skin_female2`) VALUES
	('fbi', 3, 'assistant', 'Assistant Director', 0, '{}', '{}', '{}', '{}');
INSERT INTO `job_grades` (`job_name`, `grade`, `name`, `label`, `salary`, `skin_male`, `skin_male2`, `skin_female`, `skin_female2`) VALUES
	('fbi', 4, 'boss', 'Director', 0, '{}', '{}', '{}', '{}');
INSERT INTO `job_grades` (`job_name`, `grade`, `name`, `label`, `salary`, `skin_male`, `skin_male2`, `skin_female`, `skin_female2`) VALUES
	('sheriff', 0, 'agent', 'Agent', 0, '{}', '{}', '{}', '{}');
INSERT INTO `job_grades` (`job_name`, `grade`, `name`, `label`, `salary`, `skin_male`, `skin_male2`, `skin_female`, `skin_female2`) VALUES
	('sheriff', 1, 'special', 'Experienced Agent', 0, '{}', '{}', '{}', '{}');
INSERT INTO `job_grades` (`job_name`, `grade`, `name`, `label`, `salary`, `skin_male`, `skin_male2`, `skin_female`, `skin_female2`) VALUES
	('sheriff', 2, 'supervisor', 'Supervisor', 0, '{}', '{}', '{}', '{}');
INSERT INTO `job_grades` (`job_name`, `grade`, `name`, `label`, `salary`, `skin_male`, `skin_male2`, `skin_female`, `skin_female2`) VALUES
	('sheriff', 3, 'assistant', 'Assistant Director', 0, '{}', '{}', '{}', '{}');
INSERT INTO `job_grades` (`job_name`, `grade`, `name`, `label`, `salary`, `skin_male`, `skin_male2`, `skin_female`, `skin_female2`) VALUES
	('sheriff', 4, 'boss', 'Director', 0, '{}', '{}', '{}', '{}');
INSERT INTO `job_grades` (`job_name`, `grade`, `name`, `label`, `salary`, `skin_male`, `skin_male2`, `skin_female`, `skin_female2`) VALUES
	('police', 0, 'recruit', 'Recruit', 0, '{"hair_2":0,"hair_color_2":0,"torso_1":32,"bags_1":0,"helmet_2":0,"chain_2":0,"eyebrows_3":0,"makeup_3":0,"makeup_2":0,"tshirt_1":31,"makeup_1":0,"bags_2":0,"makeup_4":0,"eyebrows_4":0,"chain_1":0,"lipstick_4":0,"bproof_2":0,"hair_color_1":0,"decals_2":0,"pants_2":0,"age_2":0,"glasses_2":0,"ears_2":0,"arms":27,"lipstick_1":0,"ears_1":-1,"mask_2":0,"sex":0,"lipstick_3":0,"helmet_1":-1,"shoes_2":0,"beard_2":0,"beard_1":0,"lipstick_2":0,"beard_4":0,"glasses_1":0,"bproof_1":0,"mask_1":0,"decals_1":1,"hair_1":0,"eyebrows_2":0,"beard_3":0,"age_1":0,"tshirt_2":0,"skin":0,"torso_2":0,"eyebrows_1":0,"face":0,"shoes_1":10,"pants_1":24}', '{}', '{}', '{}');
INSERT INTO `job_grades` (`job_name`, `grade`, `name`, `label`, `salary`, `skin_male`, `skin_male2`, `skin_female`, `skin_female2`) VALUES
	('police', 2, 'po1', 'PO 1', 0, '{} ', '{}', '{}', '{}');
INSERT INTO `job_grades` (`job_name`, `grade`, `name`, `label`, `salary`, `skin_male`, `skin_male2`, `skin_female`, `skin_female2`) VALUES
	('police', 3, 'po2', 'PO 2', 0, '{}', '{}', '{}', '{}');
INSERT INTO `job_grades` (`job_name`, `grade`, `name`, `label`, `salary`, `skin_male`, `skin_male2`, `skin_female`, `skin_female2`) VALUES
	('police', 4, 'po3', 'PO 3', 0, '{}', '{}', '{}', '{}');
INSERT INTO `job_grades` (`job_name`, `grade`, `name`, `label`, `salary`, `skin_male`, `skin_male2`, `skin_female`, `skin_female2`) VALUES
	('police', 5, 'po3+1', 'PO3+1', 0, '{}', '{}', '{}', '{}');
INSERT INTO `job_grades` (`job_name`, `grade`, `name`, `label`, `salary`, `skin_male`, `skin_male2`, `skin_female`, `skin_female2`) VALUES
	('police', 6, 'sgt', 'SGT', 0, '{}', '{}', '{}', '{}');
INSERT INTO `job_grades` (`job_name`, `grade`, `name`, `label`, `salary`, `skin_male`, `skin_male2`, `skin_female`, `skin_female2`) VALUES
	('police', 7, 'sgt2', 'SGT 2', 0, '{}', '{}', '{}', '{}');
INSERT INTO `job_grades` (`job_name`, `grade`, `name`, `label`, `salary`, `skin_male`, `skin_male2`, `skin_female`, `skin_female2`) VALUES
	('police', 8, 'dt', 'DT', 0, '{}', '{}', '{}', '{}');
INSERT INTO `job_grades` (`job_name`, `grade`, `name`, `label`, `salary`, `skin_male`, `skin_male2`, `skin_female`, `skin_female2`) VALUES
	('police', 9, 'dt2', 'DT 2', 0, '{}', '{}', '{}', '{}');
INSERT INTO `job_grades` (`job_name`, `grade`, `name`, `label`, `salary`, `skin_male`, `skin_male2`, `skin_female`, `skin_female2`) VALUES
	('police', 10, 'dt3', 'DT 3', 0, '{}', '{}', '{}', '{}');
INSERT INTO `job_grades` (`job_name`, `grade`, `name`, `label`, `salary`, `skin_male`, `skin_male2`, `skin_female`, `skin_female2`) VALUES
	('police', 11, 'lt', 'LT', 0, '{}', '{}', '{}', '{}');
INSERT INTO `job_grades` (`job_name`, `grade`, `name`, `label`, `salary`, `skin_male`, `skin_male2`, `skin_female`, `skin_female2`) VALUES
	('police', 12, 'lt2', 'LT 2', 0, '{}', '{}', '{}', '{}');
INSERT INTO `job_grades` (`job_name`, `grade`, `name`, `label`, `salary`, `skin_male`, `skin_male2`, `skin_female`, `skin_female2`) VALUES
	('police', 13, 'cpt', 'CPT', 0, '{}', '{}', '{}', '{}');
INSERT INTO `job_grades` (`job_name`, `grade`, `name`, `label`, `salary`, `skin_male`, `skin_male2`, `skin_female`, `skin_female2`) VALUES
	('police', 14, 'cpt2', 'CPT 2', 0, '{}', '{}', '{}', '{}');
INSERT INTO `job_grades` (`job_name`, `grade`, `name`, `label`, `salary`, `skin_male`, `skin_male2`, `skin_female`, `skin_female2`) VALUES
	('police', 15, 'cpt3', 'CPT 3', 0, '{}', '{}', '{}', '{}');
INSERT INTO `job_grades` (`job_name`, `grade`, `name`, `label`, `salary`, `skin_male`, `skin_male2`, `skin_female`, `skin_female2`) VALUES
	('police', 16, 'cdr', 'CDR', 0, '{}', '{}', '{}', '{}');
INSERT INTO `job_grades` (`job_name`, `grade`, `name`, `label`, `salary`, `skin_male`, `skin_male2`, `skin_female`, `skin_female2`) VALUES
	('police', 1, 'cadet', 'Cadet', 0, '{}', '{}', '{}', '{}');
INSERT INTO `job_grades` (`job_name`, `grade`, `name`, `label`, `salary`, `skin_male`, `skin_male2`, `skin_female`, `skin_female2`) VALUES
	('police', 17, 'dpc', 'DPC', 0, '{}', '{}', '{}', '{}');
INSERT INTO `job_grades` (`job_name`, `grade`, `name`, `label`, `salary`, `skin_male`, `skin_male2`, `skin_female`, `skin_female2`) VALUES
	('police', 18, 'dpc2', 'DPC 2', 0, '{}', '{}', '{}', '{}');
INSERT INTO `job_grades` (`job_name`, `grade`, `name`, `label`, `salary`, `skin_male`, `skin_male2`, `skin_female`, `skin_female2`) VALUES
	('police', 19, 'cf', 'CF', 0, '{}', '{}', '{}', '{}');
INSERT INTO `job_grades` (`job_name`, `grade`, `name`, `label`, `salary`, `skin_male`, `skin_male2`, `skin_female`, `skin_female2`) VALUES
	('offpolice', 0, 'offpd', 'OFF-PD', 0, '{}', '{}', '{}', '{}');
INSERT INTO `job_grades` (`job_name`, `grade`, `name`, `label`, `salary`, `skin_male`, `skin_male2`, `skin_female`, `skin_female2`) VALUES
	('offpolice', 1, 'offpd', 'OFF-PD', 0, '{}', '{}', '{}', '{}');
INSERT INTO `job_grades` (`job_name`, `grade`, `name`, `label`, `salary`, `skin_male`, `skin_male2`, `skin_female`, `skin_female2`) VALUES
	('offpolice', 2, 'offpd', 'OFF-PD', 0, '{}', '{}', '{}', '{}');
INSERT INTO `job_grades` (`job_name`, `grade`, `name`, `label`, `salary`, `skin_male`, `skin_male2`, `skin_female`, `skin_female2`) VALUES
	('offpolice', 3, 'offpd', 'OFF-PD', 0, '{}', '{}', '{}', '{}');
INSERT INTO `job_grades` (`job_name`, `grade`, `name`, `label`, `salary`, `skin_male`, `skin_male2`, `skin_female`, `skin_female2`) VALUES
	('offpolice', 4, 'offpd', 'OFF-PD', 0, '{}', '{}', '{}', '{}');
INSERT INTO `job_grades` (`job_name`, `grade`, `name`, `label`, `salary`, `skin_male`, `skin_male2`, `skin_female`, `skin_female2`) VALUES
	('offpolice', 5, 'offpd', 'OFF-PD', 0, '{}', '{}', '{}', '{}');
INSERT INTO `job_grades` (`job_name`, `grade`, `name`, `label`, `salary`, `skin_male`, `skin_male2`, `skin_female`, `skin_female2`) VALUES
	('offpolice', 6, 'offpd', 'OFF-PD', 0, '{}', '{}', '{}', '{}');
INSERT INTO `job_grades` (`job_name`, `grade`, `name`, `label`, `salary`, `skin_male`, `skin_male2`, `skin_female`, `skin_female2`) VALUES
	('offpolice', 7, 'offpd', 'OFF-PD', 0, '{}', '{}', '{}', '{}');
INSERT INTO `job_grades` (`job_name`, `grade`, `name`, `label`, `salary`, `skin_male`, `skin_male2`, `skin_female`, `skin_female2`) VALUES
	('offpolice', 8, 'offpd', 'OFF-PD', 0, '{}', '{}', '{}', '{}');
INSERT INTO `job_grades` (`job_name`, `grade`, `name`, `label`, `salary`, `skin_male`, `skin_male2`, `skin_female`, `skin_female2`) VALUES
	('offpolice', 9, 'offpd', 'OFF-PD', 0, '{}', '{}', '{}', '{}');
INSERT INTO `job_grades` (`job_name`, `grade`, `name`, `label`, `salary`, `skin_male`, `skin_male2`, `skin_female`, `skin_female2`) VALUES
	('offpolice', 10, 'offpd', 'OFF-PD', 0, '{}', '{}', '{}', '{}');
INSERT INTO `job_grades` (`job_name`, `grade`, `name`, `label`, `salary`, `skin_male`, `skin_male2`, `skin_female`, `skin_female2`) VALUES
	('offpolice', 11, 'offpd', 'OFF-PD', 0, '{}', '{}', '{}', '{}');
INSERT INTO `job_grades` (`job_name`, `grade`, `name`, `label`, `salary`, `skin_male`, `skin_male2`, `skin_female`, `skin_female2`) VALUES
	('offpolice', 12, 'offpd', 'OFF-PD', 0, '{}', '{}', '{}', '{}');
INSERT INTO `job_grades` (`job_name`, `grade`, `name`, `label`, `salary`, `skin_male`, `skin_male2`, `skin_female`, `skin_female2`) VALUES
	('offpolice', 13, 'offpd', 'OFF-PD', 0, '{}', '{}', '{}', '{}');
INSERT INTO `job_grades` (`job_name`, `grade`, `name`, `label`, `salary`, `skin_male`, `skin_male2`, `skin_female`, `skin_female2`) VALUES
	('offpolice', 14, 'offpd', 'OFF-PD', 0, '{}', '{}', '{}', '{}');
INSERT INTO `job_grades` (`job_name`, `grade`, `name`, `label`, `salary`, `skin_male`, `skin_male2`, `skin_female`, `skin_female2`) VALUES
	('offpolice', 15, 'offpd', 'OFF-PD', 0, '{}', '{}', '{}', '{}');
INSERT INTO `job_grades` (`job_name`, `grade`, `name`, `label`, `salary`, `skin_male`, `skin_male2`, `skin_female`, `skin_female2`) VALUES
	('offpolice', 16, 'offpd', 'OFF-PD', 0, '{}', '{}', '{}', '{}');
INSERT INTO `job_grades` (`job_name`, `grade`, `name`, `label`, `salary`, `skin_male`, `skin_male2`, `skin_female`, `skin_female2`) VALUES
	('offpolice', 17, 'offpd', 'OFF-PD', 0, '{}', '{}', '{}', '{}');
INSERT INTO `job_grades` (`job_name`, `grade`, `name`, `label`, `salary`, `skin_male`, `skin_male2`, `skin_female`, `skin_female2`) VALUES
	('offpolice', 18, 'offpd', 'OFF-PD', 0, '{}', '{}', '{}', '{}');
INSERT INTO `job_grades` (`job_name`, `grade`, `name`, `label`, `salary`, `skin_male`, `skin_male2`, `skin_female`, `skin_female2`) VALUES
	('offpolice', 19, 'offpd', 'OFF-PD', 0, '{}', '{}', '{}', '{}');
INSERT INTO `job_grades` (`job_name`, `grade`, `name`, `label`, `salary`, `skin_male`, `skin_male2`, `skin_female`, `skin_female2`) VALUES
	('uwu', 0, 'waiter', 'Waiter', 0, '{}', '{}', '{}', '{}');
INSERT INTO `job_grades` (`job_name`, `grade`, `name`, `label`, `salary`, `skin_male`, `skin_male2`, `skin_female`, `skin_female2`) VALUES
	('uwu', 1, 'security', 'Security', 0, '{}', '{}', '{}', '{}');
INSERT INTO `job_grades` (`job_name`, `grade`, `name`, `label`, `salary`, `skin_male`, `skin_male2`, `skin_female`, `skin_female2`) VALUES
	('uwu', 2, 'barista', 'Barista', 0, '{}', '{}', '{}', '{}');
INSERT INTO `job_grades` (`job_name`, `grade`, `name`, `label`, `salary`, `skin_male`, `skin_male2`, `skin_female`, `skin_female2`) VALUES
	('uwu', 3, 'hall_manager', 'Hall manager', 0, '{}', '{}', '{}', '{}');
INSERT INTO `job_grades` (`job_name`, `grade`, `name`, `label`, `salary`, `skin_male`, `skin_male2`, `skin_female`, `skin_female2`) VALUES
	('uwu', 4, 'manager', 'Manager', 0, '{}', '{}', '{}', '{}');
INSERT INTO `job_grades` (`job_name`, `grade`, `name`, `label`, `salary`, `skin_male`, `skin_male2`, `skin_female`, `skin_female2`) VALUES
	('uwu', 5, 'owner', 'Owner', 0, '{}', '{}', '{}', '{}');
/*!40000 ALTER TABLE `job_grades` ENABLE KEYS */;

-- Dumping structure for table essential.jsfour_criminalrecord
CREATE TABLE IF NOT EXISTS `jsfour_criminalrecord` (
  `offense` varchar(160) NOT NULL,
  `date` varchar(255) DEFAULT NULL,
  `institution` varchar(255) DEFAULT NULL,
  `charge` varchar(255) DEFAULT NULL,
  `description` varchar(255) DEFAULT NULL,
  `term` varchar(255) DEFAULT NULL,
  `classified` int(2) NOT NULL DEFAULT 0,
  `identifier` varchar(255) DEFAULT NULL,
  `dob` varchar(255) DEFAULT NULL,
  `warden` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`offense`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Dumping data for table essential.jsfour_criminalrecord: ~0 rows (approximately)
/*!40000 ALTER TABLE `jsfour_criminalrecord` DISABLE KEYS */;
/*!40000 ALTER TABLE `jsfour_criminalrecord` ENABLE KEYS */;

-- Dumping structure for table essential.jsfour_criminaluserinfo
CREATE TABLE IF NOT EXISTS `jsfour_criminaluserinfo` (
  `identifier` varchar(160) NOT NULL,
  `aliases` varchar(255) DEFAULT NULL,
  `recordid` varchar(255) DEFAULT NULL,
  `weight` varchar(255) DEFAULT NULL,
  `eyecolor` varchar(255) DEFAULT NULL,
  `haircolor` varchar(255) DEFAULT NULL,
  `firstname` varchar(255) DEFAULT NULL,
  `lastname` varchar(255) DEFAULT NULL,
  `dob` varchar(255) DEFAULT NULL,
  `sex` varchar(255) DEFAULT NULL,
  `height` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`identifier`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Dumping data for table essential.jsfour_criminaluserinfo: ~0 rows (approximately)
/*!40000 ALTER TABLE `jsfour_criminaluserinfo` DISABLE KEYS */;
/*!40000 ALTER TABLE `jsfour_criminaluserinfo` ENABLE KEYS */;

-- Dumping structure for table essential.licenses
CREATE TABLE IF NOT EXISTS `licenses` (
  `type` varchar(60) NOT NULL,
  `label` varchar(60) NOT NULL,
  PRIMARY KEY (`type`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_persian_ci ROW_FORMAT=DYNAMIC;

-- Dumping data for table essential.licenses: ~8 rows (approximately)
/*!40000 ALTER TABLE `licenses` DISABLE KEYS */;
INSERT INTO `licenses` (`type`, `label`) VALUES
	('boat', 'Mojaveze Boat');
INSERT INTO `licenses` (`type`, `label`) VALUES
	('drive_bike', 'Mojaveze Bike');
INSERT INTO `licenses` (`type`, `label`) VALUES
	('drive_truck', 'Mojaveze Trunk');
INSERT INTO `licenses` (`type`, `label`) VALUES
	('drive_vehicle', 'Mojaveze vehicle');
INSERT INTO `licenses` (`type`, `label`) VALUES
	('fly', 'Mojaveze fly');
INSERT INTO `licenses` (`type`, `label`) VALUES
	('gc2', 'Mojaveze Gun Class 2');
INSERT INTO `licenses` (`type`, `label`) VALUES
	('gc3', 'Mojaveze Gun Class 3');
INSERT INTO `licenses` (`type`, `label`) VALUES
	('weapon', 'Mojaveze Weapon');
/*!40000 ALTER TABLE `licenses` ENABLE KEYS */;

-- Dumping structure for table essential.mdt_bolos
CREATE TABLE IF NOT EXISTS `mdt_bolos` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `title` longtext NOT NULL,
  `plate` longtext NOT NULL,
  `owner` longtext NOT NULL,
  `individual` longtext NOT NULL,
  `detail` longtext NOT NULL,
  `tags` longtext NOT NULL,
  `gallery` longtext NOT NULL,
  `officers` longtext NOT NULL,
  `time` longtext NOT NULL,
  `author` longtext DEFAULT NULL,
  `type` longtext DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Dumping data for table essential.mdt_bolos: ~0 rows (approximately)
/*!40000 ALTER TABLE `mdt_bolos` DISABLE KEYS */;
/*!40000 ALTER TABLE `mdt_bolos` ENABLE KEYS */;

-- Dumping structure for table essential.mdt_bulletins
CREATE TABLE IF NOT EXISTS `mdt_bulletins` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `author` longtext DEFAULT NULL,
  `title` longtext DEFAULT NULL,
  `info` longtext DEFAULT NULL,
  `time` longtext DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Dumping data for table essential.mdt_bulletins: ~0 rows (approximately)
/*!40000 ALTER TABLE `mdt_bulletins` DISABLE KEYS */;
/*!40000 ALTER TABLE `mdt_bulletins` ENABLE KEYS */;

-- Dumping structure for table essential.mdt_dashmessage
CREATE TABLE IF NOT EXISTS `mdt_dashmessage` (
  `message` longtext DEFAULT NULL,
  `time` longtext DEFAULT NULL,
  `author` longtext DEFAULT NULL,
  `profilepic` longtext DEFAULT NULL,
  `job` longtext DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Dumping data for table essential.mdt_dashmessage: ~2 rows (approximately)
/*!40000 ALTER TABLE `mdt_dashmessage` DISABLE KEYS */;
INSERT INTO `mdt_dashmessage` (`message`, `time`, `author`, `profilepic`, `job`) VALUES
	('mas', '1671726787837', 'KAKXER BELA', 'https://cdn.discordapp.com/attachments/996093699060678677/1055512175839555614/image.png', 'police');
INSERT INTO `mdt_dashmessage` (`message`, `time`, `author`, `profilepic`, `job`) VALUES
	('das', '1671729694339', 'KAKXER BELA', 'https://cdn.discordapp.com/attachments/996093699060678677/1055512175839555614/image.png', 'police');
/*!40000 ALTER TABLE `mdt_dashmessage` ENABLE KEYS */;

-- Dumping structure for table essential.mdt_incidents
CREATE TABLE IF NOT EXISTS `mdt_incidents` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `title` longtext NOT NULL,
  `information` longtext NOT NULL,
  `tags` longtext NOT NULL,
  `officers` longtext NOT NULL,
  `civilians` longtext NOT NULL,
  `evidence` longtext NOT NULL,
  `associated` longtext NOT NULL,
  `time` longtext NOT NULL,
  `author` longtext DEFAULT NULL,
  `type` longtext DEFAULT 'police',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Dumping data for table essential.mdt_incidents: ~0 rows (approximately)
/*!40000 ALTER TABLE `mdt_incidents` DISABLE KEYS */;
INSERT INTO `mdt_incidents` (`id`, `title`, `information`, `tags`, `officers`, `civilians`, `evidence`, `associated`, `time`, `author`, `type`) VALUES
	(1, 'Name - Charge - 12/22/2022', '📝 Summary:\n\n[Insert Report Summary Here]\n\n🧍 Hostage: [Name Here]\n\n🔪 Weapons/Items Confiscated:\n\n· [Insert List Here]\n\n-----\n💸 Fine:\n⌚ Sentence:\n-----', '[]', '[]', '[]', '["https://cdn.discordapp.com/attachments/1044228530747220000/1046763067721130074/image.png"]', '[]', '1671719458661', 'KAKXER BELA', 'police');
/*!40000 ALTER TABLE `mdt_incidents` ENABLE KEYS */;

-- Dumping structure for table essential.mdt_logs
CREATE TABLE IF NOT EXISTS `mdt_logs` (
  `log` longtext DEFAULT NULL,
  `time` longtext DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Dumping data for table essential.mdt_logs: ~4 rows (approximately)
/*!40000 ALTER TABLE `mdt_logs` DISABLE KEYS */;
INSERT INTO `mdt_logs` (`log`, `time`) VALUES
	('KAKXER BELA Created New Incident.', '1671719417985');
INSERT INTO `mdt_logs` (`log`, `time`) VALUES
	('KAKXER BELA Edited Incident.', '1671719458661');
INSERT INTO `mdt_logs` (`log`, `time`) VALUES
	('KAKXER BELA Created New Report.', '1671719485972');
INSERT INTO `mdt_logs` (`log`, `time`) VALUES
	('KAKXER BELA Deleted Bulletin.', '1671727041299');
/*!40000 ALTER TABLE `mdt_logs` ENABLE KEYS */;

-- Dumping structure for table essential.mdt_missing
CREATE TABLE IF NOT EXISTS `mdt_missing` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `identifier` longtext NOT NULL,
  `name` longtext NOT NULL,
  `date` longtext NOT NULL,
  `age` longtext NOT NULL,
  `lastseen` longtext NOT NULL,
  `image` longtext DEFAULT NULL,
  `notes` longtext DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Dumping data for table essential.mdt_missing: ~0 rows (approximately)
/*!40000 ALTER TABLE `mdt_missing` DISABLE KEYS */;
/*!40000 ALTER TABLE `mdt_missing` ENABLE KEYS */;

-- Dumping structure for table essential.mdt_report
CREATE TABLE IF NOT EXISTS `mdt_report` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `title` longtext DEFAULT NULL,
  `reporttype` longtext DEFAULT NULL,
  `author` longtext DEFAULT NULL,
  `detail` longtext DEFAULT NULL,
  `tags` longtext DEFAULT NULL,
  `gallery` longtext DEFAULT NULL,
  `officers` longtext DEFAULT NULL,
  `civilians` longtext DEFAULT NULL,
  `time` longtext DEFAULT NULL,
  `type` longtext DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Dumping data for table essential.mdt_report: ~0 rows (approximately)
/*!40000 ALTER TABLE `mdt_report` DISABLE KEYS */;
INSERT INTO `mdt_report` (`id`, `title`, `reporttype`, `author`, `detail`, `tags`, `gallery`, `officers`, `civilians`, `time`, `type`) VALUES
	(1, '', '', 'KAKXER BELA', '', '[]', '["https://cdn.discordapp.com/attachments/1044228530747220000/1046763067721130074/image.png"]', '[]', '[]', '1671719485972', 'police');
/*!40000 ALTER TABLE `mdt_report` ENABLE KEYS */;

-- Dumping structure for table essential.mdt_vehicleinfo
CREATE TABLE IF NOT EXISTS `mdt_vehicleinfo` (
  `plate` varchar(50) NOT NULL DEFAULT '',
  `code5` longtext NOT NULL DEFAULT 0,
  `stolen` longtext NOT NULL DEFAULT 0,
  `info` longtext NOT NULL DEFAULT '',
  `image` longtext NOT NULL,
  PRIMARY KEY (`plate`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Dumping data for table essential.mdt_vehicleinfo: ~2 rows (approximately)
/*!40000 ALTER TABLE `mdt_vehicleinfo` DISABLE KEYS */;
INSERT INTO `mdt_vehicleinfo` (`plate`, `code5`, `stolen`, `info`, `image`) VALUES
	('', '0', '0', '', '');
INSERT INTO `mdt_vehicleinfo` (`plate`, `code5`, `stolen`, `info`, `image`) VALUES
	('TWSU7382', '0', '0', '', 'https://cdn.discordapp.com/attachments/769245887654002782/890579805798531082/not-found.jpg');
/*!40000 ALTER TABLE `mdt_vehicleinfo` ENABLE KEYS */;

-- Dumping structure for table essential.mdt_weapons
CREATE TABLE IF NOT EXISTS `mdt_weapons` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `identifier` longtext DEFAULT NULL,
  `serialnumber` longtext DEFAULT NULL,
  `image` longtext DEFAULT 'https://cdn.discordapp.com/attachments/770324167894761522/912602343164502096/not-found.jpg',
  `owner` longtext DEFAULT NULL,
  `brand` longtext DEFAULT 'Unknown',
  `type` longtext DEFAULT 'Unknown',
  `information` longtext DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Dumping data for table essential.mdt_weapons: ~0 rows (approximately)
/*!40000 ALTER TABLE `mdt_weapons` DISABLE KEYS */;
/*!40000 ALTER TABLE `mdt_weapons` ENABLE KEYS */;

-- Dumping structure for table essential.owned_bags
CREATE TABLE IF NOT EXISTS `owned_bags` (
  `identifier` varchar(50) DEFAULT NULL,
  `id` int(11) DEFAULT NULL,
  `x` double DEFAULT NULL,
  `y` double DEFAULT NULL,
  `z` double DEFAULT NULL,
  `itemcount` int(11) NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci ROW_FORMAT=DYNAMIC;

-- Dumping data for table essential.owned_bags: ~0 rows (approximately)
/*!40000 ALTER TABLE `owned_bags` DISABLE KEYS */;
/*!40000 ALTER TABLE `owned_bags` ENABLE KEYS */;

-- Dumping structure for table essential.owned_bag_inventory
CREATE TABLE IF NOT EXISTS `owned_bag_inventory` (
  `id` int(11) DEFAULT NULL,
  `item` varchar(50) DEFAULT NULL,
  `label` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL,
  `count` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_persian_ci ROW_FORMAT=DYNAMIC;

-- Dumping data for table essential.owned_bag_inventory: ~0 rows (approximately)
/*!40000 ALTER TABLE `owned_bag_inventory` DISABLE KEYS */;
/*!40000 ALTER TABLE `owned_bag_inventory` ENABLE KEYS */;

-- Dumping structure for table essential.owned_properties
CREATE TABLE IF NOT EXISTS `owned_properties` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `price` double NOT NULL,
  `rented` int(11) NOT NULL,
  `owner` varchar(60) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_persian_ci;

-- Dumping data for table essential.owned_properties: ~0 rows (approximately)
/*!40000 ALTER TABLE `owned_properties` DISABLE KEYS */;
/*!40000 ALTER TABLE `owned_properties` ENABLE KEYS */;

-- Dumping structure for table essential.owned_shops
CREATE TABLE IF NOT EXISTS `owned_shops` (
  `number` int(11) NOT NULL,
  `owner` varchar(250) DEFAULT '{"identifier":"government","name":"Government"}',
  `money` int(11) DEFAULT 0,
  `value` varchar(255) DEFAULT '{"forsale":true,"value":500000}',
  `inventory` longtext DEFAULT '[]',
  `name` varchar(30) DEFAULT 'Shop',
  PRIMARY KEY (`number`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Dumping data for table essential.owned_shops: ~20 rows (approximately)
/*!40000 ALTER TABLE `owned_shops` DISABLE KEYS */;
INSERT INTO `owned_shops` (`number`, `owner`, `money`, `value`, `inventory`, `name`) VALUES
	(1, '{"name":"KAKXER BELA","identifier":"steam:1100001452540bf"}', 15159200, '{"forsale":false,"value":500000}', '{"red_phone":{"amount":0,"price":10000000}}', 'Shop');
INSERT INTO `owned_shops` (`number`, `owner`, `money`, `value`, `inventory`, `name`) VALUES
	(2, '{"identifier":"government","name":"Government"}', 0, '{"forsale":true,"value":500000}', '[]', 'Shop');
INSERT INTO `owned_shops` (`number`, `owner`, `money`, `value`, `inventory`, `name`) VALUES
	(3, '{"identifier":"government","name":"Government"}', 0, '{"forsale":true,"value":500000}', '[]', 'Shop');
INSERT INTO `owned_shops` (`number`, `owner`, `money`, `value`, `inventory`, `name`) VALUES
	(4, '{"identifier":"government","name":"Government"}', 0, '{"forsale":true,"value":500000}', '[]', 'Shop');
INSERT INTO `owned_shops` (`number`, `owner`, `money`, `value`, `inventory`, `name`) VALUES
	(5, '{"identifier":"government","name":"Government"}', 0, '{"forsale":true,"value":500000}', '[]', 'Shop');
INSERT INTO `owned_shops` (`number`, `owner`, `money`, `value`, `inventory`, `name`) VALUES
	(6, '{"identifier":"government","name":"Government"}', 0, '{"forsale":true,"value":500000}', '[]', 'Shop');
INSERT INTO `owned_shops` (`number`, `owner`, `money`, `value`, `inventory`, `name`) VALUES
	(7, '{"identifier":"government","name":"Government"}', 0, '{"forsale":true,"value":500000}', '[]', 'Shop');
INSERT INTO `owned_shops` (`number`, `owner`, `money`, `value`, `inventory`, `name`) VALUES
	(8, '{"identifier":"government","name":"Government"}', 0, '{"forsale":true,"value":500000}', '[]', 'Shop');
INSERT INTO `owned_shops` (`number`, `owner`, `money`, `value`, `inventory`, `name`) VALUES
	(9, '{"identifier":"government","name":"Government"}', 0, '{"forsale":true,"value":500000}', '[]', 'Shop');
INSERT INTO `owned_shops` (`number`, `owner`, `money`, `value`, `inventory`, `name`) VALUES
	(10, '{"identifier":"government","name":"Government"}', 0, '{"forsale":true,"value":500000}', '[]', 'Shop');
INSERT INTO `owned_shops` (`number`, `owner`, `money`, `value`, `inventory`, `name`) VALUES
	(11, '{"identifier":"government","name":"Government"}', 0, '{"forsale":true,"value":500000}', '[]', 'Shop');
INSERT INTO `owned_shops` (`number`, `owner`, `money`, `value`, `inventory`, `name`) VALUES
	(12, '{"identifier":"government","name":"Government"}', 0, '{"forsale":true,"value":500000}', '[]', 'Shop');
INSERT INTO `owned_shops` (`number`, `owner`, `money`, `value`, `inventory`, `name`) VALUES
	(13, '{"identifier":"government","name":"Government"}', 0, '{"forsale":true,"value":500000}', '[]', 'Shop');
INSERT INTO `owned_shops` (`number`, `owner`, `money`, `value`, `inventory`, `name`) VALUES
	(14, '{"identifier":"government","name":"Government"}', 0, '{"forsale":true,"value":500000}', '[]', 'Shop');
INSERT INTO `owned_shops` (`number`, `owner`, `money`, `value`, `inventory`, `name`) VALUES
	(15, '{"identifier":"government","name":"Government"}', 0, '{"forsale":true,"value":500000}', '[]', 'Shop');
INSERT INTO `owned_shops` (`number`, `owner`, `money`, `value`, `inventory`, `name`) VALUES
	(16, '{"identifier":"government","name":"Government"}', 0, '{"forsale":true,"value":500000}', '[]', 'Shop');
INSERT INTO `owned_shops` (`number`, `owner`, `money`, `value`, `inventory`, `name`) VALUES
	(17, '{"identifier":"government","name":"Government"}', 0, '{"forsale":true,"value":500000}', '[]', 'Shop');
INSERT INTO `owned_shops` (`number`, `owner`, `money`, `value`, `inventory`, `name`) VALUES
	(18, '{"identifier":"government","name":"Government"}', 0, '{"forsale":true,"value":500000}', '[]', 'Shop');
INSERT INTO `owned_shops` (`number`, `owner`, `money`, `value`, `inventory`, `name`) VALUES
	(19, '{"identifier":"government","name":"Government"}', 0, '{"forsale":true,"value":500000}', '[]', 'Shop');
INSERT INTO `owned_shops` (`number`, `owner`, `money`, `value`, `inventory`, `name`) VALUES
	(20, '{"identifier":"government","name":"Government"}', 0, '{"forsale":true,"value":500000}', '[]', 'Shop');
/*!40000 ALTER TABLE `owned_shops` ENABLE KEYS */;

-- Dumping structure for table essential.owned_vehicles
CREATE TABLE IF NOT EXISTS `owned_vehicles` (
  `owner` varchar(30) NOT NULL,
  `plate` varchar(12) NOT NULL,
  `damage` longtext NOT NULL,
  `vehicle` longtext NOT NULL,
  `type` varchar(20) NOT NULL DEFAULT 'car',
  `stored` tinyint(1) NOT NULL DEFAULT 0,
  `job` varchar(20) DEFAULT 'garage',
  `parkmeter` tinytext NOT NULL DEFAULT '0',
  `garagenum` int(50) DEFAULT 1,
  `parkmeternum` int(50) DEFAULT 0,
  `policei` int(11) DEFAULT 0,
  `sheriffi` int(11) DEFAULT 0,
  `cost` int(11) DEFAULT 14500,
  `cooldown` int(11) DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_persian_ci ROW_FORMAT=DYNAMIC;

-- Dumping data for table essential.owned_vehicles: ~40 rows (approximately)
/*!40000 ALTER TABLE `owned_vehicles` DISABLE KEYS */;
INSERT INTO `owned_vehicles` (`owner`, `plate`, `damage`, `vehicle`, `type`, `stored`, `job`, `parkmeter`, `garagenum`, `parkmeternum`, `policei`, `sheriffi`, `cost`, `cooldown`) VALUES
	('steam:1100001452540bfs', 'ODZG7478', '{"engineHealth":1000.0,"dirtLevel":5.0,"fuelLevel":50.0,"vehicleHealth":1000,"doorStates":[],"bodyHealth":1000.0,"windowStates":[2,3,4,5],"tankHealth":1000.0,"tyreStates":[]}', '{"modTransmission":-1,"modSpoilers":-1,"modDial":-1,"color1":0,"modLivery":-1,"pearlescentColor":38,"interiorColor":111,"modSmokeEnabled":false,"modTurbo":false,"modRoof":-1,"modExhaust":-1,"wheelColor":156,"modEngineBlock":-1,"modGrille":-1,"color1Custom":[8,8,8],"extraEnabled":[],"modSeats":-1,"wheels":6,"neonEnabled":[false,false,false,false],"modRightFender":-1,"modSpeakers":-1,"color2Type":0,"modTrimB":-1,"color2":27,"model":86520421,"modShifterLeavers":-1,"modXenon":255,"tyreSmokeColor":[255,255,255],"neonColor":[255,0,255],"modTrunk":-1,"modBrakes":-1,"modBackWheels":-1,"modFender":-1,"modSteeringWheel":-1,"modWindows":-1,"modEngine":-1,"modTank":-1,"modStruts":-1,"modDoorSpeaker":-1,"modArmor":-1,"modVanityPlate":-1,"dashboardColor":111,"modFrontBumper":-1,"plateIndex":0,"modAerials":-1,"modRearBumper":-1,"color1Type":0,"modHood":-1,"modHydrolic":-1,"modFrontWheels":-1,"modDashboard":-1,"modArchCover":-1,"modOrnaments":-1,"modAirFilter":-1,"modTrimA":-1,"modFrame":-1,"modHorns":-1,"modPlateHolder":-1,"windowTint":-1,"modSuspension":-1,"livery":-1,"color2Custom":[105,0,0],"modAPlate":-1,"plate":"ODZG7478","modSideSkirt":-1}', 'bike', 1, 'police', '0', 1, 0, 0, 0, 14500, 0);
INSERT INTO `owned_vehicles` (`owner`, `plate`, `damage`, `vehicle`, `type`, `stored`, `job`, `parkmeter`, `garagenum`, `parkmeternum`, `policei`, `sheriffi`, `cost`, `cooldown`) VALUES
	('steam:1100001452540bfs', '44XPX908', '{"tankHealth":999.6,"engineHealth":1000.0,"fuelLevel":47.3,"windowStates":[2,3,4,5],"bodyHealth":996.3,"dirtLevel":5.3,"vehicleHealth":996,"tyreStates":[],"doorStates":[]}', '{"dashboardColor":65,"modFrontWheels":-1,"tyreSmokeColor":[255,255,255],"modXenon":255,"modHydrolic":-1,"modArmor":-1,"modWindows":-1,"modBackWheels":-1,"modAerials":-1,"modEngineBlock":-1,"wheelColor":21,"modFrontBumper":-1,"modSteeringWheel":-1,"modFender":-1,"modExhaust":-1,"modTrimB":-1,"modTrimA":-1,"pearlescentColor":144,"modHood":-1,"modRearBumper":-1,"modTransmission":-1,"model":1044193113,"modSpeakers":-1,"color1Custom":[0,0,0],"modHorns":-1,"modEngine":-1,"modBrakes":-1,"plateIndex":0,"modSeats":-1,"modTank":-1,"modStruts":-1,"color1Type":0,"color1":0,"modAPlate":-1,"modArchCover":-1,"modSpoilers":-1,"modLightbar":-1,"interiorColor":22,"neonColor":[255,0,255],"modTrunk":-1,"color2":0,"modRoof":-1,"livery":-1,"modDoorSpeaker":-1,"modSuspension":-1,"modLivery":-1,"color2Type":0,"modAirFilter":-1,"modFrame":-1,"color2Custom":[0,0,0],"plate":"44XPX908","neonEnabled":[false,false,false,false],"wheels":7,"windowTint":-1,"modSmokeEnabled":false,"modOrnaments":-1,"modShifterLeavers":-1,"modPlateHolder":-1,"modRightFender":-1,"modSideSkirt":-1,"modDial":-1,"modDashboard":-1,"modGrille":-1,"modVanityPlate":-1,"modTurbo":false,"extraEnabled":[]}', 'car', 1, 'police', '0', 1, 0, 0, 0, 14500, 0);
INSERT INTO `owned_vehicles` (`owner`, `plate`, `damage`, `vehicle`, `type`, `stored`, `job`, `parkmeter`, `garagenum`, `parkmeternum`, `policei`, `sheriffi`, `cost`, `cooldown`) VALUES
	('steam:1100001452540bfs', '42JVA112', '{"engineHealth":1000.0,"dirtLevel":5.0,"fuelLevel":50.0,"vehicleHealth":1000,"doorStates":[],"bodyHealth":1000.0,"windowStates":[4,5],"tankHealth":1000.0,"tyreStates":[]}', '{"modTransmission":-1,"modSpoilers":-1,"modArchCover":-1,"color1":34,"modFrame":-1,"pearlescentColor":158,"interiorColor":1,"modSmokeEnabled":false,"modTurbo":false,"modRoof":-1,"color2Custom":[120,120,120],"modAPlate":-1,"modEngineBlock":-1,"modGrille":-1,"color1Custom":[120,120,120],"extraEnabled":[],"modSeats":-1,"wheels":7,"neonEnabled":[false,false,false,false],"modRightFender":-1,"modSpeakers":-1,"color2Type":0,"modTrimB":-1,"color2":1,"model":-998177792,"modDashboard":-1,"modXenon":255,"tyreSmokeColor":[255,255,255],"neonColor":[255,0,255],"modTrunk":-1,"modBrakes":-1,"modBackWheels":-1,"modFender":-1,"modOrnaments":-1,"modWindows":-1,"modEngine":-1,"modTank":-1,"modStruts":-1,"modDoorSpeaker":-1,"modArmor":-1,"modVanityPlate":-1,"dashboardColor":0,"modFrontBumper":-1,"plateIndex":0,"modAerials":-1,"modRearBumper":-1,"color1Type":0,"modHood":-1,"type":"car","modDial":-1,"modFrontWheels":-1,"modExhaust":-1,"modHorns":-1,"modSteeringWheel":-1,"modAirFilter":-1,"modLivery":-1,"modHydrolic":-1,"modTrimA":-1,"modPlateHolder":-1,"windowTint":-1,"wheelColor":1,"livery":-1,"plate":"42JVA112","modSuspension":-1,"modShifterLeavers":-1,"modSideSkirt":-1}', 'car', 1, 'police', '0', 1, 0, 0, 0, 14500, 0);
INSERT INTO `owned_vehicles` (`owner`, `plate`, `damage`, `vehicle`, `type`, `stored`, `job`, `parkmeter`, `garagenum`, `parkmeternum`, `policei`, `sheriffi`, `cost`, `cooldown`) VALUES
	('steam:1100001452540bfs', '86GFQ748', '{"dirtLevel":7.1,"doorStates":[0,1],"tankHealth":871.0,"tyreStates":[0,1,4,5],"bodyHealth":0.0,"vehicleHealth":0,"engineHealth":807.2,"windowStates":[0,1,2,3,4,5],"fuelLevel":47.5}', '{"wheelColor":156,"fuelLevel":47.5,"modSeats":-1,"modExhaust":-1,"modDashboard":-1,"modRoof":-1,"engineHealth":807.2,"bodyHealth":0.0,"modHorns":-1,"tyreSmokeColor":[255,255,255],"modSideSkirt":-1,"modAerials":-1,"modDoorSpeaker":-1,"modRightFender":-1,"extras":[],"modSteeringWheel":-1,"modFrontWheels":-1,"modArmor":-1,"modDial":-1,"modLivery":-1,"plateIndex":0,"modAPlate":-1,"modFrontBumper":-1,"doorsBroken":{"0":true,"3":false,"2":false,"1":true},"modDoorR":-1,"modHydrolic":-1,"neonColor":[255,0,255],"modSuspension":-1,"windowsBroken":{"0":true,"7":true,"6":true,"5":true,"4":true,"3":true,"2":true,"1":true},"plate":"86GFQ748","neonEnabled":[false,false,false,false],"color1":0,"modArchCover":-1,"modStruts":-1,"modVanityPlate":-1,"modOrnaments":-1,"modTurbo":false,"modSpeakers":-1,"color2":0,"windowTint":-1,"modFrame":-1,"model":408192225,"modAirFilter":-1,"modEngineBlock":-1,"modTrimB":-1,"modBackWheels":-1,"modBrakes":-1,"modEngine":-1,"modLightbar":-1,"tyreBurst":{"4":true,"1":true,"0":true,"5":true},"modTransmission":-1,"modSpoilers":-1,"modTrimA":-1,"dirtLevel":7.1,"pearlescentColor":111,"modRearBumper":-1,"modTank":-1,"modHood":-1,"tankHealth":871.0,"xenonColor":255,"modPlateHolder":-1,"modShifterLeavers":-1,"modFender":-1,"modTrunk":-1,"modGrille":-1,"modXenon":1,"wheels":7,"modSmokeEnabled":false}', 'car', 1, 'police', '0', 1, 0, 0, 0, 14500, 0);
INSERT INTO `owned_vehicles` (`owner`, `plate`, `damage`, `vehicle`, `type`, `stored`, `job`, `parkmeter`, `garagenum`, `parkmeternum`, `policei`, `sheriffi`, `cost`, `cooldown`) VALUES
	('steam:1100001452540bfs', '00MLP011', '{"bodyHealth":1000.0,"tankHealth":1000.0,"engineHealth":1000.0,"tyreStates":[],"fuelLevel":65.5,"doorStates":[],"vehicleHealth":1000,"windowStates":[2,3,4,5],"dirtLevel":4.0}', '{"modArmor":-1,"modTrimB":-1,"modDoorSpeaker":-1,"plateIndex":0,"color2":0,"modAPlate":-1,"interiorColor":93,"modSpoilers":-1,"extraEnabled":[],"model":1034187331,"pearlescentColor":18,"modFrontBumper":-1,"modPlateHolder":-1,"modRightFender":-1,"tyreSmokeColor":[255,255,255],"modRoof":-1,"color2Custom":[8,8,8],"color2Type":7,"modOrnaments":-1,"modHorns":-1,"modBackWheels":-1,"modEngine":-1,"modTank":-1,"modFrame":-1,"modDial":-1,"modEngineBlock":-1,"color1":0,"modExhaust":-1,"modSpeakers":-1,"windowTint":-1,"modTrunk":-1,"modBrakes":-1,"dashboardColor":65,"neonColor":[255,0,255],"modWindows":-1,"modAerials":-1,"modFender":-1,"modSuspension":-1,"modSmokeEnabled":false,"modVanityPlate":-1,"wheels":7,"modLivery":-1,"modTrimA":-1,"modTurbo":false,"modFrontWheels":-1,"modSideSkirt":-1,"modSteeringWheel":-1,"neonEnabled":[false,false,false,false],"modShifterLeavers":-1,"modStruts":-1,"color1Custom":[8,8,8],"color1Type":7,"wheelColor":112,"modTransmission":-1,"modSeats":-1,"livery":-1,"modHydrolic":-1,"modGrille":-1,"modDashboard":-1,"modArchCover":-1,"modRearBumper":-1,"modLightbar":-1,"plate":"00MLP011","modHood":-1,"modXenon":1,"modAirFilter":-1}', 'car', 1, 'police', '0', 1, 0, 0, 0, 14500, 0);
INSERT INTO `owned_vehicles` (`owner`, `plate`, `damage`, `vehicle`, `type`, `stored`, `job`, `parkmeter`, `garagenum`, `parkmeternum`, `policei`, `sheriffi`, `cost`, `cooldown`) VALUES
	('steam:1100001452540bfs', '68QEC562', '{"engineHealth":1000.0,"dirtLevel":6.0,"fuelLevel":50.0,"vehicleHealth":1000,"doorStates":[],"bodyHealth":1000.0,"windowStates":[],"tankHealth":1000.0,"tyreStates":[]}', '{"modTransmission":-1,"modSpoilers":-1,"modArchCover":-1,"color1":6,"modFrame":-1,"pearlescentColor":111,"interiorColor":0,"modSmokeEnabled":false,"modTurbo":false,"modRoof":-1,"color2Custom":[255,255,255],"modAPlate":-1,"modEngineBlock":-1,"modGrille":-1,"color1Custom":[255,255,255],"extraEnabled":[],"modSeats":-1,"wheels":0,"neonEnabled":[false,false,false,false],"modRightFender":-1,"modSpeakers":-1,"color2Type":0,"modTrimB":-1,"color2":6,"model":-1372848492,"modDashboard":-1,"modXenon":255,"tyreSmokeColor":[255,255,255],"neonColor":[255,0,255],"modTrunk":-1,"modBrakes":-1,"modBackWheels":-1,"modFender":-1,"modOrnaments":-1,"modWindows":-1,"modEngine":-1,"modTank":-1,"modStruts":-1,"modDoorSpeaker":-1,"modArmor":-1,"modVanityPlate":-1,"dashboardColor":0,"modFrontBumper":-1,"plateIndex":0,"modAerials":-1,"modRearBumper":-1,"color1Type":0,"modHood":-1,"type":"car","modDial":-1,"modFrontWheels":-1,"modExhaust":-1,"modHorns":-1,"modSteeringWheel":-1,"modAirFilter":-1,"modLivery":-1,"modHydrolic":-1,"modTrimA":-1,"modPlateHolder":-1,"windowTint":-1,"wheelColor":156,"livery":-1,"plate":"68QEC562","modSuspension":-1,"modShifterLeavers":-1,"modSideSkirt":-1}', 'car', 1, 'police', '0', 1, 0, 0, 0, 14500, 0);
INSERT INTO `owned_vehicles` (`owner`, `plate`, `damage`, `vehicle`, `type`, `stored`, `job`, `parkmeter`, `garagenum`, `parkmeternum`, `policei`, `sheriffi`, `cost`, `cooldown`) VALUES
	('steam:1100001452540bfs', '60VNT453', '{"tankHealth":922.0,"tyreStates":[0,1,4,5],"windowStates":[0,1,2,3,4,5],"engineHealth":974.0,"fuelLevel":49.7,"dirtLevel":4.0,"vehicleHealth":661,"doorStates":[],"bodyHealth":844.0}', '{"extraEnabled":[],"color1Custom":[255,200,50],"modHydrolic":-1,"color2Type":0,"modAPlate":-1,"modBackWheels":-1,"modOrnaments":-1,"modVanityPlate":-1,"modSpoilers":-1,"livery":-1,"modRoof":-1,"modHood":-1,"modTransmission":-1,"modExhaust":-1,"modRightFender":-1,"modHorns":-1,"interiorColor":0,"modTrimB":-1,"tyreSmokeColor":[255,255,255],"modXenon":255,"modRearBumper":-1,"color1":0,"modTrimA":-1,"neonEnabled":[false,false,false,false],"modBrakes":-1,"plate":"60VNT453","modEngineBlock":-1,"dashboardColor":0,"modDial":-1,"modSuspension":-1,"modTurbo":false,"modSeats":-1,"modFrontWheels":-1,"wheelColor":0,"modArmor":-1,"modSteeringWheel":-1,"modSideSkirt":-1,"modAirFilter":-1,"wheels":4,"modStruts":-1,"modSpeakers":-1,"modTank":-1,"modTrunk":-1,"modDoorSpeaker":-1,"modPlateHolder":-1,"modAerials":-1,"neonColor":[255,0,255],"color2":0,"modEngine":-1,"plateIndex":0,"modFrontBumper":-1,"modArchCover":-1,"modShifterLeavers":-1,"modFender":-1,"color1Type":0,"modWindows":-1,"modGrille":-1,"pearlescentColor":20,"color2Custom":[255,200,50],"model":408825843,"windowTint":-1,"modFrame":-1,"modDashboard":-1,"modLivery":-1,"modSmokeEnabled":false}', 'car', 1, 'garage', '0', 1, 0, 0, 0, 14500, 0);
INSERT INTO `owned_vehicles` (`owner`, `plate`, `damage`, `vehicle`, `type`, `stored`, `job`, `parkmeter`, `garagenum`, `parkmeternum`, `policei`, `sheriffi`, `cost`, `cooldown`) VALUES
	('steam:1100001452540bf', '40YKV625', '{"engineHealth":1000.0,"dirtLevel":7.0,"fuelLevel":50.0,"vehicleHealth":1000,"doorStates":[],"bodyHealth":1000.0,"windowStates":[4,5],"tankHealth":1000.0,"tyreStates":[]}', '{"modTransmission":-1,"modSpoilers":-1,"modArchCover":-1,"color1":99,"modFrame":-1,"pearlescentColor":3,"interiorColor":0,"modSmokeEnabled":false,"modTurbo":false,"modRoof":-1,"color2Custom":[255,200,50],"modAPlate":-1,"modEngineBlock":-1,"modGrille":-1,"color1Custom":[255,200,50],"extraEnabled":[],"modSeats":-1,"wheels":7,"neonEnabled":[false,false,false,false],"modRightFender":-1,"modSpeakers":-1,"color2Type":0,"modTrimB":-1,"color2":1,"model":1987142870,"modDashboard":-1,"modXenon":255,"tyreSmokeColor":[255,255,255],"neonColor":[255,0,255],"modTrunk":-1,"modBrakes":-1,"modBackWheels":-1,"modFender":-1,"modOrnaments":-1,"modWindows":-1,"modEngine":-1,"modTank":-1,"modStruts":-1,"modDoorSpeaker":-1,"modArmor":-1,"modVanityPlate":-1,"dashboardColor":0,"modFrontBumper":-1,"plateIndex":0,"modAerials":-1,"modRearBumper":-1,"color1Type":0,"modHood":-1,"type":"car","modDial":-1,"modFrontWheels":-1,"modExhaust":-1,"modHorns":-1,"modSteeringWheel":-1,"modAirFilter":-1,"modLivery":-1,"modHydrolic":-1,"modTrimA":-1,"modPlateHolder":-1,"windowTint":-1,"wheelColor":0,"livery":-1,"plate":"40YKV625","modSuspension":-1,"modShifterLeavers":-1,"modSideSkirt":-1}', 'car', 0, 'police', '0', 1, 0, 0, 0, 14500, 0);
INSERT INTO `owned_vehicles` (`owner`, `plate`, `damage`, `vehicle`, `type`, `stored`, `job`, `parkmeter`, `garagenum`, `parkmeternum`, `policei`, `sheriffi`, `cost`, `cooldown`) VALUES
	('steam:1100001452540bf', 'TWSU7382', '{"tankHealth":1000.0,"vehicleHealth":999,"engineHealth":1000.0,"dirtLevel":2.0,"fuelLevel":99.3,"bodyHealth":1000.0,"doorStates":[],"windowStates":[3,4,5],"tyreStates":[]}', '{"modTransmission":-1,"neonColor":[255,0,255],"modPlateHolder":-1,"color1":0,"modRoof":-1,"model":745926877,"wheels":0,"neonEnabled":[false,false,false,false],"modSpeakers":-1,"dashboardColor":0,"modSmokeEnabled":false,"color1Type":0,"modTank":-1,"color2Custom":[179,185,201],"color1Custom":[8,8,8],"modXenon":255,"modGrille":-1,"modFrame":-1,"modBrakes":-1,"modExhaust":-1,"modOrnaments":-1,"windowTint":-1,"modHydrolic":-1,"modEngine":-1,"modArmor":-1,"modFrontWheels":-1,"pearlescentColor":0,"extraEnabled":{"1":1,"2":1,"7":1},"tyreSmokeColor":[255,255,255],"plate":"TWSU7382","color2":112,"modVanityPlate":-1,"wheelColor":156,"modAerials":-1,"modWindows":-1,"modEngineBlock":-1,"modAirFilter":-1,"modFender":-1,"modRightFender":-1,"modTurbo":false,"modSpoilers":-1,"modRearBumper":-1,"modFrontBumper":-1,"modDashboard":-1,"modTrimB":-1,"interiorColor":0,"modAPlate":-1,"plateIndex":4,"modSteeringWheel":-1,"modShifterLeavers":-1,"modHood":-1,"modLivery":-1,"modHorns":-1,"modDoorSpeaker":-1,"modSeats":-1,"modDial":-1,"modArchCover":-1,"color2Type":0,"modTrunk":-1,"modTrimA":-1,"modBackWheels":-1,"livery":-1,"modSideSkirt":-1,"modSuspension":-1,"modStruts":-1}', 'aircraft', 1, 'police', '0', 1, 0, 0, 0, 14500, 0);
INSERT INTO `owned_vehicles` (`owner`, `plate`, `damage`, `vehicle`, `type`, `stored`, `job`, `parkmeter`, `garagenum`, `parkmeternum`, `policei`, `sheriffi`, `cost`, `cooldown`) VALUES
	('steam:1100001452540bf', 'GMNL4973', '{"tankHealth":1000.0,"vehicleHealth":999,"engineHealth":1000.0,"dirtLevel":2.0,"fuelLevel":99.3,"bodyHealth":1000.0,"doorStates":[],"windowStates":[3,4,5],"tyreStates":[]}', '{"modArchCover":-1,"modTurbo":false,"color1Type":0,"wheelColor":156,"dashboardColor":0,"modHydrolic":-1,"color2":0,"modVanityPlate":-1,"modTank":-1,"modRoof":-1,"wheels":0,"neonColor":[255,0,255],"modHood":-1,"windowTint":-1,"neonEnabled":[false,false,false,false],"modSmokeEnabled":false,"modAerials":-1,"tyreSmokeColor":[255,255,255],"color2Custom":[8,8,8],"modFrontWheels":-1,"modSeats":-1,"modEngineBlock":-1,"modSteeringWheel":-1,"color1":73,"modTrunk":-1,"modEngine":-1,"modHorns":-1,"extraEnabled":{"7":1,"2":1,"1":1},"modDoorSpeaker":-1,"modGrille":-1,"modStruts":-1,"modBackWheels":-1,"modSuspension":-1,"modTransmission":-1,"color1Custom":[14,49,109],"modFrontBumper":-1,"modXenon":255,"modTrimA":-1,"modShifterLeavers":-1,"pearlescentColor":62,"interiorColor":0,"modFrame":-1,"color2Type":0,"modDashboard":-1,"modTrimB":-1,"modPlateHolder":-1,"modWindows":-1,"modFender":-1,"modLivery":-1,"modSpeakers":-1,"modBrakes":-1,"modAPlate":-1,"modRightFender":-1,"modArmor":-1,"modDial":-1,"modAirFilter":-1,"modRearBumper":-1,"plateIndex":0,"plate":"GMNL4973","modSpoilers":-1,"modExhaust":-1,"modSideSkirt":-1,"model":-1845487887,"livery":-1,"modOrnaments":-1}', 'aircraft', 1, 'police', '0', 1, 0, 0, 0, 14500, 0);
INSERT INTO `owned_vehicles` (`owner`, `plate`, `damage`, `vehicle`, `type`, `stored`, `job`, `parkmeter`, `garagenum`, `parkmeternum`, `policei`, `sheriffi`, `cost`, `cooldown`) VALUES
	('steam:1100001452540bf', 'UIMZ0328', '{"dirtLevel":0.0,"engineHealth":1000.0,"bodyHealth":1000.0,"vehicleHealth":1000,"tankHealth":1000.0,"fuelLevel":99.4,"doorStates":[],"windowStates":[2,3,4,5],"tyreStates":[]}', '{"dashboardColor":0,"model":-50547061,"pearlescentColor":3,"plateIndex":4,"modTurbo":false,"color2":0,"modPlateHolder":-1,"modDashboard":-1,"modBackWheels":-1,"modWindows":-1,"modSeats":-1,"modVanityPlate":-1,"modTrimB":-1,"modEngine":-1,"color2Custom":[217,217,217],"modDoorSpeaker":-1,"modSmokeEnabled":false,"neonColor":[255,0,255],"wheels":0,"color2Type":0,"modTrimA":-1,"modAPlate":-1,"modArchCover":-1,"modExhaust":-1,"modFrame":-1,"modAerials":-1,"modEngineBlock":-1,"modHorns":-1,"modFender":-1,"modSideSkirt":-1,"modHood":-1,"modFrontWheels":-1,"color1Type":0,"interiorColor":0,"modTrunk":-1,"modOrnaments":-1,"color1Custom":[217,217,217],"modSpoilers":-1,"modRightFender":-1,"modRoof":-1,"modHydrolic":-1,"neonEnabled":[false,false,false,false],"modLivery":-1,"modArmor":-1,"livery":-1,"color1":0,"modXenon":255,"modSpeakers":-1,"modSuspension":-1,"modFrontBumper":-1,"modShifterLeavers":-1,"modRearBumper":-1,"tyreSmokeColor":[255,255,255],"modTank":-1,"modTransmission":-1,"wheelColor":156,"windowTint":-1,"modAirFilter":-1,"modSteeringWheel":-1,"modDial":-1,"modStruts":-1,"modBrakes":-1,"modGrille":-1,"extraEnabled":{"2":1,"1":1},"plate":"UIMZ0328"}', 'aircraft', 1, 'police', '0', 1, 0, 0, 0, 14500, 0);
INSERT INTO `owned_vehicles` (`owner`, `plate`, `damage`, `vehicle`, `type`, `stored`, `job`, `parkmeter`, `garagenum`, `parkmeternum`, `policei`, `sheriffi`, `cost`, `cooldown`) VALUES
	('steam:1100001452540bf', 'JHZJ2789', '{"windowStates":[0,1,2,3,4,5],"engineHealth":1000.0,"vehicleHealth":1000,"tyreStates":[],"tankHealth":1000.0,"fuelLevel":98.8,"bodyHealth":1000.0,"doorStates":[],"dirtLevel":0.0}', '{"modHydrolic":-1,"modPlateHolder":-1,"dashboardColor":156,"modSeats":-1,"modSmokeEnabled":false,"neonColor":[255,0,255],"modDial":-1,"modWindows":-1,"modAPlate":-1,"modRightFender":-1,"color1Custom":[50,51,37],"modFrame":-1,"modOrnaments":-1,"modTrunk":-1,"modArmor":-1,"color1":0,"modTurbo":false,"plateIndex":0,"tyreSmokeColor":[255,255,255],"color2":0,"modShifterLeavers":-1,"color2Type":0,"modVanityPlate":-1,"modTransmission":-1,"pearlescentColor":52,"color2Custom":[89,37,37],"modHood":-1,"interiorColor":3,"modAirFilter":-1,"modFender":-1,"modLivery":-1,"extraEnabled":[],"modHorns":-1,"modEngine":-1,"modSideSkirt":-1,"color1Type":0,"model":-276744698,"neonEnabled":[false,false,false,false],"modRoof":-1,"modBrakes":-1,"livery":-1,"modFrontBumper":-1,"modGrille":-1,"modBackWheels":-1,"modArchCover":-1,"modSpoilers":-1,"windowTint":-1,"modStruts":-1,"modEngineBlock":-1,"modRearBumper":-1,"modTrimA":-1,"wheelColor":0,"modFrontWheels":-1,"modDashboard":-1,"modTank":-1,"plate":"JHZJ2789","modSuspension":-1,"modTrimB":-1,"modDoorSpeaker":-1,"modSteeringWheel":-1,"wheels":0,"modXenon":255,"modExhaust":-1,"modAerials":-1,"modSpeakers":-1}', 'boat', 1, 'garage', '0', 1, 0, 0, 0, 14500, 0);
INSERT INTO `owned_vehicles` (`owner`, `plate`, `damage`, `vehicle`, `type`, `stored`, `job`, `parkmeter`, `garagenum`, `parkmeternum`, `policei`, `sheriffi`, `cost`, `cooldown`) VALUES
	('steam:1100001452540bf', 'ZJFN5267', '{"tankHealth":1000.0,"engineHealth":1000.0,"fuelLevel":98.8,"windowStates":[0,1,2,3,4,5],"bodyHealth":1000.0,"dirtLevel":0.0,"vehicleHealth":1000,"tyreStates":[],"doorStates":[]}', '{"dashboardColor":0,"modFrontWheels":-1,"tyreSmokeColor":[255,255,255],"modXenon":255,"modHydrolic":-1,"modArmor":-1,"modWindows":-1,"modBackWheels":-1,"modAerials":-1,"modEngineBlock":-1,"wheelColor":156,"modFrontBumper":-1,"modSteeringWheel":-1,"modFender":-1,"modExhaust":-1,"modTrimB":-1,"modTrimA":-1,"pearlescentColor":0,"modHood":-1,"modRearBumper":-1,"modTransmission":-1,"model":-616331036,"modSpeakers":-1,"color1Custom":[240,240,240],"modHorns":-1,"modEngine":-1,"modBrakes":-1,"plateIndex":4,"modSeats":-1,"modTank":-1,"modStruts":-1,"color1Type":0,"color1":0,"modAPlate":-1,"modArchCover":-1,"modSpoilers":-1,"modLightbar":-1,"interiorColor":0,"neonColor":[255,0,255],"modTrunk":-1,"color2":0,"modRoof":-1,"livery":-1,"modDoorSpeaker":-1,"modSuspension":-1,"modLivery":-1,"color2Type":0,"modAirFilter":-1,"modFrame":-1,"color2Custom":[240,240,240],"plate":"ZJFN5267","neonEnabled":[false,false,false,false],"wheels":0,"windowTint":-1,"modSmokeEnabled":false,"modOrnaments":-1,"modShifterLeavers":-1,"modPlateHolder":-1,"modRightFender":-1,"modSideSkirt":-1,"modDial":-1,"modDashboard":-1,"modGrille":-1,"modVanityPlate":-1,"modTurbo":false,"extraEnabled":[]}', 'boat', 1, 'garage', '0', 1, 0, 0, 0, 14500, 0);
INSERT INTO `owned_vehicles` (`owner`, `plate`, `damage`, `vehicle`, `type`, `stored`, `job`, `parkmeter`, `garagenum`, `parkmeternum`, `policei`, `sheriffi`, `cost`, `cooldown`) VALUES
	('steam:1100001452540bf', 'QJUF0737', '{"tankHealth":1000.0,"bodyHealth":1000.0,"tyreStates":[],"vehicleHealth":1000,"dirtLevel":0.0,"windowStates":[0,1,2,3,4,5],"engineHealth":1000.0,"doorStates":[],"fuelLevel":98.4}', '{"modRoof":-1,"extraEnabled":{"3":1,"2":false,"1":false},"modHydrolic":-1,"wheels":0,"color2Custom":[8,8,8],"modVanityPlate":-1,"modRightFender":-1,"modFrontBumper":-1,"modAerials":-1,"modTrimA":-1,"modXenon":255,"tyreSmokeColor":[255,255,255],"color1Custom":[8,8,8],"color1":0,"plateIndex":4,"modRearBumper":-1,"modLightbar":-1,"dashboardColor":0,"color2Type":0,"modPlateHolder":-1,"modSeats":-1,"modArmor":-1,"model":276773164,"modAirFilter":-1,"modSideSkirt":-1,"modShifterLeavers":-1,"modDial":-1,"modGrille":-1,"modSteeringWheel":-1,"modSpoilers":-1,"neonEnabled":[false,false,false,false],"modWindows":-1,"modTurbo":false,"modSuspension":-1,"modHood":-1,"modHorns":-1,"modTrimB":-1,"neonColor":[255,0,255],"modBrakes":-1,"plate":"QJUF0737","wheelColor":156,"modLivery":-1,"modFrontWheels":-1,"modSmokeEnabled":false,"modTrunk":-1,"modOrnaments":-1,"modArchCover":-1,"modAPlate":-1,"modTank":-1,"modBackWheels":-1,"pearlescentColor":8,"windowTint":-1,"modDoorSpeaker":-1,"color2":0,"modFender":-1,"modStruts":-1,"modSpeakers":-1,"interiorColor":0,"modDashboard":-1,"modTransmission":-1,"livery":-1,"modEngine":-1,"modFrame":-1,"modExhaust":-1,"color1Type":0,"modEngineBlock":-1}', 'boat', 1, 'garage', '0', 1, 0, 0, 0, 14500, 0);
INSERT INTO `owned_vehicles` (`owner`, `plate`, `damage`, `vehicle`, `type`, `stored`, `job`, `parkmeter`, `garagenum`, `parkmeternum`, `policei`, `sheriffi`, `cost`, `cooldown`) VALUES
	('steam:1100001452540bf', 'MZTY8955', '{"dirtLevel":6.0,"doorStates":[],"tankHealth":839.8,"tyreStates":[0,1,4],"bodyHealth":47.6,"vehicleHealth":0,"engineHealth":662.0,"windowStates":[0,2,3,4,5],"fuelLevel":99.6}', '{"wheelColor":0,"fuelLevel":99.7,"modSeats":-1,"modExhaust":-1,"modDashboard":-1,"modRoof":-1,"engineHealth":662.0,"bodyHealth":47.6,"modHorns":-1,"tyreSmokeColor":[255,255,255],"modSideSkirt":-1,"modAerials":-1,"modDoorSpeaker":-1,"modRightFender":-1,"extras":[],"modSteeringWheel":-1,"modFrontWheels":-1,"modArmor":-1,"modDial":-1,"modLivery":-1,"plateIndex":0,"modAPlate":-1,"modFrontBumper":-1,"doorsBroken":{"0":false,"3":false,"2":false,"1":false},"modDoorR":-1,"modHydrolic":-1,"neonColor":[255,0,255],"modSuspension":-1,"windowsBroken":{"0":true,"7":true,"6":true,"5":true,"4":true,"3":true,"2":true,"1":false},"plate":"MZTY8955","neonEnabled":[false,false,false,false],"color1":7,"modArchCover":-1,"modStruts":-1,"modVanityPlate":-1,"modOrnaments":-1,"modTurbo":false,"modSpeakers":-1,"color2":7,"windowTint":-1,"modFrame":-1,"model":1663218586,"modAirFilter":-1,"modEngineBlock":-1,"modTrimB":-1,"modBackWheels":-1,"modBrakes":-1,"modEngine":-1,"modLightbar":-1,"tyreBurst":{"4":true,"1":true,"0":true,"5":false},"modTransmission":-1,"modSpoilers":-1,"modTrimA":-1,"dirtLevel":6.0,"pearlescentColor":3,"modRearBumper":-1,"modTank":-1,"modHood":-1,"tankHealth":839.8,"xenonColor":255,"modPlateHolder":-1,"modShifterLeavers":-1,"modFender":-1,"modTrunk":-1,"modGrille":-1,"modXenon":false,"wheels":7,"modSmokeEnabled":false}', 'car', 0, 'police', '0', 1, 0, 0, 0, 14500, 0);
INSERT INTO `owned_vehicles` (`owner`, `plate`, `damage`, `vehicle`, `type`, `stored`, `job`, `parkmeter`, `garagenum`, `parkmeternum`, `policei`, `sheriffi`, `cost`, `cooldown`) VALUES
	('steam:1100001452540bf', 'CVXD6976', '{"fuelLevel":100.0,"doorStates":[0,2,3],"tyreStates":[0,1,4,5],"vehicleHealth":0,"dirtLevel":8.1,"bodyHealth":0.0,"windowStates":[0,1,2,3,4,5],"tankHealth":972.4,"engineHealth":974.0}', '{"modDial":-1,"modArmor":-1,"modHood":-1,"modStruts":-1,"tankHealth":972.4,"modSuspension":-1,"modEngine":-1,"modTransmission":-1,"wheelColor":0,"wheels":0,"modLightbar":-1,"modTurbo":false,"modTrunk":-1,"modRoof":-1,"modFrontBumper":-1,"neonEnabled":[false,false,false,false],"modOrnaments":-1,"modHorns":-1,"modSmokeEnabled":false,"modTank":-1,"pearlescentColor":73,"modPlateHolder":-1,"windowTint":-1,"modFrame":-1,"modSpoilers":-1,"dirtLevel":8.1,"modExhaust":-1,"plateIndex":0,"modVanityPlate":-1,"modAerials":-1,"modFender":-1,"tyreBurst":{"0":true,"1":true,"5":true,"4":true},"bodyHealth":0.0,"modEngineBlock":-1,"model":-1848994066,"modAPlate":-1,"extras":[],"modBrakes":-1,"modTrimA":-1,"modFrontWheels":-1,"xenonColor":255,"fuelLevel":100.0,"modHydrolic":-1,"doorsBroken":{"0":true,"1":false,"4":false,"2":true,"3":true},"windowsBroken":{"0":true,"1":true,"6":true,"7":true,"4":true,"5":true,"2":true,"3":true},"modGrille":-1,"modDoorR":-1,"modBackWheels":-1,"modShifterLeavers":-1,"modSteeringWheel":-1,"modTrimB":-1,"tyreSmokeColor":[255,255,255],"color2":0,"modLivery":-1,"neonColor":[255,0,255],"modSideSkirt":-1,"modArchCover":-1,"modSpeakers":-1,"engineHealth":974.0,"modXenon":false,"modRightFender":-1,"modAirFilter":-1,"color1":64,"modDoorSpeaker":-1,"modSeats":-1,"modRearBumper":-1,"plate":"CVXD6976","modDashboard":-1}', 'car', 0, 'police', '0', 1, 0, 0, 0, 14500, 0);
INSERT INTO `owned_vehicles` (`owner`, `plate`, `damage`, `vehicle`, `type`, `stored`, `job`, `parkmeter`, `garagenum`, `parkmeternum`, `policei`, `sheriffi`, `cost`, `cooldown`) VALUES
	('steam:1100001452540bf', 'FKZB7705', '{"doorStates":[],"fuelLevel":100.0,"dirtLevel":4.0,"bodyHealth":1000.0,"vehicleHealth":1000,"tyreStates":[],"tankHealth":1000.0,"engineHealth":1000.0,"windowStates":[4,5]}', '{"neonColor":[255,0,255],"modAirFilter":-1,"color2":0,"modSuspension":-1,"modBrakes":-1,"modEngine":-1,"modDial":-1,"modSteeringWheel":-1,"modFender":-1,"neonEnabled":[false,false,false,false],"modTank":-1,"wheelColor":0,"pearlescentColor":73,"modTrunk":-1,"modExhaust":-1,"tyreBurst":{"5":false,"0":false,"1":false,"4":false},"modSideSkirt":-1,"modFrontBumper":-1,"modPlateHolder":-1,"modHood":-1,"modRearBumper":-1,"fuelLevel":100.0,"extras":[],"engineHealth":1000.0,"modDoorR":-1,"xenonColor":255,"modXenon":false,"modEngineBlock":-1,"modGrille":-1,"modRoof":-1,"modHorns":-1,"modAPlate":-1,"modFrame":-1,"modAerials":-1,"bodyHealth":1000.0,"windowTint":-1,"tankHealth":1000.0,"plate":"FKZB7705","modTrimA":-1,"tyreSmokeColor":[255,255,255],"modDoorSpeaker":-1,"modSeats":-1,"modHydrolic":-1,"modTransmission":-1,"wheels":0,"modLightbar":-1,"color1":64,"modStruts":-1,"plateIndex":0,"doorsBroken":{"1":false,"2":false,"3":false,"4":false,"0":false},"modArmor":-1,"modBackWheels":-1,"modRightFender":-1,"modSpoilers":-1,"modLivery":-1,"modDashboard":-1,"model":-1848994066,"modVanityPlate":-1,"modSpeakers":-1,"modTurbo":false,"modFrontWheels":-1,"dirtLevel":4.0,"modTrimB":-1,"modOrnaments":-1,"modShifterLeavers":-1,"modArchCover":-1,"modSmokeEnabled":false,"windowsBroken":{"1":false,"2":false,"3":false,"4":true,"5":true,"6":false,"7":false,"0":false}}', 'car', 0, 'police', '0', 1, 0, 0, 0, 14500, 0);
INSERT INTO `owned_vehicles` (`owner`, `plate`, `damage`, `vehicle`, `type`, `stored`, `job`, `parkmeter`, `garagenum`, `parkmeternum`, `policei`, `sheriffi`, `cost`, `cooldown`) VALUES
	('steam:1100001452540bf', 'CSKU2234', '{"doorStates":[],"fuelLevel":100.0,"dirtLevel":5.0,"bodyHealth":1000.0,"vehicleHealth":1000,"tyreStates":[],"tankHealth":1000.0,"engineHealth":1000.0,"windowStates":[4,5]}', '{"neonColor":[255,0,255],"modAirFilter":-1,"color2":0,"modSuspension":-1,"modBrakes":-1,"modEngine":-1,"modDial":-1,"modSteeringWheel":-1,"modFender":-1,"neonEnabled":[false,false,false,false],"modTank":-1,"wheelColor":0,"pearlescentColor":73,"modTrunk":-1,"modExhaust":-1,"tyreBurst":{"5":false,"0":false,"1":false,"4":false},"modSideSkirt":-1,"modFrontBumper":-1,"modPlateHolder":-1,"modHood":-1,"modRearBumper":-1,"fuelLevel":100.0,"extras":[],"engineHealth":1000.0,"modDoorR":-1,"xenonColor":255,"modXenon":false,"modEngineBlock":-1,"modGrille":-1,"modRoof":-1,"modHorns":-1,"modAPlate":-1,"modFrame":-1,"modAerials":-1,"bodyHealth":1000.0,"windowTint":-1,"tankHealth":1000.0,"plate":"CSKU2234","modTrimA":-1,"tyreSmokeColor":[255,255,255],"modDoorSpeaker":-1,"modSeats":-1,"modHydrolic":-1,"modTransmission":-1,"wheels":0,"modLightbar":-1,"color1":64,"modStruts":-1,"plateIndex":0,"doorsBroken":{"1":false,"2":false,"3":false,"4":false,"0":false},"modArmor":-1,"modBackWheels":-1,"modRightFender":-1,"modSpoilers":-1,"modLivery":-1,"modDashboard":-1,"model":-1848994066,"modVanityPlate":-1,"modSpeakers":-1,"modTurbo":false,"modFrontWheels":-1,"dirtLevel":5.0,"modTrimB":-1,"modOrnaments":-1,"modShifterLeavers":-1,"modArchCover":-1,"modSmokeEnabled":false,"windowsBroken":{"1":false,"2":false,"3":false,"4":true,"5":true,"6":false,"7":false,"0":false}}', 'car', 0, 'police', '0', 1, 0, 0, 0, 14500, 0);
INSERT INTO `owned_vehicles` (`owner`, `plate`, `damage`, `vehicle`, `type`, `stored`, `job`, `parkmeter`, `garagenum`, `parkmeternum`, `policei`, `sheriffi`, `cost`, `cooldown`) VALUES
	('steam:1100001452540bf', 'BVCD0959', '{"fuelLevel":99.7,"vehicleHealth":1000,"bodyHealth":1000.0,"dirtLevel":4.0,"tyreStates":[],"doorStates":[],"engineHealth":1000.0,"windowStates":[4,5],"tankHealth":1000.0}', '{"modSmokeEnabled":false,"modRearBumper":-1,"modTrunk":-1,"modFrontBumper":-1,"wheels":1,"modOrnaments":-1,"modEngineBlock":-1,"modVanityPlate":-1,"modSideSkirt":-1,"modArchCover":-1,"dashboardColor":0,"modTransmission":-1,"modSeats":-1,"plateIndex":4,"modAPlate":-1,"modSpoilers":-1,"modLightbar":-1,"modShifterLeavers":-1,"modDial":-1,"extraEnabled":{"1":false,"2":1},"modSteeringWheel":-1,"modAerials":-1,"modLivery":-1,"modTrimA":-1,"modFrontWheels":-1,"modTrimB":-1,"modPlateHolder":-1,"modArmor":-1,"neonEnabled":[false,false,false,false],"modBackWheels":-1,"wheelColor":156,"modHorns":-1,"modHood":-1,"color2":134,"modBrakes":-1,"modEngine":-1,"modWindows":-1,"modSuspension":-1,"modXenon":255,"windowTint":-1,"color1Custom":[255,255,255],"livery":5,"interiorColor":0,"color2Custom":[255,255,255],"tyreSmokeColor":[255,255,255],"plate":"BVCD0959","color2Type":0,"modGrille":-1,"modFrame":-1,"modExhaust":-1,"modFender":-1,"modTurbo":false,"modHydrolic":-1,"modTank":-1,"pearlescentColor":0,"modRightFender":-1,"modDashboard":-1,"modAirFilter":-1,"color1Type":0,"modRoof":-1,"modDoorSpeaker":-1,"color1":134,"modStruts":-1,"neonColor":[255,0,255],"modSpeakers":-1,"model":2046537925}', 'car', 0, 'police', '0', 1, 0, 0, 0, 14500, 0);
INSERT INTO `owned_vehicles` (`owner`, `plate`, `damage`, `vehicle`, `type`, `stored`, `job`, `parkmeter`, `garagenum`, `parkmeternum`, `policei`, `sheriffi`, `cost`, `cooldown`) VALUES
	('steam:1100001452540bf', 'RHTG9571', '{"fuelLevel":100.0,"vehicleHealth":1000,"bodyHealth":1000.0,"dirtLevel":7.0,"tyreStates":[],"doorStates":[],"engineHealth":1000.0,"windowStates":[],"tankHealth":1000.0}', '{"modSmokeEnabled":false,"modRearBumper":-1,"modTrunk":-1,"modFrontBumper":-1,"wheels":0,"modOrnaments":-1,"modEngineBlock":-1,"modVanityPlate":-1,"modSideSkirt":-1,"modArchCover":-1,"dashboardColor":0,"modTransmission":-1,"modSeats":-1,"plateIndex":4,"modAPlate":-1,"modSpoilers":-1,"modLightbar":-1,"modShifterLeavers":-1,"modDial":-1,"extraEnabled":{"1":false,"12":false},"modSteeringWheel":-1,"modAerials":-1,"modLivery":-1,"modTrimA":-1,"modFrontWheels":-1,"modTrimB":-1,"modPlateHolder":-1,"modArmor":-1,"neonEnabled":[false,false,false,false],"modBackWheels":-1,"wheelColor":156,"modHorns":-1,"modHood":-1,"color2":0,"modBrakes":-1,"modEngine":-1,"modWindows":-1,"modSuspension":-1,"modXenon":255,"windowTint":-1,"color1Custom":[255,255,255],"livery":4,"interiorColor":0,"color2Custom":[8,8,8],"tyreSmokeColor":[255,255,255],"plate":"RHTG9571","color2Type":0,"modGrille":-1,"modFrame":-1,"modExhaust":-1,"modFender":-1,"modTurbo":false,"modHydrolic":-1,"modTank":-1,"pearlescentColor":0,"modRightFender":-1,"modDashboard":-1,"modAirFilter":-1,"color1Type":0,"modRoof":-1,"modDoorSpeaker":-1,"color1":134,"modStruts":-1,"neonColor":[255,0,255],"modSpeakers":-1,"model":-1627000575}', 'car', 0, 'police', '0', 1, 0, 0, 0, 14500, 0);
INSERT INTO `owned_vehicles` (`owner`, `plate`, `damage`, `vehicle`, `type`, `stored`, `job`, `parkmeter`, `garagenum`, `parkmeternum`, `policei`, `sheriffi`, `cost`, `cooldown`) VALUES
	('steam:1100001452540bf', 'CMAE8123', '{"bodyHealth":1000.0,"doorStates":[],"windowStates":[3,4,5],"engineHealth":1000.0,"tyreStates":[],"fuelLevel":99.3,"tankHealth":1000.0,"vehicleHealth":999,"dirtLevel":4.0}', '{"modXenon":255,"modSuspension":-1,"color2Type":0,"modTrimB":-1,"wheels":0,"modStruts":-1,"modArchCover":-1,"modDoorSpeaker":-1,"modEngine":-1,"color1Custom":[8,8,8],"modHood":-1,"interiorColor":0,"pearlescentColor":5,"windowTint":-1,"modSpeakers":-1,"modTurbo":false,"modLivery":-1,"modTrimA":-1,"modSteeringWheel":-1,"modDial":-1,"modSeats":-1,"modOrnaments":-1,"modLightbar":-1,"color1Type":0,"modShifterLeavers":-1,"tyreSmokeColor":[255,255,255],"modFrame":-1,"modBrakes":-1,"modExhaust":-1,"extraEnabled":{"8":1,"7":1,"9":1,"2":1,"1":1},"neonColor":[255,0,255],"modVanityPlate":-1,"modHorns":-1,"modBackWheels":-1,"modSideSkirt":-1,"neonEnabled":[false,false,false,false],"modHydrolic":-1,"modTransmission":-1,"color1":0,"modTank":-1,"modGrille":-1,"modSpoilers":-1,"modPlateHolder":-1,"modTrunk":-1,"modRightFender":-1,"modFrontBumper":-1,"modFrontWheels":-1,"modSmokeEnabled":false,"color2Custom":[8,8,8],"wheelColor":156,"color2":0,"modAPlate":-1,"modAirFilter":-1,"plateIndex":4,"modEngineBlock":-1,"modArmor":-1,"modRoof":-1,"modRearBumper":-1,"modFender":-1,"plate":"CMAE8123","dashboardColor":0,"modWindows":-1,"modAerials":-1,"livery":-1,"modDashboard":-1,"model":788747387}', 'helicopter', 0, 'garage', '0', 1, 0, 0, 0, 14500, 0);
INSERT INTO `owned_vehicles` (`owner`, `plate`, `damage`, `vehicle`, `type`, `stored`, `job`, `parkmeter`, `garagenum`, `parkmeternum`, `policei`, `sheriffi`, `cost`, `cooldown`) VALUES
	('steam:1100001452540bf', '07ZCV758', '{"fuelLevel":44.9,"windowStates":[4,5],"doorStates":[],"vehicleHealth":659,"dirtLevel":1.9,"tankHealth":961.1,"bodyHealth":659.4,"engineHealth":969.2,"tyreStates":[]}', '{"modTrimB":-1,"modShifterLeavers":-1,"modAerials":-1,"interiorColor":111,"modLivery":-1,"modFrontWheels":-1,"extraEnabled":[],"modSpeakers":-1,"modPlateHolder":-1,"modWindows":-1,"modArmor":-1,"neonEnabled":[false,false,false,false],"plateIndex":0,"modLightbar":-1,"color2":0,"dashboardColor":111,"color1":9,"wheels":7,"modAPlate":-1,"plate":"07ZCV758","modXenon":255,"modDial":-1,"color1Custom":[255,255,255],"color2Custom":[255,255,255],"modSeats":-1,"modFrame":-1,"model":686471183,"modDoorSpeaker":-1,"tyreSmokeColor":[255,255,255],"windowTint":-1,"modTrunk":-1,"modVanityPlate":-1,"modGrille":-1,"modOrnaments":-1,"modEngine":-1,"modSpoilers":-1,"modTransmission":-1,"modFrontBumper":-1,"modStruts":-1,"modSteeringWheel":-1,"wheelColor":111,"modExhaust":-1,"modTrimA":-1,"pearlescentColor":4,"modDashboard":-1,"modBrakes":-1,"modTank":-1,"modFender":-1,"color1Type":0,"modArchCover":-1,"neonColor":[255,0,255],"modRightFender":-1,"color2Type":0,"modRearBumper":-1,"modAirFilter":-1,"modHydrolic":-1,"modSmokeEnabled":false,"modRoof":-1,"modHorns":-1,"livery":-1,"modBackWheels":-1,"modTurbo":false,"modSuspension":-1,"modEngineBlock":-1,"modHood":-1,"modSideSkirt":-1}', 'car', 0, 'garage', '0', 1, 0, 0, 0, 14500, 0);
INSERT INTO `owned_vehicles` (`owner`, `plate`, `damage`, `vehicle`, `type`, `stored`, `job`, `parkmeter`, `garagenum`, `parkmeternum`, `policei`, `sheriffi`, `cost`, `cooldown`) VALUES
	('steam:1100001452540bf', 'KNLR9796', '{"fuelLevel":100.0,"windowStates":[4,5],"doorStates":[],"vehicleHealth":996,"dirtLevel":7.0,"tankHealth":999.7,"bodyHealth":996.9,"engineHealth":1000.0,"tyreStates":[]}', '{"modTrimB":-1,"modShifterLeavers":-1,"modAerials":-1,"interiorColor":93,"modLivery":-1,"modFrontWheels":-1,"extraEnabled":[],"modSpeakers":-1,"modPlateHolder":-1,"modWindows":-1,"modArmor":-1,"neonEnabled":[false,false,false,false],"plateIndex":0,"modLightbar":-1,"color2":0,"dashboardColor":65,"color1":27,"wheels":0,"modAPlate":-1,"plate":"KNLR9796","modXenon":255,"modDial":-1,"color1Custom":[105,0,0],"color2Custom":[8,8,8],"modSeats":-1,"modFrame":-1,"model":-1848994066,"modDoorSpeaker":-1,"tyreSmokeColor":[255,255,255],"windowTint":-1,"modTrunk":-1,"modVanityPlate":-1,"modGrille":-1,"modOrnaments":-1,"modEngine":-1,"modSpoilers":-1,"modTransmission":-1,"modFrontBumper":-1,"modStruts":-1,"modSteeringWheel":-1,"wheelColor":0,"modExhaust":-1,"modTrimA":-1,"pearlescentColor":28,"modDashboard":-1,"modBrakes":-1,"modTank":-1,"modFender":-1,"color1Type":0,"modArchCover":-1,"neonColor":[255,0,255],"modRightFender":-1,"color2Type":0,"modRearBumper":-1,"modAirFilter":-1,"modHydrolic":-1,"modSmokeEnabled":false,"modRoof":-1,"modHorns":-1,"livery":-1,"modBackWheels":-1,"modTurbo":false,"modSuspension":-1,"modEngineBlock":-1,"modHood":-1,"modSideSkirt":-1}', 'car', 0, 'garage', '0', 1, 0, 0, 0, 14500, 0);
INSERT INTO `owned_vehicles` (`owner`, `plate`, `damage`, `vehicle`, `type`, `stored`, `job`, `parkmeter`, `garagenum`, `parkmeternum`, `policei`, `sheriffi`, `cost`, `cooldown`) VALUES
	('steam:1100001452540bf', 'KVAT0575', '{"engineHealth":1000.0,"dirtLevel":5.0,"doorStates":[],"windowStates":[4,5],"fuelLevel":100.0,"bodyHealth":1000.0,"tankHealth":1000.0,"vehicleHealth":1000,"tyreStates":[]}', '{"pearlescentColor":73,"color1":64,"modHood":-1,"modTransmission":-1,"color1Type":0,"neonColor":[255,0,255],"modArmor":-1,"wheelColor":0,"modLivery":-1,"modLightbar":-1,"modEngine":-1,"wheels":0,"modWindows":-1,"color2Custom":[8,8,8],"livery":-1,"modSpeakers":-1,"modRoof":-1,"modAPlate":-1,"color1Custom":[0,27,87],"modSeats":-1,"modBrakes":-1,"modTrimB":-1,"modXenon":255,"modSteeringWheel":-1,"model":-1848994066,"plateIndex":0,"modFender":-1,"modSuspension":-1,"modBackWheels":-1,"modAirFilter":-1,"modAerials":-1,"interiorColor":93,"dashboardColor":65,"modPlateHolder":-1,"tyreSmokeColor":[255,255,255],"modTank":-1,"plate":"KVAT0575","modHorns":-1,"modSpoilers":-1,"modFrontWheels":-1,"modRearBumper":-1,"windowTint":-1,"modSideSkirt":-1,"modEngineBlock":-1,"modHydrolic":-1,"neonEnabled":[false,false,false,false],"modDial":-1,"modArchCover":-1,"modGrille":-1,"modFrontBumper":-1,"modStruts":-1,"modRightFender":-1,"modTrunk":-1,"modTurbo":false,"modSmokeEnabled":false,"modTrimA":-1,"modDashboard":-1,"color2":0,"modShifterLeavers":-1,"modFrame":-1,"modOrnaments":-1,"modDoorSpeaker":-1,"modVanityPlate":-1,"modExhaust":-1,"color2Type":0,"extraEnabled":[]}', 'car', 0, 'garage', '0', 1, 0, 0, 0, 14500, 0);
INSERT INTO `owned_vehicles` (`owner`, `plate`, `damage`, `vehicle`, `type`, `stored`, `job`, `parkmeter`, `garagenum`, `parkmeternum`, `policei`, `sheriffi`, `cost`, `cooldown`) VALUES
	('steam:1100001452540bf', 'KSEF7665', '{"tankHealth":1000.0,"windowStates":[4,5],"doorStates":[],"engineHealth":1000.0,"vehicleHealth":1000,"dirtLevel":5.0,"bodyHealth":1000.0,"tyreStates":[],"fuelLevel":100.0}', '{"modRearBumper":-1,"pearlescentColor":73,"modRightFender":-1,"modBackWheels":-1,"color2":0,"modFrontBumper":-1,"color2Type":0,"modDoorSpeaker":-1,"modFender":-1,"modVanityPlate":-1,"modAerials":-1,"modSpoilers":-1,"modAPlate":-1,"modPlateHolder":-1,"modShifterLeavers":-1,"modDashboard":-1,"modArmor":-1,"plateIndex":0,"modEngine":-1,"modTransmission":-1,"modTrunk":-1,"modTank":-1,"modTrimB":-1,"modHorns":-1,"modLivery":-1,"dashboardColor":65,"modDial":-1,"model":-1848994066,"color2Custom":[8,8,8],"modSteeringWheel":-1,"modExhaust":-1,"modSpeakers":-1,"modWindows":-1,"modTurbo":false,"modRoof":-1,"modStruts":-1,"modSuspension":-1,"neonColor":[255,0,255],"modHydrolic":-1,"modLightbar":-1,"modBrakes":-1,"modHood":-1,"interiorColor":93,"modXenon":255,"windowTint":-1,"color1Type":0,"color1":64,"modTrimA":-1,"wheels":0,"modSeats":-1,"livery":-1,"extraEnabled":[],"modEngineBlock":-1,"neonEnabled":[false,false,false,false],"modOrnaments":-1,"modAirFilter":-1,"plate":"KSEF7665","modSideSkirt":-1,"color1Custom":[0,27,87],"modSmokeEnabled":false,"modFrame":-1,"modGrille":-1,"modArchCover":-1,"tyreSmokeColor":[255,255,255],"modFrontWheels":-1,"wheelColor":0}', 'car', 1, 'police', '0', 1, 0, 0, 0, 14500, 0);
INSERT INTO `owned_vehicles` (`owner`, `plate`, `damage`, `vehicle`, `type`, `stored`, `job`, `parkmeter`, `garagenum`, `parkmeternum`, `policei`, `sheriffi`, `cost`, `cooldown`) VALUES
	('steam:1100001452540bf', 'EPJQ2671', '{"bodyHealth":993.2,"doorStates":[],"vehicleHealth":993,"tyreStates":[],"tankHealth":999.3,"windowStates":[0,4,5],"fuelLevel":100.0,"dirtLevel":3.0,"engineHealth":1000.0}', '{"modTransmission":-1,"modRightFender":-1,"modSuspension":-1,"modArmor":-1,"modHorns":-1,"modFrontWheels":-1,"modGrille":-1,"color1Type":0,"modDashboard":-1,"modSpeakers":-1,"modSideSkirt":-1,"modEngine":-1,"color1Custom":[240,240,240],"modLivery":-1,"pearlescentColor":111,"plate":"EPJQ2671","modOrnaments":-1,"modXenon":255,"neonEnabled":[false,false,false,false],"livery":-1,"interiorColor":93,"color1":111,"modWindows":-1,"modPlateHolder":-1,"windowTint":-1,"modFrame":-1,"plateIndex":0,"modLightbar":-1,"modAerials":-1,"modFender":-1,"modBackWheels":-1,"tyreSmokeColor":[255,255,255],"modRearBumper":-1,"modTrimB":-1,"modShifterLeavers":-1,"modEngineBlock":-1,"modTrunk":-1,"modVanityPlate":-1,"modHood":-1,"color2":0,"modArchCover":-1,"color2Custom":[8,8,8],"color2Type":0,"dashboardColor":65,"modSteeringWheel":-1,"wheelColor":0,"model":-1848994066,"modBrakes":-1,"modTrimA":-1,"neonColor":[255,0,255],"modTurbo":false,"modFrontBumper":-1,"modHydrolic":-1,"modDial":-1,"modSeats":-1,"modAPlate":-1,"modStruts":-1,"modSpoilers":-1,"modExhaust":-1,"extraEnabled":[],"wheels":0,"modTank":-1,"modRoof":-1,"modAirFilter":-1,"modDoorSpeaker":-1,"modSmokeEnabled":false}', 'car', 1, 'garage', '0', 1, 0, 0, 0, 14500, 0);
INSERT INTO `owned_vehicles` (`owner`, `plate`, `damage`, `vehicle`, `type`, `stored`, `job`, `parkmeter`, `garagenum`, `parkmeternum`, `policei`, `sheriffi`, `cost`, `cooldown`) VALUES
	('steam:1100001452540bf', 'TPOM8274', '{"dirtLevel":3.0,"bodyHealth":1000.0,"tankHealth":1000.0,"fuelLevel":100.0,"tyreStates":[],"vehicleHealth":1000,"windowStates":[4,5],"doorStates":[],"engineHealth":1000.0}', '{"modHorns":-1,"modDial":-1,"color1":3,"plate":"TPOM8274","modTrunk":-1,"modXenon":255,"modDoorSpeaker":-1,"wheelColor":0,"dashboardColor":65,"color1Custom":[41,44,46],"modAPlate":-1,"modRightFender":-1,"windowTint":-1,"modEngineBlock":-1,"modAirFilter":-1,"color2":1,"modSeats":-1,"modFrontBumper":-1,"modSteeringWheel":-1,"modLightbar":-1,"neonEnabled":[false,false,false,false],"extraEnabled":[],"modHood":-1,"neonColor":[255,0,255],"modGrille":-1,"modTurbo":false,"modWindows":-1,"modSuspension":-1,"color2Type":0,"interiorColor":93,"modOrnaments":-1,"modSideSkirt":-1,"modFender":-1,"modTrimB":-1,"model":-1848994066,"modSpoilers":-1,"modTransmission":-1,"modFrontWheels":-1,"modPlateHolder":-1,"tyreSmokeColor":[255,255,255],"modAerials":-1,"pearlescentColor":5,"plateIndex":0,"modShifterLeavers":-1,"color1Type":0,"modRoof":-1,"color2Custom":[15,15,15],"modTrimA":-1,"modDashboard":-1,"modArmor":-1,"livery":-1,"modHydrolic":-1,"modSmokeEnabled":false,"modExhaust":-1,"modFrame":-1,"modSpeakers":-1,"modBrakes":-1,"modVanityPlate":-1,"modTank":-1,"modArchCover":-1,"modEngine":-1,"modBackWheels":-1,"modLivery":-1,"wheels":0,"modStruts":-1,"modRearBumper":-1}', 'car', 1, 'garage', '0', 1, 0, 0, 0, 14500, 0);
INSERT INTO `owned_vehicles` (`owner`, `plate`, `damage`, `vehicle`, `type`, `stored`, `job`, `parkmeter`, `garagenum`, `parkmeternum`, `policei`, `sheriffi`, `cost`, `cooldown`) VALUES
	('steam:1100001452540bf', 'PJUH5335', '{"doorStates":[],"fuelLevel":100.0,"bodyHealth":1000.0,"vehicleHealth":1000,"windowStates":[4,5],"dirtLevel":5.0,"tankHealth":1000.0,"tyreStates":[],"engineHealth":1000.0}', '{"modFrontBumper":-1,"modStruts":-1,"tyreSmokeColor":[255,255,255],"modShifterLeavers":-1,"modDashboard":-1,"modVanityPlate":-1,"pearlescentColor":89,"modRoof":-1,"modBackWheels":-1,"modDoorSpeaker":-1,"modHood":-1,"color1":38,"modRightFender":-1,"dashboardColor":65,"modEngineBlock":-1,"neonColor":[255,0,255],"modXenon":255,"color1Custom":[189,72,0],"modSeats":-1,"modSideSkirt":-1,"modAPlate":-1,"interiorColor":93,"modLightbar":-1,"color2Type":0,"modOrnaments":-1,"modBrakes":-1,"modArchCover":-1,"modSteeringWheel":-1,"modGrille":-1,"model":-1848994066,"extraEnabled":[],"modTank":-1,"modTransmission":-1,"color2Custom":[15,15,15],"modSuspension":-1,"livery":-1,"modSpoilers":-1,"modTrunk":-1,"modTrimB":-1,"modAerials":-1,"modDial":-1,"modHorns":-1,"windowTint":-1,"modWindows":-1,"modFrontWheels":-1,"modLivery":-1,"modSpeakers":-1,"modHydrolic":-1,"color1Type":0,"color2":1,"modAirFilter":-1,"plate":"PJUH5335","modSmokeEnabled":false,"plateIndex":0,"modArmor":-1,"modFrame":-1,"wheelColor":0,"modRearBumper":-1,"wheels":0,"modTrimA":-1,"modFender":-1,"modEngine":-1,"neonEnabled":[false,false,false,false],"modPlateHolder":-1,"modTurbo":false,"modExhaust":-1}', 'car', 1, 'garage', '0', 1, 0, 0, 0, 14500, 0);
INSERT INTO `owned_vehicles` (`owner`, `plate`, `damage`, `vehicle`, `type`, `stored`, `job`, `parkmeter`, `garagenum`, `parkmeternum`, `policei`, `sheriffi`, `cost`, `cooldown`) VALUES
	('steam:1100001452540bf', 'JOEC3568', '{"bodyHealth":1000.0,"tankHealth":1000.0,"windowStates":[4,5],"doorStates":[],"vehicleHealth":1000,"tyreStates":[],"engineHealth":1000.0,"dirtLevel":7.0,"fuelLevel":100.0}', '{"color1Type":0,"modShifterLeavers":-1,"color2Custom":[15,15,15],"modHood":-1,"modTurbo":false,"modArmor":-1,"color2Type":0,"extraEnabled":[],"modTransmission":-1,"modSuspension":-1,"modFender":-1,"modBrakes":-1,"neonEnabled":[false,false,false,false],"model":-1848994066,"plateIndex":0,"modWindows":-1,"windowTint":-1,"modSideSkirt":-1,"modAPlate":-1,"modDoorSpeaker":-1,"modOrnaments":-1,"modEngine":-1,"modVanityPlate":-1,"modLightbar":-1,"color2":1,"modRightFender":-1,"modArchCover":-1,"modTrimA":-1,"modLivery":-1,"modBackWheels":-1,"modTrimB":-1,"wheelColor":0,"interiorColor":93,"modFrame":-1,"modStruts":-1,"modFrontBumper":-1,"modHydrolic":-1,"plate":"JOEC3568","modPlateHolder":-1,"modRoof":-1,"modTrunk":-1,"modSteeringWheel":-1,"modFrontWheels":-1,"modSpeakers":-1,"modTank":-1,"modAerials":-1,"livery":-1,"modXenon":255,"dashboardColor":65,"modSmokeEnabled":false,"modRearBumper":-1,"pearlescentColor":67,"modHorns":-1,"modGrille":-1,"modSeats":-1,"neonColor":[255,0,255],"wheels":0,"modSpoilers":-1,"modDial":-1,"modAirFilter":-1,"color1Custom":[0,85,196],"modEngineBlock":-1,"modExhaust":-1,"tyreSmokeColor":[255,255,255],"modDashboard":-1,"color1":70}', 'car', 1, 'garage', '0', 9, 0, 0, 0, 14500, 0);
INSERT INTO `owned_vehicles` (`owner`, `plate`, `damage`, `vehicle`, `type`, `stored`, `job`, `parkmeter`, `garagenum`, `parkmeternum`, `policei`, `sheriffi`, `cost`, `cooldown`) VALUES
	('steam:1100001452540bf', 'NXDL1620', '{"fuelLevel":100.0,"tankHealth":1000.0,"doorStates":[],"dirtLevel":4.0,"windowStates":[4,5],"bodyHealth":1000.0,"tyreStates":[],"vehicleHealth":1000,"engineHealth":1000.0}', '{"modSmokeEnabled":false,"modArmor":-1,"modBrakes":-1,"modTurbo":false,"modOrnaments":-1,"modEngineBlock":-1,"modSpoilers":-1,"modSteeringWheel":-1,"extraEnabled":[],"modAPlate":-1,"windowTint":-1,"livery":-1,"modPlateHolder":-1,"neonEnabled":[false,false,false,false],"modHydrolic":-1,"modExhaust":-1,"plateIndex":0,"modRightFender":-1,"wheels":0,"color2":0,"modStruts":-1,"modTrimA":-1,"modLightbar":-1,"color1Custom":[105,0,0],"modTank":-1,"modXenon":255,"modLivery":-1,"color2Type":0,"wheelColor":0,"tyreSmokeColor":[255,255,255],"modBackWheels":-1,"modTrimB":-1,"modAirFilter":-1,"modEngine":-1,"modFender":-1,"modWindows":-1,"modFrontWheels":-1,"modArchCover":-1,"color1Type":0,"modRoof":-1,"color2Custom":[8,8,8],"modDial":-1,"modSideSkirt":-1,"modGrille":-1,"interiorColor":93,"modSpeakers":-1,"color1":0,"pearlescentColor":28,"modTrunk":-1,"model":-1848994066,"modAerials":-1,"modTransmission":-1,"modShifterLeavers":-1,"modSeats":-1,"modSuspension":-1,"modRearBumper":-1,"neonColor":[255,0,255],"plate":"NXDL1620","modFrame":-1,"modDashboard":-1,"dashboardColor":65,"modHood":-1,"modFrontBumper":-1,"modHorns":-1,"modDoorSpeaker":-1,"modVanityPlate":-1}', 'car', 1, 'garage', '0', 2, 0, 0, 0, 14500, 0);
INSERT INTO `owned_vehicles` (`owner`, `plate`, `damage`, `vehicle`, `type`, `stored`, `job`, `parkmeter`, `garagenum`, `parkmeternum`, `policei`, `sheriffi`, `cost`, `cooldown`) VALUES
	('steam:1100001452540bf', 'UQEI6903', '{"tankHealth":1000.0,"bodyHealth":999.8,"doorStates":[],"vehicleHealth":999,"dirtLevel":6.0,"fuelLevel":66.2,"tyreStates":[],"engineHealth":999.6,"windowStates":[4,5]}', '{"modTrimB":-1,"modHydrolic":-1,"plateIndex":0,"modDial":-1,"modArchCover":-1,"neonColor":[255,0,255],"color2Type":7,"modTank":-1,"plate":"UQEI6903","modRoof":-1,"modStruts":-1,"modSideSkirt":-1,"modSpeakers":-1,"modRearBumper":0,"modTrimA":-1,"wheelColor":156,"modLightbar":-1,"modWindows":-1,"modArmor":-1,"modShifterLeavers":-1,"modFender":-1,"color1Type":7,"modAPlate":-1,"modVanityPlate":-1,"modTransmission":-1,"windowTint":-1,"wheels":1,"color2":72,"modEngineBlock":-1,"modRightFender":-1,"modSmokeEnabled":false,"model":-1685021548,"color1":35,"modHorns":-1,"dashboardColor":0,"modSteeringWheel":-1,"modAirFilter":-1,"modTurbo":false,"modLivery":-1,"color2Custom":[22,22,41],"modBackWheels":-1,"modExhaust":2,"extraEnabled":{"11":false,"10":false},"modDoorSpeaker":-1,"modOrnaments":-1,"tyreSmokeColor":[255,255,255],"modGrille":1,"modPlateHolder":-1,"modFrontWheels":6,"modTrunk":-1,"livery":-1,"modEngine":-1,"modAerials":-1,"modSuspension":0,"neonEnabled":[false,false,false,false],"modDashboard":-1,"modXenon":255,"modSpoilers":0,"interiorColor":0,"modFrontBumper":0,"modHood":4,"color1Custom":[99,0,18],"pearlescentColor":28,"modFrame":0,"modBrakes":-1,"modSeats":-1}', 'car', 0, 'garage', '0', 1, 0, 0, 0, 14500, 0);
INSERT INTO `owned_vehicles` (`owner`, `plate`, `damage`, `vehicle`, `type`, `stored`, `job`, `parkmeter`, `garagenum`, `parkmeternum`, `policei`, `sheriffi`, `cost`, `cooldown`) VALUES
	('steam:1100001452540bf', 'LVAO8711', '{"vehicleHealth":1000,"dirtLevel":5.0,"doorStates":[],"tyreStates":[],"fuelLevel":100.0,"tankHealth":1000.0,"engineHealth":1000.0,"bodyHealth":1000.0,"windowStates":[2,3,4,5]}', '{"modAPlate":-1,"modTrimB":-1,"modEngineBlock":-1,"color2Type":0,"interiorColor":0,"modDashboard":-1,"modFrontWheels":-1,"dashboardColor":0,"modDoorSpeaker":-1,"modTurbo":false,"modSideSkirt":-1,"modPlateHolder":-1,"modTank":-1,"modOrnaments":-1,"modFrontBumper":-1,"extraEnabled":[],"modArmor":-1,"plate":"LVAO8711","modStruts":-1,"modXenon":255,"modHood":-1,"modRightFender":-1,"modGrille":-1,"plateIndex":0,"modArchCover":-1,"windowTint":-1,"modTrunk":-1,"modSmokeEnabled":false,"modVanityPlate":-1,"modSeats":-1,"color2Custom":[50,59,71],"color1Type":0,"wheels":7,"modAerials":-1,"modRearBumper":-1,"color1":7,"modDial":-1,"modAirFilter":-1,"wheelColor":0,"modWindows":-1,"modTrimA":-1,"modExhaust":-1,"modSpoilers":-1,"modShifterLeavers":-1,"modFender":-1,"modEngine":-1,"modHorns":-1,"neonEnabled":[false,false,false,false],"modSuspension":-1,"modHydrolic":-1,"modSteeringWheel":-1,"modBackWheels":-1,"pearlescentColor":3,"modRoof":-1,"modLightbar":-1,"color1Custom":[50,59,71],"modSpeakers":-1,"model":1663218586,"tyreSmokeColor":[255,255,255],"color2":7,"modLivery":-1,"livery":-1,"modFrame":-1,"modBrakes":-1,"neonColor":[255,0,255],"modTransmission":-1}', 'car', 0, 'garage', '0', 1, 0, 0, 0, 14500, 0);
INSERT INTO `owned_vehicles` (`owner`, `plate`, `damage`, `vehicle`, `type`, `stored`, `job`, `parkmeter`, `garagenum`, `parkmeternum`, `policei`, `sheriffi`, `cost`, `cooldown`) VALUES
	('1', 'GXQY5732', '{"tankHealth":1000.0,"vehicleHealth":1000,"dirtLevel":1.0,"bodyHealth":1000.0,"engineHealth":1000.0,"doorStates":[],"fuelLevel":100.0,"tyreStates":[],"windowStates":[4,5]}', '{"modSteeringWheel":-1,"color1Custom":[0,27,87],"modFrontBumper":-1,"plate":"GXQY5732","modArmor":-1,"modShifterLeavers":-1,"modRearBumper":-1,"model":-1848994066,"modFrame":-1,"neonEnabled":[false,false,false,false],"windowTint":-1,"pearlescentColor":73,"modGrille":-1,"modAerials":-1,"dashboardColor":65,"modTrunk":-1,"color2Custom":[8,8,8],"modHood":-1,"modTank":-1,"color2Type":0,"color1Type":0,"modTransmission":-1,"modArchCover":-1,"modDoorSpeaker":-1,"interiorColor":93,"modFender":-1,"modOrnaments":-1,"modDial":-1,"modExhaust":-1,"modLightbar":-1,"modVanityPlate":-1,"wheelColor":0,"modWindows":-1,"livery":-1,"modRightFender":-1,"modDashboard":-1,"modFrontWheels":-1,"modBrakes":-1,"modEngineBlock":-1,"modXenon":255,"modStruts":-1,"modRoof":-1,"color2":0,"modLivery":-1,"modAPlate":-1,"modSpoilers":-1,"neonColor":[255,0,255],"modSuspension":-1,"modSmokeEnabled":false,"color1":64,"modBackWheels":-1,"modSideSkirt":-1,"modHydrolic":-1,"modPlateHolder":-1,"modAirFilter":-1,"modTrimA":-1,"tyreSmokeColor":[255,255,255],"modTurbo":false,"modEngine":-1,"extraEnabled":[],"modSeats":-1,"modHorns":-1,"modSpeakers":-1,"plateIndex":0,"modTrimB":-1,"wheels":0}', 'car', 1, 'gang', '0', 1, 0, 0, 0, 14500, 0);
INSERT INTO `owned_vehicles` (`owner`, `plate`, `damage`, `vehicle`, `type`, `stored`, `job`, `parkmeter`, `garagenum`, `parkmeternum`, `policei`, `sheriffi`, `cost`, `cooldown`) VALUES
	('1', 'HUEH6805', '{"tankHealth":1000.0,"vehicleHealth":1000,"dirtLevel":1.0,"bodyHealth":1000.0,"engineHealth":1000.0,"doorStates":[],"fuelLevel":100.0,"tyreStates":[],"windowStates":[4,5]}', '{"modSteeringWheel":-1,"color1Custom":[0,27,87],"modFrontBumper":-1,"plate":"HUEH6805","modArmor":-1,"modShifterLeavers":-1,"modRearBumper":-1,"model":-1848994066,"modFrame":-1,"neonEnabled":[false,false,false,false],"windowTint":-1,"pearlescentColor":73,"modGrille":-1,"modAerials":-1,"dashboardColor":65,"modTrunk":-1,"color2Custom":[8,8,8],"modHood":-1,"modTank":-1,"color2Type":0,"color1Type":0,"modTransmission":-1,"modArchCover":-1,"modDoorSpeaker":-1,"interiorColor":93,"modFender":-1,"modOrnaments":-1,"modDial":-1,"modExhaust":-1,"modLightbar":-1,"modVanityPlate":-1,"wheelColor":0,"modWindows":-1,"livery":-1,"modRightFender":-1,"modDashboard":-1,"modFrontWheels":-1,"modBrakes":-1,"modEngineBlock":-1,"modXenon":255,"modStruts":-1,"modRoof":-1,"color2":0,"modLivery":-1,"modAPlate":-1,"modSpoilers":-1,"neonColor":[255,0,255],"modSuspension":-1,"modSmokeEnabled":false,"color1":64,"modBackWheels":-1,"modSideSkirt":-1,"modHydrolic":-1,"modPlateHolder":-1,"modAirFilter":-1,"modTrimA":-1,"tyreSmokeColor":[255,255,255],"modTurbo":false,"modEngine":-1,"extraEnabled":[],"modSeats":-1,"modHorns":-1,"modSpeakers":-1,"plateIndex":0,"modTrimB":-1,"wheels":0}', 'car', 1, 'gang', '0', 1, 0, 0, 0, 14500, 0);
INSERT INTO `owned_vehicles` (`owner`, `plate`, `damage`, `vehicle`, `type`, `stored`, `job`, `parkmeter`, `garagenum`, `parkmeternum`, `policei`, `sheriffi`, `cost`, `cooldown`) VALUES
	('asghar', 'CBSE9044', '{"tankHealth":1000.0,"vehicleHealth":1000,"dirtLevel":1.0,"bodyHealth":1000.0,"engineHealth":1000.0,"doorStates":[],"fuelLevel":100.0,"tyreStates":[],"windowStates":[4,5]}', '{"modWindows":-1,"modTrunk":-1,"color1":64,"modSpeakers":-1,"modRightFender":-1,"pearlescentColor":73,"modLightbar":-1,"modSmokeEnabled":false,"modEngine":-1,"interiorColor":93,"modTrimA":-1,"color1Custom":[0,27,87],"modSpoilers":-1,"modStruts":-1,"modFrame":-1,"modTank":-1,"modRearBumper":-1,"modAirFilter":-1,"plateIndex":0,"modAPlate":-1,"modEngineBlock":-1,"modHydrolic":-1,"modOrnaments":-1,"modGrille":-1,"modHood":-1,"modHorns":-1,"modBackWheels":-1,"windowTint":-1,"modArmor":-1,"modRoof":-1,"neonColor":[255,0,255],"plate":"CBSE9044","model":-1848994066,"color2Custom":[8,8,8],"livery":-1,"wheelColor":0,"extraEnabled":[],"modDoorSpeaker":-1,"color2":0,"modPlateHolder":-1,"modBrakes":-1,"modSideSkirt":-1,"neonEnabled":[false,false,false,false],"modSuspension":-1,"modAerials":-1,"modSeats":-1,"modVanityPlate":-1,"modDial":-1,"modExhaust":-1,"modShifterLeavers":-1,"modLivery":-1,"color2Type":0,"modArchCover":-1,"color1Type":0,"modTrimB":-1,"modXenon":255,"modTurbo":false,"modSteeringWheel":-1,"modTransmission":-1,"modDashboard":-1,"modFrontWheels":-1,"modFender":-1,"wheels":0,"modFrontBumper":-1,"tyreSmokeColor":[255,255,255],"dashboardColor":65}', 'car', 0, 'gang', '0', 1, 0, 0, 0, 14500, 0);
INSERT INTO `owned_vehicles` (`owner`, `plate`, `damage`, `vehicle`, `type`, `stored`, `job`, `parkmeter`, `garagenum`, `parkmeternum`, `policei`, `sheriffi`, `cost`, `cooldown`) VALUES
	('steam:1100001452540bf', '80TVL007', '{"tankHealth":999.7,"bodyHealth":997.5,"doorStates":[],"vehicleHealth":997,"dirtLevel":9.1,"fuelLevel":48.9,"tyreStates":[],"engineHealth":997.0,"windowStates":[]}', '{"modTrimB":-1,"modHydrolic":-1,"plateIndex":0,"modDial":-1,"modArchCover":-1,"neonColor":[255,0,255],"color2Type":0,"modTank":-1,"plate":"80TVL007","modRoof":-1,"modStruts":-1,"modSideSkirt":-1,"modSpeakers":-1,"modRearBumper":-1,"modTrimA":-1,"wheelColor":7,"modLightbar":-1,"modWindows":-1,"modArmor":-1,"modShifterLeavers":-1,"modFender":-1,"color1Type":0,"modAPlate":-1,"modVanityPlate":-1,"modTransmission":-1,"windowTint":-1,"wheels":3,"color2":0,"modEngineBlock":-1,"modRightFender":-1,"modSmokeEnabled":false,"model":634118882,"color1":0,"modHorns":-1,"dashboardColor":156,"modSteeringWheel":-1,"modAirFilter":-1,"modTurbo":false,"modLivery":-1,"color2Custom":[0,0,0],"modBackWheels":-1,"modExhaust":-1,"extraEnabled":{"10":false,"12":1},"modDoorSpeaker":-1,"modOrnaments":-1,"tyreSmokeColor":[255,255,255],"modGrille":-1,"modPlateHolder":-1,"modFrontWheels":-1,"modTrunk":-1,"livery":-1,"modEngine":-1,"modAerials":-1,"modSuspension":-1,"neonEnabled":[false,false,false,false],"modDashboard":-1,"modXenon":255,"modSpoilers":-1,"interiorColor":8,"modFrontBumper":-1,"modHood":-1,"color1Custom":[0,0,0],"pearlescentColor":2,"modFrame":-1,"modBrakes":-1,"modSeats":-1}', 'car', 0, 'garage', '0', 1, 0, 0, 0, 14500, 0);
INSERT INTO `owned_vehicles` (`owner`, `plate`, `damage`, `vehicle`, `type`, `stored`, `job`, `parkmeter`, `garagenum`, `parkmeternum`, `policei`, `sheriffi`, `cost`, `cooldown`) VALUES
	('steam:1100001452540bf', '69RBC015', '{"bodyHealth":1000.0,"windowStates":[4,5],"dirtLevel":6.0,"tankHealth":1000.0,"tyreStates":[],"fuelLevel":50.0,"engineHealth":1000.0,"vehicleHealth":1000,"doorStates":[]}', '{"plateIndex":0,"modTurbo":false,"modSideSkirt":-1,"modGrille":-1,"wheels":1,"color2Custom":[0,0,0],"modFrontWheels":-1,"modEngine":-1,"modTank":-1,"neonEnabled":[false,false,false,false],"modHood":-1,"modHorns":-1,"modTrimB":-1,"color1":142,"dashboardColor":0,"modFrame":-1,"wheelColor":88,"modRightFender":-1,"modArmor":-1,"modTrimA":-1,"color1Type":7,"modEngineBlock":-1,"modSuspension":-1,"tyreSmokeColor":[255,255,255],"modStruts":-1,"modAirFilter":-1,"modShifterLeavers":-1,"modSeats":-1,"modDashboard":-1,"modExhaust":-1,"modFender":-1,"modSpeakers":-1,"modXenon":255,"modTransmission":-1,"color2":25,"modSpoilers":-1,"modVanityPlate":-1,"extraEnabled":{"3":false,"2":1},"interiorColor":0,"neonColor":[255,0,255],"modTrunk":-1,"modDoorSpeaker":-1,"modArchCover":-1,"pearlescentColor":81,"modDial":-1,"livery":-1,"modRoof":-1,"color2Type":7,"modSmokeEnabled":false,"modFrontBumper":-1,"modBrakes":-1,"modLivery":-1,"modOrnaments":-1,"model":-2039755226,"modWindows":-1,"windowTint":-1,"modAerials":-1,"modPlateHolder":-1,"modSteeringWheel":-1,"modHydrolic":-1,"type":"car","modBackWheels":3,"plate":"69RBC015","modRearBumper":-1,"modLightbar":-1,"color1Custom":[0,0,0],"modAPlate":-1}', 'car', 0, 'garage', '0', 1, 0, 0, 0, 14500, 0);
INSERT INTO `owned_vehicles` (`owner`, `plate`, `damage`, `vehicle`, `type`, `stored`, `job`, `parkmeter`, `garagenum`, `parkmeternum`, `policei`, `sheriffi`, `cost`, `cooldown`) VALUES
	('steam:1100001452540bf', '43RVP172', '{"bodyHealth":1000.0,"windowStates":[4,5],"dirtLevel":3.0,"tankHealth":1000.0,"tyreStates":[],"fuelLevel":50.0,"engineHealth":1000.0,"vehicleHealth":1000,"doorStates":[]}', '{"plateIndex":0,"modTurbo":false,"modSideSkirt":-1,"modGrille":-1,"wheels":1,"color2Custom":[0,0,0],"modFrontWheels":-1,"modEngine":-1,"modTank":-1,"neonEnabled":[false,false,false,false],"modHood":-1,"modHorns":-1,"modTrimB":-1,"color1":7,"dashboardColor":156,"modFrame":-1,"wheelColor":0,"modRightFender":-1,"modArmor":-1,"modTrimA":-1,"color1Type":0,"modEngineBlock":-1,"modSuspension":-1,"tyreSmokeColor":[255,255,255],"modStruts":-1,"modAirFilter":-1,"modShifterLeavers":-1,"modSeats":-1,"modDashboard":-1,"modExhaust":-1,"modFender":-1,"modSpeakers":-1,"modXenon":255,"modTransmission":-1,"color2":120,"modSpoilers":-1,"modVanityPlate":-1,"extraEnabled":[],"interiorColor":2,"neonColor":[255,0,255],"modTrunk":-1,"modDoorSpeaker":-1,"modArchCover":-1,"pearlescentColor":7,"modDial":-1,"livery":-1,"modRoof":-1,"color2Type":0,"modSmokeEnabled":false,"modFrontBumper":-1,"modBrakes":-1,"modLivery":-1,"modOrnaments":-1,"model":-49115651,"modWindows":-1,"windowTint":-1,"modAerials":-1,"modPlateHolder":-1,"modSteeringWheel":-1,"modHydrolic":-1,"type":"car","modBackWheels":-1,"plate":"43RVP172","modRearBumper":-1,"modLightbar":-1,"color1Custom":[0,0,0],"modAPlate":-1}', 'car', 0, 'garage', '0', 1, 0, 0, 0, 14500, 0);
INSERT INTO `owned_vehicles` (`owner`, `plate`, `damage`, `vehicle`, `type`, `stored`, `job`, `parkmeter`, `garagenum`, `parkmeternum`, `policei`, `sheriffi`, `cost`, `cooldown`) VALUES
	('steam:1100001452540bf', '84MEF027', '{"tankHealth":995.9,"bodyHealth":959.4,"doorStates":[],"vehicleHealth":959,"dirtLevel":5.1,"fuelLevel":48.9,"tyreStates":[],"engineHealth":1000.0,"windowStates":[2,3,4,5]}', '{"modTrimB":-1,"modHydrolic":-1,"plateIndex":0,"modDial":-1,"modArchCover":-1,"neonColor":[255,0,255],"color2Type":0,"modTank":-1,"plate":"84MEF027","modRoof":-1,"modStruts":-1,"modSideSkirt":-1,"modSpeakers":-1,"modRearBumper":-1,"modTrimA":-1,"wheelColor":112,"modLightbar":-1,"modWindows":-1,"modArmor":-1,"modShifterLeavers":-1,"modFender":-1,"color1Type":0,"modAPlate":-1,"modVanityPlate":-1,"modTransmission":-1,"windowTint":-1,"wheels":7,"color2":33,"modEngineBlock":-1,"modRightFender":-1,"modSmokeEnabled":false,"model":1044193113,"color1":27,"modHorns":-1,"dashboardColor":65,"modSteeringWheel":-1,"modAirFilter":-1,"modTurbo":false,"modLivery":-1,"color2Custom":[255,255,255],"modBackWheels":-1,"modExhaust":-1,"extraEnabled":[],"modDoorSpeaker":-1,"modOrnaments":-1,"tyreSmokeColor":[255,255,255],"modGrille":-1,"modPlateHolder":-1,"modFrontWheels":-1,"modTrunk":-1,"livery":-1,"modEngine":-1,"modAerials":-1,"modSuspension":-1,"neonEnabled":[false,false,false,false],"modDashboard":-1,"modXenon":255,"modSpoilers":-1,"interiorColor":33,"modFrontBumper":-1,"modHood":-1,"color1Custom":[255,255,255],"pearlescentColor":18,"modFrame":-1,"modBrakes":-1,"modSeats":-1}', 'car', 1, 'garage', '0', 1, 0, 0, 0, 14500, 0);
INSERT INTO `owned_vehicles` (`owner`, `plate`, `damage`, `vehicle`, `type`, `stored`, `job`, `parkmeter`, `garagenum`, `parkmeternum`, `policei`, `sheriffi`, `cost`, `cooldown`) VALUES
	('steam:1100001452540bf', 'VEUV2948', '{"bodyHealth":928.0,"vehicleHealth":927,"tyreStates":[],"tankHealth":976.2,"fuelLevel":61.5,"dirtLevel":0.5,"engineHealth":982.5,"windowStates":[0,2,3,4,5],"doorStates":[]}', '{"plateIndex":0,"modTurbo":false,"color1Custom":[138,11,0],"modGrille":-1,"wheels":7,"pearlescentColor":0,"modFrontWheels":-1,"modEngine":-1,"modTank":-1,"neonEnabled":[false,false,false,false],"modHood":-1,"modHorns":-1,"modTrimB":-1,"color1":28,"dashboardColor":0,"modFrame":-1,"wheelColor":156,"color2":0,"modArmor":-1,"modTrimA":-1,"color1Type":0,"neonColor":[255,0,255],"modSuspension":-1,"tyreSmokeColor":[255,255,255],"modStruts":-1,"modAirFilter":-1,"modShifterLeavers":-1,"modSeats":-1,"modVanityPlate":-1,"modExhaust":-1,"modFender":-1,"modSpeakers":-1,"modHydrolic":-1,"modTransmission":-1,"modSideSkirt":-1,"color2Type":0,"extraEnabled":{"12":false,"10":false},"modSpoilers":-1,"interiorColor":0,"modEngineBlock":-1,"modTrunk":-1,"plate":"VEUV2948","modBackWheels":-1,"modDial":-1,"livery":-1,"modPlateHolder":-1,"modFrontBumper":-1,"modRoof":-1,"modSmokeEnabled":false,"modAerials":-1,"modLightbar":-1,"modBrakes":-1,"modDoorSpeaker":-1,"model":2072687711,"windowTint":-1,"modAPlate":-1,"color2Custom":[8,8,8],"modSteeringWheel":-1,"modDashboard":-1,"modXenon":255,"modArchCover":-1,"modRightFender":-1,"modRearBumper":-1,"modWindows":-1,"modLivery":-1,"modOrnaments":-1}', 'car', 0, 'garage', '0', 1, 0, 0, 0, 14500, 0);
/*!40000 ALTER TABLE `owned_vehicles` ENABLE KEYS */;

-- Dumping structure for table essential.phone_accounts
CREATE TABLE IF NOT EXISTS `phone_accounts` (
  `app` varchar(50) NOT NULL,
  `id` varchar(80) NOT NULL,
  `name` varchar(50) NOT NULL,
  `password` varchar(50) NOT NULL,
  `birthdate` varchar(50) NOT NULL,
  `gender` varchar(50) NOT NULL,
  `interested` text NOT NULL,
  `avatar` text NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Dumping data for table essential.phone_accounts: ~0 rows (approximately)
/*!40000 ALTER TABLE `phone_accounts` DISABLE KEYS */;
/*!40000 ALTER TABLE `phone_accounts` ENABLE KEYS */;

-- Dumping structure for table essential.phone_alertjobs
CREATE TABLE IF NOT EXISTS `phone_alertjobs` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `job` varchar(255) NOT NULL,
  `alerts` text DEFAULT NULL,
  `date` timestamp NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`id`),
  UNIQUE KEY `job` (`job`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Dumping data for table essential.phone_alertjobs: ~2 rows (approximately)
/*!40000 ALTER TABLE `phone_alertjobs` DISABLE KEYS */;
INSERT INTO `phone_alertjobs` (`id`, `job`, `alerts`, `date`) VALUES
	(1, 'police', '[{"img":"none","location":{"x":1176.138427734375,"y":2672.15966796875,"z":37.87028503417969},"message":"aqq","phone":"8572769980","alertID":1}]', '2022-11-23 16:31:06');
INSERT INTO `phone_alertjobs` (`id`, `job`, `alerts`, `date`) VALUES
	(2, 'ambulance', '[{"message":"Injured person","alertID":1,"location":{"x":92.29949951171877,"z":20.79184913635254,"y":-1928.1995849609376}},{"message":"Injured person","alertID":2,"location":{"x":418.0994567871094,"y":-971.8989868164063,"z":29.42925643920898}}]', '2022-12-02 07:55:21');
/*!40000 ALTER TABLE `phone_alertjobs` ENABLE KEYS */;

-- Dumping structure for table essential.phone_app_chat
CREATE TABLE IF NOT EXISTS `phone_app_chat` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `channel` varchar(20) NOT NULL,
  `message` varchar(255) NOT NULL,
  `time` timestamp NOT NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci ROW_FORMAT=DYNAMIC;

-- Dumping data for table essential.phone_app_chat: ~0 rows (approximately)
/*!40000 ALTER TABLE `phone_app_chat` DISABLE KEYS */;
/*!40000 ALTER TABLE `phone_app_chat` ENABLE KEYS */;

-- Dumping structure for table essential.phone_calls
CREATE TABLE IF NOT EXISTS `phone_calls` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `owner` varchar(10) NOT NULL COMMENT 'Name',
  `num` varchar(10) NOT NULL COMMENT 'Phone Number',
  `incoming` int(11) NOT NULL COMMENT 'Define Incoming Call',
  `time` timestamp NOT NULL DEFAULT current_timestamp(),
  `accepts` int(11) NOT NULL COMMENT 'Accept Call',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=442 DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci ROW_FORMAT=DYNAMIC;

-- Dumping data for table essential.phone_calls: ~62 rows (approximately)
/*!40000 ALTER TABLE `phone_calls` DISABLE KEYS */;
INSERT INTO `phone_calls` (`id`, `owner`, `num`, `incoming`, `time`, `accepts`) VALUES
	(380, '0939853348', '111', 1, '2021-11-08 14:59:32', 0);
INSERT INTO `phone_calls` (`id`, `owner`, `num`, `incoming`, `time`, `accepts`) VALUES
	(381, '0939853348', '0939906282', 1, '2021-11-09 08:25:55', 0);
INSERT INTO `phone_calls` (`id`, `owner`, `num`, `incoming`, `time`, `accepts`) VALUES
	(382, '0939906282', '0939853348', 0, '2021-11-09 08:25:55', 0);
INSERT INTO `phone_calls` (`id`, `owner`, `num`, `incoming`, `time`, `accepts`) VALUES
	(383, '0939952527', '0939726172', 1, '2021-11-10 08:55:26', 0);
INSERT INTO `phone_calls` (`id`, `owner`, `num`, `incoming`, `time`, `accepts`) VALUES
	(384, '0939607506', '0939833377', 1, '2021-11-11 01:08:33', 1);
INSERT INTO `phone_calls` (`id`, `owner`, `num`, `incoming`, `time`, `accepts`) VALUES
	(385, '0939833377', '0939607506', 0, '2021-11-11 01:08:33', 1);
INSERT INTO `phone_calls` (`id`, `owner`, `num`, `incoming`, `time`, `accepts`) VALUES
	(386, '0939833377', '0939607506', 1, '2021-11-11 01:08:58', 1);
INSERT INTO `phone_calls` (`id`, `owner`, `num`, `incoming`, `time`, `accepts`) VALUES
	(387, '0939607506', '0939833377', 0, '2021-11-11 01:08:58', 1);
INSERT INTO `phone_calls` (`id`, `owner`, `num`, `incoming`, `time`, `accepts`) VALUES
	(388, '0939833377', '0939607506', 0, '2021-11-11 01:09:54', 1);
INSERT INTO `phone_calls` (`id`, `owner`, `num`, `incoming`, `time`, `accepts`) VALUES
	(389, '0939607506', '0939833377', 1, '2021-11-11 01:09:54', 1);
INSERT INTO `phone_calls` (`id`, `owner`, `num`, `incoming`, `time`, `accepts`) VALUES
	(390, '0939607506', '0939833377', 1, '2021-11-11 01:09:56', 1);
INSERT INTO `phone_calls` (`id`, `owner`, `num`, `incoming`, `time`, `accepts`) VALUES
	(391, '0939833377', '0939607506', 0, '2021-11-11 01:09:56', 1);
INSERT INTO `phone_calls` (`id`, `owner`, `num`, `incoming`, `time`, `accepts`) VALUES
	(392, '0939513264', '0939426965', 1, '2021-11-11 03:40:03', 0);
INSERT INTO `phone_calls` (`id`, `owner`, `num`, `incoming`, `time`, `accepts`) VALUES
	(393, '0939426965', '0939513264', 0, '2021-11-11 03:40:03', 0);
INSERT INTO `phone_calls` (`id`, `owner`, `num`, `incoming`, `time`, `accepts`) VALUES
	(394, '0939607506', '0939586472', 1, '2021-11-11 07:14:52', 0);
INSERT INTO `phone_calls` (`id`, `owner`, `num`, `incoming`, `time`, `accepts`) VALUES
	(395, '0939586472', '0939607506', 0, '2021-11-11 07:14:52', 0);
INSERT INTO `phone_calls` (`id`, `owner`, `num`, `incoming`, `time`, `accepts`) VALUES
	(396, '0939846965', '110', 1, '2021-11-14 02:55:44', 0);
INSERT INTO `phone_calls` (`id`, `owner`, `num`, `incoming`, `time`, `accepts`) VALUES
	(397, '0939729647', '0939731208', 1, '2021-11-15 05:18:15', 1);
INSERT INTO `phone_calls` (`id`, `owner`, `num`, `incoming`, `time`, `accepts`) VALUES
	(398, '0939731208', '0939729647', 0, '2021-11-15 05:18:15', 1);
INSERT INTO `phone_calls` (`id`, `owner`, `num`, `incoming`, `time`, `accepts`) VALUES
	(399, '0939729647', '0939731208', 1, '2021-11-15 05:18:37', 1);
INSERT INTO `phone_calls` (`id`, `owner`, `num`, `incoming`, `time`, `accepts`) VALUES
	(400, '0939731208', '0939729647', 0, '2021-11-15 05:18:37', 1);
INSERT INTO `phone_calls` (`id`, `owner`, `num`, `incoming`, `time`, `accepts`) VALUES
	(401, '0939357006', '22', 1, '2021-11-16 01:07:10', 0);
INSERT INTO `phone_calls` (`id`, `owner`, `num`, `incoming`, `time`, `accepts`) VALUES
	(402, '0939952527', '0939798911', 1, '2021-11-22 14:35:32', 1);
INSERT INTO `phone_calls` (`id`, `owner`, `num`, `incoming`, `time`, `accepts`) VALUES
	(403, '0939798911', '0939952527', 0, '2021-11-22 14:35:32', 1);
INSERT INTO `phone_calls` (`id`, `owner`, `num`, `incoming`, `time`, `accepts`) VALUES
	(404, '0939952527', '0939798911', 1, '2021-11-22 14:35:33', 1);
INSERT INTO `phone_calls` (`id`, `owner`, `num`, `incoming`, `time`, `accepts`) VALUES
	(405, '0939798911', '0939952527', 0, '2021-11-22 14:35:33', 1);
INSERT INTO `phone_calls` (`id`, `owner`, `num`, `incoming`, `time`, `accepts`) VALUES
	(406, '0939411565', '0939302438', 1, '2021-11-28 08:35:44', 1);
INSERT INTO `phone_calls` (`id`, `owner`, `num`, `incoming`, `time`, `accepts`) VALUES
	(407, '0939302438', '0939411565', 0, '2021-11-28 08:35:44', 1);
INSERT INTO `phone_calls` (`id`, `owner`, `num`, `incoming`, `time`, `accepts`) VALUES
	(408, '0939411565', '0939302438', 1, '2021-11-28 08:36:22', 1);
INSERT INTO `phone_calls` (`id`, `owner`, `num`, `incoming`, `time`, `accepts`) VALUES
	(409, '0939302438', '0939411565', 0, '2021-11-28 08:36:22', 1);
INSERT INTO `phone_calls` (`id`, `owner`, `num`, `incoming`, `time`, `accepts`) VALUES
	(410, '0939411565', '0939302438', 1, '2021-11-28 08:44:46', 1);
INSERT INTO `phone_calls` (`id`, `owner`, `num`, `incoming`, `time`, `accepts`) VALUES
	(411, '0939302438', '0939411565', 0, '2021-11-28 08:44:46', 1);
INSERT INTO `phone_calls` (`id`, `owner`, `num`, `incoming`, `time`, `accepts`) VALUES
	(412, '0939477496', '0911820073', 1, '2021-11-30 01:18:50', 0);
INSERT INTO `phone_calls` (`id`, `owner`, `num`, `incoming`, `time`, `accepts`) VALUES
	(413, '0939896875', '0939146129', 1, '2021-11-30 03:02:57', 0);
INSERT INTO `phone_calls` (`id`, `owner`, `num`, `incoming`, `time`, `accepts`) VALUES
	(414, '0939746429', '0939896875', 1, '2021-11-30 03:05:02', 1);
INSERT INTO `phone_calls` (`id`, `owner`, `num`, `incoming`, `time`, `accepts`) VALUES
	(415, '0939896875', '0939746429', 0, '2021-11-30 03:05:02', 1);
INSERT INTO `phone_calls` (`id`, `owner`, `num`, `incoming`, `time`, `accepts`) VALUES
	(416, '0939746429', '0939896875', 1, '2021-11-30 03:05:03', 1);
INSERT INTO `phone_calls` (`id`, `owner`, `num`, `incoming`, `time`, `accepts`) VALUES
	(417, '0939896875', '0939746429', 0, '2021-11-30 03:05:03', 1);
INSERT INTO `phone_calls` (`id`, `owner`, `num`, `incoming`, `time`, `accepts`) VALUES
	(418, '0939746429', '0939896875', 1, '2021-11-30 03:05:04', 1);
INSERT INTO `phone_calls` (`id`, `owner`, `num`, `incoming`, `time`, `accepts`) VALUES
	(419, '0939896875', '0939746429', 0, '2021-11-30 03:05:04', 1);
INSERT INTO `phone_calls` (`id`, `owner`, `num`, `incoming`, `time`, `accepts`) VALUES
	(420, '0939746429', '0939896875', 1, '2021-11-30 03:05:04', 1);
INSERT INTO `phone_calls` (`id`, `owner`, `num`, `incoming`, `time`, `accepts`) VALUES
	(421, '0939896875', '0939746429', 0, '2021-11-30 03:05:04', 1);
INSERT INTO `phone_calls` (`id`, `owner`, `num`, `incoming`, `time`, `accepts`) VALUES
	(422, '0939952527', '0998', 1, '2021-12-03 11:55:10', 0);
INSERT INTO `phone_calls` (`id`, `owner`, `num`, `incoming`, `time`, `accepts`) VALUES
	(423, '0939952527', '777', 1, '2021-12-04 11:32:07', 0);
INSERT INTO `phone_calls` (`id`, `owner`, `num`, `incoming`, `time`, `accepts`) VALUES
	(424, '0939691000', '0939817880', 1, '2021-12-05 06:46:23', 0);
INSERT INTO `phone_calls` (`id`, `owner`, `num`, `incoming`, `time`, `accepts`) VALUES
	(425, '0939817880', '0939691000', 0, '2021-12-05 06:46:23', 0);
INSERT INTO `phone_calls` (`id`, `owner`, `num`, `incoming`, `time`, `accepts`) VALUES
	(426, '0939817880', '0939691000', 1, '2021-12-05 07:34:50', 1);
INSERT INTO `phone_calls` (`id`, `owner`, `num`, `incoming`, `time`, `accepts`) VALUES
	(427, '0939691000', '0939817880', 0, '2021-12-05 07:34:50', 1);
INSERT INTO `phone_calls` (`id`, `owner`, `num`, `incoming`, `time`, `accepts`) VALUES
	(428, '0939817880', '0939691000', 1, '2021-12-05 07:34:50', 1);
INSERT INTO `phone_calls` (`id`, `owner`, `num`, `incoming`, `time`, `accepts`) VALUES
	(429, '0939691000', '0939817880', 0, '2021-12-05 07:34:50', 1);
INSERT INTO `phone_calls` (`id`, `owner`, `num`, `incoming`, `time`, `accepts`) VALUES
	(430, '0939817880', '0939691000', 1, '2021-12-05 07:35:02', 1);
INSERT INTO `phone_calls` (`id`, `owner`, `num`, `incoming`, `time`, `accepts`) VALUES
	(431, '0939691000', '0939817880', 0, '2021-12-05 07:35:02', 1);
INSERT INTO `phone_calls` (`id`, `owner`, `num`, `incoming`, `time`, `accepts`) VALUES
	(432, '0939817880', '0939691000', 1, '2021-12-05 07:35:03', 1);
INSERT INTO `phone_calls` (`id`, `owner`, `num`, `incoming`, `time`, `accepts`) VALUES
	(433, '0939691000', '0939817880', 0, '2021-12-05 07:35:03', 1);
INSERT INTO `phone_calls` (`id`, `owner`, `num`, `incoming`, `time`, `accepts`) VALUES
	(434, '0939817880', '0939691000', 1, '2021-12-05 07:35:04', 1);
INSERT INTO `phone_calls` (`id`, `owner`, `num`, `incoming`, `time`, `accepts`) VALUES
	(435, '0939691000', '0939817880', 0, '2021-12-05 07:35:04', 1);
INSERT INTO `phone_calls` (`id`, `owner`, `num`, `incoming`, `time`, `accepts`) VALUES
	(436, '0939817880', '0939691000', 1, '2021-12-05 07:36:17', 1);
INSERT INTO `phone_calls` (`id`, `owner`, `num`, `incoming`, `time`, `accepts`) VALUES
	(437, '0939691000', '0939817880', 0, '2021-12-05 07:36:17', 1);
INSERT INTO `phone_calls` (`id`, `owner`, `num`, `incoming`, `time`, `accepts`) VALUES
	(438, '0939817880', '0939691000', 1, '2021-12-05 07:36:18', 1);
INSERT INTO `phone_calls` (`id`, `owner`, `num`, `incoming`, `time`, `accepts`) VALUES
	(439, '0939691000', '0939817880', 0, '2021-12-05 07:36:18', 1);
INSERT INTO `phone_calls` (`id`, `owner`, `num`, `incoming`, `time`, `accepts`) VALUES
	(440, '0939952527', '0913128285', 1, '2021-12-07 04:20:33', 0);
INSERT INTO `phone_calls` (`id`, `owner`, `num`, `incoming`, `time`, `accepts`) VALUES
	(441, '0912653402', '095555555', 1, '2022-10-23 01:23:58', 0);
/*!40000 ALTER TABLE `phone_calls` ENABLE KEYS */;

-- Dumping structure for table essential.phone_chatrooms
CREATE TABLE IF NOT EXISTS `phone_chatrooms` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `room_code` varchar(10) NOT NULL,
  `room_name` varchar(15) NOT NULL,
  `room_owner_id` varchar(50) DEFAULT NULL,
  `room_owner_name` varchar(60) DEFAULT NULL,
  `room_members` text DEFAULT NULL,
  `room_pin` varchar(50) DEFAULT NULL,
  `unpaid_balance` decimal(10,2) DEFAULT 0.00,
  `is_masked` tinyint(1) DEFAULT 0,
  `is_pinned` tinyint(1) DEFAULT 0,
  `created` datetime DEFAULT current_timestamp(),
  PRIMARY KEY (`id`),
  UNIQUE KEY `room_code` (`room_code`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Dumping data for table essential.phone_chatrooms: ~2 rows (approximately)
/*!40000 ALTER TABLE `phone_chatrooms` DISABLE KEYS */;
INSERT INTO `phone_chatrooms` (`id`, `room_code`, `room_name`, `room_owner_id`, `room_owner_name`, `room_members`, `room_pin`, `unpaid_balance`, `is_masked`, `is_pinned`, `created`) VALUES
	(2, 'lounge', 'The Lounge', 'official', 'Government', '{"steam:1100001356ed847":{"notify":true,"cid":"steam:1100001356ed847","name":"dsadasdas dsads"}}', NULL, 0.00, 0, 1, '2022-11-18 08:13:22');
INSERT INTO `phone_chatrooms` (`id`, `room_code`, `room_name`, `room_owner_id`, `room_owner_name`, `room_members`, `room_pin`, `unpaid_balance`, `is_masked`, `is_pinned`, `created`) VALUES
	(3, 'events', 'Events', 'official', 'Government', NULL, NULL, 0.00, 0, 1, '2022-11-18 08:13:22');
/*!40000 ALTER TABLE `phone_chatrooms` ENABLE KEYS */;

-- Dumping structure for table essential.phone_chatroom_messages
CREATE TABLE IF NOT EXISTS `phone_chatroom_messages` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `room_id` int(10) unsigned DEFAULT NULL,
  `member_id` varchar(50) DEFAULT NULL,
  `member_name` varchar(50) DEFAULT NULL,
  `message` text DEFAULT NULL,
  `is_pinned` tinyint(1) DEFAULT 0,
  `created` datetime DEFAULT current_timestamp(),
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Dumping data for table essential.phone_chatroom_messages: ~9 rows (approximately)
/*!40000 ALTER TABLE `phone_chatroom_messages` DISABLE KEYS */;
INSERT INTO `phone_chatroom_messages` (`id`, `room_id`, `member_id`, `member_name`, `message`, `is_pinned`, `created`) VALUES
	(1, 1, 'SYSTEM', 'Member Activity', 'steve watson joined the channel, welcome!', 0, '2022-12-01 16:14:24');
INSERT INTO `phone_chatroom_messages` (`id`, `room_id`, `member_id`, `member_name`, `message`, `is_pinned`, `created`) VALUES
	(2, 1, 'SYSTEM', 'Member Activity', 'steve watson has left the channel, bye boy.', 0, '2022-12-01 16:14:30');
INSERT INTO `phone_chatroom_messages` (`id`, `room_id`, `member_id`, `member_name`, `message`, `is_pinned`, `created`) VALUES
	(3, 2, 'SYSTEM', 'Member Activity', 'dsadasdas dsads joined the channel, welcome!', 0, '2022-12-01 16:15:00');
INSERT INTO `phone_chatroom_messages` (`id`, `room_id`, `member_id`, `member_name`, `message`, `is_pinned`, `created`) VALUES
	(4, 2, 'steam:1100001356ed847', 'dsadasdas dsads', 'salam', 0, '2022-12-01 16:15:10');
INSERT INTO `phone_chatroom_messages` (`id`, `room_id`, `member_id`, `member_name`, `message`, `is_pinned`, `created`) VALUES
	(5, 1, 'SYSTEM', 'Member Activity', 'steve watson joined the channel, welcome!', 0, '2022-12-01 16:15:28');
INSERT INTO `phone_chatroom_messages` (`id`, `room_id`, `member_id`, `member_name`, `message`, `is_pinned`, `created`) VALUES
	(6, 1, 'steam:11000011bf03921', 'steve watson', 'salam', 0, '2022-12-01 16:15:33');
INSERT INTO `phone_chatroom_messages` (`id`, `room_id`, `member_id`, `member_name`, `message`, `is_pinned`, `created`) VALUES
	(7, 1, 'SYSTEM', 'Member Activity', 'dsadasdas dsads joined the channel, welcome!', 0, '2022-12-01 16:15:42');
INSERT INTO `phone_chatroom_messages` (`id`, `room_id`, `member_id`, `member_name`, `message`, `is_pinned`, `created`) VALUES
	(8, 1, 'steam:1100001356ed847', 'dsadasdas dsads', 'Alo', 0, '2022-12-01 16:15:47');
INSERT INTO `phone_chatroom_messages` (`id`, `room_id`, `member_id`, `member_name`, `message`, `is_pinned`, `created`) VALUES
	(10, 1, 'steam:1100001356ed847', 'dsadasdas dsads', 'OOMADAm Koon beddam', 0, '2022-12-01 16:16:00');
/*!40000 ALTER TABLE `phone_chatroom_messages` ENABLE KEYS */;

-- Dumping structure for table essential.phone_chats
CREATE TABLE IF NOT EXISTS `phone_chats` (
  `app` varchar(50) NOT NULL,
  `author` varchar(50) NOT NULL,
  `number` varchar(50) NOT NULL,
  `created` varchar(50) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Dumping data for table essential.phone_chats: ~0 rows (approximately)
/*!40000 ALTER TABLE `phone_chats` DISABLE KEYS */;
/*!40000 ALTER TABLE `phone_chats` ENABLE KEYS */;

-- Dumping structure for table essential.phone_crypto
CREATE TABLE IF NOT EXISTS `phone_crypto` (
  `crypto` varchar(50) NOT NULL DEFAULT 'btc',
  `worth` int(11) NOT NULL DEFAULT 0,
  `history` text DEFAULT NULL,
  PRIMARY KEY (`crypto`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Dumping data for table essential.phone_crypto: ~0 rows (approximately)
/*!40000 ALTER TABLE `phone_crypto` DISABLE KEYS */;
/*!40000 ALTER TABLE `phone_crypto` ENABLE KEYS */;

-- Dumping structure for table essential.phone_invoices
CREATE TABLE IF NOT EXISTS `phone_invoices` (
  `id` int(10) NOT NULL AUTO_INCREMENT,
  `citizenid` varchar(50) DEFAULT NULL,
  `amount` int(11) NOT NULL DEFAULT 0,
  `society` tinytext DEFAULT NULL,
  `sender` varchar(50) DEFAULT NULL,
  `sendercitizenid` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

-- Dumping data for table essential.phone_invoices: ~0 rows (approximately)
/*!40000 ALTER TABLE `phone_invoices` DISABLE KEYS */;
/*!40000 ALTER TABLE `phone_invoices` ENABLE KEYS */;

-- Dumping structure for table essential.phone_messages
CREATE TABLE IF NOT EXISTS `phone_messages` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `phone` varchar(50) DEFAULT NULL,
  `number` varchar(50) NOT NULL,
  `owner` varchar(50) DEFAULT NULL,
  `messages` text NOT NULL,
  `type` varchar(50) DEFAULT NULL,
  `read` int(11) DEFAULT NULL,
  `created` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=24 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Dumping data for table essential.phone_messages: ~2 rows (approximately)
/*!40000 ALTER TABLE `phone_messages` DISABLE KEYS */;
INSERT INTO `phone_messages` (`id`, `phone`, `number`, `owner`, `messages`, `type`, `read`, `created`) VALUES
	(20, '553348962', '8573284445\n', NULL, '[{"owner":"553348962","type":"message","read":0,"message":"madare mamad Moon","created":"2022-12-01 15:19:10"},{"owner":"553348962","type":"location","read":0,"message":"{\\"x\\":426.50323486328127,\\"y\\":-984.8522338867188}","created":"2022-12-01 15:19:19"},{"owner":"553348962","type":"message","read":0,"message":"asdasd","created":"2022-12-07 16:30:53"}]', NULL, NULL, '2022-12-07 16:30:53');
INSERT INTO `phone_messages` (`id`, `phone`, `number`, `owner`, `messages`, `type`, `read`, `created`) VALUES
	(21, '8573284445\n', '553348962', NULL, '[{"owner":"553348962","type":"message","read":0,"message":"madare mamad Moon","created":"2022-12-01 15:19:10"},{"owner":"553348962","type":"location","read":0,"message":"{\\"x\\":426.50323486328127,\\"y\\":-984.8522338867188}","created":"2022-12-01 15:19:19"},{"owner":"553348962","type":"message","read":0,"message":"asdasd","created":"2022-12-07 16:30:53"}]', NULL, NULL, '2022-12-07 16:30:53');
/*!40000 ALTER TABLE `phone_messages` ENABLE KEYS */;

-- Dumping structure for table essential.phone_news
CREATE TABLE IF NOT EXISTS `phone_news` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `owner` varchar(50) DEFAULT NULL,
  `title` varchar(50) DEFAULT NULL,
  `content` text DEFAULT NULL,
  `image` text DEFAULT NULL,
  `created` varchar(50) DEFAULT '',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Dumping data for table essential.phone_news: ~0 rows (approximately)
/*!40000 ALTER TABLE `phone_news` DISABLE KEYS */;
/*!40000 ALTER TABLE `phone_news` ENABLE KEYS */;

-- Dumping structure for table essential.phone_notifies
CREATE TABLE IF NOT EXISTS `phone_notifies` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `phone` varchar(50) NOT NULL,
  `msg_content` text NOT NULL,
  `msg_head` varchar(50) NOT NULL DEFAULT '',
  `app_name` text NOT NULL,
  `msg_time` varchar(50) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=77 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Dumping data for table essential.phone_notifies: ~0 rows (approximately)
/*!40000 ALTER TABLE `phone_notifies` DISABLE KEYS */;
/*!40000 ALTER TABLE `phone_notifies` ENABLE KEYS */;

-- Dumping structure for table essential.phone_reminders
CREATE TABLE IF NOT EXISTS `phone_reminders` (
  `id` int(11) DEFAULT NULL,
  `owner` varchar(46) DEFAULT NULL,
  `header` varchar(50) DEFAULT NULL,
  `note` varchar(50) DEFAULT NULL,
  `date` varchar(50) DEFAULT NULL,
  `time` varchar(50) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Dumping data for table essential.phone_reminders: ~0 rows (approximately)
/*!40000 ALTER TABLE `phone_reminders` DISABLE KEYS */;
/*!40000 ALTER TABLE `phone_reminders` ENABLE KEYS */;

-- Dumping structure for table essential.phone_users_contacts
CREATE TABLE IF NOT EXISTS `phone_users_contacts` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `identifier` varchar(60) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL,
  `number` varchar(10) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL,
  `display` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT '-1',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=MyISAM AUTO_INCREMENT=92 DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci ROW_FORMAT=DYNAMIC;

-- Dumping data for table essential.phone_users_contacts: 3 rows
/*!40000 ALTER TABLE `phone_users_contacts` DISABLE KEYS */;
INSERT INTO `phone_users_contacts` (`id`, `identifier`, `number`, `display`) VALUES
	(89, 'steam:11000014a890703', '0939846965', 'saman');
INSERT INTO `phone_users_contacts` (`id`, `identifier`, `number`, `display`) VALUES
	(90, 'steam:110000131ef6384', '0939475989', 'arad');
INSERT INTO `phone_users_contacts` (`id`, `identifier`, `number`, `display`) VALUES
	(91, 'steam:11000013f2c89a2', '0939746429', 'mobin');
/*!40000 ALTER TABLE `phone_users_contacts` ENABLE KEYS */;

-- Dumping structure for table essential.player_contacts
CREATE TABLE IF NOT EXISTS `player_contacts` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `identifier` varchar(50) DEFAULT NULL,
  `name` varchar(50) DEFAULT NULL,
  `number` varchar(50) DEFAULT NULL,
  `iban` varchar(50) NOT NULL DEFAULT '0',
  `display` varchar(50) DEFAULT NULL,
  `note` text NOT NULL,
  `pp` text NOT NULL,
  `isBlocked` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  KEY `identifier` (`identifier`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=39 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Dumping data for table essential.player_contacts: ~0 rows (approximately)
/*!40000 ALTER TABLE `player_contacts` DISABLE KEYS */;
INSERT INTO `player_contacts` (`id`, `identifier`, `name`, `number`, `iban`, `display`, `note`, `pp`, `isBlocked`) VALUES
	(38, '553348962', 'Mehrbod Tighe', '8573284445\n', '0', NULL, '', './img/app_details/default.png', NULL);
/*!40000 ALTER TABLE `player_contacts` ENABLE KEYS */;

-- Dumping structure for table essential.player_gallery
CREATE TABLE IF NOT EXISTS `player_gallery` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `identifier` text NOT NULL,
  `resim` text NOT NULL,
  `data` text NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Dumping data for table essential.player_gallery: ~0 rows (approximately)
/*!40000 ALTER TABLE `player_gallery` DISABLE KEYS */;
/*!40000 ALTER TABLE `player_gallery` ENABLE KEYS */;

-- Dumping structure for table essential.player_mails
CREATE TABLE IF NOT EXISTS `player_mails` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `identifier` varchar(50) DEFAULT NULL,
  `sender` varchar(50) DEFAULT NULL,
  `subject` varchar(50) DEFAULT NULL,
  `message` text DEFAULT NULL,
  `read` tinyint(4) DEFAULT NULL,
  `mailid` int(11) DEFAULT NULL,
  `date` timestamp NULL DEFAULT current_timestamp(),
  `button` text DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  KEY `identifier` (`identifier`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Dumping data for table essential.player_mails: ~0 rows (approximately)
/*!40000 ALTER TABLE `player_mails` DISABLE KEYS */;
/*!40000 ALTER TABLE `player_mails` ENABLE KEYS */;

-- Dumping structure for table essential.player_notes
CREATE TABLE IF NOT EXISTS `player_notes` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `identifier` text NOT NULL,
  `baslik` text NOT NULL,
  `aciklama` text NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Dumping data for table essential.player_notes: ~0 rows (approximately)
/*!40000 ALTER TABLE `player_notes` DISABLE KEYS */;
INSERT INTO `player_notes` (`id`, `identifier`, `baslik`, `aciklama`) VALUES
	(1, 'steam:1100001440a9ff9', 'test', 'Descriadadadaption...');
/*!40000 ALTER TABLE `player_notes` ENABLE KEYS */;

-- Dumping structure for table essential.properties
CREATE TABLE IF NOT EXISTS `properties` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) DEFAULT NULL,
  `label` varchar(255) DEFAULT NULL,
  `entering` varchar(255) DEFAULT NULL,
  `exit` varchar(255) DEFAULT NULL,
  `inside` varchar(255) DEFAULT NULL,
  `outside` varchar(255) DEFAULT NULL,
  `ipls` varchar(255) DEFAULT '[]',
  `gateway` varchar(255) DEFAULT NULL,
  `is_single` int(11) DEFAULT NULL,
  `is_room` int(11) DEFAULT NULL,
  `is_gateway` int(11) DEFAULT NULL,
  `room_menu` varchar(255) DEFAULT NULL,
  `price` int(11) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=43 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Dumping data for table essential.properties: ~42 rows (approximately)
/*!40000 ALTER TABLE `properties` DISABLE KEYS */;
INSERT INTO `properties` (`id`, `name`, `label`, `entering`, `exit`, `inside`, `outside`, `ipls`, `gateway`, `is_single`, `is_room`, `is_gateway`, `room_menu`, `price`) VALUES
	(1, 'WhispymoundDrive', '2677 Whispymound Drive', '{"y":564.89,"z":182.959,"x":119.384}', '{"x":117.347,"y":559.506,"z":183.304}', '{"y":557.032,"z":183.301,"x":118.037}', '{"y":567.798,"z":182.131,"x":119.249}', '[]', NULL, 1, 1, 0, '{"x":118.748,"y":566.573,"z":175.697}', 1500000);
INSERT INTO `properties` (`id`, `name`, `label`, `entering`, `exit`, `inside`, `outside`, `ipls`, `gateway`, `is_single`, `is_room`, `is_gateway`, `room_menu`, `price`) VALUES
	(2, 'NorthConkerAvenue2045', '2045 North Conker Avenue', '{"x":372.796,"y":428.327,"z":144.685}', '{"x":373.548,"y":422.982,"z":144.907},', '{"y":420.075,"z":145.904,"x":372.161}', '{"x":372.454,"y":432.886,"z":143.443}', '[]', NULL, 1, 1, 0, '{"x":377.349,"y":429.422,"z":137.3}', 1500000);
INSERT INTO `properties` (`id`, `name`, `label`, `entering`, `exit`, `inside`, `outside`, `ipls`, `gateway`, `is_single`, `is_room`, `is_gateway`, `room_menu`, `price`) VALUES
	(3, 'RichardMajesticApt2', 'Richard Majestic, Apt 2', '{"y":-379.165,"z":37.961,"x":-936.363}', '{"y":-365.476,"z":113.274,"x":-913.097}', '{"y":-367.637,"z":113.274,"x":-918.022}', '{"y":-382.023,"z":37.961,"x":-943.626}', '[]', NULL, 1, 1, 0, '{"x":-927.554,"y":-377.744,"z":112.674}', 1700000);
INSERT INTO `properties` (`id`, `name`, `label`, `entering`, `exit`, `inside`, `outside`, `ipls`, `gateway`, `is_single`, `is_room`, `is_gateway`, `room_menu`, `price`) VALUES
	(4, 'NorthConkerAvenue2044', '2044 North Conker Avenue', '{"y":440.8,"z":146.702,"x":346.964}', '{"y":437.456,"z":148.394,"x":341.683}', '{"y":435.626,"z":148.394,"x":339.595}', '{"x":350.535,"y":443.329,"z":145.764}', '[]', NULL, 1, 1, 0, '{"x":337.726,"y":436.985,"z":140.77}', 1500000);
INSERT INTO `properties` (`id`, `name`, `label`, `entering`, `exit`, `inside`, `outside`, `ipls`, `gateway`, `is_single`, `is_room`, `is_gateway`, `room_menu`, `price`) VALUES
	(5, 'WildOatsDrive', '3655 Wild Oats Drive', '{"y":502.696,"z":136.421,"x":-176.003}', '{"y":497.817,"z":136.653,"x":-174.349}', '{"y":495.069,"z":136.666,"x":-173.331}', '{"y":506.412,"z":135.0664,"x":-177.927}', '[]', NULL, 1, 1, 0, '{"x":-174.725,"y":493.095,"z":129.043}', 1500000);
INSERT INTO `properties` (`id`, `name`, `label`, `entering`, `exit`, `inside`, `outside`, `ipls`, `gateway`, `is_single`, `is_room`, `is_gateway`, `room_menu`, `price`) VALUES
	(6, 'HillcrestAvenue2862', '2862 Hillcrest Avenue', '{"y":596.58,"z":142.641,"x":-686.554}', '{"y":591.988,"z":144.392,"x":-681.728}', '{"y":590.608,"z":144.392,"x":-680.124}', '{"y":599.019,"z":142.059,"x":-689.492}', '[]', NULL, 1, 1, 0, '{"x":-680.46,"y":588.6,"z":136.769}', 1500000);
INSERT INTO `properties` (`id`, `name`, `label`, `entering`, `exit`, `inside`, `outside`, `ipls`, `gateway`, `is_single`, `is_room`, `is_gateway`, `room_menu`, `price`) VALUES
	(7, 'LowEndApartment', 'Appartement de base', '{"y":-1078.735,"z":28.4031,"x":292.528}', '{"y":-1007.152,"z":-102.002,"x":265.845}', '{"y":-1002.802,"z":-100.008,"x":265.307}', '{"y":-1078.669,"z":28.401,"x":296.738}', '[]', NULL, 1, 1, 0, '{"x":265.916,"y":-999.38,"z":-100.008}', 562500);
INSERT INTO `properties` (`id`, `name`, `label`, `entering`, `exit`, `inside`, `outside`, `ipls`, `gateway`, `is_single`, `is_room`, `is_gateway`, `room_menu`, `price`) VALUES
	(8, 'MadWayneThunder', '2113 Mad Wayne Thunder', '{"y":454.955,"z":96.462,"x":-1294.433}', '{"x":-1289.917,"y":449.541,"z":96.902}', '{"y":446.322,"z":96.899,"x":-1289.642}', '{"y":455.453,"z":96.517,"x":-1298.851}', '[]', NULL, 1, 1, 0, '{"x":-1287.306,"y":455.901,"z":89.294}', 1500000);
INSERT INTO `properties` (`id`, `name`, `label`, `entering`, `exit`, `inside`, `outside`, `ipls`, `gateway`, `is_single`, `is_room`, `is_gateway`, `room_menu`, `price`) VALUES
	(9, 'HillcrestAvenue2874', '2874 Hillcrest Avenue', '{"x":-853.346,"y":696.678,"z":147.782}', '{"y":690.875,"z":151.86,"x":-859.961}', '{"y":688.361,"z":151.857,"x":-859.395}', '{"y":701.628,"z":147.773,"x":-855.007}', '[]', NULL, 1, 1, 0, '{"x":-858.543,"y":697.514,"z":144.253}', 1500000);
INSERT INTO `properties` (`id`, `name`, `label`, `entering`, `exit`, `inside`, `outside`, `ipls`, `gateway`, `is_single`, `is_room`, `is_gateway`, `room_menu`, `price`) VALUES
	(10, 'HillcrestAvenue2868', '2868 Hillcrest Avenue', '{"y":620.494,"z":141.588,"x":-752.82}', '{"y":618.62,"z":143.153,"x":-759.317}', '{"y":617.629,"z":143.153,"x":-760.789}', '{"y":621.281,"z":141.254,"x":-750.919}', '[]', NULL, 1, 1, 0, '{"x":-762.504,"y":618.992,"z":135.53}', 1500000);
INSERT INTO `properties` (`id`, `name`, `label`, `entering`, `exit`, `inside`, `outside`, `ipls`, `gateway`, `is_single`, `is_room`, `is_gateway`, `room_menu`, `price`) VALUES
	(11, 'TinselTowersApt12', 'Tinsel Towers, Apt 42', '{"y":37.025,"z":42.58,"x":-618.299}', '{"y":58.898,"z":97.2,"x":-603.301}', '{"y":58.941,"z":97.2,"x":-608.741}', '{"y":30.603,"z":42.524,"x":-620.017}', '[]', NULL, 1, 1, 0, '{"x":-622.173,"y":54.585,"z":96.599}', 1700000);
INSERT INTO `properties` (`id`, `name`, `label`, `entering`, `exit`, `inside`, `outside`, `ipls`, `gateway`, `is_single`, `is_room`, `is_gateway`, `room_menu`, `price`) VALUES
	(12, 'MiltonDrive', 'Milton Drive', '{"x":-775.17,"y":312.01,"z":84.658}', NULL, NULL, '{"x":-775.346,"y":306.776,"z":84.7}', '[]', NULL, 0, 0, 1, NULL, 0);
INSERT INTO `properties` (`id`, `name`, `label`, `entering`, `exit`, `inside`, `outside`, `ipls`, `gateway`, `is_single`, `is_room`, `is_gateway`, `room_menu`, `price`) VALUES
	(13, 'Modern1Apartment', 'Appartement Moderne 1', NULL, '{"x":-784.194,"y":323.636,"z":210.997}', '{"x":-779.751,"y":323.385,"z":210.997}', NULL, '["apa_v_mp_h_01_a"]', 'MiltonDrive', 0, 1, 0, '{"x":-766.661,"y":327.672,"z":210.396}', 1300000);
INSERT INTO `properties` (`id`, `name`, `label`, `entering`, `exit`, `inside`, `outside`, `ipls`, `gateway`, `is_single`, `is_room`, `is_gateway`, `room_menu`, `price`) VALUES
	(14, 'Modern2Apartment', 'Appartement Moderne 2', NULL, '{"x":-786.8663,"y":315.764,"z":186.913}', '{"x":-781.808,"y":315.866,"z":186.913}', NULL, '["apa_v_mp_h_01_c"]', 'MiltonDrive', 0, 1, 0, '{"x":-795.735,"y":326.757,"z":186.313}', 1300000);
INSERT INTO `properties` (`id`, `name`, `label`, `entering`, `exit`, `inside`, `outside`, `ipls`, `gateway`, `is_single`, `is_room`, `is_gateway`, `room_menu`, `price`) VALUES
	(15, 'Modern3Apartment', 'Appartement Moderne 3', NULL, '{"x":-774.012,"y":342.042,"z":195.686}', '{"x":-779.057,"y":342.063,"z":195.686}', NULL, '["apa_v_mp_h_01_b"]', 'MiltonDrive', 0, 1, 0, '{"x":-765.386,"y":330.782,"z":195.08}', 1300000);
INSERT INTO `properties` (`id`, `name`, `label`, `entering`, `exit`, `inside`, `outside`, `ipls`, `gateway`, `is_single`, `is_room`, `is_gateway`, `room_menu`, `price`) VALUES
	(16, 'Mody1Apartment', 'Appartement Mode 1', NULL, '{"x":-784.194,"y":323.636,"z":210.997}', '{"x":-779.751,"y":323.385,"z":210.997}', NULL, '["apa_v_mp_h_02_a"]', 'MiltonDrive', 0, 1, 0, '{"x":-766.615,"y":327.878,"z":210.396}', 1300000);
INSERT INTO `properties` (`id`, `name`, `label`, `entering`, `exit`, `inside`, `outside`, `ipls`, `gateway`, `is_single`, `is_room`, `is_gateway`, `room_menu`, `price`) VALUES
	(17, 'Mody2Apartment', 'Appartement Mode 2', NULL, '{"x":-786.8663,"y":315.764,"z":186.913}', '{"x":-781.808,"y":315.866,"z":186.913}', NULL, '["apa_v_mp_h_02_c"]', 'MiltonDrive', 0, 1, 0, '{"x":-795.297,"y":327.092,"z":186.313}', 1300000);
INSERT INTO `properties` (`id`, `name`, `label`, `entering`, `exit`, `inside`, `outside`, `ipls`, `gateway`, `is_single`, `is_room`, `is_gateway`, `room_menu`, `price`) VALUES
	(18, 'Mody3Apartment', 'Appartement Mode 3', NULL, '{"x":-774.012,"y":342.042,"z":195.686}', '{"x":-779.057,"y":342.063,"z":195.686}', NULL, '["apa_v_mp_h_02_b"]', 'MiltonDrive', 0, 1, 0, '{"x":-765.303,"y":330.932,"z":195.085}', 1300000);
INSERT INTO `properties` (`id`, `name`, `label`, `entering`, `exit`, `inside`, `outside`, `ipls`, `gateway`, `is_single`, `is_room`, `is_gateway`, `room_menu`, `price`) VALUES
	(19, 'Vibrant1Apartment', 'Appartement Vibrant 1', NULL, '{"x":-784.194,"y":323.636,"z":210.997}', '{"x":-779.751,"y":323.385,"z":210.997}', NULL, '["apa_v_mp_h_03_a"]', 'MiltonDrive', 0, 1, 0, '{"x":-765.885,"y":327.641,"z":210.396}', 1300000);
INSERT INTO `properties` (`id`, `name`, `label`, `entering`, `exit`, `inside`, `outside`, `ipls`, `gateway`, `is_single`, `is_room`, `is_gateway`, `room_menu`, `price`) VALUES
	(20, 'Vibrant2Apartment', 'Appartement Vibrant 2', NULL, '{"x":-786.8663,"y":315.764,"z":186.913}', '{"x":-781.808,"y":315.866,"z":186.913}', NULL, '["apa_v_mp_h_03_c"]', 'MiltonDrive', 0, 1, 0, '{"x":-795.607,"y":327.344,"z":186.313}', 1300000);
INSERT INTO `properties` (`id`, `name`, `label`, `entering`, `exit`, `inside`, `outside`, `ipls`, `gateway`, `is_single`, `is_room`, `is_gateway`, `room_menu`, `price`) VALUES
	(21, 'Vibrant3Apartment', 'Appartement Vibrant 3', NULL, '{"x":-774.012,"y":342.042,"z":195.686}', '{"x":-779.057,"y":342.063,"z":195.686}', NULL, '["apa_v_mp_h_03_b"]', 'MiltonDrive', 0, 1, 0, '{"x":-765.525,"y":330.851,"z":195.085}', 1300000);
INSERT INTO `properties` (`id`, `name`, `label`, `entering`, `exit`, `inside`, `outside`, `ipls`, `gateway`, `is_single`, `is_room`, `is_gateway`, `room_menu`, `price`) VALUES
	(22, 'Sharp1Apartment', 'Appartement Persan 1', NULL, '{"x":-784.194,"y":323.636,"z":210.997}', '{"x":-779.751,"y":323.385,"z":210.997}', NULL, '["apa_v_mp_h_04_a"]', 'MiltonDrive', 0, 1, 0, '{"x":-766.527,"y":327.89,"z":210.396}', 1300000);
INSERT INTO `properties` (`id`, `name`, `label`, `entering`, `exit`, `inside`, `outside`, `ipls`, `gateway`, `is_single`, `is_room`, `is_gateway`, `room_menu`, `price`) VALUES
	(23, 'Sharp2Apartment', 'Appartement Persan 2', NULL, '{"x":-786.8663,"y":315.764,"z":186.913}', '{"x":-781.808,"y":315.866,"z":186.913}', NULL, '["apa_v_mp_h_04_c"]', 'MiltonDrive', 0, 1, 0, '{"x":-795.642,"y":326.497,"z":186.313}', 1300000);
INSERT INTO `properties` (`id`, `name`, `label`, `entering`, `exit`, `inside`, `outside`, `ipls`, `gateway`, `is_single`, `is_room`, `is_gateway`, `room_menu`, `price`) VALUES
	(24, 'Sharp3Apartment', 'Appartement Persan 3', NULL, '{"x":-774.012,"y":342.042,"z":195.686}', '{"x":-779.057,"y":342.063,"z":195.686}', NULL, '["apa_v_mp_h_04_b"]', 'MiltonDrive', 0, 1, 0, '{"x":-765.503,"y":331.318,"z":195.085}', 1300000);
INSERT INTO `properties` (`id`, `name`, `label`, `entering`, `exit`, `inside`, `outside`, `ipls`, `gateway`, `is_single`, `is_room`, `is_gateway`, `room_menu`, `price`) VALUES
	(25, 'Monochrome1Apartment', 'Appartement Monochrome 1', NULL, '{"x":-784.194,"y":323.636,"z":210.997}', '{"x":-779.751,"y":323.385,"z":210.997}', NULL, '["apa_v_mp_h_05_a"]', 'MiltonDrive', 0, 1, 0, '{"x":-766.289,"y":328.086,"z":210.396}', 1300000);
INSERT INTO `properties` (`id`, `name`, `label`, `entering`, `exit`, `inside`, `outside`, `ipls`, `gateway`, `is_single`, `is_room`, `is_gateway`, `room_menu`, `price`) VALUES
	(26, 'Monochrome2Apartment', 'Appartement Monochrome 2', NULL, '{"x":-786.8663,"y":315.764,"z":186.913}', '{"x":-781.808,"y":315.866,"z":186.913}', NULL, '["apa_v_mp_h_05_c"]', 'MiltonDrive', 0, 1, 0, '{"x":-795.692,"y":326.762,"z":186.313}', 1300000);
INSERT INTO `properties` (`id`, `name`, `label`, `entering`, `exit`, `inside`, `outside`, `ipls`, `gateway`, `is_single`, `is_room`, `is_gateway`, `room_menu`, `price`) VALUES
	(27, 'Monochrome3Apartment', 'Appartement Monochrome 3', NULL, '{"x":-774.012,"y":342.042,"z":195.686}', '{"x":-779.057,"y":342.063,"z":195.686}', NULL, '["apa_v_mp_h_05_b"]', 'MiltonDrive', 0, 1, 0, '{"x":-765.094,"y":330.976,"z":195.085}', 1300000);
INSERT INTO `properties` (`id`, `name`, `label`, `entering`, `exit`, `inside`, `outside`, `ipls`, `gateway`, `is_single`, `is_room`, `is_gateway`, `room_menu`, `price`) VALUES
	(28, 'Seductive1Apartment', 'Appartement SÃÂÃÂÃÂÃÂ©duisant 1', NULL, '{"x":-784.194,"y":323.636,"z":210.997}', '{"x":-779.751,"y":323.385,"z":210.997}', NULL, '["apa_v_mp_h_06_a"]', 'MiltonDrive', 0, 1, 0, '{"x":-766.263,"y":328.104,"z":210.396}', 1300000);
INSERT INTO `properties` (`id`, `name`, `label`, `entering`, `exit`, `inside`, `outside`, `ipls`, `gateway`, `is_single`, `is_room`, `is_gateway`, `room_menu`, `price`) VALUES
	(29, 'Seductive2Apartment', 'Appartement SÃÂÃÂÃÂÃÂ©duisant 2', NULL, '{"x":-786.8663,"y":315.764,"z":186.913}', '{"x":-781.808,"y":315.866,"z":186.913}', NULL, '["apa_v_mp_h_06_c"]', 'MiltonDrive', 0, 1, 0, '{"x":-795.655,"y":326.611,"z":186.313}', 1300000);
INSERT INTO `properties` (`id`, `name`, `label`, `entering`, `exit`, `inside`, `outside`, `ipls`, `gateway`, `is_single`, `is_room`, `is_gateway`, `room_menu`, `price`) VALUES
	(30, 'Seductive3Apartment', 'Appartement SÃÂÃÂÃÂÃÂ©duisant 3', NULL, '{"x":-774.012,"y":342.042,"z":195.686}', '{"x":-779.057,"y":342.063,"z":195.686}', NULL, '["apa_v_mp_h_06_b"]', 'MiltonDrive', 0, 1, 0, '{"x":-765.3,"y":331.414,"z":195.085}', 1300000);
INSERT INTO `properties` (`id`, `name`, `label`, `entering`, `exit`, `inside`, `outside`, `ipls`, `gateway`, `is_single`, `is_room`, `is_gateway`, `room_menu`, `price`) VALUES
	(31, 'Regal1Apartment', 'Appartement RÃÂÃÂÃÂÃÂ©gal 1', NULL, '{"x":-784.194,"y":323.636,"z":210.997}', '{"x":-779.751,"y":323.385,"z":210.997}', NULL, '["apa_v_mp_h_07_a"]', 'MiltonDrive', 0, 1, 0, '{"x":-765.956,"y":328.257,"z":210.396}', 1300000);
INSERT INTO `properties` (`id`, `name`, `label`, `entering`, `exit`, `inside`, `outside`, `ipls`, `gateway`, `is_single`, `is_room`, `is_gateway`, `room_menu`, `price`) VALUES
	(32, 'Regal2Apartment', 'Appartement RÃÂÃÂÃÂÃÂ©gal 2', NULL, '{"x":-786.8663,"y":315.764,"z":186.913}', '{"x":-781.808,"y":315.866,"z":186.913}', NULL, '["apa_v_mp_h_07_c"]', 'MiltonDrive', 0, 1, 0, '{"x":-795.545,"y":326.659,"z":186.313}', 1300000);
INSERT INTO `properties` (`id`, `name`, `label`, `entering`, `exit`, `inside`, `outside`, `ipls`, `gateway`, `is_single`, `is_room`, `is_gateway`, `room_menu`, `price`) VALUES
	(33, 'Regal3Apartment', 'Appartement RÃÂÃÂÃÂÃÂ©gal 3', NULL, '{"x":-774.012,"y":342.042,"z":195.686}', '{"x":-779.057,"y":342.063,"z":195.686}', NULL, '["apa_v_mp_h_07_b"]', 'MiltonDrive', 0, 1, 0, '{"x":-765.087,"y":331.429,"z":195.123}', 1300000);
INSERT INTO `properties` (`id`, `name`, `label`, `entering`, `exit`, `inside`, `outside`, `ipls`, `gateway`, `is_single`, `is_room`, `is_gateway`, `room_menu`, `price`) VALUES
	(34, 'Aqua1Apartment', 'Appartement Aqua 1', NULL, '{"x":-784.194,"y":323.636,"z":210.997}', '{"x":-779.751,"y":323.385,"z":210.997}', NULL, '["apa_v_mp_h_08_a"]', 'MiltonDrive', 0, 1, 0, '{"x":-766.187,"y":328.47,"z":210.396}', 1300000);
INSERT INTO `properties` (`id`, `name`, `label`, `entering`, `exit`, `inside`, `outside`, `ipls`, `gateway`, `is_single`, `is_room`, `is_gateway`, `room_menu`, `price`) VALUES
	(35, 'Aqua2Apartment', 'Appartement Aqua 2', NULL, '{"x":-786.8663,"y":315.764,"z":186.913}', '{"x":-781.808,"y":315.866,"z":186.913}', NULL, '["apa_v_mp_h_08_c"]', 'MiltonDrive', 0, 1, 0, '{"x":-795.658,"y":326.563,"z":186.313}', 1300000);
INSERT INTO `properties` (`id`, `name`, `label`, `entering`, `exit`, `inside`, `outside`, `ipls`, `gateway`, `is_single`, `is_room`, `is_gateway`, `room_menu`, `price`) VALUES
	(36, 'Aqua3Apartment', 'Appartement Aqua 3', NULL, '{"x":-774.012,"y":342.042,"z":195.686}', '{"x":-779.057,"y":342.063,"z":195.686}', NULL, '["apa_v_mp_h_08_b"]', 'MiltonDrive', 0, 1, 0, '{"x":-765.287,"y":331.084,"z":195.086}', 1300000);
INSERT INTO `properties` (`id`, `name`, `label`, `entering`, `exit`, `inside`, `outside`, `ipls`, `gateway`, `is_single`, `is_room`, `is_gateway`, `room_menu`, `price`) VALUES
	(37, 'IntegrityWay', '4 Integrity Way', '{"x":-47.804,"y":-585.867,"z":36.956}', NULL, NULL, '{"x":-54.178,"y":-583.762,"z":35.798}', '[]', NULL, 0, 0, 1, NULL, 0);
INSERT INTO `properties` (`id`, `name`, `label`, `entering`, `exit`, `inside`, `outside`, `ipls`, `gateway`, `is_single`, `is_room`, `is_gateway`, `room_menu`, `price`) VALUES
	(38, 'IntegrityWay28', '4 Integrity Way - Apt 28', NULL, '{"x":-31.409,"y":-594.927,"z":79.03}', '{"x":-26.098,"y":-596.909,"z":79.03}', NULL, '[]', 'IntegrityWay', 0, 1, 0, '{"x":-11.923,"y":-597.083,"z":78.43}', 1700000);
INSERT INTO `properties` (`id`, `name`, `label`, `entering`, `exit`, `inside`, `outside`, `ipls`, `gateway`, `is_single`, `is_room`, `is_gateway`, `room_menu`, `price`) VALUES
	(39, 'IntegrityWay30', '4 Integrity Way - Apt 30', NULL, '{"x":-17.702,"y":-588.524,"z":89.114}', '{"x":-16.21,"y":-582.569,"z":89.114}', NULL, '[]', 'IntegrityWay', 0, 1, 0, '{"x":-26.327,"y":-588.384,"z":89.123}', 1700000);
INSERT INTO `properties` (`id`, `name`, `label`, `entering`, `exit`, `inside`, `outside`, `ipls`, `gateway`, `is_single`, `is_room`, `is_gateway`, `room_menu`, `price`) VALUES
	(40, 'DellPerroHeights', 'Dell Perro Heights', '{"x":-1447.06,"y":-538.28,"z":33.74}', NULL, NULL, '{"x":-1440.022,"y":-548.696,"z":33.74}', '[]', NULL, 0, 0, 1, NULL, 0);
INSERT INTO `properties` (`id`, `name`, `label`, `entering`, `exit`, `inside`, `outside`, `ipls`, `gateway`, `is_single`, `is_room`, `is_gateway`, `room_menu`, `price`) VALUES
	(41, 'DellPerroHeightst4', 'Dell Perro Heights - Apt 28', NULL, '{"x":-1452.125,"y":-540.591,"z":73.044}', '{"x":-1455.435,"y":-535.79,"z":73.044}', NULL, '[]', 'DellPerroHeights', 0, 1, 0, '{"x":-1467.058,"y":-527.571,"z":72.443}', 1700000);
INSERT INTO `properties` (`id`, `name`, `label`, `entering`, `exit`, `inside`, `outside`, `ipls`, `gateway`, `is_single`, `is_room`, `is_gateway`, `room_menu`, `price`) VALUES
	(42, 'DellPerroHeightst7', 'Dell Perro Heights - Apt 30', NULL, '{"x":-1451.562,"y":-523.535,"z":55.928}', '{"x":-1456.02,"y":-519.209,"z":55.929}', NULL, '[]', 'DellPerroHeights', 0, 1, 0, '{"x":-1457.026,"y":-530.219,"z":55.937}', 1700000);
/*!40000 ALTER TABLE `properties` ENABLE KEYS */;

-- Dumping structure for table essential.redeemcode
CREATE TABLE IF NOT EXISTS `redeemcode` (
  `code` varchar(50) DEFAULT NULL,
  `money` int(11) DEFAULT 0,
  `bank` int(11) DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Dumping data for table essential.redeemcode: ~0 rows (approximately)
/*!40000 ALTER TABLE `redeemcode` DISABLE KEYS */;
INSERT INTO `redeemcode` (`code`, `money`, `bank`) VALUES
	('S56ASD4', 50000, 25000);
/*!40000 ALTER TABLE `redeemcode` ENABLE KEYS */;

-- Dumping structure for table essential.redeemcode_users
CREATE TABLE IF NOT EXISTS `redeemcode_users` (
  `identifier` varchar(50) DEFAULT NULL,
  `redeemcode` varchar(50) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Dumping data for table essential.redeemcode_users: ~0 rows (approximately)
/*!40000 ALTER TABLE `redeemcode_users` DISABLE KEYS */;
/*!40000 ALTER TABLE `redeemcode_users` ENABLE KEYS */;

-- Dumping structure for table essential.rented_vehicles
CREATE TABLE IF NOT EXISTS `rented_vehicles` (
  `vehicle` varchar(60) NOT NULL,
  `plate` varchar(12) NOT NULL,
  `player_name` varchar(255) NOT NULL,
  `base_price` int(11) NOT NULL,
  `rent_price` int(11) NOT NULL,
  `owner` varchar(22) NOT NULL,
  PRIMARY KEY (`plate`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_persian_ci ROW_FORMAT=DYNAMIC;

-- Dumping data for table essential.rented_vehicles: ~0 rows (approximately)
/*!40000 ALTER TABLE `rented_vehicles` DISABLE KEYS */;
/*!40000 ALTER TABLE `rented_vehicles` ENABLE KEYS */;

-- Dumping structure for table essential.reports
CREATE TABLE IF NOT EXISTS `reports` (
  `identifier` varchar(50) NOT NULL,
  `count` int(5) DEFAULT NULL,
  PRIMARY KEY (`identifier`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Dumping data for table essential.reports: ~4 rows (approximately)
/*!40000 ALTER TABLE `reports` DISABLE KEYS */;
INSERT INTO `reports` (`identifier`, `count`) VALUES
	('steam:11000011bf03921', 1);
INSERT INTO `reports` (`identifier`, `count`) VALUES
	('steam:1100001341c207b', 1);
INSERT INTO `reports` (`identifier`, `count`) VALUES
	('steam:110000144c6a3b8', 1);
INSERT INTO `reports` (`identifier`, `count`) VALUES
	('steam:1100001452540bf', 1);
/*!40000 ALTER TABLE `reports` ENABLE KEYS */;

-- Dumping structure for table essential.shipments
CREATE TABLE IF NOT EXISTS `shipments` (
  `id` int(11) DEFAULT NULL,
  `identifier` varchar(50) DEFAULT NULL,
  `label` varchar(50) DEFAULT NULL,
  `item` varchar(50) DEFAULT NULL,
  `price` varchar(50) DEFAULT NULL,
  `count` varchar(50) DEFAULT NULL,
  `time` int(20) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci ROW_FORMAT=DYNAMIC;

-- Dumping data for table essential.shipments: ~0 rows (approximately)
/*!40000 ALTER TABLE `shipments` DISABLE KEYS */;
/*!40000 ALTER TABLE `shipments` ENABLE KEYS */;

-- Dumping structure for table essential.shops2
CREATE TABLE IF NOT EXISTS `shops2` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `store` varchar(100) NOT NULL,
  `item` varchar(100) NOT NULL,
  `price` int(11) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Dumping data for table essential.shops2: ~8 rows (approximately)
/*!40000 ALTER TABLE `shops2` DISABLE KEYS */;
INSERT INTO `shops2` (`id`, `store`, `item`, `price`) VALUES
	(1, 'narekshop', 'yusuf', 50000);
INSERT INTO `shops2` (`id`, `store`, `item`, `price`) VALUES
	(2, 'narekshop', 'grip', 20000);
INSERT INTO `shops2` (`id`, `store`, `item`, `price`) VALUES
	(3, 'narekshop', 'flashlight', 15000);
INSERT INTO `shops2` (`id`, `store`, `item`, `price`) VALUES
	(4, 'narekshop', 'silencer', 80000);
INSERT INTO `shops2` (`id`, `store`, `item`, `price`) VALUES
	(5, 'narekshop', 'clip', 5000);
INSERT INTO `shops2` (`id`, `store`, `item`, `price`) VALUES
	(6, 'narekshop', 'net_cracker', 500000);
INSERT INTO `shops2` (`id`, `store`, `item`, `price`) VALUES
	(7, 'narekshop', 'thermite', 200000);
INSERT INTO `shops2` (`id`, `store`, `item`, `price`) VALUES
	(8, 'narekshop', 'blowtorch', 280000);
/*!40000 ALTER TABLE `shops2` ENABLE KEYS */;

-- Dumping structure for table essential.stashs
CREATE TABLE IF NOT EXISTS `stashs` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `stash` varchar(255) NOT NULL DEFAULT '[]',
  `inventory` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL,
  PRIMARY KEY (`stash`),
  KEY `id` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=27 DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

-- Dumping data for table essential.stashs: ~8 rows (approximately)
/*!40000 ALTER TABLE `stashs` DISABLE KEYS */;
INSERT INTO `stashs` (`id`, `stash`, `inventory`) VALUES
	(1, 'stash-bag_10461Bg104613', '[{"slot":1,"weight":0.01,"name":"5.56mm","info":[],"count":101},{"slot":2,"weight":10,"name":"weapon_smg","info":{"components":[],"extras":{"license":"No License"},"ammo":0,"tint":false},"count":1},{"slot":3,"weight":1,"name":"phone","info":[],"count":1},{"slot":4,"weight":1,"name":"phone","info":[],"count":1}]');
INSERT INTO `stashs` (`id`, `stash`, `inventory`) VALUES
	(5, 'stash-bag_62622NG626223', '[{"info":{"tint":false,"components":[],"extras":{"license":"No License"},"ammo":0},"name":"weapon_smg","slot":1,"count":1,"weight":10}]');
INSERT INTO `stashs` (`id`, `stash`, `inventory`) VALUES
	(15, 'stash-Balcao', '[]');
INSERT INTO `stashs` (`id`, `stash`, `inventory`) VALUES
	(17, 'stash-frigorificouwu', '[]');
INSERT INTO `stashs` (`id`, `stash`, `inventory`) VALUES
	(8, 'stash-police', '[]');
INSERT INTO `stashs` (`id`, `stash`, `inventory`) VALUES
	(14, 'stash-steam:1100001452540bf', '[{"weight":1,"count":1,"slot":1,"name":"red_phone","info":[]}]');
INSERT INTO `stashs` (`id`, `stash`, `inventory`) VALUES
	(25, 'stash-Table_2_UwU_Cafe', '[]');
INSERT INTO `stashs` (`id`, `stash`, `inventory`) VALUES
	(23, 'stash-Table_4_UwU_Cafe', '[]');
/*!40000 ALTER TABLE `stashs` ENABLE KEYS */;

-- Dumping structure for table essential.tiktok_users
CREATE TABLE IF NOT EXISTS `tiktok_users` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `username` varchar(50) NOT NULL DEFAULT '0',
  `phone` varchar(50) NOT NULL DEFAULT '0',
  `pp` text DEFAULT NULL,
  `name` varchar(50) NOT NULL DEFAULT '0',
  `bio` text NOT NULL DEFAULT '',
  `birthday` varchar(50) NOT NULL DEFAULT '0',
  `videos` text NOT NULL DEFAULT '{}',
  `followers` text NOT NULL,
  `following` text NOT NULL,
  `liked` text NOT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  KEY `id` (`id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=14 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Dumping data for table essential.tiktok_users: ~0 rows (approximately)
/*!40000 ALTER TABLE `tiktok_users` DISABLE KEYS */;
INSERT INTO `tiktok_users` (`id`, `username`, `phone`, `pp`, `name`, `bio`, `birthday`, `videos`, `followers`, `following`, `liked`) VALUES
	(13, 'bist', '553419652', './img/app_details/default.png', 'sajad', '', '1999-01-01', '[]', '[]', '[]', '["553419652-440"]');
/*!40000 ALTER TABLE `tiktok_users` ENABLE KEYS */;

-- Dumping structure for table essential.tiktok_videos
CREATE TABLE IF NOT EXISTS `tiktok_videos` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `userID` int(11) DEFAULT NULL,
  `created` varchar(50) NOT NULL DEFAULT '00:00:00',
  `data` text DEFAULT NULL,
  `phone` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=441 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Dumping data for table essential.tiktok_videos: ~0 rows (approximately)
/*!40000 ALTER TABLE `tiktok_videos` DISABLE KEYS */;
INSERT INTO `tiktok_videos` (`id`, `userID`, `created`, `data`, `phone`) VALUES
	(440, 13, '2022-12-01 16:25:08', '{"url":"https://media.discordapp.net/attachments/1043854942127001630/1047924674132189214/video.webm","likeds":["553419652"],"comments":[],"owner":"553419652"}', '553419652');
/*!40000 ALTER TABLE `tiktok_videos` ENABLE KEYS */;

-- Dumping structure for table essential.tinder_accounts
CREATE TABLE IF NOT EXISTS `tinder_accounts` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `phone` varchar(50) NOT NULL DEFAULT '0',
  `pp` text NOT NULL,
  `name` varchar(50) NOT NULL DEFAULT '0',
  `gender` varchar(50) NOT NULL,
  `targetGender` varchar(50) NOT NULL DEFAULT '0',
  `hobbies` varchar(50) NOT NULL DEFAULT '0',
  `age` varchar(50) NOT NULL DEFAULT '0',
  `description` varchar(50) NOT NULL DEFAULT '0',
  `password` varchar(50) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=17 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Dumping data for table essential.tinder_accounts: ~0 rows (approximately)
/*!40000 ALTER TABLE `tinder_accounts` DISABLE KEYS */;
/*!40000 ALTER TABLE `tinder_accounts` ENABLE KEYS */;

-- Dumping structure for table essential.tinder_likes
CREATE TABLE IF NOT EXISTS `tinder_likes` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `phone` varchar(1024) NOT NULL,
  `likeds` mediumtext NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Dumping data for table essential.tinder_likes: ~0 rows (approximately)
/*!40000 ALTER TABLE `tinder_likes` DISABLE KEYS */;
/*!40000 ALTER TABLE `tinder_likes` ENABLE KEYS */;

-- Dumping structure for table essential.tinder_messages
CREATE TABLE IF NOT EXISTS `tinder_messages` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `phone` varchar(50) NOT NULL,
  `number` varchar(50) NOT NULL,
  `messages` varchar(1024) DEFAULT '{}',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Dumping data for table essential.tinder_messages: ~0 rows (approximately)
/*!40000 ALTER TABLE `tinder_messages` DISABLE KEYS */;
/*!40000 ALTER TABLE `tinder_messages` ENABLE KEYS */;

-- Dumping structure for table essential.trunk_inventory
CREATE TABLE IF NOT EXISTS `trunk_inventory` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `plate` varchar(8) NOT NULL,
  `data` text NOT NULL,
  `owned` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `plate` (`plate`)
) ENGINE=InnoDB AUTO_INCREMENT=4621 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Dumping data for table essential.trunk_inventory: ~408 rows (approximately)
/*!40000 ALTER TABLE `trunk_inventory` DISABLE KEYS */;
INSERT INTO `trunk_inventory` (`id`, `plate`, `data`, `owned`) VALUES
	(3424, 'QLA 3128', '{}', 1);
INSERT INTO `trunk_inventory` (`id`, `plate`, `data`, `owned`) VALUES
	(3432, 'NWX 3188', '{}', 1);
INSERT INTO `trunk_inventory` (`id`, `plate`, `data`, `owned`) VALUES
	(3452, 'YIT 7217', '{}', 1);
INSERT INTO `trunk_inventory` (`id`, `plate`, `data`, `owned`) VALUES
	(3453, 'TRY 2592', '{}', 1);
INSERT INTO `trunk_inventory` (`id`, `plate`, `data`, `owned`) VALUES
	(3459, 'RTP 3211', '{}', 1);
INSERT INTO `trunk_inventory` (`id`, `plate`, `data`, `owned`) VALUES
	(3462, 'TYW 9801', '{"coffre":[],"weapons":[{"ammo":239,"name":"WEAPON_PISTOL50","label":"Pistol .50"}]}', 1);
INSERT INTO `trunk_inventory` (`id`, `plate`, `data`, `owned`) VALUES
	(3467, 'PNX 4601', '{}', 1);
INSERT INTO `trunk_inventory` (`id`, `plate`, `data`, `owned`) VALUES
	(3471, 'YOS 9755', '{}', 1);
INSERT INTO `trunk_inventory` (`id`, `plate`, `data`, `owned`) VALUES
	(3475, 'EXU 1658', '{}', 1);
INSERT INTO `trunk_inventory` (`id`, `plate`, `data`, `owned`) VALUES
	(3480, 'MUT 0213', '{}', 1);
INSERT INTO `trunk_inventory` (`id`, `plate`, `data`, `owned`) VALUES
	(3481, 'PTV 4570', '{}', 1);
INSERT INTO `trunk_inventory` (`id`, `plate`, `data`, `owned`) VALUES
	(3489, 'SEPI2027', '{"weapons":[{"name":"WEAPON_PETROLCAN","ammo":4500,"label":"Jerrycan"},{"name":"WEAPON_PETROLCAN","ammo":4500,"label":"Jerrycan"}]}', 1);
INSERT INTO `trunk_inventory` (`id`, `plate`, `data`, `owned`) VALUES
	(3490, 'PVZ 0171', '{"weapons":[{"name":"WEAPON_PISTOL","ammo":0,"label":"Pistol"},{"name":"WEAPON_PETROLCAN","ammo":4500,"label":"Jerrycan"}]}', 1);
INSERT INTO `trunk_inventory` (`id`, `plate`, `data`, `owned`) VALUES
	(3497, 'FHC 5750', '{}', 1);
INSERT INTO `trunk_inventory` (`id`, `plate`, `data`, `owned`) VALUES
	(3505, 'CYY 7963', '{}', 1);
INSERT INTO `trunk_inventory` (`id`, `plate`, `data`, `owned`) VALUES
	(3506, 'MRU 2905', '{"weapons":[{"name":"WEAPON_PETROLCAN","ammo":4500,"label":"Jerrycan"}]}', 1);
INSERT INTO `trunk_inventory` (`id`, `plate`, `data`, `owned`) VALUES
	(3525, 'QHJ 5038', '{}', 1);
INSERT INTO `trunk_inventory` (`id`, `plate`, `data`, `owned`) VALUES
	(3533, 'WDO 5647', '{}', 1);
INSERT INTO `trunk_inventory` (`id`, `plate`, `data`, `owned`) VALUES
	(3544, 'TSW 7355', '{}', 1);
INSERT INTO `trunk_inventory` (`id`, `plate`, `data`, `owned`) VALUES
	(3545, 'BQB 3214', '{}', 1);
INSERT INTO `trunk_inventory` (`id`, `plate`, `data`, `owned`) VALUES
	(3546, 'IEQ 4294', '{}', 1);
INSERT INTO `trunk_inventory` (`id`, `plate`, `data`, `owned`) VALUES
	(3551, 'BWA 7007', '{}', 1);
INSERT INTO `trunk_inventory` (`id`, `plate`, `data`, `owned`) VALUES
	(3557, 'FJY 6003', '{}', 1);
INSERT INTO `trunk_inventory` (`id`, `plate`, `data`, `owned`) VALUES
	(3567, 'OAS 2889', '{}', 1);
INSERT INTO `trunk_inventory` (`id`, `plate`, `data`, `owned`) VALUES
	(3576, 'HGR 9128', '{}', 1);
INSERT INTO `trunk_inventory` (`id`, `plate`, `data`, `owned`) VALUES
	(3577, 'CNX 8870', '{"coffre":[{"count":5,"name":"fixkit"}]}', 1);
INSERT INTO `trunk_inventory` (`id`, `plate`, `data`, `owned`) VALUES
	(3580, 'QKP 1883', '{}', 1);
INSERT INTO `trunk_inventory` (`id`, `plate`, `data`, `owned`) VALUES
	(3582, 'WOV 3685', '{}', 1);
INSERT INTO `trunk_inventory` (`id`, `plate`, `data`, `owned`) VALUES
	(3583, 'IMPALER ', '{}', 1);
INSERT INTO `trunk_inventory` (`id`, `plate`, `data`, `owned`) VALUES
	(3592, ' AJOCK4 ', '{"weapons":[{"ammo":250,"label":"Pistol","name":"WEAPON_PISTOL"}]}', 1);
INSERT INTO `trunk_inventory` (`id`, `plate`, `data`, `owned`) VALUES
	(3597, 'AZZ 2589', '{}', 1);
INSERT INTO `trunk_inventory` (`id`, `plate`, `data`, `owned`) VALUES
	(3600, 'SNG 2071', '{}', 1);
INSERT INTO `trunk_inventory` (`id`, `plate`, `data`, `owned`) VALUES
	(3603, 'XDU 2424', '{}', 1);
INSERT INTO `trunk_inventory` (`id`, `plate`, `data`, `owned`) VALUES
	(3605, 'MSN 0005', '{}', 1);
INSERT INTO `trunk_inventory` (`id`, `plate`, `data`, `owned`) VALUES
	(3608, 'QTP 6680', '{}', 1);
INSERT INTO `trunk_inventory` (`id`, `plate`, `data`, `owned`) VALUES
	(3611, 'PLC 0163', '{}', 1);
INSERT INTO `trunk_inventory` (`id`, `plate`, `data`, `owned`) VALUES
	(3612, 'JLX 9964', '{"weapons":[{"name":"WEAPON_ASSAULTRIFLE","ammo":245,"label":"Assault rifle"}]}', 1);
INSERT INTO `trunk_inventory` (`id`, `plate`, `data`, `owned`) VALUES
	(3613, 'JTH 7278', '{}', 1);
INSERT INTO `trunk_inventory` (`id`, `plate`, `data`, `owned`) VALUES
	(3617, 'MKA 3524', '{}', 1);
INSERT INTO `trunk_inventory` (`id`, `plate`, `data`, `owned`) VALUES
	(3620, 'DAF 3245', '{"coffre":[]}', 1);
INSERT INTO `trunk_inventory` (`id`, `plate`, `data`, `owned`) VALUES
	(3621, 'RVN 8324', '{"coffre":[{"name":"fixkit","count":2}]}', 1);
INSERT INTO `trunk_inventory` (`id`, `plate`, `data`, `owned`) VALUES
	(3627, 'OJH 2065', '{}', 1);
INSERT INTO `trunk_inventory` (`id`, `plate`, `data`, `owned`) VALUES
	(3629, 'KMT 1960', '{}', 1);
INSERT INTO `trunk_inventory` (`id`, `plate`, `data`, `owned`) VALUES
	(3630, 'ETM 9112', '{}', 1);
INSERT INTO `trunk_inventory` (`id`, `plate`, `data`, `owned`) VALUES
	(3633, 'AKO 1843', '{}', 1);
INSERT INTO `trunk_inventory` (`id`, `plate`, `data`, `owned`) VALUES
	(3634, 'TFE 6587', '{}', 1);
INSERT INTO `trunk_inventory` (`id`, `plate`, `data`, `owned`) VALUES
	(3636, 'GHZ 7641', '{}', 1);
INSERT INTO `trunk_inventory` (`id`, `plate`, `data`, `owned`) VALUES
	(3637, 'PRB 0188', '{}', 1);
INSERT INTO `trunk_inventory` (`id`, `plate`, `data`, `owned`) VALUES
	(3640, 'WOX 0522', '{}', 1);
INSERT INTO `trunk_inventory` (`id`, `plate`, `data`, `owned`) VALUES
	(3643, 'FQH 8143', '{"weapons":[]}', 1);
INSERT INTO `trunk_inventory` (`id`, `plate`, `data`, `owned`) VALUES
	(3649, 'GPY 0770', '{}', 1);
INSERT INTO `trunk_inventory` (`id`, `plate`, `data`, `owned`) VALUES
	(3657, 'DJM 7748', '{}', 1);
INSERT INTO `trunk_inventory` (`id`, `plate`, `data`, `owned`) VALUES
	(3659, 'WUG 1330', '{}', 1);
INSERT INTO `trunk_inventory` (`id`, `plate`, `data`, `owned`) VALUES
	(3660, 'VEXPAIN ', '{}', 1);
INSERT INTO `trunk_inventory` (`id`, `plate`, `data`, `owned`) VALUES
	(3665, 'BZC 9985', '{}', 1);
INSERT INTO `trunk_inventory` (`id`, `plate`, `data`, `owned`) VALUES
	(3666, 'RUH 8304', '{"coffre":[],"weapons":[]}', 1);
INSERT INTO `trunk_inventory` (`id`, `plate`, `data`, `owned`) VALUES
	(3670, 'BEQ 7829', '{}', 1);
INSERT INTO `trunk_inventory` (`id`, `plate`, `data`, `owned`) VALUES
	(3672, 'QYK 7023', '{}', 1);
INSERT INTO `trunk_inventory` (`id`, `plate`, `data`, `owned`) VALUES
	(3676, 'HIP 0307', '{"weapons":[],"coffre":[]}', 1);
INSERT INTO `trunk_inventory` (`id`, `plate`, `data`, `owned`) VALUES
	(3679, 'WSB 8730', '{}', 1);
INSERT INTO `trunk_inventory` (`id`, `plate`, `data`, `owned`) VALUES
	(3680, 'WFH 7795', '{}', 1);
INSERT INTO `trunk_inventory` (`id`, `plate`, `data`, `owned`) VALUES
	(3683, 'UUU 4821', '{}', 1);
INSERT INTO `trunk_inventory` (`id`, `plate`, `data`, `owned`) VALUES
	(3686, 'YGN 5400', '{"weapons":[{"name":"WEAPON_PISTOL","label":"Pistol","ammo":143}]}', 1);
INSERT INTO `trunk_inventory` (`id`, `plate`, `data`, `owned`) VALUES
	(3687, 'OTV 8498', '{"weapons":[{"name":"WEAPON_SMG","ammo":223,"label":"SMG"},{"name":"WEAPON_CARBINERIFLE","ammo":207,"label":"Carbine rifle"},{"name":"WEAPON_STUNGUN","ammo":-1,"label":"Taser"},{"name":"WEAPON_FLASHLIGHT","ammo":0,"label":"Flashlight"},{"name":"WEAPON_PISTOL","ammo":222,"label":"Pistol"},{"name":"WEAPON_ADVANCEDRIFLE","ammo":246,"label":"Advanced rifle"}],"coffre":[{"count":1,"name":"hifi"}]}', 1);
INSERT INTO `trunk_inventory` (`id`, `plate`, `data`, `owned`) VALUES
	(3688, 'ATS 9712', '{"weapons":[{"name":"WEAPON_MUSKET","label":"Musket","ammo":249},{"name":"WEAPON_KNIFE","label":"Knife","ammo":0},{"name":"WEAPON_ASSAULTRIFLE","label":"Assault rifle","ammo":127}]}', 1);
INSERT INTO `trunk_inventory` (`id`, `plate`, `data`, `owned`) VALUES
	(3689, '  BHRD  ', '{"weapons":[{"name":"WEAPON_ASSAULTRIFLE","label":"Assault rifle","ammo":228}],"coffre":[]}', 1);
INSERT INTO `trunk_inventory` (`id`, `plate`, `data`, `owned`) VALUES
	(3695, 'XST 3175', '{}', 1);
INSERT INTO `trunk_inventory` (`id`, `plate`, `data`, `owned`) VALUES
	(3696, 'ZRI 8651', '{"weapons":[{"ammo":240,"name":"WEAPON_PISTOL50","label":"Pistol .50"},{"ammo":231,"name":"WEAPON_PISTOL_MK2","label":"Pistol MK2"},{"ammo":101,"name":"WEAPON_MICROSMG","label":"Micro SMG"},{"ammo":249,"name":"WEAPON_PISTOL50","label":"Pistol .50"},{"ammo":243,"name":"WEAPON_ASSAULTRIFLE","label":"Assault rifle"},{"ammo":234,"name":"WEAPON_PISTOL_MK2","label":"Pistol MK2"},{"ammo":222,"name":"WEAPON_PISTOL","label":"Pistol"},{"ammo":250,"name":"WEAPON_HEAVYSHOTGUN","label":"Heavy shotgun"},{"ammo":228,"name":"WEAPON_ASSAULTRIFLE_MK2","label":"Assaultrifle MK2"},{"name":"WEAPON_GUSENBERG","ammo":193,"label":"Gusenberg sweeper"}]}', 1);
INSERT INTO `trunk_inventory` (`id`, `plate`, `data`, `owned`) VALUES
	(3700, 'SWP 9409', '{}', 1);
INSERT INTO `trunk_inventory` (`id`, `plate`, `data`, `owned`) VALUES
	(3708, 'TUW 8070', '{}', 1);
INSERT INTO `trunk_inventory` (`id`, `plate`, `data`, `owned`) VALUES
	(3712, 'CIK 9031', '{}', 1);
INSERT INTO `trunk_inventory` (`id`, `plate`, `data`, `owned`) VALUES
	(3714, 'TBU 4189', '{}', 1);
INSERT INTO `trunk_inventory` (`id`, `plate`, `data`, `owned`) VALUES
	(3716, 'HLM 1780', '{}', 1);
INSERT INTO `trunk_inventory` (`id`, `plate`, `data`, `owned`) VALUES
	(3722, 'ACS 6106', '{}', 1);
INSERT INTO `trunk_inventory` (`id`, `plate`, `data`, `owned`) VALUES
	(3724, 'SEF 8169', '{}', 1);
INSERT INTO `trunk_inventory` (`id`, `plate`, `data`, `owned`) VALUES
	(3725, 'JQJ 4263', '{"weapons":[{"name":"WEAPON_PISTOL","label":"Pistol","ammo":210}]}', 1);
INSERT INTO `trunk_inventory` (`id`, `plate`, `data`, `owned`) VALUES
	(3726, 'LZO 9501', '{}', 1);
INSERT INTO `trunk_inventory` (`id`, `plate`, `data`, `owned`) VALUES
	(3727, 'GQS 6484', '{}', 1);
INSERT INTO `trunk_inventory` (`id`, `plate`, `data`, `owned`) VALUES
	(3742, 'ARJ 4932', '{"weapons":[{"ammo":0,"name":"WEAPON_KNIFE","label":"Knife"},{"ammo":0,"name":"WEAPON_KNIFE","label":"Knife"},{"ammo":0,"name":"WEAPON_KNIFE","label":"Knife"},{"ammo":0,"name":"WEAPON_KNIFE","label":"Knife"}]}', 1);
INSERT INTO `trunk_inventory` (`id`, `plate`, `data`, `owned`) VALUES
	(3745, 'RJD 8713', '{}', 1);
INSERT INTO `trunk_inventory` (`id`, `plate`, `data`, `owned`) VALUES
	(3748, 'YMZ 1090', '{"coffre":[{"name":"clip","count":3}],"weapons":[{"ammo":229,"label":"Special carbine","name":"WEAPON_SPECIALCARBINE"},{"ammo":0,"label":"Knife","name":"WEAPON_KNIFE"},{"ammo":239,"label":"Carbine rifle","name":"WEAPON_CARBINERIFLE"}]}', 1);
INSERT INTO `trunk_inventory` (`id`, `plate`, `data`, `owned`) VALUES
	(3753, 'MDE 9165', '{}', 1);
INSERT INTO `trunk_inventory` (`id`, `plate`, `data`, `owned`) VALUES
	(3757, 'FMY 4796', '{"weapons":[]}', 1);
INSERT INTO `trunk_inventory` (`id`, `plate`, `data`, `owned`) VALUES
	(3763, 'LUL 4614', '{"weapons":[]}', 1);
INSERT INTO `trunk_inventory` (`id`, `plate`, `data`, `owned`) VALUES
	(3764, 'XVW 1064', '{}', 1);
INSERT INTO `trunk_inventory` (`id`, `plate`, `data`, `owned`) VALUES
	(3765, 'TUH 7658', '{}', 1);
INSERT INTO `trunk_inventory` (`id`, `plate`, `data`, `owned`) VALUES
	(3773, 'RTS 3107', '{"weapons":[{"label":"Knife","ammo":0,"name":"WEAPON_KNIFE"}]}', 1);
INSERT INTO `trunk_inventory` (`id`, `plate`, `data`, `owned`) VALUES
	(3774, 'VDJ 6834', '{}', 1);
INSERT INTO `trunk_inventory` (`id`, `plate`, `data`, `owned`) VALUES
	(3779, 'OMZ 2835', '{}', 1);
INSERT INTO `trunk_inventory` (`id`, `plate`, `data`, `owned`) VALUES
	(3784, 'MHK 6680', '{}', 1);
INSERT INTO `trunk_inventory` (`id`, `plate`, `data`, `owned`) VALUES
	(3785, 'FXV 4236', '{}', 1);
INSERT INTO `trunk_inventory` (`id`, `plate`, `data`, `owned`) VALUES
	(3788, 'LGF 3841', '{}', 1);
INSERT INTO `trunk_inventory` (`id`, `plate`, `data`, `owned`) VALUES
	(3794, 'EJV 3719', '{}', 1);
INSERT INTO `trunk_inventory` (`id`, `plate`, `data`, `owned`) VALUES
	(3797, 'YVI 2404', '{}', 1);
INSERT INTO `trunk_inventory` (`id`, `plate`, `data`, `owned`) VALUES
	(3802, 'VGJ 2963', '{}', 1);
INSERT INTO `trunk_inventory` (`id`, `plate`, `data`, `owned`) VALUES
	(3807, 'RLT 9689', '{}', 1);
INSERT INTO `trunk_inventory` (`id`, `plate`, `data`, `owned`) VALUES
	(3810, 'TUC 9627', '{}', 1);
INSERT INTO `trunk_inventory` (`id`, `plate`, `data`, `owned`) VALUES
	(3816, 'JFM 6009', '{}', 1);
INSERT INTO `trunk_inventory` (`id`, `plate`, `data`, `owned`) VALUES
	(3818, 'BKK 7414', '{"weapons":[]}', 1);
INSERT INTO `trunk_inventory` (`id`, `plate`, `data`, `owned`) VALUES
	(3819, 'PBU 9493', '{}', 1);
INSERT INTO `trunk_inventory` (`id`, `plate`, `data`, `owned`) VALUES
	(3823, 'CVQ 0930', '{"weapons":[{"ammo":229,"label":"Pistol","name":"WEAPON_PISTOL"}]}', 1);
INSERT INTO `trunk_inventory` (`id`, `plate`, `data`, `owned`) VALUES
	(3825, 'FHZ 1419', '{}', 1);
INSERT INTO `trunk_inventory` (`id`, `plate`, `data`, `owned`) VALUES
	(3826, 'DKJ 8349', '{}', 1);
INSERT INTO `trunk_inventory` (`id`, `plate`, `data`, `owned`) VALUES
	(3830, 'TKM 5913', '{"weapons":[{"ammo":216,"label":"Combat Pistol","name":"WEAPON_COMBATPISTOL"},{"ammo":200,"label":"Combat Pistol","name":"WEAPON_COMBATPISTOL"},{"ammo":230,"label":"Combat Pistol","name":"WEAPON_COMBATPISTOL"},{"ammo":241,"label":"SMG","name":"WEAPON_SMG"},{"ammo":171,"label":"SMG","name":"WEAPON_SMG"},{"ammo":216,"label":"SMG","name":"WEAPON_SMG"},{"ammo":199,"label":"Micro SMG","name":"WEAPON_MICROSMG"},{"ammo":232,"label":"Micro SMG","name":"WEAPON_MICROSMG"},{"ammo":246,"label":"Pistol MK2","name":"WEAPON_PISTOL_MK2"},{"ammo":242,"label":"Pistol MK2","name":"WEAPON_PISTOL_MK2"},{"ammo":235,"label":"Pistol MK2","name":"WEAPON_PISTOL_MK2"},{"ammo":233,"label":"Pistol MK2","name":"WEAPON_PISTOL_MK2"}]}', 1);
INSERT INTO `trunk_inventory` (`id`, `plate`, `data`, `owned`) VALUES
	(3831, 'MPW 2209', '{}', 1);
INSERT INTO `trunk_inventory` (`id`, `plate`, `data`, `owned`) VALUES
	(3832, 'YFN 2202', '{"coffre":[]}', 1);
INSERT INTO `trunk_inventory` (`id`, `plate`, `data`, `owned`) VALUES
	(3833, 'BLN 1134', '{}', 1);
INSERT INTO `trunk_inventory` (`id`, `plate`, `data`, `owned`) VALUES
	(3837, 'ASZ 5598', '{"weapons":[{"label":"Special carbine","ammo":204,"name":"WEAPON_SPECIALCARBINE"},{"label":"Special carbine","ammo":221,"name":"WEAPON_SPECIALCARBINE"},{"label":"Special carbine","ammo":214,"name":"WEAPON_SPECIALCARBINE"},{"label":"Carbine rifle","ammo":249,"name":"WEAPON_CARBINERIFLE"},{"label":"Micro SMG","ammo":44,"name":"WEAPON_MICROSMG"},{"label":"Pistol .50","ammo":234,"name":"WEAPON_PISTOL50"},{"label":"Special carbine","ammo":228,"name":"WEAPON_SPECIALCARBINE"},{"label":"Special carbine","ammo":216,"name":"WEAPON_SPECIALCARBINE"},{"label":"Micro SMG","name":"WEAPON_MICROSMG","ammo":110}]}', 1);
INSERT INTO `trunk_inventory` (`id`, `plate`, `data`, `owned`) VALUES
	(3842, 'OTF 9770', '{}', 1);
INSERT INTO `trunk_inventory` (`id`, `plate`, `data`, `owned`) VALUES
	(3851, 'RQS 4293', '{}', 1);
INSERT INTO `trunk_inventory` (`id`, `plate`, `data`, `owned`) VALUES
	(3865, 'YQG 7759', '{}', 1);
INSERT INTO `trunk_inventory` (`id`, `plate`, `data`, `owned`) VALUES
	(3873, 'GSJ 6324', '{}', 1);
INSERT INTO `trunk_inventory` (`id`, `plate`, `data`, `owned`) VALUES
	(3874, 'XDT 9229', '{}', 1);
INSERT INTO `trunk_inventory` (`id`, `plate`, `data`, `owned`) VALUES
	(3876, 'ITD 0572', '{}', 1);
INSERT INTO `trunk_inventory` (`id`, `plate`, `data`, `owned`) VALUES
	(3880, 'DXP 8555', '{"weapons":[{"name":"WEAPON_COMBATPDW","ammo":228,"label":"Combat pdw"},{"name":"WEAPON_COMBATPDW","ammo":249,"label":"Combat pdw"},{"name":"WEAPON_CARBINERIFLE_MK2","ammo":208,"label":"Carbinerifle MK2"},{"name":"WEAPON_CARBINERIFLE_MK2","ammo":0,"label":"Carbinerifle MK2"},{"name":"WEAPON_CARBINERIFLE_MK2","ammo":216,"label":"Carbinerifle MK2"},{"name":"WEAPON_KNIFE","ammo":0,"label":"Knife"}],"coffre":[{"name":"headbag","count":1}]}', 1);
INSERT INTO `trunk_inventory` (`id`, `plate`, `data`, `owned`) VALUES
	(3884, 'LLP 0229', '{}', 1);
INSERT INTO `trunk_inventory` (`id`, `plate`, `data`, `owned`) VALUES
	(3886, 'GVE 0254', '{}', 1);
INSERT INTO `trunk_inventory` (`id`, `plate`, `data`, `owned`) VALUES
	(3892, 'SCR 8057', '{}', 1);
INSERT INTO `trunk_inventory` (`id`, `plate`, `data`, `owned`) VALUES
	(3893, 'CLD 5608', '{"weapons":[{"name":"WEAPON_SMG","ammo":219,"label":"SMG"}]}', 1);
INSERT INTO `trunk_inventory` (`id`, `plate`, `data`, `owned`) VALUES
	(3904, 'HGU 1304', '{}', 1);
INSERT INTO `trunk_inventory` (`id`, `plate`, `data`, `owned`) VALUES
	(3908, 'JVD 3578', '{}', 1);
INSERT INTO `trunk_inventory` (`id`, `plate`, `data`, `owned`) VALUES
	(3909, 'IBT 5937', '{}', 1);
INSERT INTO `trunk_inventory` (`id`, `plate`, `data`, `owned`) VALUES
	(3911, 'LBZ 1482', '{"weapons":[{"label":"SMG","ammo":211,"name":"WEAPON_SMG"}]}', 1);
INSERT INTO `trunk_inventory` (`id`, `plate`, `data`, `owned`) VALUES
	(3912, 'VIS 2023', '{}', 1);
INSERT INTO `trunk_inventory` (`id`, `plate`, `data`, `owned`) VALUES
	(3916, 'SNW 5445', '{}', 1);
INSERT INTO `trunk_inventory` (`id`, `plate`, `data`, `owned`) VALUES
	(3918, 'TMU 2753', '{}', 1);
INSERT INTO `trunk_inventory` (`id`, `plate`, `data`, `owned`) VALUES
	(3919, 'BFI 5265', '{"coffre":[{"name":"meth","count":3},{"name":"radio","count":1}]}', 1);
INSERT INTO `trunk_inventory` (`id`, `plate`, `data`, `owned`) VALUES
	(3920, 'DRZ 9951', '{}', 1);
INSERT INTO `trunk_inventory` (`id`, `plate`, `data`, `owned`) VALUES
	(3921, 'NGY 6318', '{}', 1);
INSERT INTO `trunk_inventory` (`id`, `plate`, `data`, `owned`) VALUES
	(3922, 'GPZ 6785', '{}', 1);
INSERT INTO `trunk_inventory` (`id`, `plate`, `data`, `owned`) VALUES
	(3924, 'LWE 5475', '{}', 1);
INSERT INTO `trunk_inventory` (`id`, `plate`, `data`, `owned`) VALUES
	(3927, 'DAP 7011', '{}', 1);
INSERT INTO `trunk_inventory` (`id`, `plate`, `data`, `owned`) VALUES
	(3933, 'QJQ 4122', '{}', 1);
INSERT INTO `trunk_inventory` (`id`, `plate`, `data`, `owned`) VALUES
	(3939, 'ELM 4850', '{"coffre":[{"count":6,"name":"clip"}],"weapons":[{"ammo":0,"label":"Knife","name":"WEAPON_KNIFE"},{"ammo":0,"label":"Knife","name":"WEAPON_KNIFE"},{"ammo":244,"label":"Sns pistol","name":"WEAPON_SNSPISTOL"},{"ammo":0,"label":"Knife","name":"WEAPON_KNIFE"},{"ammo":0,"label":"Knife","name":"WEAPON_KNIFE"},{"ammo":250,"label":"Sns pistol","name":"WEAPON_SNSPISTOL"},{"ammo":250,"label":"SMG","name":"WEAPON_SMG"},{"ammo":123,"label":"Pistol","name":"WEAPON_PISTOL"},{"ammo":200,"label":"Pistol","name":"WEAPON_PISTOL"}]}', 1);
INSERT INTO `trunk_inventory` (`id`, `plate`, `data`, `owned`) VALUES
	(3941, 'WNI 4667', '{"weapons":[{"name":"WEAPON_PISTOL50","ammo":235,"label":"Pistol .50"},{"name":"WEAPON_KNIFE","ammo":0,"label":"Knife"},{"name":"WEAPON_PISTOL50","ammo":242,"label":"Pistol .50"},{"name":"WEAPON_KNIFE","ammo":0,"label":"Knife"},{"name":"WEAPON_KNIFE","ammo":0,"label":"Knife"},{"name":"WEAPON_SMG","ammo":249,"label":"SMG"},{"name":"WEAPON_SMG","ammo":250,"label":"SMG"},{"name":"WEAPON_MICROSMG","ammo":225,"label":"Micro SMG"},{"name":"WEAPON_KNIFE","ammo":0,"label":"Knife"}]}', 1);
INSERT INTO `trunk_inventory` (`id`, `plate`, `data`, `owned`) VALUES
	(3942, 'UTT 1775', '{}', 1);
INSERT INTO `trunk_inventory` (`id`, `plate`, `data`, `owned`) VALUES
	(3943, 'DMY 3115', '{"coffre":[],"weapons":[{"ammo":250,"name":"WEAPON_CARBINERIFLE","label":"Carbine rifle"},{"ammo":0,"name":"WEAPON_SPECIALCARBINE","label":"Special carbine"},{"name":"WEAPON_REVOLVER","ammo":154,"label":"Heavy revolver"},{"name":"WEAPON_ASSAULTSMG","ammo":250,"label":"Assault SMG"},{"name":"WEAPON_CARBINERIFLE","ammo":191,"label":"Carbine rifle"},{"name":"WEAPON_SMG","ammo":0,"label":"SMG"}]}', 1);
INSERT INTO `trunk_inventory` (`id`, `plate`, `data`, `owned`) VALUES
	(3944, 'SDB 4465', '{"weapons":[{"label":"Special carbine","ammo":250,"name":"WEAPON_SPECIALCARBINE"}]}', 1);
INSERT INTO `trunk_inventory` (`id`, `plate`, `data`, `owned`) VALUES
	(3946, 'PTJ 6386', '{}', 1);
INSERT INTO `trunk_inventory` (`id`, `plate`, `data`, `owned`) VALUES
	(3948, 'YRC 7893', '{"weapons":[{"name":"WEAPON_CARBINERIFLE","ammo":202,"label":"Carbine rifle"}]}', 1);
INSERT INTO `trunk_inventory` (`id`, `plate`, `data`, `owned`) VALUES
	(3950, 'URV 5516', '{"weapons":[{"label":"Micro SMG","ammo":250,"name":"WEAPON_MICROSMG"},{"label":"Micro SMG","ammo":250,"name":"WEAPON_MICROSMG"},{"label":"Micro SMG","ammo":250,"name":"WEAPON_MICROSMG"},{"label":"Micro SMG","ammo":250,"name":"WEAPON_MICROSMG"},{"label":"Micro SMG","ammo":250,"name":"WEAPON_MICROSMG"},{"label":"Micro SMG","ammo":250,"name":"WEAPON_MICROSMG"},{"label":"Micro SMG","ammo":250,"name":"WEAPON_MICROSMG"},{"label":"Micro SMG","ammo":250,"name":"WEAPON_MICROSMG"},{"label":"Pistol","ammo":223,"name":"WEAPON_PISTOL"},{"label":"Pistol","ammo":223,"name":"WEAPON_PISTOL"},{"label":"Pistol","ammo":223,"name":"WEAPON_PISTOL"},{"label":"Pistol","ammo":223,"name":"WEAPON_PISTOL"},{"label":"Pistol","ammo":223,"name":"WEAPON_PISTOL"},{"label":"Pistol","ammo":223,"name":"WEAPON_PISTOL"},{"label":"Pistol","ammo":223,"name":"WEAPON_PISTOL"},{"label":"Pistol","ammo":223,"name":"WEAPON_PISTOL"},{"label":"Pistol","ammo":223,"name":"WEAPON_PISTOL"},{"label":"Pistol","ammo":223,"name":"WEAPON_PISTOL"},{"label":"Micro SMG","ammo":250,"name":"WEAPON_MICROSMG"},{"label":"Micro SMG","ammo":250,"name":"WEAPON_MICROSMG"},{"label":"Micro SMG","ammo":250,"name":"WEAPON_MICROSMG"},{"label":"Micro SMG","ammo":250,"name":"WEAPON_MICROSMG"},{"label":"Micro SMG","ammo":250,"name":"WEAPON_MICROSMG"},{"label":"Micro SMG","ammo":250,"name":"WEAPON_MICROSMG"},{"label":"Micro SMG","ammo":250,"name":"WEAPON_MICROSMG"},{"label":"Micro SMG","ammo":250,"name":"WEAPON_MICROSMG"},{"label":"Pistol","ammo":223,"name":"WEAPON_PISTOL"},{"label":"Pistol","ammo":223,"name":"WEAPON_PISTOL"},{"label":"Pistol","ammo":223,"name":"WEAPON_PISTOL"}]}', 1);
INSERT INTO `trunk_inventory` (`id`, `plate`, `data`, `owned`) VALUES
	(3951, 'PUW 0530', '{}', 1);
INSERT INTO `trunk_inventory` (`id`, `plate`, `data`, `owned`) VALUES
	(3952, 'IZW 8431', '{}', 1);
INSERT INTO `trunk_inventory` (`id`, `plate`, `data`, `owned`) VALUES
	(3954, 'RVK 9274', '{}', 1);
INSERT INTO `trunk_inventory` (`id`, `plate`, `data`, `owned`) VALUES
	(3969, 'PFX 3796', '{"coffre":[]}', 1);
INSERT INTO `trunk_inventory` (`id`, `plate`, `data`, `owned`) VALUES
	(3972, 'TUH 2048', '{"weapons":[]}', 1);
INSERT INTO `trunk_inventory` (`id`, `plate`, `data`, `owned`) VALUES
	(3973, 'OBR 6111', '{}', 1);
INSERT INTO `trunk_inventory` (`id`, `plate`, `data`, `owned`) VALUES
	(3974, 'IYB 0863', '{"weapons":[]}', 1);
INSERT INTO `trunk_inventory` (`id`, `plate`, `data`, `owned`) VALUES
	(3975, 'YOI 1235', '{"weapons":[]}', 1);
INSERT INTO `trunk_inventory` (`id`, `plate`, `data`, `owned`) VALUES
	(3976, 'QQH 3832', '{"coffre":[{"count":10,"name":"silencer"},{"count":29,"name":"grip"}],"weapons":[{"ammo":250,"name":"WEAPON_SMG","label":"SMG"},{"name":"WEAPON_PISTOL","ammo":122,"label":"Pistol"},{"name":"WEAPON_CARBINERIFLE","ammo":250,"label":"Carbine rifle"},{"name":"WEAPON_CARBINERIFLE","ammo":239,"label":"Carbine rifle"},{"name":"WEAPON_CARBINERIFLE","ammo":220,"label":"Carbine rifle"},{"name":"WEAPON_SMG","ammo":248,"label":"SMG"}]}', 1);
INSERT INTO `trunk_inventory` (`id`, `plate`, `data`, `owned`) VALUES
	(3977, 'RNT 6327', '{}', 1);
INSERT INTO `trunk_inventory` (`id`, `plate`, `data`, `owned`) VALUES
	(3981, 'WFJ 1000', '{}', 1);
INSERT INTO `trunk_inventory` (`id`, `plate`, `data`, `owned`) VALUES
	(3983, 'QON 5106', '{}', 1);
INSERT INTO `trunk_inventory` (`id`, `plate`, `data`, `owned`) VALUES
	(3984, 'AFG 9946', '{}', 1);
INSERT INTO `trunk_inventory` (`id`, `plate`, `data`, `owned`) VALUES
	(3985, 'LPL 5863', '{}', 1);
INSERT INTO `trunk_inventory` (`id`, `plate`, `data`, `owned`) VALUES
	(3993, 'TCT 6478', '{"coffre":[]}', 1);
INSERT INTO `trunk_inventory` (`id`, `plate`, `data`, `owned`) VALUES
	(3994, 'XUO 1123', '{}', 1);
INSERT INTO `trunk_inventory` (`id`, `plate`, `data`, `owned`) VALUES
	(3998, 'DCN 9293', '{"coffre":[]}', 1);
INSERT INTO `trunk_inventory` (`id`, `plate`, `data`, `owned`) VALUES
	(3999, 'YHU 5455', '{"coffre":[]}', 1);
INSERT INTO `trunk_inventory` (`id`, `plate`, `data`, `owned`) VALUES
	(4000, 'IJF 9870', '{"coffre":[]}', 1);
INSERT INTO `trunk_inventory` (`id`, `plate`, `data`, `owned`) VALUES
	(4001, 'OGW 6841', '{"coffre":[]}', 1);
INSERT INTO `trunk_inventory` (`id`, `plate`, `data`, `owned`) VALUES
	(4002, 'JGE 4300', '{}', 1);
INSERT INTO `trunk_inventory` (`id`, `plate`, `data`, `owned`) VALUES
	(4004, 'WTH 2459', '{}', 1);
INSERT INTO `trunk_inventory` (`id`, `plate`, `data`, `owned`) VALUES
	(4013, 'NFU 2822', '{}', 1);
INSERT INTO `trunk_inventory` (`id`, `plate`, `data`, `owned`) VALUES
	(4014, 'YMI 5311', '{}', 1);
INSERT INTO `trunk_inventory` (`id`, `plate`, `data`, `owned`) VALUES
	(4016, 'TLK 2908', '{"coffre":[{"name":"net_cracker","count":2}],"weapons":[{"name":"WEAPON_SMG_MK2","ammo":246,"label":"SMG MK2"},{"name":"WEAPON_CARBINERIFLE_MK2","ammo":246,"label":"Carbinerifle MK2"},{"name":"WEAPON_VINTAGEPISTOL","ammo":0,"label":"Vintage pistol"},{"name":"WEAPON_MINISMG","ammo":0,"label":"Mini Smg"},{"name":"WEAPON_COMBATPDW","ammo":0,"label":"Combat pdw"},{"name":"WEAPON_ASSAULTRIFLE","ammo":0,"label":"Assault rifle"},{"name":"WEAPON_BULLPUPRIFLE","ammo":0,"label":"Bullpup rifle"},{"name":"WEAPON_STUNGUN","ammo":-1,"label":"Taser"},{"name":"WEAPON_CARBINERIFLE_MK2","ammo":243,"label":"Carbinerifle MK2"},{"name":"WEAPON_ASSAULTRIFLE_MK2","ammo":0,"label":"Assaultrifle MK2"},{"name":"WEAPON_SMG","ammo":220,"label":"SMG"},{"name":"WEAPON_ADVANCEDRIFLE","ammo":234,"label":"Advanced rifle"},{"name":"WEAPON_ASSAULTRIFLE","ammo":0,"label":"Assault rifle"},{"name":"WEAPON_CARBINERIFLE","ammo":0,"label":"Carbine rifle"},{"name":"WEAPON_STUNGUN","ammo":-1,"label":"Taser"},{"name":"WEAPON_FLASHLIGHT","ammo":0,"label":"Flashlight"},{"name":"WEAPON_NIGHTSTICK","ammo":0,"label":"Nightstick"},{"name":"WEAPON_MG","ammo":220,"label":"MG"},{"name":"WEAPON_COMBATMG_MK2","ammo":0,"label":"Combatmg MK2"},{"name":"WEAPON_REVOLVER","ammo":207,"label":"Heavy revolver"},{"name":"WEAPON_SMG","ammo":250,"label":"SMG"},{"name":"WEAPON_REVOLVER","ammo":232,"label":"Heavy revolver"},{"name":"WEAPON_PISTOL50","ammo":0,"label":"Pistol .50"},{"name":"WEAPON_HEAVYPISTOL","ammo":0,"label":"Heavy pistol"},{"name":"WEAPON_REVOLVER_MK2","ammo":0,"label":"Revolver MK2"},{"name":"WEAPON_SMG","ammo":149,"label":"SMG"}]}', 1);
INSERT INTO `trunk_inventory` (`id`, `plate`, `data`, `owned`) VALUES
	(4022, 'RKR 4201', '{}', 1);
INSERT INTO `trunk_inventory` (`id`, `plate`, `data`, `owned`) VALUES
	(4023, 'DCD 2377', '{}', 1);
INSERT INTO `trunk_inventory` (`id`, `plate`, `data`, `owned`) VALUES
	(4029, 'LBS 4462', '{"weapons":[{"name":"WEAPON_COMBATPISTOL","label":"Combat Pistol","ammo":195},{"name":"WEAPON_PISTOL","label":"Pistol","ammo":0},{"name":"WEAPON_CARBINERIFLE_MK2","label":"Carbinerifle MK2","ammo":250},{"name":"WEAPON_HEAVYPISTOL","label":"Heavy pistol","ammo":0},{"name":"WEAPON_MICROSMG","label":"Micro SMG","ammo":100},{"name":"WEAPON_SMG","label":"SMG","ammo":0},{"name":"WEAPON_BULLPUPRIFLE","label":"Bullpup rifle","ammo":0}]}', 1);
INSERT INTO `trunk_inventory` (`id`, `plate`, `data`, `owned`) VALUES
	(4030, 'ESH 0216', '{"weapons":[{"name":"WEAPON_CARBINERIFLE_MK2","ammo":158,"label":"Carbinerifle MK2"}]}', 1);
INSERT INTO `trunk_inventory` (`id`, `plate`, `data`, `owned`) VALUES
	(4031, 'UAR 3782', '{"coffre":[{"count":4,"name":"bread"},{"count":9,"name":"burger"},{"count":24,"name":"sprite"},{"count":3,"name":"marabou"},{"count":3,"name":"pizza"}],"weapons":[{"name":"WEAPON_PETROLCAN","label":"Jerrycan","ammo":4500},{"name":"WEAPON_PETROLCAN","label":"Jerrycan","ammo":4500},{"name":"WEAPON_PETROLCAN","label":"Jerrycan","ammo":4500},{"name":"WEAPON_PETROLCAN","label":"Jerrycan","ammo":4500},{"name":"WEAPON_PETROLCAN","label":"Jerrycan","ammo":4500},{"name":"WEAPON_PETROLCAN","label":"Jerrycan","ammo":4330},{"name":"WEAPON_PETROLCAN","label":"Jerrycan","ammo":4500},{"name":"WEAPON_PETROLCAN","label":"Jerrycan","ammo":4499},{"name":"WEAPON_PETROLCAN","label":"Jerrycan","ammo":4500},{"name":"WEAPON_PETROLCAN","label":"Jerrycan","ammo":4500}]}', 1);
INSERT INTO `trunk_inventory` (`id`, `plate`, `data`, `owned`) VALUES
	(4033, 'FDU 5422', '{}', 1);
INSERT INTO `trunk_inventory` (`id`, `plate`, `data`, `owned`) VALUES
	(4036, 'KAA 9931', '{}', 1);
INSERT INTO `trunk_inventory` (`id`, `plate`, `data`, `owned`) VALUES
	(4038, 'JRL 0813', '{}', 1);
INSERT INTO `trunk_inventory` (`id`, `plate`, `data`, `owned`) VALUES
	(4039, 'PCX 6749', '{}', 1);
INSERT INTO `trunk_inventory` (`id`, `plate`, `data`, `owned`) VALUES
	(4041, 'QPX 5400', '{}', 1);
INSERT INTO `trunk_inventory` (`id`, `plate`, `data`, `owned`) VALUES
	(4045, 'UAV 8770', '{}', 1);
INSERT INTO `trunk_inventory` (`id`, `plate`, `data`, `owned`) VALUES
	(4046, 'DCD 7762', '{}', 1);
INSERT INTO `trunk_inventory` (`id`, `plate`, `data`, `owned`) VALUES
	(4049, 'XTT 3393', '{}', 1);
INSERT INTO `trunk_inventory` (`id`, `plate`, `data`, `owned`) VALUES
	(4053, 'JOG 9647', '{}', 1);
INSERT INTO `trunk_inventory` (`id`, `plate`, `data`, `owned`) VALUES
	(4058, 'EDQ 1475', '{"weapons":[]}', 1);
INSERT INTO `trunk_inventory` (`id`, `plate`, `data`, `owned`) VALUES
	(4059, 'NGR 0000', '{}', 1);
INSERT INTO `trunk_inventory` (`id`, `plate`, `data`, `owned`) VALUES
	(4060, 'LKB 7696', '{}', 1);
INSERT INTO `trunk_inventory` (`id`, `plate`, `data`, `owned`) VALUES
	(4061, 'JSR 9565', '{"weapons":[{"name":"WEAPON_ASSAULTRIFLE_MK2","ammo":228,"label":"Assaultrifle MK2"},{"name":"WEAPON_SMG","ammo":102,"label":"SMG"},{"name":"WEAPON_PISTOL50","ammo":245,"label":"Pistol .50"}],"coffre":[]}', 1);
INSERT INTO `trunk_inventory` (`id`, `plate`, `data`, `owned`) VALUES
	(4062, 'ZUK 1909', '{}', 1);
INSERT INTO `trunk_inventory` (`id`, `plate`, `data`, `owned`) VALUES
	(4063, 'DVD 4743', '{}', 1);
INSERT INTO `trunk_inventory` (`id`, `plate`, `data`, `owned`) VALUES
	(4070, 'VYT 4046', '{"weapons":[]}', 1);
INSERT INTO `trunk_inventory` (`id`, `plate`, `data`, `owned`) VALUES
	(4074, 'PFM 7924', '{}', 1);
INSERT INTO `trunk_inventory` (`id`, `plate`, `data`, `owned`) VALUES
	(4078, 'OJG 5992', '{}', 1);
INSERT INTO `trunk_inventory` (`id`, `plate`, `data`, `owned`) VALUES
	(4080, 'GFP 9966', '{"weapons":[]}', 1);
INSERT INTO `trunk_inventory` (`id`, `plate`, `data`, `owned`) VALUES
	(4082, 'AMIR1HNR', '{"weapons":[{"name":"WEAPON_COMBATPISTOL","label":"Combat Pistol","ammo":235}]}', 1);
INSERT INTO `trunk_inventory` (`id`, `plate`, `data`, `owned`) VALUES
	(4087, 'FBM 4369', '{}', 1);
INSERT INTO `trunk_inventory` (`id`, `plate`, `data`, `owned`) VALUES
	(4090, 'LRH 9218', '{"weapons":[],"coffre":[]}', 1);
INSERT INTO `trunk_inventory` (`id`, `plate`, `data`, `owned`) VALUES
	(4094, 'PBE 2230', '{}', 1);
INSERT INTO `trunk_inventory` (`id`, `plate`, `data`, `owned`) VALUES
	(4095, 'FES 1073', '{}', 1);
INSERT INTO `trunk_inventory` (`id`, `plate`, `data`, `owned`) VALUES
	(4096, 'YRW 6532', '{}', 1);
INSERT INTO `trunk_inventory` (`id`, `plate`, `data`, `owned`) VALUES
	(4097, 'GJU 2460', '{"weapons":[]}', 1);
INSERT INTO `trunk_inventory` (`id`, `plate`, `data`, `owned`) VALUES
	(4099, 'OHA 9347', '{}', 1);
INSERT INTO `trunk_inventory` (`id`, `plate`, `data`, `owned`) VALUES
	(4102, 'IUZ 1743', '{}', 1);
INSERT INTO `trunk_inventory` (`id`, `plate`, `data`, `owned`) VALUES
	(4103, 'BLD 4759', '{"weapons":[],"coffre":[]}', 1);
INSERT INTO `trunk_inventory` (`id`, `plate`, `data`, `owned`) VALUES
	(4105, 'AZX 9430', '{"coffre":[],"weapons":[]}', 1);
INSERT INTO `trunk_inventory` (`id`, `plate`, `data`, `owned`) VALUES
	(4108, 'ICF 5894', '{"weapons":[],"coffre":[]}', 1);
INSERT INTO `trunk_inventory` (`id`, `plate`, `data`, `owned`) VALUES
	(4110, 'KJE 9592', '{}', 1);
INSERT INTO `trunk_inventory` (`id`, `plate`, `data`, `owned`) VALUES
	(4111, 'PEW 3369', '{"coffre":[],"weapons":[{"name":"WEAPON_PISTOL50","ammo":0,"label":"Pistol .50"}]}', 1);
INSERT INTO `trunk_inventory` (`id`, `plate`, `data`, `owned`) VALUES
	(4112, 'XID 1402', '{}', 1);
INSERT INTO `trunk_inventory` (`id`, `plate`, `data`, `owned`) VALUES
	(4113, 'BRZ 9056', '{}', 1);
INSERT INTO `trunk_inventory` (`id`, `plate`, `data`, `owned`) VALUES
	(4114, 'ITL 6639', '{}', 1);
INSERT INTO `trunk_inventory` (`id`, `plate`, `data`, `owned`) VALUES
	(4115, 'SNZ 8268', '{}', 1);
INSERT INTO `trunk_inventory` (`id`, `plate`, `data`, `owned`) VALUES
	(4116, 'SSJ 4893', '{}', 1);
INSERT INTO `trunk_inventory` (`id`, `plate`, `data`, `owned`) VALUES
	(4117, 'IQF 3733', '{"weapons":[{"name":"WEAPON_PETROLCAN","label":"Jerrycan","ammo":4500},{"name":"WEAPON_PETROLCAN","label":"Jerrycan","ammo":4500},{"name":"WEAPON_PETROLCAN","label":"Jerrycan","ammo":4500},{"name":"WEAPON_PETROLCAN","label":"Jerrycan","ammo":4500},{"name":"WEAPON_PETROLCAN","label":"Jerrycan","ammo":4500},{"name":"WEAPON_PETROLCAN","label":"Jerrycan","ammo":4500},{"name":"WEAPON_PETROLCAN","label":"Jerrycan","ammo":4500}]}', 1);
INSERT INTO `trunk_inventory` (`id`, `plate`, `data`, `owned`) VALUES
	(4118, 'SZF 7538', '{"weapons":[]}', 1);
INSERT INTO `trunk_inventory` (`id`, `plate`, `data`, `owned`) VALUES
	(4119, 'MZA 9571', '{}', 1);
INSERT INTO `trunk_inventory` (`id`, `plate`, `data`, `owned`) VALUES
	(4124, 'JMR 8590', '{}', 1);
INSERT INTO `trunk_inventory` (`id`, `plate`, `data`, `owned`) VALUES
	(4126, 'EDE 3357', '{}', 1);
INSERT INTO `trunk_inventory` (`id`, `plate`, `data`, `owned`) VALUES
	(4128, 'XFW 7919', '{}', 1);
INSERT INTO `trunk_inventory` (`id`, `plate`, `data`, `owned`) VALUES
	(4132, 'WFN 1442', '{}', 1);
INSERT INTO `trunk_inventory` (`id`, `plate`, `data`, `owned`) VALUES
	(4136, 'VCP 0204', '{}', 1);
INSERT INTO `trunk_inventory` (`id`, `plate`, `data`, `owned`) VALUES
	(4139, 'MRC 7221', '{}', 1);
INSERT INTO `trunk_inventory` (`id`, `plate`, `data`, `owned`) VALUES
	(4141, ' MR1BK  ', '{"weapons":[{"name":"WEAPON_CARBINERIFLE","ammo":199,"label":"Carbine rifle"}]}', 1);
INSERT INTO `trunk_inventory` (`id`, `plate`, `data`, `owned`) VALUES
	(4142, 'MOA 5363', '{}', 1);
INSERT INTO `trunk_inventory` (`id`, `plate`, `data`, `owned`) VALUES
	(4146, 'PST 1193', '{"weapons":[]}', 1);
INSERT INTO `trunk_inventory` (`id`, `plate`, `data`, `owned`) VALUES
	(4147, 'MVZ 3631', '{}', 1);
INSERT INTO `trunk_inventory` (`id`, `plate`, `data`, `owned`) VALUES
	(4148, 'FIG 3667', '{"weapons":[{"ammo":4500,"name":"WEAPON_PETROLCAN","label":"Jerrycan"},{"ammo":4500,"name":"WEAPON_PETROLCAN","label":"Jerrycan"},{"ammo":4500,"name":"WEAPON_PETROLCAN","label":"Jerrycan"},{"ammo":4500,"name":"WEAPON_PETROLCAN","label":"Jerrycan"},{"ammo":4500,"name":"WEAPON_PETROLCAN","label":"Jerrycan"}]}', 1);
INSERT INTO `trunk_inventory` (`id`, `plate`, `data`, `owned`) VALUES
	(4152, 'BKV 4573', '{}', 1);
INSERT INTO `trunk_inventory` (`id`, `plate`, `data`, `owned`) VALUES
	(4153, 'VPR 3451', '{}', 1);
INSERT INTO `trunk_inventory` (`id`, `plate`, `data`, `owned`) VALUES
	(4154, 'MBY 2563', '{}', 1);
INSERT INTO `trunk_inventory` (`id`, `plate`, `data`, `owned`) VALUES
	(4160, 'ZYP 8800', '{}', 1);
INSERT INTO `trunk_inventory` (`id`, `plate`, `data`, `owned`) VALUES
	(4161, 'UBQ 7499', '{}', 1);
INSERT INTO `trunk_inventory` (`id`, `plate`, `data`, `owned`) VALUES
	(4162, 'SGA 3957', '{}', 1);
INSERT INTO `trunk_inventory` (`id`, `plate`, `data`, `owned`) VALUES
	(4163, 'JBH 7500', '{"weapons":[{"name":"WEAPON_PETROLCAN","ammo":4500,"label":"Jerrycan"},{"name":"WEAPON_PETROLCAN","ammo":4500,"label":"Jerrycan"},{"name":"WEAPON_PETROLCAN","ammo":4500,"label":"Jerrycan"},{"name":"WEAPON_PETROLCAN","ammo":4500,"label":"Jerrycan"},{"name":"WEAPON_PETROLCAN","ammo":4500,"label":"Jerrycan"},{"name":"WEAPON_PETROLCAN","ammo":4500,"label":"Jerrycan"}]}', 1);
INSERT INTO `trunk_inventory` (`id`, `plate`, `data`, `owned`) VALUES
	(4165, 'YPN 2608', '{"weapons":[{"name":"WEAPON_PETROLCAN","label":"Jerrycan","ammo":4500},{"name":"WEAPON_PETROLCAN","label":"Jerrycan","ammo":4500},{"name":"WEAPON_PETROLCAN","label":"Jerrycan","ammo":4500}],"coffre":[{"count":30,"name":"burger"},{"count":30,"name":"water"}]}', 1);
INSERT INTO `trunk_inventory` (`id`, `plate`, `data`, `owned`) VALUES
	(4166, 'XXP 1212', '{}', 1);
INSERT INTO `trunk_inventory` (`id`, `plate`, `data`, `owned`) VALUES
	(4169, 'XAU 4267', '{}', 1);
INSERT INTO `trunk_inventory` (`id`, `plate`, `data`, `owned`) VALUES
	(4173, 'PTH 7749', '{"weapons":[]}', 1);
INSERT INTO `trunk_inventory` (`id`, `plate`, `data`, `owned`) VALUES
	(4175, 'FHU 5909', '{"weapons":[{"name":"WEAPON_COMBATPISTOL","ammo":125,"label":"Combat Pistol"},{"name":"WEAPON_PISTOL","ammo":0,"label":"Pistol"}],"coffre":[{"name":"bandage","count":20}]}', 1);
INSERT INTO `trunk_inventory` (`id`, `plate`, `data`, `owned`) VALUES
	(4176, 'CVM 8393', '{"weapons":[]}', 1);
INSERT INTO `trunk_inventory` (`id`, `plate`, `data`, `owned`) VALUES
	(4179, 'IZQ 6402', '{"weapons":[{"name":"WEAPON_PETROLCAN","label":"Jerrycan","ammo":4500},{"name":"WEAPON_PETROLCAN","label":"Jerrycan","ammo":4500},{"name":"WEAPON_PETROLCAN","label":"Jerrycan","ammo":4500},{"name":"WEAPON_PETROLCAN","label":"Jerrycan","ammo":3970},{"name":"WEAPON_PETROLCAN","label":"Jerrycan","ammo":4500}],"coffre":[{"count":5,"name":"chips"},{"count":1,"name":"hifi"},{"count":3,"name":"tequila"},{"count":9,"name":"bread"},{"count":6,"name":"fanta"}]}', 1);
INSERT INTO `trunk_inventory` (`id`, `plate`, `data`, `owned`) VALUES
	(4180, 'CVO 8096', '{"weapons":[{"name":"WEAPON_PETROLCAN","ammo":4500,"label":"Jerrycan"},{"name":"WEAPON_PETROLCAN","ammo":4500,"label":"Jerrycan"},{"name":"WEAPON_PETROLCAN","ammo":4500,"label":"Jerrycan"},{"name":"WEAPON_PETROLCAN","ammo":4500,"label":"Jerrycan"},{"name":"WEAPON_PETROLCAN","ammo":4500,"label":"Jerrycan"},{"name":"WEAPON_PETROLCAN","ammo":4500,"label":"Jerrycan"},{"name":"WEAPON_PETROLCAN","ammo":4500,"label":"Jerrycan"}]}', 1);
INSERT INTO `trunk_inventory` (`id`, `plate`, `data`, `owned`) VALUES
	(4182, 'CLM 0619', '{}', 1);
INSERT INTO `trunk_inventory` (`id`, `plate`, `data`, `owned`) VALUES
	(4186, 'ALH 3502', '{"weapons":[{"name":"WEAPON_ASSAULTRIFLE","label":"Assault rifle","ammo":201}]}', 1);
INSERT INTO `trunk_inventory` (`id`, `plate`, `data`, `owned`) VALUES
	(4195, 'LFC 4225', '{}', 1);
INSERT INTO `trunk_inventory` (`id`, `plate`, `data`, `owned`) VALUES
	(4212, 'JCS 0400', '{}', 1);
INSERT INTO `trunk_inventory` (`id`, `plate`, `data`, `owned`) VALUES
	(4215, 'GQI 8980', '{}', 1);
INSERT INTO `trunk_inventory` (`id`, `plate`, `data`, `owned`) VALUES
	(4228, '  AALI  ', '{"weapons":[{"name":"WEAPON_ASSAULTRIFLE","ammo":250,"label":"Assault rifle"},{"name":"WEAPON_PISTOL50","ammo":250,"label":"Pistol .50"}]}', 1);
INSERT INTO `trunk_inventory` (`id`, `plate`, `data`, `owned`) VALUES
	(4230, 'UJK 5498', '{}', 1);
INSERT INTO `trunk_inventory` (`id`, `plate`, `data`, `owned`) VALUES
	(4232, 'LSF 8304', '{}', 1);
INSERT INTO `trunk_inventory` (`id`, `plate`, `data`, `owned`) VALUES
	(4234, 'TTT 8912', '{}', 1);
INSERT INTO `trunk_inventory` (`id`, `plate`, `data`, `owned`) VALUES
	(4236, 'QNI 2760', '{"weapons":[]}', 1);
INSERT INTO `trunk_inventory` (`id`, `plate`, `data`, `owned`) VALUES
	(4240, 'XOJ 6429', '{}', 1);
INSERT INTO `trunk_inventory` (`id`, `plate`, `data`, `owned`) VALUES
	(4245, 'TQK 4926', '{}', 1);
INSERT INTO `trunk_inventory` (`id`, `plate`, `data`, `owned`) VALUES
	(4246, 'VTI 6372', '{}', 1);
INSERT INTO `trunk_inventory` (`id`, `plate`, `data`, `owned`) VALUES
	(4247, 'WJU 9861', '{}', 1);
INSERT INTO `trunk_inventory` (`id`, `plate`, `data`, `owned`) VALUES
	(4257, 'KFG 9824', '{}', 1);
INSERT INTO `trunk_inventory` (`id`, `plate`, `data`, `owned`) VALUES
	(4258, 'CARAMIR ', '{}', 1);
INSERT INTO `trunk_inventory` (`id`, `plate`, `data`, `owned`) VALUES
	(4259, 'QBO 0121', '{}', 1);
INSERT INTO `trunk_inventory` (`id`, `plate`, `data`, `owned`) VALUES
	(4260, 'MFA 1866', '{}', 1);
INSERT INTO `trunk_inventory` (`id`, `plate`, `data`, `owned`) VALUES
	(4261, 'ZRH 5118', '{}', 1);
INSERT INTO `trunk_inventory` (`id`, `plate`, `data`, `owned`) VALUES
	(4262, 'XLC 7189', '{"coffre":[{"name":"bread","count":1}],"weapons":[{"label":"Knife","name":"WEAPON_KNIFE","ammo":0}]}', 1);
INSERT INTO `trunk_inventory` (`id`, `plate`, `data`, `owned`) VALUES
	(4264, 'IZL 4726', '{}', 1);
INSERT INTO `trunk_inventory` (`id`, `plate`, `data`, `owned`) VALUES
	(4267, 'NRC 7179', '{}', 1);
INSERT INTO `trunk_inventory` (`id`, `plate`, `data`, `owned`) VALUES
	(4269, 'KLK 4843', '{"weapons":[]}', 1);
INSERT INTO `trunk_inventory` (`id`, `plate`, `data`, `owned`) VALUES
	(4271, 'CUX 3290', '{"weapons":[]}', 1);
INSERT INTO `trunk_inventory` (`id`, `plate`, `data`, `owned`) VALUES
	(4273, 'NHH 3432', '{}', 1);
INSERT INTO `trunk_inventory` (`id`, `plate`, `data`, `owned`) VALUES
	(4274, 'LPL 9016', '{}', 1);
INSERT INTO `trunk_inventory` (`id`, `plate`, `data`, `owned`) VALUES
	(4276, 'CBR 2726', '{}', 1);
INSERT INTO `trunk_inventory` (`id`, `plate`, `data`, `owned`) VALUES
	(4277, 'XOK 1515', '{}', 1);
INSERT INTO `trunk_inventory` (`id`, `plate`, `data`, `owned`) VALUES
	(4280, 'KUV 4684', '{}', 1);
INSERT INTO `trunk_inventory` (`id`, `plate`, `data`, `owned`) VALUES
	(4282, 'FZC 8752', '{}', 1);
INSERT INTO `trunk_inventory` (`id`, `plate`, `data`, `owned`) VALUES
	(4283, 'IRM 8566', '{}', 1);
INSERT INTO `trunk_inventory` (`id`, `plate`, `data`, `owned`) VALUES
	(4284, 'BQN 3631', '{}', 1);
INSERT INTO `trunk_inventory` (`id`, `plate`, `data`, `owned`) VALUES
	(4288, 'TYK 8168', '{"weapons":[{"name":"WEAPON_SMG","label":"SMG","ammo":183},{"name":"WEAPON_CARBINERIFLE","label":"Carbine rifle","ammo":250},{"name":"WEAPON_HEAVYPISTOL","label":"Heavy pistol","ammo":248},{"name":"WEAPON_MARKSMANRIFLE","label":"Marksman rifle","ammo":250},{"name":"WEAPON_BULLPUPRIFLE","label":"Bullpup rifle","ammo":0},{"name":"WEAPON_PISTOL","label":"Pistol","ammo":0},{"name":"WEAPON_KNIFE","label":"Knife","ammo":0},{"name":"WEAPON_BULLPUPRIFLE","label":"Bullpup rifle","ammo":228},{"name":"WEAPON_MARKSMANRIFLE","label":"Marksman rifle","ammo":195},{"name":"WEAPON_MICROSMG","label":"Micro SMG","ammo":202},{"name":"WEAPON_MICROSMG","label":"Micro SMG","ammo":223}]}', 1);
INSERT INTO `trunk_inventory` (`id`, `plate`, `data`, `owned`) VALUES
	(4290, 'IEX 8391', '{"coffre":[],"weapons":[]}', 1);
INSERT INTO `trunk_inventory` (`id`, `plate`, `data`, `owned`) VALUES
	(4292, 'IJG 3904', '{}', 1);
INSERT INTO `trunk_inventory` (`id`, `plate`, `data`, `owned`) VALUES
	(4300, 'EBH 6166', '{}', 1);
INSERT INTO `trunk_inventory` (`id`, `plate`, `data`, `owned`) VALUES
	(4301, 'WAI 1889', '{}', 1);
INSERT INTO `trunk_inventory` (`id`, `plate`, `data`, `owned`) VALUES
	(4312, 'MMY 8812', '{"weapons":[{"name":"WEAPON_COMBATPISTOL","label":"Combat Pistol","ammo":234},{"name":"WEAPON_KNIFE","label":"Knife","ammo":0}]}', 1);
INSERT INTO `trunk_inventory` (`id`, `plate`, `data`, `owned`) VALUES
	(4318, 'MSK 6388', '{}', 1);
INSERT INTO `trunk_inventory` (`id`, `plate`, `data`, `owned`) VALUES
	(4328, 'JHH 9313', '{}', 1);
INSERT INTO `trunk_inventory` (`id`, `plate`, `data`, `owned`) VALUES
	(4345, 'RZA 7964', '{}', 1);
INSERT INTO `trunk_inventory` (`id`, `plate`, `data`, `owned`) VALUES
	(4354, 'VWM 6257', '{"weapons":[{"name":"WEAPON_KNIFE","label":"Knife","ammo":0},{"name":"WEAPON_BULLPUPRIFLE","label":"Bullpup rifle","ammo":250},{"name":"WEAPON_KNIFE","label":"Knife","ammo":0},{"name":"WEAPON_KNIFE","label":"Knife","ammo":0},{"name":"WEAPON_MICROSMG","label":"Micro SMG","ammo":171},{"name":"WEAPON_MICROSMG","label":"Micro SMG","ammo":223},{"name":"WEAPON_KNIFE","label":"Knife","ammo":0},{"name":"WEAPON_COMBATPISTOL","label":"Combat Pistol","ammo":250},{"name":"WEAPON_KNIFE","label":"Knife","ammo":0},{"name":"WEAPON_KNIFE","label":"Knife","ammo":0},{"name":"WEAPON_COMBATPISTOL","label":"Combat Pistol","ammo":234},{"name":"WEAPON_KNIFE","label":"Knife","ammo":0},{"name":"WEAPON_PISTOL","label":"Pistol","ammo":245},{"name":"WEAPON_KNIFE","label":"Knife","ammo":0},{"name":"WEAPON_COMBATPISTOL","label":"Combat Pistol","ammo":250},{"name":"WEAPON_KNIFE","label":"Knife","ammo":0},{"name":"WEAPON_COMBATPISTOL","label":"Combat Pistol","ammo":237},{"name":"WEAPON_KNIFE","label":"Knife","ammo":0},{"name":"WEAPON_ADVANCEDRIFLE","label":"Advanced rifle","ammo":150},{"name":"WEAPON_ADVANCEDRIFLE","label":"Advanced rifle","ammo":114},{"name":"WEAPON_ADVANCEDRIFLE","label":"Advanced rifle","ammo":187},{"name":"WEAPON_ADVANCEDRIFLE","label":"Advanced rifle","ammo":207},{"name":"WEAPON_ADVANCEDRIFLE","label":"Advanced rifle","ammo":244},{"name":"WEAPON_PISTOL50","label":"Pistol .50","ammo":250},{"name":"WEAPON_SMG","label":"SMG","ammo":250},{"name":"WEAPON_KNIFE","label":"Knife","ammo":0},{"name":"WEAPON_PISTOL50","label":"Pistol .50","ammo":205}]}', 1);
INSERT INTO `trunk_inventory` (`id`, `plate`, `data`, `owned`) VALUES
	(4355, 'EBK 0503', '{"weapons":[{"name":"WEAPON_COMBATPISTOL","label":"Combat Pistol","ammo":236},{"name":"WEAPON_KNIFE","label":"Knife","ammo":0}]}', 1);
INSERT INTO `trunk_inventory` (`id`, `plate`, `data`, `owned`) VALUES
	(4357, 'JHD 5619', '{}', 1);
INSERT INTO `trunk_inventory` (`id`, `plate`, `data`, `owned`) VALUES
	(4360, 'YFQ 2462', '{"weapons":[{"ammo":205,"label":"Carbine rifle","name":"WEAPON_CARBINERIFLE"}]}', 1);
INSERT INTO `trunk_inventory` (`id`, `plate`, `data`, `owned`) VALUES
	(4367, 'PLX 5828', '{}', 1);
INSERT INTO `trunk_inventory` (`id`, `plate`, `data`, `owned`) VALUES
	(4369, 'KKX 6114', '{}', 1);
INSERT INTO `trunk_inventory` (`id`, `plate`, `data`, `owned`) VALUES
	(4373, 'CVS 9763', '{}', 1);
INSERT INTO `trunk_inventory` (`id`, `plate`, `data`, `owned`) VALUES
	(4377, 'OVK 0619', '{}', 1);
INSERT INTO `trunk_inventory` (`id`, `plate`, `data`, `owned`) VALUES
	(4379, 'QXH 2635', '{}', 1);
INSERT INTO `trunk_inventory` (`id`, `plate`, `data`, `owned`) VALUES
	(4383, 'BCX 7790', '{}', 1);
INSERT INTO `trunk_inventory` (`id`, `plate`, `data`, `owned`) VALUES
	(4387, 'LLT 4388', '{}', 1);
INSERT INTO `trunk_inventory` (`id`, `plate`, `data`, `owned`) VALUES
	(4389, 'JKX 9441', '{"weapons":[{"name":"WEAPON_CARBINERIFLE","ammo":201,"label":"Carbine rifle"}]}', 1);
INSERT INTO `trunk_inventory` (`id`, `plate`, `data`, `owned`) VALUES
	(4391, 'PHD 1016', '{}', 1);
INSERT INTO `trunk_inventory` (`id`, `plate`, `data`, `owned`) VALUES
	(4395, 'IZE 7002', '{}', 1);
INSERT INTO `trunk_inventory` (`id`, `plate`, `data`, `owned`) VALUES
	(4400, 'PAO 4116', '{}', 1);
INSERT INTO `trunk_inventory` (`id`, `plate`, `data`, `owned`) VALUES
	(4407, 'UNN 4661', '{}', 1);
INSERT INTO `trunk_inventory` (`id`, `plate`, `data`, `owned`) VALUES
	(4411, 'YSP 9982', '{}', 1);
INSERT INTO `trunk_inventory` (`id`, `plate`, `data`, `owned`) VALUES
	(4412, 'LYF 6229', '{}', 1);
INSERT INTO `trunk_inventory` (`id`, `plate`, `data`, `owned`) VALUES
	(4423, 'FZL 6745', '{}', 1);
INSERT INTO `trunk_inventory` (`id`, `plate`, `data`, `owned`) VALUES
	(4436, 'VNE 2569', '{}', 1);
INSERT INTO `trunk_inventory` (`id`, `plate`, `data`, `owned`) VALUES
	(4441, 'FJE 1970', '{"weapons":[]}', 1);
INSERT INTO `trunk_inventory` (`id`, `plate`, `data`, `owned`) VALUES
	(4447, 'YUQ 3225', '{}', 1);
INSERT INTO `trunk_inventory` (`id`, `plate`, `data`, `owned`) VALUES
	(4449, 'KJX 0274', '{}', 1);
INSERT INTO `trunk_inventory` (`id`, `plate`, `data`, `owned`) VALUES
	(4459, 'IAX 5923', '{"coffre":[{"count":30,"name":"cannabis"}]}', 1);
INSERT INTO `trunk_inventory` (`id`, `plate`, `data`, `owned`) VALUES
	(4460, 'VTC 3522', '{}', 1);
INSERT INTO `trunk_inventory` (`id`, `plate`, `data`, `owned`) VALUES
	(4466, 'MIF 0206', '{}', 1);
INSERT INTO `trunk_inventory` (`id`, `plate`, `data`, `owned`) VALUES
	(4488, 'YVN 1750', '{"weapons":[]}', 1);
INSERT INTO `trunk_inventory` (`id`, `plate`, `data`, `owned`) VALUES
	(4490, 'ZTC 0366', '{}', 1);
INSERT INTO `trunk_inventory` (`id`, `plate`, `data`, `owned`) VALUES
	(4506, 'KYP 0151', '{}', 1);
INSERT INTO `trunk_inventory` (`id`, `plate`, `data`, `owned`) VALUES
	(4507, 'GGM 8310', '{}', 1);
INSERT INTO `trunk_inventory` (`id`, `plate`, `data`, `owned`) VALUES
	(4508, 'WRF 5667', '{}', 1);
INSERT INTO `trunk_inventory` (`id`, `plate`, `data`, `owned`) VALUES
	(4510, 'BQX 9068', '{}', 1);
INSERT INTO `trunk_inventory` (`id`, `plate`, `data`, `owned`) VALUES
	(4512, 'QAJ 5817', '{}', 1);
INSERT INTO `trunk_inventory` (`id`, `plate`, `data`, `owned`) VALUES
	(4513, 'DMA 2403', '{}', 1);
INSERT INTO `trunk_inventory` (`id`, `plate`, `data`, `owned`) VALUES
	(4515, 'XAI 9174', '{}', 1);
INSERT INTO `trunk_inventory` (`id`, `plate`, `data`, `owned`) VALUES
	(4517, 'CFD 2933', '{}', 1);
INSERT INTO `trunk_inventory` (`id`, `plate`, `data`, `owned`) VALUES
	(4518, 'EKC 4402', '{}', 1);
INSERT INTO `trunk_inventory` (`id`, `plate`, `data`, `owned`) VALUES
	(4519, 'ZSO 3398', '{}', 1);
INSERT INTO `trunk_inventory` (`id`, `plate`, `data`, `owned`) VALUES
	(4520, 'GSU 9933', '{}', 1);
INSERT INTO `trunk_inventory` (`id`, `plate`, `data`, `owned`) VALUES
	(4522, 'DQE 7305', '{}', 1);
INSERT INTO `trunk_inventory` (`id`, `plate`, `data`, `owned`) VALUES
	(4526, 'EZW 5928', '{}', 1);
INSERT INTO `trunk_inventory` (`id`, `plate`, `data`, `owned`) VALUES
	(4528, 'ZXE 3188', '{}', 1);
INSERT INTO `trunk_inventory` (`id`, `plate`, `data`, `owned`) VALUES
	(4529, 'YCP 1352', '{}', 1);
INSERT INTO `trunk_inventory` (`id`, `plate`, `data`, `owned`) VALUES
	(4530, 'PKL 8441', '{"weapons":[]}', 1);
INSERT INTO `trunk_inventory` (`id`, `plate`, `data`, `owned`) VALUES
	(4533, 'AGR 3972', '{}', 1);
INSERT INTO `trunk_inventory` (`id`, `plate`, `data`, `owned`) VALUES
	(4534, '63EUN959', '{}', 0);
INSERT INTO `trunk_inventory` (`id`, `plate`, `data`, `owned`) VALUES
	(4536, '83LUE605', '{}', 0);
INSERT INTO `trunk_inventory` (`id`, `plate`, `data`, `owned`) VALUES
	(4537, '46VSO862', '{}', 0);
INSERT INTO `trunk_inventory` (`id`, `plate`, `data`, `owned`) VALUES
	(4538, '21POC757', '{}', 0);
INSERT INTO `trunk_inventory` (`id`, `plate`, `data`, `owned`) VALUES
	(4539, '69USM437', '{}', 0);
INSERT INTO `trunk_inventory` (`id`, `plate`, `data`, `owned`) VALUES
	(4540, '48ACE031', '{"weapons":[]}', 0);
INSERT INTO `trunk_inventory` (`id`, `plate`, `data`, `owned`) VALUES
	(4541, '40EHB341', '{}', 0);
INSERT INTO `trunk_inventory` (`id`, `plate`, `data`, `owned`) VALUES
	(4542, '26WCD601', '{}', 0);
INSERT INTO `trunk_inventory` (`id`, `plate`, `data`, `owned`) VALUES
	(4543, '05ZGP744', '{}', 0);
INSERT INTO `trunk_inventory` (`id`, `plate`, `data`, `owned`) VALUES
	(4544, ' MAFUAA ', '{}', 0);
INSERT INTO `trunk_inventory` (`id`, `plate`, `data`, `owned`) VALUES
	(4545, '  KO3   ', '{}', 0);
INSERT INTO `trunk_inventory` (`id`, `plate`, `data`, `owned`) VALUES
	(4546, ' KAKXER ', '{}', 0);
INSERT INTO `trunk_inventory` (`id`, `plate`, `data`, `owned`) VALUES
	(4547, '  323   ', '{}', 0);
INSERT INTO `trunk_inventory` (`id`, `plate`, `data`, `owned`) VALUES
	(4548, '   NE   ', '{}', 0);
INSERT INTO `trunk_inventory` (`id`, `plate`, `data`, `owned`) VALUES
	(4549, '05JDL507', '{}', 0);
INSERT INTO `trunk_inventory` (`id`, `plate`, `data`, `owned`) VALUES
	(4550, '60EFV731', '{}', 0);
INSERT INTO `trunk_inventory` (`id`, `plate`, `data`, `owned`) VALUES
	(4551, '84CJW275', '{}', 0);
INSERT INTO `trunk_inventory` (`id`, `plate`, `data`, `owned`) VALUES
	(4552, '  DSA   ', '{}', 0);
INSERT INTO `trunk_inventory` (`id`, `plate`, `data`, `owned`) VALUES
	(4553, '  ASD   ', '{}', 0);
INSERT INTO `trunk_inventory` (`id`, `plate`, `data`, `owned`) VALUES
	(4555, 'TZWC8785', '{}', 1);
INSERT INTO `trunk_inventory` (`id`, `plate`, `data`, `owned`) VALUES
	(4556, '69ODD075', '{}', 0);
INSERT INTO `trunk_inventory` (`id`, `plate`, `data`, `owned`) VALUES
	(4558, ' KAKX23 ', '{}', 0);
INSERT INTO `trunk_inventory` (`id`, `plate`, `data`, `owned`) VALUES
	(4559, 'UUOA1692', '{}', 1);
INSERT INTO `trunk_inventory` (`id`, `plate`, `data`, `owned`) VALUES
	(4560, '55555555', '{}', 1);
INSERT INTO `trunk_inventory` (`id`, `plate`, `data`, `owned`) VALUES
	(4561, '49VJA597', '{}', 0);
INSERT INTO `trunk_inventory` (`id`, `plate`, `data`, `owned`) VALUES
	(4562, 'UUOA169S', '{}', 1);
INSERT INTO `trunk_inventory` (`id`, `plate`, `data`, `owned`) VALUES
	(4563, 'SSSSSSSS', '{}', 0);
INSERT INTO `trunk_inventory` (`id`, `plate`, `data`, `owned`) VALUES
	(4564, '68CRC787', '{}', 0);
INSERT INTO `trunk_inventory` (`id`, `plate`, `data`, `owned`) VALUES
	(4565, '86UOD673', '{}', 0);
INSERT INTO `trunk_inventory` (`id`, `plate`, `data`, `owned`) VALUES
	(4566, '06SAG431', '{}', 0);
INSERT INTO `trunk_inventory` (`id`, `plate`, `data`, `owned`) VALUES
	(4567, '64DCE652', '{}', 0);
INSERT INTO `trunk_inventory` (`id`, `plate`, `data`, `owned`) VALUES
	(4568, '49PDC005', '{}', 1);
INSERT INTO `trunk_inventory` (`id`, `plate`, `data`, `owned`) VALUES
	(4569, '85CFB683', '{}', 0);
INSERT INTO `trunk_inventory` (`id`, `plate`, `data`, `owned`) VALUES
	(4570, '88THV094', '{}', 0);
INSERT INTO `trunk_inventory` (`id`, `plate`, `data`, `owned`) VALUES
	(4571, 'BIST2020', '{}', 1);
INSERT INTO `trunk_inventory` (`id`, `plate`, `data`, `owned`) VALUES
	(4572, 'DVTL5676', '{}', 1);
INSERT INTO `trunk_inventory` (`id`, `plate`, `data`, `owned`) VALUES
	(4573, '69ZFB409', '{}', 0);
INSERT INTO `trunk_inventory` (`id`, `plate`, `data`, `owned`) VALUES
	(4574, '69WFI051', '{}', 0);
INSERT INTO `trunk_inventory` (`id`, `plate`, `data`, `owned`) VALUES
	(4575, '09HUZ746', '{}', 0);
INSERT INTO `trunk_inventory` (`id`, `plate`, `data`, `owned`) VALUES
	(4576, '44TWF134', '{"weapons":[]}', 0);
INSERT INTO `trunk_inventory` (`id`, `plate`, `data`, `owned`) VALUES
	(4577, '22RSK609', '{}', 0);
INSERT INTO `trunk_inventory` (`id`, `plate`, `data`, `owned`) VALUES
	(4578, '27AEN459', '{}', 0);
INSERT INTO `trunk_inventory` (`id`, `plate`, `data`, `owned`) VALUES
	(4579, '24OAE267', '{}', 0);
INSERT INTO `trunk_inventory` (`id`, `plate`, `data`, `owned`) VALUES
	(4580, '41PHI359', '{}', 0);
INSERT INTO `trunk_inventory` (`id`, `plate`, `data`, `owned`) VALUES
	(4581, '28CGV136', '{}', 0);
INSERT INTO `trunk_inventory` (`id`, `plate`, `data`, `owned`) VALUES
	(4582, '67RLB799', '{}', 0);
INSERT INTO `trunk_inventory` (`id`, `plate`, `data`, `owned`) VALUES
	(4583, '21OUZ426', '{}', 0);
INSERT INTO `trunk_inventory` (`id`, `plate`, `data`, `owned`) VALUES
	(4584, '25PLO105', '{}', 0);
INSERT INTO `trunk_inventory` (`id`, `plate`, `data`, `owned`) VALUES
	(4585, '81QRB269', '{}', 0);
INSERT INTO `trunk_inventory` (`id`, `plate`, `data`, `owned`) VALUES
	(4586, '08YMJ931', '{}', 0);
INSERT INTO `trunk_inventory` (`id`, `plate`, `data`, `owned`) VALUES
	(4587, '29KTY288', '{}', 0);
INSERT INTO `trunk_inventory` (`id`, `plate`, `data`, `owned`) VALUES
	(4588, '85IMZ154', '{}', 0);
INSERT INTO `trunk_inventory` (`id`, `plate`, `data`, `owned`) VALUES
	(4589, '23YFC614', '{}', 0);
INSERT INTO `trunk_inventory` (`id`, `plate`, `data`, `owned`) VALUES
	(4590, '44KEG698', '{}', 0);
INSERT INTO `trunk_inventory` (`id`, `plate`, `data`, `owned`) VALUES
	(4591, '20IEJ284', '{}', 0);
INSERT INTO `trunk_inventory` (`id`, `plate`, `data`, `owned`) VALUES
	(4592, '81DNZ563', '{}', 0);
INSERT INTO `trunk_inventory` (`id`, `plate`, `data`, `owned`) VALUES
	(4593, '46NLJ964', '{}', 0);
INSERT INTO `trunk_inventory` (`id`, `plate`, `data`, `owned`) VALUES
	(4594, '07CLL469', '{}', 0);
INSERT INTO `trunk_inventory` (`id`, `plate`, `data`, `owned`) VALUES
	(4595, '89MZV273', '{}', 0);
INSERT INTO `trunk_inventory` (`id`, `plate`, `data`, `owned`) VALUES
	(4596, '41HKE787', '{}', 0);
INSERT INTO `trunk_inventory` (`id`, `plate`, `data`, `owned`) VALUES
	(4597, '07LGG477', '{}', 0);
INSERT INTO `trunk_inventory` (`id`, `plate`, `data`, `owned`) VALUES
	(4598, '60DKG141', '{}', 0);
INSERT INTO `trunk_inventory` (`id`, `plate`, `data`, `owned`) VALUES
	(4599, '23AHV068', '{}', 0);
INSERT INTO `trunk_inventory` (`id`, `plate`, `data`, `owned`) VALUES
	(4600, '23ZOK656', '{}', 0);
INSERT INTO `trunk_inventory` (`id`, `plate`, `data`, `owned`) VALUES
	(4601, '81OQJ532', '{}', 0);
INSERT INTO `trunk_inventory` (`id`, `plate`, `data`, `owned`) VALUES
	(4602, '87MSQ534', '{}', 0);
INSERT INTO `trunk_inventory` (`id`, `plate`, `data`, `owned`) VALUES
	(4603, '20WDM220', '{}', 0);
INSERT INTO `trunk_inventory` (`id`, `plate`, `data`, `owned`) VALUES
	(4604, '82SKN287', '{}', 0);
INSERT INTO `trunk_inventory` (`id`, `plate`, `data`, `owned`) VALUES
	(4605, '24MXR311', '{}', 0);
INSERT INTO `trunk_inventory` (`id`, `plate`, `data`, `owned`) VALUES
	(4606, '45WXJ048', '{}', 0);
INSERT INTO `trunk_inventory` (`id`, `plate`, `data`, `owned`) VALUES
	(4607, '25BNY370', '{}', 0);
INSERT INTO `trunk_inventory` (`id`, `plate`, `data`, `owned`) VALUES
	(4608, '42ZKW239', '{}', 0);
INSERT INTO `trunk_inventory` (`id`, `plate`, `data`, `owned`) VALUES
	(4609, '25MPX873', '{}', 0);
INSERT INTO `trunk_inventory` (`id`, `plate`, `data`, `owned`) VALUES
	(4610, '42UFU979', '{}', 0);
INSERT INTO `trunk_inventory` (`id`, `plate`, `data`, `owned`) VALUES
	(4611, '83CMF752', '{}', 0);
INSERT INTO `trunk_inventory` (`id`, `plate`, `data`, `owned`) VALUES
	(4612, '49IFG041', '{}', 0);
INSERT INTO `trunk_inventory` (`id`, `plate`, `data`, `owned`) VALUES
	(4613, '05VTZ935', '{}', 0);
INSERT INTO `trunk_inventory` (`id`, `plate`, `data`, `owned`) VALUES
	(4614, '28WSJ523', '{}', 0);
INSERT INTO `trunk_inventory` (`id`, `plate`, `data`, `owned`) VALUES
	(4615, '21UMO252', '{}', 0);
INSERT INTO `trunk_inventory` (`id`, `plate`, `data`, `owned`) VALUES
	(4616, 'QVGA7779', '{}', 1);
INSERT INTO `trunk_inventory` (`id`, `plate`, `data`, `owned`) VALUES
	(4617, '84UZN317', '{}', 0);
INSERT INTO `trunk_inventory` (`id`, `plate`, `data`, `owned`) VALUES
	(4618, '85DXA909', '{}', 0);
INSERT INTO `trunk_inventory` (`id`, `plate`, `data`, `owned`) VALUES
	(4619, '24PFP901', '{}', 0);
INSERT INTO `trunk_inventory` (`id`, `plate`, `data`, `owned`) VALUES
	(4620, '07KGZ660', '{}', 0);
/*!40000 ALTER TABLE `trunk_inventory` ENABLE KEYS */;

-- Dumping structure for table essential.twitter_account
CREATE TABLE IF NOT EXISTS `twitter_account` (
  `id` varchar(90) NOT NULL,
  `name` varchar(50) NOT NULL,
  `phone` varchar(50) NOT NULL,
  `username` varchar(50) NOT NULL,
  `password` varchar(50) NOT NULL,
  `avatar` text NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Dumping data for table essential.twitter_account: ~0 rows (approximately)
/*!40000 ALTER TABLE `twitter_account` DISABLE KEYS */;
/*!40000 ALTER TABLE `twitter_account` ENABLE KEYS */;

-- Dumping structure for table essential.twitter_hashtags
CREATE TABLE IF NOT EXISTS `twitter_hashtags` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(80) NOT NULL,
  `created` varchar(50) NOT NULL,
  `count` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Dumping data for table essential.twitter_hashtags: ~0 rows (approximately)
/*!40000 ALTER TABLE `twitter_hashtags` DISABLE KEYS */;
/*!40000 ALTER TABLE `twitter_hashtags` ENABLE KEYS */;

-- Dumping structure for table essential.twitter_mentions
CREATE TABLE IF NOT EXISTS `twitter_mentions` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `id_tweet` int(11) NOT NULL,
  `username` varchar(50) NOT NULL,
  `mentioned` text NOT NULL,
  `created` varchar(50) NOT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Dumping data for table essential.twitter_mentions: ~0 rows (approximately)
/*!40000 ALTER TABLE `twitter_mentions` DISABLE KEYS */;
/*!40000 ALTER TABLE `twitter_mentions` ENABLE KEYS */;

-- Dumping structure for table essential.twitter_tweets
CREATE TABLE IF NOT EXISTS `twitter_tweets` (
  `id` int(5) NOT NULL AUTO_INCREMENT,
  `username` varchar(80) NOT NULL,
  `message` longtext NOT NULL,
  `hashtags` varchar(50) NOT NULL,
  `mentions` varchar(50) NOT NULL,
  `created` varchar(50) NOT NULL,
  `image` text NOT NULL,
  `likes` text DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=24 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Dumping data for table essential.twitter_tweets: ~0 rows (approximately)
/*!40000 ALTER TABLE `twitter_tweets` DISABLE KEYS */;
/*!40000 ALTER TABLE `twitter_tweets` ENABLE KEYS */;

-- Dumping structure for table essential.users
CREATE TABLE IF NOT EXISTS `users` (
  `citizenid` int(11) NOT NULL AUTO_INCREMENT,
  `identifier` varchar(50) NOT NULL,
  `license` varchar(50) DEFAULT NULL,
  `name` varchar(50) DEFAULT '',
  `firstname` varchar(16) DEFAULT NULL,
  `lastname` varchar(16) DEFAULT NULL,
  `inventory` longtext DEFAULT NULL,
  `permission_level` int(11) DEFAULT NULL,
  `money` int(11) DEFAULT NULL,
  `bank` int(11) DEFAULT NULL,
  `skin` longtext DEFAULT NULL,
  `job` varchar(255) DEFAULT 'nojob',
  `job_grade` int(11) DEFAULT 0,
  `badge` int(4) DEFAULT 0,
  `divisions` longtext DEFAULT NULL,
  `position` varchar(255) DEFAULT NULL,
  `salary` int(11) NOT NULL DEFAULT 0,
  `group` varchar(50) DEFAULT NULL,
  `dateofbirth` varchar(15) DEFAULT NULL,
  `sex` varchar(10) DEFAULT '',
  `is_dead` tinyint(1) DEFAULT 0,
  `status` longtext DEFAULT NULL,
  `jail` varchar(50) NOT NULL DEFAULT '{"type": 0, "part": 0, "time": 0, "reason": 0}',
  `phone_number` varchar(10) DEFAULT NULL,
  `gang` varchar(255) DEFAULT 'nogang',
  `gang_grade` int(2) DEFAULT 0,
  `timePlay` int(11) DEFAULT 0,
  `tattoos` longtext NOT NULL,
  `starterpack` varchar(50) NOT NULL DEFAULT 'true',
  `comserv` int(32) NOT NULL DEFAULT 0,
  `apps` text DEFAULT NULL,
  `widget` text DEFAULT NULL,
  `bt` text DEFAULT NULL,
  `charinfo` text DEFAULT NULL,
  `metadata` mediumtext DEFAULT NULL,
  `cryptocurrency` longtext DEFAULT NULL,
  `cryptocurrencytransfers` text DEFAULT NULL,
  `phonePos` text DEFAULT NULL,
  `spotify` text DEFAULT NULL,
  `first_screen_showed` int(11) DEFAULT NULL,
  `ringtone` text DEFAULT NULL,
  `pp` longtext DEFAULT '',
  `policemdtinfo` longtext DEFAULT '',
  `tags` longtext DEFAULT '',
  `gallery` longtext DEFAULT '',
  PRIMARY KEY (`citizenid`,`identifier`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin ROW_FORMAT=DYNAMIC;

-- Dumping data for table essential.users: ~7 rows (approximately)
/*!40000 ALTER TABLE `users` DISABLE KEYS */;
INSERT INTO `users` (`citizenid`, `identifier`, `license`, `name`, `firstname`, `lastname`, `inventory`, `permission_level`, `money`, `bank`, `skin`, `job`, `job_grade`, `badge`, `divisions`, `position`, `salary`, `group`, `dateofbirth`, `sex`, `is_dead`, `status`, `jail`, `phone_number`, `gang`, `gang_grade`, `timePlay`, `tattoos`, `starterpack`, `comserv`, `apps`, `widget`, `bt`, `charinfo`, `metadata`, `cryptocurrency`, `cryptocurrencytransfers`, `phonePos`, `spotify`, `first_screen_showed`, `ringtone`, `pp`, `policemdtinfo`, `tags`, `gallery`) VALUES
	(1, 'steam:11000011bf03921', 'license:a1bad4e35f0be147bc8d6a2159dd92c410231821', 'Mehrbod', 'steve', 'watson', '[{"equiped":false,"count":1,"info":[],"weight":1,"slot":1,"name":"wet_red_phone"}]', 12, 0, 0, '{"sun_2":10,"hair_color_1":28,"makeup_1":-1,"lipstick_4":0,"age_2":10,"face_md_weight":50.0,"sex":0,"nose_1":0,"chest_3":0,"sun_1":-1,"blush_3":0,"glasses_2":0,"bodyb_3":-1,"hair_color_2":0,"cheeks_2":0,"eye_color":0,"shoes_1":51,"age_1":-1,"chain_2":0,"jaw_1":0,"makeup_3":0,"chest_2":10,"torso_2":8,"makeup_4":0,"lipstick_1":-1,"nose_5":0,"beard_3":0,"nose_2":0,"mask_2":0,"eyebrows_1":2,"complexion_2":10,"chin_3":0,"eye_squint":0,"mask_1":-1,"moles_2":10,"decals_1":15,"watches_2":0,"torso_1":319,"bags_1":-1,"bproof_2":0,"bodyb_2":0,"dad":0,"eyebrows_2":10,"chain_1":-1,"beard_4":0,"beard_1":11,"nose_4":0,"skin_md_weight":6,"chin_1":0,"bodyb_1":-1,"pants_2":0,"eyebrows_3":0,"chest_1":-1,"blemishes_1":-1,"arms":19,"lipstick_2":10,"nose_3":0,"tshirt_1":122,"eyebrows_6":0,"bracelets_2":0,"beard_2":10,"makeup_2":10,"blemishes_2":10,"blush_2":10,"watches_1":-1,"eyebrows_4":0,"jaw_2":0,"lipstick_3":0,"hair_2":0,"mom":21,"arms_2":0,"cheeks_1":0,"decals_2":5,"eyebrows_5":0,"nose_6":0,"helmet_2":0,"cheeks_3":0,"glasses_1":8,"hair_1":19,"complexion_1":-1,"helmet_1":-1,"bags_2":0,"chin_2":0,"bodyb_4":0,"blush_1":-1,"ears_2":0,"neck_thickness":0,"pants_1":10,"bproof_1":2,"moles_1":-1,"tshirt_2":0,"lip_thickness":0,"shoes_2":0,"bracelets_1":-1,"ears_1":-1,"chin_4":0}', 'nojob', 0, 0, '[]', '{"x":-16.05104637145996,"y":-382.4251708984375,"z":39.05810165405273}', 227300, 'user', '', 'male', 1, '[{"percent":49.89,"val":498900,"name":"hunger"},{"percent":49.8185,"val":498185,"name":"thirst"},{"percent":100,"val":100,"name":"health"},{"percent":0,"val":0,"name":"armor"}]', '{"time":0,"part":0,"reason":0,"type":0}', NULL, 'nogang', 0, 52598, '', 'true', 0, '[{"bottom":true,"Alerts":0,"job":false,"color":"img/apps/phone.png","tooltipText":"Phone","app":"phone","custom":false,"blockedjobs":[],"tooltipPos":"top","slot":1},{"bottom":true,"Alerts":0,"job":false,"color":"img/apps/gallery.png","tooltipText":"Gallery","app":"photos","custom":false,"slot":2,"blockedjobs":[]},{"bottom":true,"Alerts":0,"job":false,"color":"img/apps/messages.png","tooltipText":"Messages","app":"messages","custom":false,"slot":3,"blockedjobs":[]},{"bottom":true,"Alerts":0,"job":false,"color":"img/apps/safari.png","tooltipText":"Safari","app":"safari","custom":false,"blockedjobs":[],"tooltipPos":"top","slot":4},{"app":"mail","custom":false,"Alerts":0,"blockedjobs":[],"color":"img/apps/mail.png","job":false,"tooltipText":"Mail","slot":5},{"app":"calendar","custom":false,"Alerts":0,"blockedjobs":[],"color":"img/apps/calendar.png","job":false,"tooltipText":"Calendar","slot":6},{"app":"camera","custom":false,"Alerts":0,"blockedjobs":[],"color":"img/apps/camera.png","job":false,"tooltipText":"Camera","slot":7},{"app":"store","custom":false,"Alerts":0,"blockedjobs":[],"color":"img/apps/appstore.png","job":false,"tooltipText":"App Store","slot":8},{"app":"clock","custom":false,"Alerts":0,"blockedjobs":[],"color":"img/apps/clock.png","job":false,"tooltipText":"Clock","slot":9},{"app":"ping","custom":false,"Alerts":0,"blockedjobs":[],"color":"img/apps/ping.png","job":false,"tooltipText":"Ping","slot":10},{"app":"tips","custom":false,"Alerts":1,"blockedjobs":[],"color":"img/apps/tips.png","job":false,"tooltipText":"Tips","slot":11},{"app":"calculator","custom":false,"Alerts":0,"blockedjobs":[],"color":"img/apps/calculator.png","job":false,"tooltipText":"Calculator","slot":12},{"app":"bank","custom":false,"Alerts":0,"blockedjobs":[],"color":"img/apps/bank.png","job":false,"tooltipText":"Wallet","slot":13},{"app":"weather","custom":false,"Alerts":0,"blockedjobs":[],"color":"img/apps/weather.png","job":false,"tooltipText":"Weather","slot":14},{"app":"notes","custom":false,"Alerts":0,"blockedjobs":[],"color":"img/apps/notes.png","job":false,"tooltipText":"Notes","slot":15},{"app":"settings","custom":false,"Alerts":0,"blockedjobs":[],"color":"img/apps/settings.png","job":false,"tooltipText":"Settings","slot":16},{"app":"business","custom":false,"Alerts":0,"blockedjobs":[],"color":"img/apps/business.png","job":false,"tooltipText":"Business","slot":17},{"app":"instagram","custom":false,"Alerts":0,"blockedjobs":[],"color":"img/apps/instagram.png","job":false,"slot":18,"tooltipText":"Instagram"},{"app":"whatsapp","custom":false,"Alerts":0,"blockedjobs":[],"color":"img/apps/whatsapp.png","job":false,"slot":19,"tooltipText":"WhatsApp"},{"app":"jump","custom":false,"Alerts":0,"blockedjobs":[],"color":"img/apps/jump.png","job":false,"slot":20,"tooltipText":"Doodle Jump"},{"app":"group-chats","custom":false,"Alerts":0,"blockedjobs":[],"color":"img/apps/discord.png","job":false,"slot":21,"tooltipText":"Discord"},{"app":"twitter","custom":false,"Alerts":0,"blockedjobs":[],"color":"img/apps/twitter.png","job":false,"slot":22,"tooltipText":"Twitter"},{"app":"pacman","custom":false,"Alerts":0,"job":false,"color":"img/apps/pacman.png","tooltipText":"PAC-MAN","slot":23,"blockedjobs":[]}]', '{"widget_gorunum":false}', '0', '{"account":"V5883512315","lastname":"watson","firstname":"steve","phone":"8573284445"}', '{"walletid":"V-89610197","cryptoid":"cpt-dk251","CryptoCurrency":[],"phone":{"background":"b14","Pincode":"9731","InstalledApps":{"meos":"meos","instagram":"instagram","jump":"jump","group-chats":"group-chats","pacman":"pacman","twitter":"twitter","whatsapp":"whatsapp"}}}', NULL, NULL, '{"left":871.0243530273438,"top":25.98958396911621}', NULL, 1, NULL, '', '', '', '');
INSERT INTO `users` (`citizenid`, `identifier`, `license`, `name`, `firstname`, `lastname`, `inventory`, `permission_level`, `money`, `bank`, `skin`, `job`, `job_grade`, `badge`, `divisions`, `position`, `salary`, `group`, `dateofbirth`, `sex`, `is_dead`, `status`, `jail`, `phone_number`, `gang`, `gang_grade`, `timePlay`, `tattoos`, `starterpack`, `comserv`, `apps`, `widget`, `bt`, `charinfo`, `metadata`, `cryptocurrency`, `cryptocurrencytransfers`, `phonePos`, `spotify`, `first_screen_showed`, `ringtone`, `pp`, `policemdtinfo`, `tags`, `gallery`) VALUES
	(2, 'steam:1100001341c207b', 'license:e3d350e1c82020c66e8cf66401fcc72b3b343329', 'Mehdi BAx', 'asdasd', 'asdadas', '[{"info":[],"equiped":5,"slot":1,"count":1,"weight":1,"name":"radio"},{"info":{"tint":false,"extras":{"license":"No License"},"ammo":0,"components":[]},"equiped":false,"slot":2,"count":1,"weight":5,"name":"weapon_pistol"},{"info":{"tint":false,"extras":{"license":"No License"},"ammo":0,"components":[]},"equiped":false,"slot":3,"count":1,"weight":10,"name":"weapon_carbinerifle"},{"info":[],"equiped":6,"slot":4,"count":1,"weight":1,"name":"red_phone"},{"info":[],"equiped":false,"slot":5,"count":10,"weight":0.01,"name":"9mm"},{"info":[],"equiped":false,"slot":6,"count":1,"weight":1,"name":"radio"},{"info":[],"equiped":false,"slot":7,"count":10,"weight":0.01,"name":"44_magnum"},{"info":[],"equiped":false,"slot":8,"count":10,"weight":0.01,"name":"45_acp"},{"info":{"tint":false,"extras":{"license":"No License"},"ammo":0,"components":[]},"equiped":"4","slot":9,"count":1,"weight":1,"name":"weapon_flashlight"},{"info":[],"equiped":false,"slot":10,"count":10,"weight":0.01,"name":"7.62mm"},{"info":[],"equiped":false,"slot":11,"count":1.0,"weight":1,"name":"grip"},{"info":[],"equiped":false,"slot":12,"count":1.0,"weight":1,"name":"flashlight"}]', 12, 99962999, 2147483647, '{"bags_2":0,"complexion_1":-1,"sex":0,"eyebrows_1":0,"makeup_2":10,"moles_2":10,"shoes_2":1,"hair_1":7,"chin_3":0,"mom":21,"beard_3":0,"lipstick_4":0,"cheeks_2":0,"eye_color":0,"neck_thickness":0,"complexion_2":10,"nose_5":0,"chest_2":10,"cheeks_1":0,"bodyb_4":0,"lipstick_2":10,"nose_4":0,"chain_2":0,"ears_1":-1,"makeup_1":-1,"hair_color_2":0,"blemishes_2":10,"jaw_1":0,"pants_2":0,"mask_1":-1,"arms_2":0,"cheeks_3":0,"glasses_2":0,"makeup_4":0,"shoes_1":9,"bracelets_2":0,"age_2":10,"pants_1":10,"watches_2":0,"arms":31,"decals_2":3,"nose_3":0,"age_1":-1,"hair_color_1":0,"skin_md_weight":6,"torso_2":8,"sun_1":-1,"makeup_3":0,"lip_thickness":0,"beard_1":-1,"moles_1":-1,"blemishes_1":-1,"chin_2":0,"tshirt_1":58,"nose_1":0,"nose_6":0,"nose_2":0,"dad":0,"eyebrows_6":0,"helmet_2":0,"torso_1":317,"eyebrows_3":0,"beard_2":10,"lipstick_3":0,"bproof_2":0,"chin_1":0,"sun_2":10,"beard_4":0,"lipstick_1":-1,"watches_1":-1,"helmet_1":-1,"chest_3":0,"mask_2":0,"bodyb_2":0,"blush_3":0,"decals_1":8,"chest_1":-1,"tshirt_2":0,"blush_1":-1,"glasses_1":-1,"eye_squint":0,"bodyb_1":-1,"ears_2":0,"face_md_weight":50.0,"blush_2":10,"jaw_2":0,"chain_1":-1,"eyebrows_2":10,"bags_1":-1,"chin_4":0,"bodyb_3":-1,"bracelets_1":0,"bproof_1":0,"hair_2":0,"eyebrows_4":0,"eyebrows_5":0}', 'nojob', 0, 0, '[]', '{"z":80.20005798339844,"x":1449.714111328125,"y":712.7086181640625}', 0, 'user', NULL, 'male', 1, '[{"name":"hunger","percent":95.78999999999999,"val":957900},{"name":"thirst","percent":93.0535,"val":930535},{"name":"health","percent":100,"val":100},{"name":"armor","percent":100,"val":100}]', '{"type": 0, "part": 0, "time": 0, "reason": 0}', '0912113802', 'nogang', 0, 37775, '', 'true', 0, NULL, '{"widget_gorunum":false}', '0', '{"phone":"553348962","lastname":"asdadas","account":"QS4114907877","firstname":"asdasd"}', '{"walletid":"QS-94500856","CryptoCurrency":[],"phone":{"InstalledApps":[]},"cryptoid":"cpt-Sl202"}', NULL, NULL, NULL, NULL, 1, NULL, '', '', '', '');
INSERT INTO `users` (`citizenid`, `identifier`, `license`, `name`, `firstname`, `lastname`, `inventory`, `permission_level`, `money`, `bank`, `skin`, `job`, `job_grade`, `badge`, `divisions`, `position`, `salary`, `group`, `dateofbirth`, `sex`, `is_dead`, `status`, `jail`, `phone_number`, `gang`, `gang_grade`, `timePlay`, `tattoos`, `starterpack`, `comserv`, `apps`, `widget`, `bt`, `charinfo`, `metadata`, `cryptocurrency`, `cryptocurrencytransfers`, `phonePos`, `spotify`, `first_screen_showed`, `ringtone`, `pp`, `policemdtinfo`, `tags`, `gallery`) VALUES
	(3, 'steam:1100001356ed847', 'license:e3d350e1c82020c66e8cf66401fcc72b3b343329', 'SajadBist', 'dsadasdas', 'dsads', '[{"info":[],"equiped":false,"slot":1,"count":1,"weight":1,"name":"wet_red_phone"},{"info":{"tint":false,"extras":{"license":"No License"},"ammo":0,"components":["suppressor","scope"]},"equiped":"1","slot":2,"count":1,"weight":10,"name":"weapon_assaultrifle"},{"info":[],"equiped":5,"slot":3,"count":1,"weight":1,"name":"radio"}]', 7, 1111108134, 1036142486, '{"bodyb_4":0,"nose_4":0,"nose_6":0,"bracelets_1":-1,"jaw_1":0,"decals_1":0,"torso_1":140,"watches_1":-1,"tshirt_1":10,"bproof_2":0,"pants_1":52,"eye_squint":0,"blemishes_1":-1,"bodyb_3":-1,"blush_2":10,"complexion_2":10,"nose_5":0,"helmet_1":-1,"makeup_1":-1,"bodyb_2":0,"hair_color_2":0,"chain_1":-1,"cheeks_1":0,"neck_thickness":0,"shoes_1":10,"complexion_1":-1,"eyebrows_3":0,"bags_2":0,"makeup_2":10,"chin_2":0,"eyebrows_1":0,"helmet_2":0,"dad":44,"pants_2":2,"ears_2":0,"blemishes_2":10,"glasses_2":0,"lipstick_1":-1,"beard_3":0,"beard_2":10,"face_md_weight":0,"blush_1":-1,"bodyb_1":-1,"shoes_2":0,"hair_1":7,"tshirt_2":2,"decals_2":0,"sun_2":10,"chin_1":0,"beard_1":-1,"bags_1":-1,"mask_2":0,"makeup_4":0,"chest_2":10,"lip_thickness":0,"bproof_1":0,"cheeks_2":0,"lipstick_2":10,"arms":22,"age_1":-1,"glasses_1":5,"cheeks_3":0,"eyebrows_2":10,"chest_3":0,"age_2":10,"blush_3":0,"mask_1":-1,"eyebrows_5":0,"torso_2":3,"chin_3":0,"lipstick_3":0,"sex":0,"beard_4":0,"ears_1":-1,"hair_2":0,"jaw_2":0,"nose_3":-2,"moles_2":10,"sun_1":-1,"hair_color_1":0,"nose_1":0,"makeup_3":0,"arms_2":0,"chin_4":0,"watches_2":0,"eyebrows_4":0,"skin_md_weight":41,"bracelets_2":0,"lipstick_4":0,"chest_1":-1,"eye_color":0,"moles_1":-1,"mom":44,"nose_2":-1,"chain_2":0,"eyebrows_6":0}', 'police', 5, 0, '[]', '{"z":29.00680541992187,"x":267.6430358886719,"y":-850.05419921875}', 63800, 'user', NULL, 'male', 1, '[{"name":"hunger","percent":42.61,"val":426100},{"name":"thirst","percent":37.8065,"val":378065},{"name":"health","percent":100,"val":100},{"name":"armor","percent":0,"val":0}]', '{"type": 0, "part": 0, "time": 0, "reason": 0}', '0912812840', 'nogang', 0, 46207, '', 'true', 0, '[{"bottom":true,"tooltipPos":"top","Alerts":0,"app":"phone","color":"img/apps/phone.png","slot":1,"blockedjobs":[],"custom":false,"job":false,"tooltipText":"Phone"},{"bottom":true,"Alerts":0,"app":"photos","color":"img/apps/gallery.png","slot":2,"blockedjobs":[],"custom":false,"job":false,"tooltipText":"Gallery"},{"bottom":true,"Alerts":0,"app":"messages","color":"img/apps/messages.png","slot":3,"blockedjobs":[],"custom":false,"job":false,"tooltipText":"Messages"},{"bottom":true,"tooltipPos":"top","Alerts":0,"app":"safari","color":"img/apps/safari.png","slot":4,"blockedjobs":[],"custom":false,"job":false,"tooltipText":"Safari"},{"slot":5,"tooltipText":"Mail","color":"img/apps/mail.png","Alerts":0,"app":"mail","custom":false,"job":false,"blockedjobs":[]},{"slot":6,"tooltipText":"Calendar","color":"img/apps/calendar.png","Alerts":0,"app":"calendar","custom":false,"job":false,"blockedjobs":[]},{"slot":7,"tooltipText":"Camera","color":"img/apps/camera.png","Alerts":0,"app":"camera","custom":false,"job":false,"blockedjobs":[]},{"slot":8,"tooltipText":"App Store","color":"img/apps/appstore.png","Alerts":0,"app":"store","custom":false,"job":false,"blockedjobs":[]},{"slot":9,"tooltipText":"Clock","color":"img/apps/clock.png","Alerts":0,"app":"clock","custom":false,"job":false,"blockedjobs":[]},{"slot":10,"tooltipText":"Ping","color":"img/apps/ping.png","Alerts":0,"app":"ping","custom":false,"job":false,"blockedjobs":[]},{"slot":11,"tooltipText":"Tips","color":"img/apps/tips.png","Alerts":1,"app":"tips","custom":false,"job":false,"blockedjobs":[]},{"slot":12,"tooltipText":"Calculator","color":"img/apps/calculator.png","Alerts":0,"app":"calculator","custom":false,"job":false,"blockedjobs":[]},{"slot":13,"tooltipText":"Wallet","color":"img/apps/bank.png","Alerts":0,"app":"bank","custom":false,"job":false,"blockedjobs":[]},{"slot":14,"tooltipText":"Weather","color":"img/apps/weather.png","Alerts":0,"app":"weather","custom":false,"job":false,"blockedjobs":[]},{"slot":15,"tooltipText":"Notes","color":"img/apps/notes.png","Alerts":0,"app":"notes","custom":false,"job":false,"blockedjobs":[]},{"slot":16,"tooltipText":"Settings","color":"img/apps/settings.png","Alerts":0,"app":"settings","custom":false,"job":false,"blockedjobs":[]},{"slot":17,"tooltipText":"Business","color":"img/apps/business.png","Alerts":0,"app":"business","custom":false,"job":false,"blockedjobs":[]},{"Alerts":0,"slot":18,"color":"img/apps/flappy.png","tooltipText":"Flappy Bird","app":"flappy","custom":false,"job":false,"blockedjobs":[]},{"Alerts":0,"slot":19,"color":"img/apps/jump.png","tooltipText":"Doodle Jump","app":"jump","custom":false,"job":false,"blockedjobs":[]},{"Alerts":0,"slot":20,"color":"img/apps/kong.png","tooltipText":"Donkey Kong","app":"kong","custom":false,"job":false,"blockedjobs":[]},{"Alerts":0,"slot":21,"color":"img/apps/labyrinth.png","tooltipText":"Maze Puzzle Game","app":"labyrinth","custom":false,"job":false,"blockedjobs":[]},{"Alerts":0,"slot":22,"color":"img/apps/discord.png","tooltipText":"Discord","app":"group-chats","custom":false,"job":false,"blockedjobs":[]},{"Alerts":0,"slot":23,"color":"img/apps/garages.png","tooltipText":"My Garage","app":"garage","custom":false,"job":false,"blockedjobs":[]},{"Alerts":0,"slot":24,"color":"img/apps/radio.png","tooltipText":"Radio","app":"radio","custom":false,"job":false,"blockedjobs":[]},{"Alerts":0,"slot":25,"color":"img/apps/workspace.png","tooltipText":"State","app":"state","custom":false,"job":false,"blockedjobs":[]},{"Alerts":0,"slot":26,"color":"img/apps/tower.png","tooltipText":"City Building","app":"tower","custom":false,"job":false,"blockedjobs":[]},{"Alerts":0,"slot":27,"color":"img/apps/pacman.png","tooltipText":"PAC-MAN","app":"pacman","custom":false,"job":false,"blockedjobs":[]},{"Alerts":0,"slot":28,"color":"img/apps/whatsapp.png","tooltipText":"WhatsApp","app":"whatsapp","custom":false,"job":false,"blockedjobs":[]},{"Alerts":0,"slot":29,"color":"img/apps/weazel.png","tooltipText":"News","app":"weazel","custom":false,"job":false,"blockedjobs":[]},{"Alerts":0,"slot":30,"color":"img/apps/uberDriver.png","tooltipText":"Uber","app":"uberDriver","custom":false,"job":false,"blockedjobs":[]},{"Alerts":0,"slot":31,"color":"img/apps/uber.png","tooltipText":"Uber Eats","app":"uber","custom":false,"job":false,"blockedjobs":[]},{"Alerts":0,"slot":32,"color":"img/apps/twitter.png","tooltipText":"Twitter","app":"twitter","custom":false,"job":false,"blockedjobs":[]},{"Alerts":0,"slot":33,"color":"img/apps/tinder.png","tooltipText":"Tinder","app":"tinder","custom":false,"job":false,"blockedjobs":[]},{"Alerts":0,"slot":34,"color":"img/apps/tiktok.png","tooltipText":"Tiktok","app":"tiktok","custom":false,"job":false,"blockedjobs":[]},{"Alerts":0,"slot":35,"color":"img/apps/instagram.png","tooltipText":"Instagram","app":"instagram","custom":false,"job":false,"blockedjobs":[]},{"Alerts":0,"slot":36,"color":"img/apps/darkweb.png","tooltipText":"Onion Browser","app":"darkweb","custom":false,"job":false,"blockedjobs":["police"]},{"Alerts":0,"slot":37,"color":"img/apps/yellow_pages.png","tooltipText":"Yellow Pages","app":"advert","custom":false,"job":false,"blockedjobs":[]}]', '{"widget_gorunum":false}', '0', '{"lastname":"dsads","phone":"553419652","account":"QS9365754771","firstname":"dsadasdas"}', '{"walletid":"QS-26193455","CryptoCurrency":[],"phone":{"Pincode":"0202","background":"b27","InstalledApps":{"group-chats":"group-chats","weazel":"weazel","kong":"kong","twitter":"twitter","advert":"advert","uber":"uber","tinder":"tinder","tower":"tower","instagram":"instagram","radio":"radio","flappy":"flappy","pacman":"pacman","state":"state","jump":"jump","tiktok":"tiktok","whatsapp":"whatsapp","labyrinth":"labyrinth","darkweb":"darkweb","uberDriver":"uberDriver","garage":"garage"},"profilepicture":"./img/app_details/default.png"},"cryptoid":"cpt-Bl501"}', NULL, NULL, NULL, NULL, 1, NULL, '', '', '', '');
INSERT INTO `users` (`citizenid`, `identifier`, `license`, `name`, `firstname`, `lastname`, `inventory`, `permission_level`, `money`, `bank`, `skin`, `job`, `job_grade`, `badge`, `divisions`, `position`, `salary`, `group`, `dateofbirth`, `sex`, `is_dead`, `status`, `jail`, `phone_number`, `gang`, `gang_grade`, `timePlay`, `tattoos`, `starterpack`, `comserv`, `apps`, `widget`, `bt`, `charinfo`, `metadata`, `cryptocurrency`, `cryptocurrencytransfers`, `phonePos`, `spotify`, `first_screen_showed`, `ringtone`, `pp`, `policemdtinfo`, `tags`, `gallery`) VALUES
	(4, 'steam:110000141b999f2', 'license:e3d350e1c82020c66e8cf66401fcc72b3b343329', 'Sadegh Ahmadi', 's', 'a', '[{"info":[],"count":1,"slot":1,"name":"radio","weight":1,"equiped":false},{"info":{"components":[],"extras":{"license":"No License"},"ammo":0,"tint":false},"count":1,"slot":2,"name":"weapon_pistol","weight":5,"equiped":false},{"info":{"components":[],"extras":{"license":"No License"},"ammo":0,"tint":false},"count":1,"slot":3,"name":"weapon_pistol","weight":5,"equiped":false},{"info":{"components":[],"extras":{"license":"No License"},"ammo":0,"tint":false},"count":1,"slot":4,"name":"weapon_pistol","weight":5,"equiped":false},{"info":{"components":[],"extras":{"license":"No License"},"ammo":0,"tint":false},"count":1,"slot":5,"name":"weapon_pistol","weight":5,"equiped":false},{"info":{"components":[],"extras":{"license":"No License"},"ammo":0,"tint":false},"count":1,"slot":6,"name":"weapon_pistol","weight":5,"equiped":false},{"info":{"components":[],"extras":{"license":"No License"},"ammo":0,"tint":false},"count":1,"slot":7,"name":"weapon_pistol","weight":5,"equiped":false},{"info":{"components":[],"extras":{"license":"No License"},"ammo":0,"tint":false},"count":1,"slot":8,"name":"weapon_pistol","weight":5,"equiped":false},{"info":{"components":[],"extras":{"license":"No License"},"ammo":0,"tint":false},"count":1,"slot":9,"name":"weapon_pistol","weight":5,"equiped":false},{"info":[],"count":1,"slot":10,"name":"red_phone","weight":1,"equiped":6}]', 10, 0, 0, '{"blush_1":-1,"mask_2":0,"nose_4":0,"lipstick_3":0,"shoes_1":2,"nose_1":0,"dad":0,"chin_4":0,"chest_3":0,"neck_thickness":0,"hair_color_1":0,"watches_1":-1,"chain_1":-1,"pants_1":4,"lipstick_4":0,"eyebrows_1":0,"eyebrows_3":0,"glasses_1":-1,"arms":12,"blush_2":10,"bproof_1":-1,"helmet_2":0,"nose_2":0,"beard_2":10,"bproof_2":0,"cheeks_2":0,"chest_2":10,"jaw_2":0,"nose_5":0,"tshirt_1":15,"chin_3":0,"tshirt_2":0,"helmet_1":-1,"blush_3":0,"makeup_4":0,"sex":0,"face_md_weight":50.0,"bags_2":0,"blemishes_2":10,"eye_color":0,"chest_1":-1,"skin_md_weight":6,"bags_1":-1,"lipstick_2":10,"mask_1":-1,"bracelets_1":-1,"hair_2":0,"eyebrows_6":0,"hair_color_2":0,"cheeks_1":0,"chin_1":0,"sun_1":-1,"jaw_1":0,"moles_1":-1,"sun_2":10,"lipstick_1":-1,"moles_2":10,"eyebrows_2":10,"torso_1":17,"chain_2":0,"beard_1":-1,"age_2":10,"makeup_2":10,"beard_4":0,"makeup_1":-1,"lip_thickness":0,"complexion_1":-1,"age_1":-1,"eyebrows_4":0,"complexion_2":10,"eyebrows_5":0,"hair_1":4,"torso_2":0,"watches_2":0,"blemishes_1":-1,"nose_3":0,"nose_6":0,"shoes_2":0,"beard_3":0,"chin_2":0,"pants_2":0,"cheeks_3":0,"bracelets_2":0,"glasses_2":0,"mom":21,"makeup_3":0}', 'cardealer', 3, 0, '[]', '{"y":-1579.967529296875,"x":-1186.610107421875,"z":4.37444925308227}', 2600, 'user', NULL, 'male', 1, '[{"percent":87.78,"name":"hunger","val":877800},{"percent":79.837,"name":"thirst","val":798370},{"percent":100,"name":"health","val":100},{"percent":0,"name":"armor","val":0}]', '{"type": 0, "part": 0, "time": 0, "reason": 0}', '0912177023', 'nogang', 0, 4944, '', 'true', 0, NULL, NULL, '0', '{"phone":"8572769980","lastname":"","firstname":"","account":"V2532564498"}', '{"phone":{"Pincode":"1111","background":"b25","InstalledApps":[]},"CryptoCurrency":[],"cryptoid":"cpt-Gs950","walletid":"V-14767595"}', NULL, NULL, NULL, NULL, 1, NULL, '', '', '', '');
INSERT INTO `users` (`citizenid`, `identifier`, `license`, `name`, `firstname`, `lastname`, `inventory`, `permission_level`, `money`, `bank`, `skin`, `job`, `job_grade`, `badge`, `divisions`, `position`, `salary`, `group`, `dateofbirth`, `sex`, `is_dead`, `status`, `jail`, `phone_number`, `gang`, `gang_grade`, `timePlay`, `tattoos`, `starterpack`, `comserv`, `apps`, `widget`, `bt`, `charinfo`, `metadata`, `cryptocurrency`, `cryptocurrencytransfers`, `phonePos`, `spotify`, `first_screen_showed`, `ringtone`, `pp`, `policemdtinfo`, `tags`, `gallery`) VALUES
	(5, 'steam:1100001440a9ff9', 'license:e3d350e1c82020c66e8cf66401fcc72b3b343329', 'Daniyal', 'tom', 'wells', '[{"info":[],"count":1,"name":"red_phone","slot":1,"weight":1,"equiped":6}]', 0, 0, 0, '{"blush_1":-1,"mask_2":0,"nose_4":0,"lipstick_3":0,"age_1":-1,"nose_1":0,"dad":0,"chin_4":0,"chest_3":0,"neck_thickness":0,"hair_color_1":0,"chin_2":0,"shoes_2":0,"pants_1":45,"lipstick_4":0,"eyebrows_1":0,"eyebrows_3":0,"glasses_1":-1,"arms":1,"skin_md_weight":6,"bproof_1":-1,"helmet_2":0,"nose_2":0,"beard_2":10,"bproof_2":0,"cheeks_2":0,"makeup_2":10,"jaw_2":0,"cheeks_3":0,"eyebrows_4":0,"chin_3":0,"tshirt_2":0,"helmet_1":-1,"mom":21,"makeup_4":0,"sex":0,"bags_2":0,"chest_1":-1,"makeup_3":0,"face_md_weight":50.0,"cheeks_1":0,"nose_5":0,"bags_1":-1,"lipstick_2":10,"mask_1":-1,"age_2":10,"hair_2":0,"eyebrows_6":0,"hair_color_2":0,"bracelets_1":-1,"watches_2":0,"eye_color":0,"blemishes_2":10,"moles_1":-1,"sun_2":10,"lipstick_1":-1,"moles_2":10,"eyebrows_2":10,"torso_1":50,"blush_2":10,"glasses_2":0,"beard_4":0,"chin_1":0,"chest_2":10,"makeup_1":-1,"lip_thickness":0,"complexion_1":-1,"beard_3":0,"chain_2":0,"complexion_2":10,"eyebrows_5":0,"hair_1":4,"shoes_1":2,"tshirt_1":15,"blemishes_1":-1,"nose_3":0,"nose_6":0,"torso_2":1,"watches_1":-1,"chain_1":-1,"pants_2":0,"blush_3":0,"bracelets_2":0,"jaw_1":0,"sun_1":-1,"beard_1":-1}', 'nojob', 0, 0, '[]', '{"y":-1127.1309814453126,"z":8.29417514801025,"x":-819.5546875}', 0, 'user', NULL, 'male', 0, '[{"val":990300,"percent":99.03,"name":"hunger"},{"val":983995,"percent":98.39949999999999,"name":"thirst"},{"val":100,"percent":100,"name":"health"},{"val":0,"percent":0,"name":"armor"}]', '{"type": 0, "part": 0, "time": 0, "reason": 0}', NULL, 'nogang', 0, 747, '', 'true', 0, NULL, NULL, '0', '{"phone":"8565809436","lastname":"","firstname":"","account":"V5446214516"}', '{"phone":{"Pincode":"1234","background":"b3","InstalledApps":[]},"CryptoCurrency":[],"cryptoid":"cpt-Yc633","walletid":"V-17341513"}', NULL, NULL, NULL, NULL, 1, NULL, '', '', '', '');
INSERT INTO `users` (`citizenid`, `identifier`, `license`, `name`, `firstname`, `lastname`, `inventory`, `permission_level`, `money`, `bank`, `skin`, `job`, `job_grade`, `badge`, `divisions`, `position`, `salary`, `group`, `dateofbirth`, `sex`, `is_dead`, `status`, `jail`, `phone_number`, `gang`, `gang_grade`, `timePlay`, `tattoos`, `starterpack`, `comserv`, `apps`, `widget`, `bt`, `charinfo`, `metadata`, `cryptocurrency`, `cryptocurrencytransfers`, `phonePos`, `spotify`, `first_screen_showed`, `ringtone`, `pp`, `policemdtinfo`, `tags`, `gallery`) VALUES
	(6, 'steam:110000144c6a3b8', 'license:e3d350e1c82020c66e8cf66401fcc72b3b343329', 'theMani_kh', 'Salam', 'Khodafez', '[{"name":"radio","count":1,"equiped":5,"slot":1,"info":[],"weight":1},{"name":"weapon_heavypistol","count":1,"weight":5,"info":{"components":["suppressor"],"extras":{"license":"No License"},"ammo":138,"tint":false},"slot":2,"equiped":false},{"name":"red_phone","count":1,"equiped":6,"slot":3,"info":[],"weight":1},{"name":"bodycam","count":1,"equiped":false,"slot":4,"info":[],"weight":0.3},{"name":"megaphone","count":1,"equiped":false,"slot":5,"info":[],"weight":2},{"name":"weapon_pistol50","count":1,"weight":5,"info":{"components":[],"extras":{"license":"No License"},"ammo":0,"tint":false},"slot":6,"equiped":false},{"name":"weapon_combatpdw","count":1,"equiped":"1","slot":7,"info":{"components":["clip_extended","flashlight","scope","grip","suppressor"],"ammo":0,"extras":{"license":"No License"},"tint":3},"weight":10},{"name":"9mm","count":69,"equiped":false,"slot":8,"info":[],"weight":0.01},{"name":"weapon_switchblade","count":1,"equiped":"4","slot":9,"info":{"components":[],"ammo":0,"extras":{"license":"No License"},"tint":false},"weight":2}]', 0, 1000, 9300, '{"bracelets_2":0,"makeup_1":-1,"neck_thickness":0,"helmet_2":0,"chain_1":-1,"bproof_2":0,"beard_3":0,"eye_color":0,"nose_3":0,"chin_1":0,"pants_2":8,"face_md_weight":50.0,"hair_1":4,"torso_1":138,"hair_2":0,"complexion_2":10,"chain_2":0,"nose_5":0,"eyebrows_2":10,"lipstick_1":-1,"nose_2":0,"hair_color_2":0,"bproof_1":-1,"chest_3":0,"hair_color_1":0,"eyebrows_6":0,"beard_4":0,"pants_1":10,"blush_3":0,"lip_thickness":0,"chin_4":0,"cheeks_2":0,"makeup_3":0,"eyebrows_3":0,"dad":0,"blemishes_2":10,"glasses_1":-1,"sun_1":-1,"arms":20,"eyebrows_5":0,"age_2":10,"lipstick_3":0,"blush_1":-1,"moles_2":10,"sex":0,"mask_2":0,"bracelets_1":-1,"mom":21,"sun_2":10,"torso_2":2,"makeup_4":0,"makeup_2":10,"chin_2":0,"skin_md_weight":6,"bags_2":0,"watches_1":-1,"beard_1":-1,"shoes_2":0,"chest_2":10,"bags_1":-1,"nose_1":0,"helmet_1":-1,"tshirt_2":0,"shoes_1":4,"lipstick_4":0,"tshirt_1":15,"lipstick_2":10,"mask_1":-1,"cheeks_3":0,"jaw_2":0,"chest_1":-1,"eyebrows_4":0,"watches_2":0,"moles_1":-1,"blush_2":10,"glasses_2":0,"nose_4":0,"beard_2":10,"blemishes_1":-1,"jaw_1":0,"complexion_1":-1,"age_1":-1,"nose_6":0,"cheeks_1":0,"chin_3":0,"eyebrows_1":0}', 'nojob', 0, 0, '[]', '{"y":-1051.46728515625,"x":-536.4482421875,"z":22.6419506072998}', 19000, 'user', NULL, 'male', 1, '[{"val":500000,"name":"hunger","percent":50.0},{"val":500000,"name":"thirst","percent":50.0},{"val":100,"name":"health","percent":100},{"val":0,"name":"armor","percent":0}]', '{"type": 0, "part": 0, "time": 0, "reason": 0}', '0912558292', 'nogang', 0, 37694, '', 'true', 0, NULL, '{"widget_gorunum":false}', '0', '{"lastname":"Khodafez","account":"QS8247837872","phone":"553194362","firstname":"Salam"}', '{"walletid":"QS-98688584","cryptoid":"cpt-VA801","phone":{"background":"b2","InstalledApps":[],"lockscreen":false,"profilepicture":"https://media.discordapp.net/attachments/1013413430050422784/1045405043773415525/screenshot.jpg"},"CryptoCurrency":[]}', NULL, NULL, NULL, NULL, 1, NULL, '', '', '', '');
INSERT INTO `users` (`citizenid`, `identifier`, `license`, `name`, `firstname`, `lastname`, `inventory`, `permission_level`, `money`, `bank`, `skin`, `job`, `job_grade`, `badge`, `divisions`, `position`, `salary`, `group`, `dateofbirth`, `sex`, `is_dead`, `status`, `jail`, `phone_number`, `gang`, `gang_grade`, `timePlay`, `tattoos`, `starterpack`, `comserv`, `apps`, `widget`, `bt`, `charinfo`, `metadata`, `cryptocurrency`, `cryptocurrencytransfers`, `phonePos`, `spotify`, `first_screen_showed`, `ringtone`, `pp`, `policemdtinfo`, `tags`, `gallery`) VALUES
	(7, 'steam:1100001452540bf', 'license:e3d350e1c82020c66e8cf66401fcc72b3b343329', 'KAKXER', 'KAKXER', 'BELA', '[{"slot":1,"count":1,"info":[],"equiped":5,"name":"radio","weight":1},{"slot":2,"count":1,"info":[],"equiped":false,"name":"oil","weight":6}]', 16, 135000, 31934410, '{"chin_3":0,"hair_color_2":0,"eyebrows_1":0,"face_2":21,"bodyb_3":-1,"sun_2":10,"beard_2":10,"lipstick_2":10,"neck_thickness":0,"cheeks_1":0,"ears_1":3,"watches_2":2,"pants_2":0,"mom":21,"shoes_1":32,"shoes":10,"cheeks_3":0,"lipstick_1":-1,"face_3":5,"helmet_1":143,"eyebrows_6":0,"skin_md_weight":6,"chest_1":-1,"bproof_1":-1,"makeup_2":10,"lipstick_4":0,"pants_1":26,"blemishes_2":10,"makeup_3":0,"face_md_weight":50.0,"decals_1":1,"eyebrows_4":0,"dad":0,"blemishes_1":-1,"makeup_4":0,"bracelets_1":6,"nose_5":0,"shoes_2":3,"beard_4":0,"hair_1":4,"hair":{"texture":0,"style":0,"highlight":0,"color":0},"sex":0,"makeup_1":-1,"hair_color_1":0,"lip_thickness":0,"age_2":10,"nose_4":0,"eyebrows_5":0,"beard_3":0,"torso_1":81,"nose_3":0,"headBlend":{"skinThird":0,"thirdMix":0,"skinMix":0,"shapeSecond":0,"skinFirst":0,"shapeMix":0,"shapeFirst":0,"skinSecond":0,"shapeThird":0},"lipstick_3":0,"chain_1":51,"tshirt_2":0,"nose_6":0,"bags_1":-1,"chin_2":0,"bodyb_4":0,"ears_2":0,"components":[{"texture":0,"component_id":0,"drawable":0},{"texture":0,"component_id":2,"drawable":0},{"texture":0,"component_id":1,"drawable":0},{"texture":0,"component_id":7,"drawable":0},{"texture":2,"component_id":4,"drawable":79},{"texture":4,"component_id":6,"drawable":32},{"texture":0,"component_id":10,"drawable":0},{"texture":1,"component_id":3,"drawable":19},{"texture":0,"component_id":5,"drawable":0},{"texture":0,"component_id":9,"drawable":0},{"texture":0,"component_id":8,"drawable":15},{"texture":0,"component_id":11,"drawable":80}],"tattoos":[],"age_1":-1,"chest_3":0,"jaw_2":0,"skin":0,"chain_2":0,"bodyb_1":-1,"blush_1":-1,"mask_1":-1,"headOverlays":{"blush":{"style":0,"color":0,"opacity":0},"makeUp":{"secondColor":0,"style":0,"opacity":0,"color":0},"bodyBlemishes":{"style":0,"color":0,"opacity":0},"lipstick":{"style":0,"color":0,"opacity":0},"complexion":{"style":0,"color":0,"opacity":0},"eyebrows":{"style":0,"color":0,"opacity":0},"beard":{"style":0,"color":0,"opacity":0},"ageing":{"style":0,"color":0,"opacity":0},"chestHair":{"style":0,"color":0,"opacity":0},"sunDamage":{"style":0,"color":0,"opacity":0},"blemishes":{"style":0,"color":0,"opacity":0},"moleAndFreckles":{"style":0,"color":0,"opacity":0}},"arms_2":0,"helmet_2":0,"eyebrows_2":10,"decals_2":0,"beard_1":-1,"chest_2":10,"arms":19,"jaw_1":0,"chin_1":0,"face_1":16,"glasses":0,"torso_2":0,"watches_1":6,"moles_2":10,"eyebrows_3":0,"complexion_2":10,"bags_2":0,"chin_4":0,"faceFeatures":{"cheeksBoneWidth":0,"nosePeakLowering":0,"eyesOpening":0,"eyeBrownHigh":0,"chinBoneLenght":0,"chinHole":0,"nosePeakHigh":0,"cheeksBoneHigh":0,"chinBoneSize":0,"lipsThickness":0,"neckThickness":0,"jawBoneBackSize":0,"noseWidth":0,"eyeBrownForward":0,"noseBoneHigh":0,"nosePeakSize":0,"jawBoneWidth":0,"chinBoneLowering":0,"noseBoneTwist":0,"cheeksWidth":0},"eye_squint":0,"complexion_1":-1,"tshirt_1":15,"blush_2":10,"nose_1":0,"bodyb_2":0,"glasses_2":4,"nose_2":0,"props":[{"drawable":18,"prop_id":1,"texture":5},{"drawable":4,"prop_id":2,"texture":0},{"drawable":6,"prop_id":6,"texture":2},{"drawable":6,"prop_id":7,"texture":0},{"drawable":152,"prop_id":0,"texture":0}],"model":"mp_m_freemode_01","bracelets_2":0,"blush_3":0,"eye_color":0,"glasses_1":5,"mask_2":0,"bproof_2":0,"hair_2":0,"sun_1":-1,"eyeColor":-1,"moles_1":-1,"cheeks_2":0,"face":0}', 'cardealer', 3, 0, '{"police":{"fa":0,"hr":1,"gc2":0}}', '{"y":-969.7406616210938,"x":117.55223083496094,"z":28.74896240234375}', 98000, 'user', NULL, 'male', 1, '[{"percent":43.78,"name":"hunger","val":437800},{"percent":44.137,"name":"thirst","val":441370},{"percent":50,"name":"health","val":50},{"percent":0,"name":"armor","val":0}]', '{"type": 0, "part": 0, "time": 0, "reason": 0}', '0912912520', 'asghar', 6, 504900, '', 'true', 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '', '', '', '');
/*!40000 ALTER TABLE `users` ENABLE KEYS */;

-- Dumping structure for table essential.user_licenses
CREATE TABLE IF NOT EXISTS `user_licenses` (
  `type` varchar(60) NOT NULL,
  `owner` varchar(60) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_persian_ci ROW_FORMAT=DYNAMIC;

-- Dumping data for table essential.user_licenses: ~4 rows (approximately)
/*!40000 ALTER TABLE `user_licenses` DISABLE KEYS */;
INSERT INTO `user_licenses` (`type`, `owner`) VALUES
	('weapon', 'steam:1100001440a9ff9');
INSERT INTO `user_licenses` (`type`, `owner`) VALUES
	('gc2', 'steam:1100001452540bf');
INSERT INTO `user_licenses` (`type`, `owner`) VALUES
	('gc3', 'steam:1100001452540bf');
INSERT INTO `user_licenses` (`type`, `owner`) VALUES
	('weapon', 'steam:1100001452540bf');
/*!40000 ALTER TABLE `user_licenses` ENABLE KEYS */;

-- Dumping structure for table essential.user_outfits
CREATE TABLE IF NOT EXISTS `user_outfits` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `identifier` varchar(50) DEFAULT NULL,
  `outfitname` varchar(50) NOT NULL DEFAULT '0',
  `model` varchar(50) DEFAULT NULL,
  `props` varchar(1000) DEFAULT NULL,
  `components` varchar(1500) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `identifier_outfitname_model` (`identifier`,`outfitname`,`model`),
  KEY `identifier` (`identifier`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Dumping data for table essential.user_outfits: ~0 rows (approximately)
/*!40000 ALTER TABLE `user_outfits` DISABLE KEYS */;
/*!40000 ALTER TABLE `user_outfits` ENABLE KEYS */;

-- Dumping structure for table essential.weashops
CREATE TABLE IF NOT EXISTS `weashops` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `zone` varchar(255) NOT NULL,
  `item` varchar(255) NOT NULL,
  `price` int(11) NOT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=66 DEFAULT CHARSET=utf8 COLLATE=utf8_persian_ci ROW_FORMAT=DYNAMIC;

-- Dumping data for table essential.weashops: ~8 rows (approximately)
/*!40000 ALTER TABLE `weashops` DISABLE KEYS */;
INSERT INTO `weashops` (`id`, `zone`, `item`, `price`) VALUES
	(9, 'GunShop', 'WEAPON_BAT', 15000);
INSERT INTO `weashops` (`id`, `zone`, `item`, `price`) VALUES
	(50, 'GunShop', 'WEAPON_SNSPISTOL', 100000);
INSERT INTO `weashops` (`id`, `zone`, `item`, `price`) VALUES
	(60, 'GunShop', 'WEAPON_SWITCHBLADE', 150000);
INSERT INTO `weashops` (`id`, `zone`, `item`, `price`) VALUES
	(61, 'GunShop', 'WEAPON_FLASHLIGHT', 20000);
INSERT INTO `weashops` (`id`, `zone`, `item`, `price`) VALUES
	(62, 'GunShop', 'weapon_flaregun', 60000);
INSERT INTO `weashops` (`id`, `zone`, `item`, `price`) VALUES
	(63, 'GunShop', 'WEAPON_DAGGER', 30000);
INSERT INTO `weashops` (`id`, `zone`, `item`, `price`) VALUES
	(64, 'GunShop', 'weapon_bzgas', 56000);
INSERT INTO `weashops` (`id`, `zone`, `item`, `price`) VALUES
	(65, 'GunShop', 'gadget_parachute', 80000);
/*!40000 ALTER TABLE `weashops` ENABLE KEYS */;

-- Dumping structure for table essential.whatsapp_accounts
CREATE TABLE IF NOT EXISTS `whatsapp_accounts` (
  `id` varchar(100) NOT NULL,
  `name` varchar(50) NOT NULL,
  `phone` varchar(50) NOT NULL,
  `password` varchar(50) NOT NULL,
  `avatar` text NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Dumping data for table essential.whatsapp_accounts: ~0 rows (approximately)
/*!40000 ALTER TABLE `whatsapp_accounts` DISABLE KEYS */;
/*!40000 ALTER TABLE `whatsapp_accounts` ENABLE KEYS */;

-- Dumping structure for table essential.whatsapp_chats
CREATE TABLE IF NOT EXISTS `whatsapp_chats` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `phone` varchar(50) NOT NULL,
  `number` varchar(50) NOT NULL,
  `created` varchar(50) NOT NULL,
  `messages` text NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=43 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Dumping data for table essential.whatsapp_chats: ~0 rows (approximately)
/*!40000 ALTER TABLE `whatsapp_chats` DISABLE KEYS */;
/*!40000 ALTER TABLE `whatsapp_chats` ENABLE KEYS */;

-- Dumping structure for table essential.whatsapp_chats_messages
CREATE TABLE IF NOT EXISTS `whatsapp_chats_messages` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `id_chat` int(11) NOT NULL,
  `owner` varchar(50) NOT NULL,
  `type` varchar(50) NOT NULL,
  `created` varchar(50) NOT NULL,
  `message` mediumtext NOT NULL,
  `readed` int(1) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Dumping data for table essential.whatsapp_chats_messages: ~0 rows (approximately)
/*!40000 ALTER TABLE `whatsapp_chats_messages` DISABLE KEYS */;
/*!40000 ALTER TABLE `whatsapp_chats_messages` ENABLE KEYS */;

-- Dumping structure for table essential.whatsapp_groups
CREATE TABLE IF NOT EXISTS `whatsapp_groups` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `phone` varchar(50) NOT NULL,
  `number` varchar(50) NOT NULL,
  `type` varchar(50) NOT NULL,
  `name` varchar(50) NOT NULL,
  `image` text NOT NULL,
  `created` varchar(50) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Dumping data for table essential.whatsapp_groups: ~0 rows (approximately)
/*!40000 ALTER TABLE `whatsapp_groups` DISABLE KEYS */;
/*!40000 ALTER TABLE `whatsapp_groups` ENABLE KEYS */;

-- Dumping structure for table essential.whatsapp_groups_messages
CREATE TABLE IF NOT EXISTS `whatsapp_groups_messages` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `id_group` varchar(50) NOT NULL,
  `owner` varchar(50) NOT NULL,
  `type` varchar(50) NOT NULL,
  `message` text NOT NULL,
  `created` varchar(50) NOT NULL,
  `read` int(11) NOT NULL,
  `name` varchar(50) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Dumping data for table essential.whatsapp_groups_messages: ~0 rows (approximately)
/*!40000 ALTER TABLE `whatsapp_groups_messages` DISABLE KEYS */;
/*!40000 ALTER TABLE `whatsapp_groups_messages` ENABLE KEYS */;

-- Dumping structure for table essential.whatsapp_groups_users
CREATE TABLE IF NOT EXISTS `whatsapp_groups_users` (
  `number_group` varchar(50) NOT NULL,
  `admin` int(11) NOT NULL,
  `phone` varchar(50) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Dumping data for table essential.whatsapp_groups_users: ~0 rows (approximately)
/*!40000 ALTER TABLE `whatsapp_groups_users` DISABLE KEYS */;
/*!40000 ALTER TABLE `whatsapp_groups_users` ENABLE KEYS */;

-- Dumping structure for table essential.whatsapp_stories
CREATE TABLE IF NOT EXISTS `whatsapp_stories` (
  `phone` varchar(50) NOT NULL,
  `image` text NOT NULL,
  `created` varchar(50) NOT NULL,
  `description` varchar(50) DEFAULT NULL,
  `location` varchar(50) DEFAULT NULL,
  `filter` varchar(50) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Dumping data for table essential.whatsapp_stories: ~0 rows (approximately)
/*!40000 ALTER TABLE `whatsapp_stories` DISABLE KEYS */;
/*!40000 ALTER TABLE `whatsapp_stories` ENABLE KEYS */;

-- Dumping structure for table essential.whitelist
CREATE TABLE IF NOT EXISTS `whitelist` (
  `identifier` varchar(40) NOT NULL,
  `Name` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`identifier`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Dumping data for table essential.whitelist: ~0 rows (approximately)
/*!40000 ALTER TABLE `whitelist` DISABLE KEYS */;
/*!40000 ALTER TABLE `whitelist` ENABLE KEYS */;

/*!40101 SET SQL_MODE=IFNULL(@OLD_SQL_MODE, '') */;
/*!40014 SET FOREIGN_KEY_CHECKS=IF(@OLD_FOREIGN_KEY_CHECKS IS NULL, 1, @OLD_FOREIGN_KEY_CHECKS) */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
