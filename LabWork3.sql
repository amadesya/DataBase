#Task1
SELECT * FROM authors;

#Task2
SELECT surname, name FROM authors
LIMIT 3;

#Task3
SELECT DISTINCT country FROM authors
ORDER BY country;

#Task4
SELECT 
	id,
    title,
    5 AS "Скидка", 
    price,
    price * 0.95 AS "Цена со скидкой" 
FROM book;

#Task5
SELECT price,
    CASE 
        WHEN price < 100 THEN 'Дешевые'
        WHEN price >= 100 AND price < 1000 THEN 'Средние'
        WHEN price >= 1000 THEN 'Дорогие'
    END AS price_category
FROM 
    book
ORDER BY price DESC;

#Task6
SELECT login, surname, name, phone
FROM сustomers
WHERE phone IS NOT NULL;

#Task7
SELECT title
FROM book
WHERE title LIKE '%компьютер%';

#Task8
SELECT 
	MIN(price) as 'Мин',
    AVG(price) as 'Средняя',
    MAX(price) as 'Макс'
FROM book;

#Task9
SELECT 
    author_id,
    title,
    COUNT(*) AS book_count
FROM 
    book
GROUP BY 
    author_id, title;

#Task10
SELECT 
    country,
    COUNT(*) AS author_count
FROM 
    authors
GROUP BY 
    country
HAVING 
    COUNT(*) > 1;



