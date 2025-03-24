DELIMITER $$
CREATE FUNCTION get_price_by_order(order_id INT)
RETURNS DECIMAL(10, 2)
DETERMINISTIC
BEGIN
    DECLARE total_price DECIMAL(10, 2);
    SELECT IFNULL(SUM(book.price), 0) INTO total_price
    FROM book
    JOIN composition ON book.id = composition.book_id
    WHERE composition.order_id = order_id;
    RETURN total_price;
END $$
DELIMITER ;

SELECT GET_PRICE_BY_ORDER(1)

DELIMITER $$
CREATE FUNCTION get_fullname_by_login(order_id INT)
RETURNS DECIMAL(10, 2)
DETERMINISTIC
BEGIN
    DECLARE total_price DECIMAL(10, 2);
    SELECT IFNULL(SUM(book.price), 0) INTO total_price
    FROM book
    JOIN composition ON book.id = composition.book_id
    WHERE composition.order_id = order_id;
    RETURN total_price;
END $$
DELIMITER ;

DELIMITER $$

CREATE FUNCTION `get_fullname_by_login` (logins VARCHAR(20))
RETURNS VARCHAR(100)
DETERMINISTIC
READS SQL DATA
BEGIN
    DECLARE fullname VARCHAR(100);
    SELECT CONCAT(UPPER(name), ' ', UPPER(surname)) 
    INTO fullname
    FROM customers
    WHERE customers.login = logins;
    RETURN fullname;
END $$

DELIMITER ;

select get_fullname_by_login('ivanov123');


DROP FUNCTION IF EXISTS `get_books_by_author_id`;

DELIMITER $$

CREATE FUNCTION `get_books_by_author_id` (id INT)
RETURNS VARCHAR(200)
DETERMINISTIC
BEGIN
    DECLARE books VARCHAR(200);
    SELECT GROUP_CONCAT(book.title SEPARATOR ', ') INTO books
    FROM book
    WHERE book.author_id = id;
    RETURN books;
END$$

DELIMITER ;

SELECT get_books_by_author_id(4);

DELIMITER $$

CREATE FUNCTION `get_authors_count_by_country` (country_name VARCHAR(30))
RETURNS INT
DETERMINISTIC
BEGIN
    DECLARE authors_count INT;
	SELECT count(country) INTO authors_count FROM authors
    WHERE authors.country = country_name;
    RETURN authors_count;
END$$

DELIMITER ;

DELIMITER $$

CREATE FUNCTION `get_income_by_year` (year_number INT)
RETURNS INT
DETERMINISTIC
BEGIN
    DECLARE total_price INT;
	SELECT 
		SUM(book.price * composition.count) INTO total_price
	FROM
		composition
	JOIN book ON composition.book_id = book.id
	JOIN orders ON composition.order_id = orders.id
	WHERE year(order_date) = year_number;
    RETURN total_price;
END$$

DELIMITER ;

SELECT get_income_by_year(2024);

