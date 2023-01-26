CREATE TABLE IF NOT EXISTS `owned_shops` (
	`number` int(11) DEFAULT NULL,
  	`owner` varchar(250) DEFAULT '{"identifier":"government","name":"Government"}',
  	`money` int(11) DEFAULT 0,
  	`value` varchar(255) DEFAULT '{"forsale":true,"value":500000}',
  	`inventory` LONGTEXT NULL DEFAULT '[]',
  	`name` varchar(30) DEFAULT 'Shop',
  	PRIMARY KEY (`number`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;