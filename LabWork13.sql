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

select get_fullname_by_login('ivanov123')