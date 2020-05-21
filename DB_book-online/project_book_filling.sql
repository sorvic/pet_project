/*
Требования к курсовому проекту:

1) Составить общее текстовое описание БД и решаемых ею задач;
2) минимальное количество таблиц - 10;
3) скрипты создания структуры БД (с первичными ключами, индексами, внешними ключами);
4) создать ERDiagram для БД;
-->>> 5) скрипты наполнения БД данными;
6) скрипты характерных выборок (включающие группировки, JOIN'ы, вложенные таблицы);
7) представления (минимум 2);
8) хранимые процедуры / триггеры;
*/

-- -------------------------------------------------------------------------
-- ПРОЕКТ - Онлайн-магазин-библиотека с возможностью покупки книг и выдачей книг для чтения
-- -------------------------------------------------------------------------
/*
1) Таблица стран => занес руками
2) Таблица городов => занес руками
3) Таблица пользователей (читателей) - то как регаются на сайте => частично руками - 5, остальное filldb (500)
4) Таблица профилей читателей - заполняемый профиль в личном кабинете => частично руками - 5, остальное filldb (500)
5) Таблица издательств => часитично руками - 4, остальное filldb (20)
6) Таблица рабочих контактов (контактные лица издательств) => filldb (100)
7) Таблица рубрик => занес руками
8) Таблица авторов => частично руками - 6, остальное filldb (50)
9) Таблица каталог книг => filldb (500)
10) Таблица видов заказа (покупка/аренда) => занес при создание
11) Таблица заказов => filldb (100)
12) Состав заказа => filldb (100)
13) Рейтинг (М*M пользователи и книги) => filldb (400)
14) Рецензии => filldb (300)
*/


USE book_online;

-- Таблица стран
SELECT * FROM countries;
INSERT INTO countries VALUES
	(NULL, 'Россия'),
	(NULL, 'Финляндия'),
	(NULL, 'Эстония')
;

-- Таблица городов
SELECT * FROM towns;
INSERT INTO towns VALUES
	(NULL, 'Москва', 1), (NULL, 'Санкт-Петербург', 1), (NULL, 'Тверь', 1), (NULL, 'Псков', 1), (NULL, 'Выборг', 1),
	(NULL, 'Пушкин', 1), (NULL, 'Кронштадт', 1), (NULL, 'Клин', 1), (NULL, 'Солнечногорск', 1), (NULL, 'Видное', 1),
	(NULL, 'Хельсинки', 2), (NULL, 'Иматра', 2), (NULL, 'Лаппеенранта', 2), (NULL, 'Котка', 2), (NULL, 'Порвоо', 2),
	(NULL, 'Таллин', 2), (NULL, 'Нарва', 2), (NULL, 'Раквере', 2), (NULL, 'Вильянди', 3), (NULL, 'Хаапсалу', 3)
;

-- Таблица пользователей (читателей) - частично руками - 5, остальное filldb
SELECT * FROM users;
DESC users;
INSERT INTO users VALUES
	(NULL, 'sorvic1', 'asWQEsfa', 'sorvic1@gmail.com', DEFAULT, DEFAULT),
	(NULL, 'sorvic2', 'asWEfa', 'sorvic2@gmail.com', DEFAULT, DEFAULT),
	(NULL, 'sorvic3', 'Esfa', 'sorvic3@gmail.com', DEFAULT, DEFAULT),
	(NULL, 'sorvic4', 'aafsfa', 'sorvic4@gmail.com', DEFAULT, DEFAULT),
	(NULL, 'sorvic5', 'fs312d', 'sorvic5@gmail.com', DEFAULT, DEFAULT)
;

-- DELETE FROM users WHERE login = 'sorvic';

-- Таблица профилей читателей - частично руками - 5, остальное filldb
SELECT * FROM profiles;
DESC profiles;
INSERT INTO profiles VALUES
	(1, 'Victor1', 'Sorvic', 'm', '79112121530', '1986-12-25', 2, DEFAULT, DEFAULT),
	(2, 'Victor2', 'Sorvic2', 'm', '2121530', '1986-07-25', 2, DEFAULT, DEFAULT),
	(3, 'Victor3', 'Sorvic', 'm', '9112121530', '1998-12-25', 2, DEFAULT, DEFAULT),
	(4, 'Victor', 'Sorvic4', 'm', NULL, '1986-12-12', 2, DEFAULT, DEFAULT),
	(5, 'Victor', 'Sorvic5', 'm', NULL, '1998-01-25', 2, DEFAULT, DEFAULT)
;

-- Таблица издательств - часитично руками - 4, остальное filldb
SELECT * FROM publishings;
DESC publishings;
INSERT INTO profiles VALUES
	(NULL, 'МИФ', 'Манн, Иванов и Фербера', '79113121530', 'mif@mif.com'),
	(NULL, 'ACT', 'Издательство АСТ', '79113121530', 'act@act.com'),
	(NULL, 'Питер', 'Питер', '791131530', 'act@act.com'),
	(NULL, 'Минск', 'Поппури Минск', '79113130', 'act@act.com')
;

-- Таблица рабочих контактов (контактные лица издательств) - filldb
SELECT * FROM contact_faces;
DESC contact_faces;


-- Таблица рубрик - вручную
SELECT * FROM rubricators;
DESC rubricators;
INSERT INTO rubricators VALUES
	(NULL, 'Бизнес-образование'), (NULL, 'Личные финансы'), (NULL, 'Маркетинг и продажи'),
	(NULL, 'Менеджмент и управление'), (NULL, 'Саморазвитие'), (NULL, 'Психология'),
	(NULL, 'Дизайн'), (NULL, 'Известные личности'), (NULL, 'Компьютерные технологии')
;

-- Таблица авторов - частично руками - 6, остальное filldb
SELECT * FROM authors;
DESC authors;
INSERT INTO authors VALUES
	(NULL, 'Алексей', 'Благирев'), (NULL, 'Тони', 'Шейн'),
	(NULL, 'Владимир', 'Савельев'), (NULL, 'Александр', 'Фридман'),
	(NULL, 'Вадим', 'Зеланд'), (NULL, 'Алексей', 'Герасименко')
;

-- Таблица каталог книг - filldb
SELECT * FROM books;
DESC books;

-- Таблица видов заказа (покупка/аренда) - занес при создание
SELECT * FROM order_types;
DESC order_types;

-- Таблица заказов - filldb
SELECT * FROM orders;
DESC orders;

-- Состав заказа - filldb
SELECT * FROM orders_books;
DESC orders_books;

-- Рейтинг (М*M пользователи и книги) - filldb
SELECT * FROM ratings;
DESC ratings;

-- Рецензии - filldb
SELECT * FROM reviews;
DESC reviews;
