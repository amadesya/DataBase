#Task 1
DELIMITER $$

CREATE TRIGGER before_delete_customers
BEFORE DELETE ON customers
FOR EACH ROW
BEGIN
    DELETE FROM composition WHERE order_id IN (SELECT id FROM orders WHERE customers_id = OLD.id);
    
    DELETE FROM orders WHERE customers_id = OLD.id;
END $$

DELIMITER ;

INSERT INTO customers (login, surname, name, address, phone)
VALUES 
    ('test_user4', 'Test', 'User', 'Test Address', '1234567890'),
    ('john_doe', 'Doe', 'John', '123 Elm Street', '0987654321'),
    ('mary_smith', 'Smith', 'Mary', '456 Oak Road', '1122334455'),
    ('alice_jones', 'Jones', 'Alice', '789 Pine Avenue', '9988776655'),
    ('bob_brown', 'Brown', 'Bob', '101 Maple Lane', '6677889900');

INSERT INTO orders (id, customers_id, order_date)
VALUES 
    (1, 1, '2025-03-01'),
    (2, 1, '2025-03-02'),
    (3, 2, '2025-03-03'),
    (4, 2, '2025-03-04'),
    (5, 3, '2025-03-05'),
    (6, 3, '2025-03-06'),
    (7, 4, '2025-03-07'),
    (8, 4, '2025-03-08'),
    (9, 5, '2025-03-09'),
    (10, 5, '2025-03-10');

INSERT INTO composition (order_id, book_id, count)
VALUES 
    (1, 1, 2),
    (1, 2, 3),
    (2, 1, 1),
    (3, 2, 5),
    (3, 3, 2),
    (4, 1, 4);

DELETE FROM customers WHERE id = 21;
SELECT * FROM orders;
SELECT * FROM composition;
SELECT * FROM customers;


#Task 2
DELIMITER $$

CREATE TRIGGER before_insert_books
BEFORE INSERT ON book
FOR EACH ROW
BEGIN
    IF NEW.price > 5000 THEN
        SET NEW.price = 5000;
    END IF;
END $$

DELIMITER ;

INSERT INTO book (author_id, title, genre, price, weight, year_publication, pages)
VALUES (2, 'оч дорогая книг', 'другое', 6000, 1.5, 2023, 350);

SELECT * FROM book WHERE title = 'оч дорогая книг';

#Task 3
DELIMITER $$

CREATE TRIGGER before_insert_orders
BEFORE INSERT ON orders
FOR EACH ROW
BEGIN
    IF NEW.order_date IS NULL THEN
        SET NEW.order_date = NOW();
    END IF;
END $$

DELIMITER ;

INSERT INTO orders (customers_id)
VALUES (1); 

SELECT * FROM orders WHERE customers_id = 1 AND order_date IS NOT NULL;

#Task 4
DELIMITER $$

CREATE TRIGGER before_insert_composition
BEFORE INSERT ON composition
FOR EACH ROW
BEGIN
    UPDATE book
    SET count = count - NEW.count
    WHERE id = NEW.book_id;
    
    IF (SELECT count FROM book WHERE id = NEW.book_id) < 0 THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Недостаточно книг на складе';
    END IF;
END $$

DELIMITER ;

INSERT INTO book (author_id, title, genre, price, weight, year_publication, pages, count)
VALUES 
    (2, 'Книга 1', 'другое', 500, 1.2, 2020, 350, 10),
    (2, 'Книга 2', 'другое', 300, 1.0, 2021, 250, 5); 

SELECT * FROM book;

INSERT INTO orders (customers_id, order_date)
VALUES 
    (1, '2025-03-01'),
    (2, '2025-03-02');

INSERT INTO composition (order_id, book_id, count)
VALUES 
    (1, 25, 4),
    (2, 24, 6); 

SELECT * FROM book;
SELECT * FROM orders;
SELECT * FROM composition;

