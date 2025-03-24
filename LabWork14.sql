DELIMITER $$

CREATE PROCEDURE add_customer(
    IN p_login VARCHAR(50),
    IN p_name VARCHAR(50),
    IN p_surname VARCHAR(50),
    IN p_address VARCHAR(255),
    IN p_phone VARCHAR(20)
)
BEGIN
    INSERT INTO customers (login, name, surname, address, phone)
    VALUES (p_login, p_name, p_surname, p_address, p_phone);

    SELECT LAST_INSERT_ID() AS customer_id;
END$$

DELIMITER ;

CALL add_customer('zxc', 'Dota', '2', 'Папанина', '+22814881377');

DELIMITER $$

CREATE PROCEDURE get_part_of_title(IN I VARCHAR(255))
BEGIN
    SELECT title 
    FROM book 
    WHERE title LIKE CONCAT('%', I, '%');
END$$

DELIMITER ;

CALL get_part_of_title('');

DELIMITER $$

CREATE PROCEDURE add_new_author(
    IN p_surname VARCHAR(255),
    IN p_name VARCHAR(255),
    IN p_country VARCHAR(255),
    OUT p_author_id INT
)
BEGIN
    INSERT INTO authors (surname, name, country)
    VALUES (surname, name, p_country);
    
    SET p_author_id = LAST_INSERT_ID();
END $$

DELIMITER ;

CALL add_new_author('Иван', 'Иванов', 'Россия', @new_author_id);
SELECT @new_author_id;

DELIMITER $$

CREATE PROCEDURE update_books_price(IN p_percentage DECIMAL(5, 2))
BEGIN
    UPDATE book
    SET price = price * (1 + p_percentage / 100);
END $$

DELIMITER ;

CALL update_books_price(5);

SELECT * FROM book;

DELIMITER $$

CREATE PROCEDURE delete_authors_without_books()
BEGIN
    DELETE FROM authors
    WHERE authors.id NOT IN (SELECT DISTINCT author_id FROM book);
    
	SELECT id, name, surname, country
    FROM authors;
END $$

DELIMITER ;

CALL delete_authors_without_books();


