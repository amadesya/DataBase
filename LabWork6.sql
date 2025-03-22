#Task 1
SELECT 
    DATABASE() AS 'database',
    USER() AS 'user',
    CURDATE() AS 'current data',
    CURTIME() AS 'current time',
    NOW() AS 'time and date';

#Task 2
SELECT 
    id,
    YEAR(NOW()) AS 'current year',
    DAYNAME(CURDATE()) AS 'day name',
    MONTHNAME(CURDATE()) AS 'month name',
    order_date AS 'order date'
FROM
    orders
WHERE 
    YEAR(order_date) = YEAR(CURDATE());

#Task 3
SELECT 
    ROUND(price,-1) AS rounded_price, 
    REPLACE(title, '  ', ' ') AS cleaned_title
FROM 
    book;

#Task 4
SELECT CONCAT_WS('.', surname, LEFT(name, 1)) as format_author_name, CONCAT_WS(', ', book.title, CONCAT(book.price,'$')) as format_title_with_price
FROM authors
	JOIN book ON book.author_id = authors.id;

#Task 5
SELECT CONCAT(surname, ' ', name, ', ', country), group_concat(' ',book.title) as t
from authors
	JOIN book ON book.author_id = authors.id
GROUP BY surname
order by surname;
    
#Task 6
SELECT login, surname, name, 
    CASE 
        WHEN address = '-' THEN NULL 
        ELSE address 
    END AS address,
    CASE 
        WHEN phone = '' THEN '-' 
        ELSE phone 
    END AS phone
FROM 
    customers;
    
#Task 7
SELECT 
	ROW_NUMBER() OVER(ORDER BY title) row_num,
	book.*
FROM book
order by title;

#Task 8
SELECT 
    title,
    genre,
    price, 
    price_rank
FROM (
    SELECT 
        title,
        genre,
        price,
        DENSE_RANK() OVER (PARTITION BY genre ORDER BY price DESC) AS price_rank
    FROM 
        book
) AS ranked_books
WHERE 
    price_rank <= 3
ORDER BY 
    genre, price DESC;

    
    
    
    