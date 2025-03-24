#Task 1
-- Создание пользователя userTask1 с привелегиями SHOW DATABASES

CREATE USER 'userTask1'@'localhost';
GRANT SHOW DATABASES ON *.* TO 'userTask1'@'localhost';

-- Команды для проверки привелегий SHOW DATABASES пользователя userTask1

#Должны быть возможности для выполнения команд
SHOW DATABASES; 

#Не должно быть такой возможности
CREATE DATABASE testdb; 
DROP DATABASE testdb; 

#Task 2
-- Создание пользователя userTask1 с привелегиями SHOW DATABASE

CREATE USER 'userTask2'@'localhost' IDENTIFIED BY '123';
GRANT SHOW DATABASES ON *.* TO 'userTask2'@'localhost';

-- Команды для проверки привелегий  ALL PRIVILEGES пользователя userTask2

#Должны быть возможности для выполнения команд
SHOW DATABASES; 
CREATE DATABASE testdb; 
DROP DATABASE testdb; 
CREATE USER 'new_user'@'localhost' IDENTIFIED BY 'password'; 
DROP USER 'new_user'@'localhost'; 

#Task 3

-- Создание пользователя userTask3 с привелегиями на выполнения DML-команд (SELECT, INSERT, UPDATE, DELETE) для базы данных Market
CREATE USER 'userTask3'@'localhost' identified by 'qwerty';
GRANT SELECT, INSERT, UPDATE, DELETE ON Market.* TO 'userTask3'@'localhost';

-- Команды для проверки привелегий пользователя userTask3

#Показывает только базу данных Market
SHOW DATABASES; 

#Должны быть возможности для выполнения команд
SELECT * FROM Market.orders;

INSERT INTO Market.orders (customers_id, order_date) VALUES (8, '2025-03-01'); 

UPDATE Market.orders SET order_date = '2025-03-10' WHERE id = 1;

DELETE FROM Market.orders WHERE id = 1;

#Task 4

-- Создание пользователя userTask4 с привелегиями на выполнение запроса SELECT в таблице Books базы данных Market
CREATE USER 'userTask4'@'localhost';
GRANT SELECT ON Market.Book TO 'userTask4'@'localhost';

-- Команды для проверки привелегий пользователя userTask4

#Показывает только базу данных Market
SHOW DATABASES; 

#Должны быть возможности для выполнения команд
SELECT * FROM Market.Book;

#Не должно быть такой возможности
INSERT INTO Market.Book (author_id, title, genre, price, weight, year_publication, pages) 
VALUES (2, 'Книга 2', 'другое', 20, 1.5, 2023, 300);

UPDATE Market.Book
SET price = 25 
WHERE id = 1;

DELETE FROM Market.Book WHERE id = 1;

#Task 5

-- Создание пользователя userTask5, имеющего привилегии на выполнение
-- запросов на выборку из столбцов код, название и цена и на изменение столбца цена
-- таблицы Book БД Market
CREATE USER 'userTask5'@'localhost';
GRANT SELECT(id, title, price), UPDATE(price) ON Market.Book TO 'userTask5'@'localhost';

-- Команды для проверки привелегий пользователя userTask5

#Должны быть возможности для выполнения команд
SELECT id, title, price FROM Market.Book;
UPDATE Market.Book SET price = 25 WHERE id = 1;

#Не должно быть такой возможности
SELECT id, title, price, weight FROM Market.Book;
UPDATE Market.Book SET title = 'Новое название' WHERE id = 1; #Привелегия только на столбец price


