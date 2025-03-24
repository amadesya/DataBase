CREATE TABLE deleted_customers (
    id INT PRIMARY KEY,
    login varchar(20),
    surname VARCHAR(50),
    name VARCHAR(50),
    address VARCHAR(100),
    phone VARCHAR(15),
    deletion_date DATE
);

DELIMITER $$

CREATE TRIGGER after_delete_customers
AFTER DELETE ON customers
FOR EACH ROW
BEGIN
    INSERT INTO deleted_customers(id, login, surname, name, address, phone, deletion_date)
    VALUES (id, OLD.login, OLD.surname, OLD.name, OLD.address, OLD.phone, NOW());
END $$

CREATE TABLE `logs` (
  `id` int NOT NULL AUTO_INCREMENT,
  `table_name` varchar(50),
  `operation` varchar(10),
  `operation_time` datetime DEFAULT CURRENT_TIMESTAMP,
  `current_user` varchar(50),
  PRIMARY KEY (`id`)
) ENGINE=InnoDB 
DELIMITER ;

DELIMITER $$

CREATE TRIGGER after_insert_books
AFTER INSERT ON book
FOR EACH ROW
BEGIN
    INSERT INTO Logs (table_name, operation, operation_time, user_name)
    VALUES ('book', 'INSERT', NOW(), USER());
END $$

DELIMITER ;

DELIMITER $$

CREATE TRIGGER after_delete_orders
AFTER DELETE ON orders
FOR EACH ROW
BEGIN
    IF NOT EXISTS (SELECT 1 FROM orders WHERE customers_id = OLD.customers_id) THEN
        DELETE FROM customers WHERE id = OLD.customers_id;
    END IF;
END $$

DELIMITER ;

SELECT * FROM customers;
SELECT * FROM orders;
DELETE FROM composition WHERE order_id = 3;
DELETE FROM orders WHERE id = 3;

SELECT * FROM customers;
SELECT * FROM orders;
SELECT * FROM composition;

DELIMITER $$

CREATE TRIGGER after_insert_composition
AFTER INSERT ON composition
FOR EACH ROW
BEGIN
    SET @orderCost = (
        SELECT SUM(composition.count * book.price) 
        FROM composition
        JOIN book ON composition.book_id = book.id
        WHERE composition.order_id = NEW.order_id
    );
END $$

DELIMITER ;

INSERT INTO composition (order_id, book_id, count)
VALUES (1, 2, 3);

SELECT @orderCost;



