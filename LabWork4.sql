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
    login,
    id
FROM customers

#Task 5

