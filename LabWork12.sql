CREATE VIEW viewdelivers AS
    SELECT 
        orders.id, order_date, customers_id, login, surname, name
    FROM
        customers
            JOIN
        orders ON customers.id = orders.customers_id
    WHERE
        YEAR(order_date) = YEAR(NOW());

CREATE VIEW viewauthors AS
    SELECT 
        book.id,
        authors.surname,
        authors.name,
        book.title,
        book.price
    FROM
        book
            JOIN
        authors ON book.author_id = authors.id;




CREATE VIEW viewlistbooks AS
    SELECT 
        authors.surname,
        authors.name,
        GROUP_CONCAT(book.title
            SEPARATOR ';') AS book_titles
    FROM
        authors
            JOIN
        book ON authors.id = book.author_id
    GROUP BY authors.id , authors.surname , authors.name; 
    

CREATE VIEW ViewCheckTales AS
    SELECT 
        *,
        CASE
            WHEN title LIKE '%сказки%' THEN 'Да'
            ELSE 'Нет'
        END AS has_tales
    FROM
        viewauthors;

CREATE VIEW ViewAuthorsPriceCategory AS
SELECT *,
    CASE
        WHEN price < 1000 THEN 'Дешёвая'
        WHEN price >= 1000 AND price < 5000 THEN 'Средняя'
        ELSE 'Дорогая'
    END AS category
FROM viewauthors;
