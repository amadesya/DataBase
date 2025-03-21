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

DELETE FROM `market`.`tempbooks`
WHERE `titlle` LIKE '%компьютер%';

UPDATE `market`.`tempbooks`
SET 
    `price` = CASE 
        WHEN `surname` = 'Пушкин' THEN `price` * 2
        WHEN `surname` = 'Иванов' THEN `price` - 50
        ELSE `price`
    END
WHERE `id` > 0;  -- Условие с индексированным столбцом

TRUNCATE TABLE `market`.`tempbooks`;

UPDATE book
        JOIN
    authors ON book.author_id = authors.id 
SET 
    book.price = book.price + 100
WHERE
    authors.country = 'Росcия'

DELETE FROM `customers`
WHERE `id` NOT IN (
    SELECT `customers_id`
    FROM `orders`
);

