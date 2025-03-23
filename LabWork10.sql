CREATE TABLE IF NOT EXISTS `market`.`BooksInfo` (
    `id` INT NOT NULL AUTO_INCREMENT,
    `surname` VARCHAR(50) NOT NULL,
    `name` VARCHAR(50) NOT NULL,
    `title` VARCHAR(50) NOT NULL,
    `price` DECIMAL(6,2) DEFAULT 0,   
    `pages` SMALLINT DEFAULT 0,
    `year_publication` YEAR,
    PRIMARY KEY (`id`)
);

ALTER TABLE BooksInfo ADD CONSTRAINT UQ_BooksInfo_Title UNIQUE (Title);
ALTER TABLE BooksInfo ADD CONSTRAINT UQ_BooksInfo_Name UNIQUE (name);
ALTER TABLE BooksInfo ADD CONSTRAINT UQ_BooksInfo_Surname UNIQUE (surname);

ALTER TABLE BooksInfo ADD arrival_date DATE;

ALTER TABLE booksinfo DROP column pages;