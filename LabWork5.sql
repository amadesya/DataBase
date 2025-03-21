CREATE TABLE `market`.`tempbooks` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `surname` VARCHAR(50) NOT NULL,
  `name` VARCHAR(50) NOT NULL,
  `titlle` VARCHAR(50) NOT NULL,
  `price` DECIMAL(6,2) NOT NULL DEFAULT 0,
  PRIMARY KEY (`id`));

INSERT INTO `market`.`tempbooks` (surname, name, titlle, price)
SELECT 
    authors.surname,
    authors.name,
    book.title,
    book.price
FROM 
    authors
JOIN 
    book ON authors.id = book.author_id;
