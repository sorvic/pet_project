/*
Требования к курсовому проекту:

-->>> 1)  Составить общее текстовое описание БД и решаемых ею задач;
-->>> 2) минимальное количество таблиц - 10;
-->>> 3) скрипты создания структуры БД (с первичными ключами, индексами, внешними ключами);
-->>> 4) создать ERDiagram для БД;
5) скрипты наполнения БД данными;
6) скрипты характерных выборок (включающие группировки, JOIN'ы, вложенные таблицы);
7) представления (минимум 2);
8) хранимые процедуры / триггеры;
*/

-- -------------------------------------------------------------------------
-- ПРОЕКТ - Онлайн-магазин-библиотека с возможностью покупки книг и выдачей книг для чтения
-- -------------------------------------------------------------------------
/*Таблица стран
1) Таблица стран
2) Таблица городов
3) Таблица пользователей (читателей) - то как регаются на сайте
4) Таблица профилей читателей - заполняемый профиль в личном кабинете
5) Таблица издательств
6) Таблица рабочих контактов (контактные лица издательств)
7) Таблица рубрик
8) Таблица авторов
9) Таблица каталог книг
10) Таблица видов заказа (покупка/аренда)
11) Таблица заказов
12) Состав заказа
13) Рейтинг (М*M пользователи и книги)
14) Рецензии
*/

DROP DATABASE IF EXISTS book_online;
CREATE DATABASE book_online;
USE book_online;

-- Таблица стран
DROP TABLE IF EXISTS countries;
CREATE TABLE countries (
	id SERIAL PRIMARY KEY,
	country VARCHAR (100)
);

-- Таблица городов
DROP TABLE IF EXISTS towns;
CREATE TABLE towns (
	id SERIAL PRIMARY KEY,
	town VARCHAR(100),
	country_id BIGINT UNSIGNED NOT NULL,
	
	-- внешние ключи
	FOREIGN KEY (country_id) REFERENCES countries(id)
);

-- Таблица пользователей (читателей)
DROP TABLE IF EXISTS users;
CREATE TABLE users (
	id SERIAL PRIMARY KEY,
	login VARCHAR(50)NOT NULL UNIQUE, -- логин
	pswd VARCHAR(50)NOT NULL, -- пароль
	email VARCHAR(120) NOT NULL UNIQUE,
  	created_at DATETIME DEFAULT NOW(),
  	updated_at DATETIME DEFAULT NOW() ON UPDATE NOW()
);

-- Таблица профилей читателей
DROP TABLE IF EXISTS profiles;
CREATE TABLE profiles (
	user_id SERIAL PRIMARY KEY,
	firstname VARCHAR(50),
	lastname VARCHAR(50),
	gender CHAR(1),
	phone VARCHAR(50),
	birthday DATE,
	town_id BIGINT UNSIGNED NULL,
  	created_at DATETIME DEFAULT NOW(),
  	updated_at DATETIME DEFAULT NOW() ON UPDATE NOW(),

	-- индексируем нужные записи, чтобы при добавлене новых они пересчитывались
	INDEX profiles_firstname_lastname_idx(firstname, lastname),
	
	-- внешние ключи
	FOREIGN KEY (user_id) REFERENCES users(id),
	FOREIGN KEY (town_id) REFERENCES towns(id)
);

-- Таблица издательств
DROP TABLE IF EXISTS publishings;
CREATE TABLE publishings (
	id SERIAL PRIMARY KEY,
	publishing VARCHAR(30), -- краткое название издательства
	publishing_full VARCHAR(200), -- полное название издательства
	phone_pbl BIGINT UNIQUE, -- телефон издательства
	email_pbl VARCHAR(120) UNIQUE -- email издательства	
);

-- Таблица рабочих контактов (контактные лица издательств)
DROP TABLE IF EXISTS contact_faces;
CREATE TABLE contact_faces (
	id SERIAL PRIMARY KEY,
	firstname_cf VARCHAR(50),
	lastname_cf VARCHAR(50),
	phone_cf VARCHAR(50),
	email_cf VARCHAR(120),
	publishing_id BIGINT UNSIGNED NOT NULL,
	created_at DATETIME DEFAULT NOW(),
  	updated_at DATETIME DEFAULT NOW() ON UPDATE NOW(),

	-- индексируем нужные записи, чтобы при добавлене новых они пересчитывались
	INDEX contact_faces_firstname_lastname_idx(firstname_cf, lastname_cf),
	-- внешние ключи
	FOREIGN KEY (publishing_id) REFERENCES publishings(id)
);

-- Таблица рубрик
DROP TABLE IF EXISTS rubricators;
CREATE TABLE rubricators (
	id SERIAL PRIMARY KEY,
	rubricator VARCHAR(100) 
);

-- Таблица авторов
DROP TABLE IF EXISTS authors;
CREATE TABLE authors (
	id SERIAL PRIMARY KEY,
	name_aut VARCHAR(50), -- Имя автора
	surname_aut VARCHAR(50) -- Фамилия автора
);

-- Таблица каталог книг
DROP TABLE IF EXISTS books;
CREATE TABLE books (
	id SERIAL PRIMARY KEY,
	title VARCHAR(250) NOT NULL, -- название книги
	author_id BIGINT UNSIGNED NOT NULL, -- автор (внешний)
	page SMALLINT, -- кол. страниц
	publishing_id BIGINT UNSIGNED NOT NULL, -- издательство (внешний)
	price DECIMAL(7.2), -- цена
	raiting FLOAT, -- рейтинг
	rubricator_id BIGINT UNSIGNED NOT NULL, -- рубрикатор (внешний)
	date_in DATE, -- дата поступления
	date_read DATE, -- дата выбытия - купили или взяли почитать
	description LONGTEXT, -- описание
	review TEXT, -- отзыв
	created_at DATETIME DEFAULT NOW(),
  	updated_at DATETIME DEFAULT NOW() ON UPDATE NOW(),
	
  	-- внешние ключи
	FOREIGN KEY (author_id) REFERENCES authors(id),
	FOREIGN KEY (publishing_id) REFERENCES publishings(id),
	FOREIGN KEY (rubricator_id) REFERENCES rubricators(id)
);

-- Таблица видов заказа (покупка/аренда)
DROP TABLE IF EXISTS order_types;
CREATE TABLE order_types (
	id SERIAL PRIMARY KEY,
    name ENUM('rent', 'sale', 'bay')
);


-- Таблица заказов
DROP TABLE IF EXISTS orders;
CREATE TABLE orders (
	id SERIAL PRIMARY KEY,
	order_type_id BIGINT UNSIGNED NOT NULL,
	user_id BIGINT UNSIGNED NOT NULL,
  	created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
  	updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  	KEY index_of_user_id(user_id),
	
  	-- внешние ключи
	FOREIGN KEY (user_id) REFERENCES users(id),
	FOREIGN KEY (order_type_id) REFERENCES order_types(id)
);


-- Состав заказа
DROP TABLE IF EXISTS orders_books;
CREATE TABLE orders_products (
  	id SERIAL PRIMARY KEY,
  	order_id BIGINT UNSIGNED NOT NULL,
  	book_id BIGINT UNSIGNED NOT NULL,
  	total INT UNSIGNED DEFAULT 1 COMMENT 'Количество заказанных товарных позиций',
  	created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
  	updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  
   	-- внешние ключи
	FOREIGN KEY (order_id) REFERENCES orders(id),
	FOREIGN KEY (book_id) REFERENCES books(id)
);


-- Рейтинг (М*M пользователи и книги)
DROP TABLE IF EXISTS ratings;
CREATE TABLE ratings (
	id SERIAL PRIMARY KEY,
	rating ENUM('1', '2', '3', '4', '5'),
	book_id BIGINT UNSIGNED NOT NULL,

	-- внешние ключи
	FOREIGN KEY (book_id) REFERENCES books(id)
);


-- Рецензии
DROP TABLE IF EXISTS reviews;
CREATE TABLE reviews (
	id SERIAL PRIMARY KEY,
	review TEXT,
	book_id BIGINT UNSIGNED NOT NULL,

	-- внешние ключи
	FOREIGN KEY (book_id) REFERENCES books(id)
);

