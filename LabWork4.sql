#Task 1
SELECT surname, name, title, price
FROM book
INNER JOIN authors ON authors.id = book.author_id
WHERE country = 'Россия';

#Task 2
SELECT surname, name, COUNT(book.id) AS book_count
FROM authors
LEFT JOIN book ON authors.id = book.author_id
GROUP BY surname, name;

#Task 3
SELECT surname, name
FROM authors
WHERE id NOT IN (
    SELECT book.author_id
    FROM book
    WHERE title LIKE '%linux%' OR title LIKE '%windows%'
);

#Task 4
SELECT 
    customers.login,
    COUNT(DISTINCT orders.id) AS order_count,
    SUM(composition.count) AS book_count,
    SUM(book.price * composition.count) AS book_total_price
FROM
    customers
        JOIN
    orders ON customers.id = orders.customers_id
        JOIN
    composition ON composition.order_id = orders.id
        JOIN
    book ON composition.book_id = book.id
GROUP BY customers.login;

#Task 5
SELECT 
    customers.login,
    COUNT(DISTINCT orders.id) AS order_count,
    SUM(composition.count) AS book_count,
    SUM(book.price * composition.count) AS book_total_price
FROM
    customers
        JOIN
    orders ON customers.id = orders.customers_id
        JOIN
    composition ON composition.order_id = orders.id
        JOIN
    book ON composition.book_id = book.id
GROUP BY customers.login
HAVING book_count > 10;
