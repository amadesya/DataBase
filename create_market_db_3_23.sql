-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------
SHOW WARNINGS;
-- -----------------------------------------------------
-- Schema market
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema market
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `market` DEFAULT CHARACTER SET utf8mb4 ;
SHOW WARNINGS;
USE `market` ;

-- -----------------------------------------------------
-- Table `market`.`authors`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `market`.`authors` (
  `id` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `surname` VARCHAR(50) NOT NULL,
  `name` VARCHAR(50) NOT NULL,
  `country` VARCHAR(30) NOT NULL DEFAULT 'Россия',
  PRIMARY KEY (`id`),
  UNIQUE INDEX `idx_author_surname` (`surname` ASC) INVISIBLE,
  UNIQUE INDEX `idx_author_name` (`name` ASC) VISIBLE)
ENGINE = InnoDB
AUTO_INCREMENT = 15
DEFAULT CHARACTER SET = utf8mb3;

SHOW WARNINGS;

-- -----------------------------------------------------
-- Table `market`.`book`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `market`.`book` (
  `id` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `author_id` INT UNSIGNED NOT NULL,
  `title` VARCHAR(50) NOT NULL,
  `genre` ENUM('проза', 'поэзия', 'другое') NOT NULL DEFAULT 'проза',
  `price` DECIMAL(6,2) UNSIGNED NOT NULL,
  `weight` DECIMAL(4,3) UNSIGNED NOT NULL,
  `year_publication` YEAR NULL DEFAULT NULL,
  `pages` SMALLINT NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_author_id_idx` (`author_id` ASC) VISIBLE,
  CONSTRAINT `fk_author_id`
    FOREIGN KEY (`author_id`)
    REFERENCES `market`.`authors` (`id`)
    ON UPDATE CASCADE)
ENGINE = InnoDB
AUTO_INCREMENT = 12
DEFAULT CHARACTER SET = utf8mb3;

SHOW WARNINGS;

-- -----------------------------------------------------
-- Table `market`.`booksinfo`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `market`.`booksinfo` (
  `id` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `surname` VARCHAR(50) NOT NULL,
  `name` VARCHAR(50) NOT NULL,
  `title` VARCHAR(50) NOT NULL,
  `price` DECIMAL(6,2) NULL DEFAULT '0.00',
  `year_publication` YEAR NULL DEFAULT NULL,
  `arrival_date` DATE NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `UQ_BooksInfo_Title` (`title` ASC) VISIBLE,
  UNIQUE INDEX `UQ_BooksInfo_Name` (`name` ASC) VISIBLE,
  UNIQUE INDEX `UQ_BooksInfo_Surname` (`surname` ASC) VISIBLE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4;

SHOW WARNINGS;

-- -----------------------------------------------------
-- Table `market`.`customers`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `market`.`customers` (
  `id` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `login` VARCHAR(20) NOT NULL,
  `surname` VARCHAR(50) NOT NULL,
  `name` VARCHAR(50) NOT NULL,
  `address` VARCHAR(100) NOT NULL,
  `phone` VARCHAR(15) NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `idx_customers_login` (`login` ASC) VISIBLE)
ENGINE = InnoDB
AUTO_INCREMENT = 4
DEFAULT CHARACTER SET = utf8mb3;

SHOW WARNINGS;

-- -----------------------------------------------------
-- Table `market`.`orders`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `market`.`orders` (
  `id` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `customers_id` INT UNSIGNED NOT NULL,
  `order_date` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  INDEX `fk_customers_id_idx` (`customers_id` ASC) VISIBLE,
  CONSTRAINT `fk_customers_id`
    FOREIGN KEY (`customers_id`)
    REFERENCES `market`.`customers` (`id`))
ENGINE = InnoDB
AUTO_INCREMENT = 6
DEFAULT CHARACTER SET = utf8mb3;

SHOW WARNINGS;

-- -----------------------------------------------------
-- Table `market`.`composition`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `market`.`composition` (
  `order_id` INT UNSIGNED NOT NULL,
  `book_id` INT UNSIGNED NOT NULL,
  `count` TINYINT UNSIGNED NOT NULL DEFAULT '1',
  PRIMARY KEY (`order_id`, `book_id`),
  INDEX `fk_book_id_idx` (`book_id` ASC) VISIBLE,
  CONSTRAINT `fk_book_id`
    FOREIGN KEY (`book_id`)
    REFERENCES `market`.`book` (`id`),
  CONSTRAINT `fk_order_id`
    FOREIGN KEY (`order_id`)
    REFERENCES `market`.`orders` (`id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb3;

SHOW WARNINGS;

-- -----------------------------------------------------
-- Table `market`.`delivery`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `market`.`delivery` (
  `book_id` INT UNSIGNED NOT NULL,
  `count` INT NOT NULL,
  `delivery_date` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  INDEX `fk_delivery_book_id_idx` (`book_id` ASC) VISIBLE,
  CONSTRAINT `fk_delivery_book_id`
    FOREIGN KEY (`book_id`)
    REFERENCES `market`.`book` (`id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;

SHOW WARNINGS;

-- -----------------------------------------------------
-- Table `market`.`myeventtable`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `market`.`myeventtable` (
  `id` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `event_time` DATETIME NOT NULL,
  `event_name` VARCHAR(50) NOT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;

SHOW WARNINGS;

-- -----------------------------------------------------
-- Table `market`.`tempbooks`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `market`.`tempbooks` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `surname` VARCHAR(50) NOT NULL,
  `name` VARCHAR(50) NOT NULL,
  `titlle` VARCHAR(50) NOT NULL,
  `price` DECIMAL(6,2) NOT NULL DEFAULT '0.00',
  PRIMARY KEY (`id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb3;

SHOW WARNINGS;
USE `market` ;

-- -----------------------------------------------------
-- Placeholder table for view `market`.`viewauthors`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `market`.`viewauthors` (`id` INT, `surname` INT, `name` INT, `title` INT, `price` INT);
SHOW WARNINGS;

-- -----------------------------------------------------
-- Placeholder table for view `market`.`viewauthorspricecategory`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `market`.`viewauthorspricecategory` (`id` INT, `surname` INT, `name` INT, `title` INT, `price` INT, `category` INT);
SHOW WARNINGS;

-- -----------------------------------------------------
-- Placeholder table for view `market`.`viewchecktales`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `market`.`viewchecktales` (`id` INT, `surname` INT, `name` INT, `title` INT, `price` INT, `has_tales` INT);
SHOW WARNINGS;

-- -----------------------------------------------------
-- Placeholder table for view `market`.`viewdelivers`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `market`.`viewdelivers` (`id` INT, `order_date` INT, `customers_id` INT, `login` INT, `surname` INT, `name` INT);
SHOW WARNINGS;

-- -----------------------------------------------------
-- Placeholder table for view `market`.`viewlistbooks`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `market`.`viewlistbooks` (`surname` INT, `name` INT, `book_titles` INT);
SHOW WARNINGS;

-- -----------------------------------------------------
-- View `market`.`viewauthors`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `market`.`viewauthors`;
SHOW WARNINGS;
USE `market`;
CREATE  OR REPLACE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `market`.`viewauthors` AS select `market`.`book`.`id` AS `id`,`market`.`authors`.`surname` AS `surname`,`market`.`authors`.`name` AS `name`,`market`.`book`.`title` AS `title`,`market`.`book`.`price` AS `price` from (`market`.`book` join `market`.`authors` on((`market`.`book`.`author_id` = `market`.`authors`.`id`)));
SHOW WARNINGS;

-- -----------------------------------------------------
-- View `market`.`viewauthorspricecategory`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `market`.`viewauthorspricecategory`;
SHOW WARNINGS;
USE `market`;
CREATE  OR REPLACE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `market`.`viewauthorspricecategory` AS select `market`.`viewauthors`.`id` AS `id`,`market`.`viewauthors`.`surname` AS `surname`,`market`.`viewauthors`.`name` AS `name`,`market`.`viewauthors`.`title` AS `title`,`market`.`viewauthors`.`price` AS `price`,(case when (`market`.`viewauthors`.`price` < 1000) then 'Дешёвая' when ((`market`.`viewauthors`.`price` >= 1000) and (`market`.`viewauthors`.`price` < 5000)) then 'Средняя' else 'Дорогая' end) AS `category` from `market`.`viewauthors`;
SHOW WARNINGS;

-- -----------------------------------------------------
-- View `market`.`viewchecktales`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `market`.`viewchecktales`;
SHOW WARNINGS;
USE `market`;
CREATE  OR REPLACE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `market`.`viewchecktales` AS select `market`.`viewauthors`.`id` AS `id`,`market`.`viewauthors`.`surname` AS `surname`,`market`.`viewauthors`.`name` AS `name`,`market`.`viewauthors`.`title` AS `title`,`market`.`viewauthors`.`price` AS `price`,(case when (`market`.`viewauthors`.`title` like '%сказки%') then 'Да' else 'Нет' end) AS `has_tales` from `market`.`viewauthors`;
SHOW WARNINGS;

-- -----------------------------------------------------
-- View `market`.`viewdelivers`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `market`.`viewdelivers`;
SHOW WARNINGS;
USE `market`;
CREATE  OR REPLACE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `market`.`viewdelivers` AS select `market`.`orders`.`id` AS `id`,`market`.`orders`.`order_date` AS `order_date`,`market`.`orders`.`customers_id` AS `customers_id`,`market`.`customers`.`login` AS `login`,`market`.`customers`.`surname` AS `surname`,`market`.`customers`.`name` AS `name` from (`market`.`customers` join `market`.`orders` on((`market`.`customers`.`id` = `market`.`orders`.`customers_id`))) where (year(`market`.`orders`.`order_date`) = year(now()));
SHOW WARNINGS;

-- -----------------------------------------------------
-- View `market`.`viewlistbooks`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `market`.`viewlistbooks`;
SHOW WARNINGS;
USE `market`;
CREATE  OR REPLACE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `market`.`viewlistbooks` AS select `market`.`authors`.`surname` AS `surname`,`market`.`authors`.`name` AS `name`,group_concat(`market`.`book`.`title` separator ';') AS `book_titles` from (`market`.`authors` join `market`.`book` on((`market`.`authors`.`id` = `market`.`book`.`author_id`))) group by `market`.`authors`.`id`,`market`.`authors`.`surname`,`market`.`authors`.`name`;
SHOW WARNINGS;

SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
