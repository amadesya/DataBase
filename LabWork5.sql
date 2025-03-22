CREATE TABLE tempbooks (
    id INT NOT NULL AUTO_INCREMENT,
    surname VARCHAR(50) NOT NULL,
    name VARCHAR(50) NOT NULL,
    title VARCHAR(50) NOT NULL,
    price DECIMAL(6 , 2 ) NOT NULL DEFAULT 0,
    PRIMARY KEY (id)
);

INSERT INTO tempbooks (surname, name, title, price)
SELECT 
    authors.surname,
    authors.name,
    book.title,
    book.price
FROM 
    authors
JOIN 
    book ON authors.id = book.author_id;

DELETE FROM tempbooks
WHERE title LIKE '%компьютер%';

UPDATE tempbooks
SET 
    price = CASE 
        WHEN surname = 'Пушкин' THEN price * 2
        WHEN surname = 'Иванов' THEN price - 50
        ELSE price
    END;

TRUNCATE TABLE tempbooks;

UPDATE book
        JOIN
    authors ON book.author_id = authors.id 
SET 
    book.price = book.price + 100
WHERE
    authors.country = 'Росcия';

DELETE FROM customers
WHERE id NOT IN (
    SELECT customers_id
    FROM orders
);

REPLACE INTO authors (surname, name, country)
VALUES ('Пушкин', 'Александр', 'Россия');

INSERT INTO authors (surname, name, country)
VALUES ('1', '1', 'США')
ON DUPLICATE KEY UPDATE
    country = VALUES(country);


