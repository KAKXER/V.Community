USE `database`;

CREATE TABLE IF NOT EXISTS `owned_vehicles` (
  `owner` varchar(30) COLLATE utf8_persian_ci NOT NULL,
  `plate` varchar(12) COLLATE utf8_persian_ci NOT NULL,
  `damage` longtext COLLATE utf8_persian_ci NOT NULL,
  `vehicle` longtext COLLATE utf8_persian_ci NOT NULL,
  `type` varchar(20) COLLATE utf8_persian_ci NOT NULL DEFAULT 'car',
  `stored` tinyint(1) NOT NULL DEFAULT 0,
  `job` varchar(20) COLLATE utf8_persian_ci DEFAULT NULL,
  `parkmeter` tinytext COLLATE utf8_persian_ci NOT NULL DEFAULT '0',
  `garagenum` int(50) DEFAULT 1,
  `parkmeternum` int(50) DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_persian_ci ROW_FORMAT=DYNAMIC;