SET GLOBAL event_scheduler = ON; 

ALTER DATABASE `market` DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci;


CREATE TABLE IF NOT EXISTS `market`.`myEventTable` (
  `id` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `eventTime` DATETIME NOT NULL,
  `eventName` VARCHAR(50) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE = InnoDB
  DEFAULT CHARACTER SET = utf8mb4;

DELIMITER $$
CREATE EVENT IF NOT EXISTS `event1`
ON SCHEDULE EVERY 10 SECOND
STARTS NOW() 
ENDS NOW() + INTERVAL 5 MINUTE
DO
BEGIN
  INSERT INTO `market`.`myEventTable` (eventTime, eventName)
  VALUES (NOW(), 'event1');
END $$
DELIMITER ;

DELIMITER $$
CREATE EVENT IF NOT EXISTS `event2`
ON SCHEDULE EVERY 150 SECOND 
STARTS NOW()
ENDS NOW() + INTERVAL 1 DAY
DO
BEGIN
  INSERT INTO `market`.`myEventTable` (eventTime, eventName)
  VALUES (NOW(), 'event2');
END $$
DELIMITER ;

DELIMITER $$
CREATE EVENT IF NOT EXISTS `event3`
ON SCHEDULE AT '2025-03-22 18:00:00'  -- Укажите точное время
DO
BEGIN
  INSERT INTO `market`.`myEventTable` (eventTime, eventName)
  VALUES (NOW(), 'event3');
END $$
DELIMITER ;

DELIMITER $$
CREATE EVENT IF NOT EXISTS `eventAuthor`
ON SCHEDULE EVERY 1 DAY
STARTS TIMESTAMP(CURRENT_DATE, '15:00:00')  
DO
BEGIN
  INSERT INTO `market`.`myEventTable` (eventTime, eventName)
  VALUES (NOW(), 'eventAuthor');

  DELETE FROM `market`.`authors`
  WHERE id NOT IN (SELECT DISTINCT author_id FROM `market`.`book`);
END $$
DELIMITER ;

SELECT *
FROM information_schema.EVENTS;