-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema Market
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema Market
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `Market` DEFAULT CHARACTER SET utf8 ;
SHOW WARNINGS;
USE `Market` ;

-- -----------------------------------------------------
-- Table `Market`.`Authors`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Market`.`Authors` (
  `id` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `surname` VARCHAR(50) NOT NULL,
  `name` VARCHAR(50) NOT NULL,
  `country` VARCHAR(30) NOT NULL DEFAULT 'Россия',
  PRIMARY KEY (`id`),
  UNIQUE INDEX `idx_author_surname` (`surname` ASC) INVISIBLE,
  UNIQUE INDEX `idx_author_name` (`name` ASC) VISIBLE)
ENGINE = InnoDB;

SHOW WARNINGS;

-- -----------------------------------------------------
-- Table `Market`.`Book`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Market`.`Book` (
  `id` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `id` INT NOT NULL,
  `title` VARCHAR(50) NOT NULL,
  `genre` ENUM('проза', 'поэзия', 'другое') NOT NULL DEFAULT 'проза',
  `price` DECIMAL(6,2) UNSIGNED NOT NULL,
  `weight` DECIMAL(4,3) UNSIGNED NOT NULL,
  `year_publication` YEAR(2) NULL,
  `pages` SMALLINT NULL,
  `Bookcol` VARCHAR(45) NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_author_id_idx` (`id` ASC) INVISIBLE,
  CONSTRAINT `fk_author_id`
    FOREIGN KEY (`id`)
    REFERENCES `Market`.`Authors` (`id`)
    ON DELETE NO ACTION
    ON UPDATE CASCADE)
ENGINE = InnoDB;

SHOW WARNINGS;

-- -----------------------------------------------------
-- Table `Market`.`Сustomers`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Market`.`Сustomers` (
  `id` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `login` VARCHAR(20) NOT NULL,
  `surname` VARCHAR(50) NOT NULL,
  `name` VARCHAR(50) NOT NULL,
  `address` VARCHAR(100) NOT NULL,
  `phone` VARCHAR(20) NULL,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `customer_login_UNIQUE` (`login` ASC) VISIBLE)
ENGINE = InnoDB;

SHOW WARNINGS;

-- -----------------------------------------------------
-- Table `Market`.`Orders`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Market`.`Orders` (
  `id` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `customers_id` INT UNSIGNED NOT NULL,
  `order_date` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  INDEX `customers_id_idx` (`customers_id` ASC) VISIBLE,
  CONSTRAINT `customers_id`
    FOREIGN KEY (`customers_id`)
    REFERENCES `Market`.`Сustomers` (`id`)
    ON DELETE NO ACTION
    ON UPDATE CASCADE)
ENGINE = InnoDB;

SHOW WARNINGS;

-- -----------------------------------------------------
-- Table `Market`.`Composition`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Market`.`Composition` (
  `orders_id` INT NOT NULL,
  `book_id` INT NOT NULL,
  `count` TINYINT NOT NULL DEFAULT 1,
  PRIMARY KEY (`orders_id`, `book_id`),
  INDEX `fk_book_id_idx` (`book_id` ASC) VISIBLE,
  CONSTRAINT `fk_orders_id`
    FOREIGN KEY (`orders_id`)
    REFERENCES `Market`.`Orders` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_book_id`
    FOREIGN KEY (`book_id`)
    REFERENCES `Market`.`Book` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

SHOW WARNINGS;

SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;

CONSTRAINT Composition CHECK (count > 0 AND count <= 100)
