
CREATE DATABASE IF NOT EXISTS `database`
USE `database`;

CREATE TABLE IF NOT EXISTS `redeemcode` (
  `code` varchar(50) DEFAULT NULL,
  `money` int(11) DEFAULT 0,
  `bank` int(11) DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

INSERT INTO `redeemcode` (`code`, `money`, `bank`) VALUES
	('S56ASD4', 50000, 25000);

CREATE TABLE IF NOT EXISTS `redeemcode_users` (
  `identifier` varchar(50) DEFAULT NULL,
  `redeemcode` varchar(50) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;