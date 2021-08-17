USE Sys; 
CREATE DATABASE booking; 

-- SHOW DATABASES;

-- DROP DATABASE booking; 

USE booking;


-- Справочник отелей
CREATE TABLE hotels (
	id INTEGER UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY COMMENT "Идентификатор строки",
	name VARCHAR(100) NOT NULL COMMENT "Название отеля",
	category_id INT UNSIGNED COMMENT "Ссылка на справочник категорий",
	descritipon TEXT COMMENT "Описание отеля",
	city_id INT UNSIGNED COMMENT "Ссылка на справочник городов",
	resort_id INT UNSIGNED COMMENT "Ссылка на справочник курортов",
  	created_at DATETIME DEFAULT CURRENT_TIMESTAMP COMMENT "Время создания строки",  
 	updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT "Время обновления строки"
)
COMMENT "Справочник отелей"; 

-- Справочник категорий отелей
CREATE TABLE hotel_catigories (
	id INTEGER UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY COMMENT "Идентификатор строки",
	name VARCHAR(50) NOT NULL COMMENT "Назвние категории",
	created_at DATETIME DEFAULT CURRENT_TIMESTAMP COMMENT "Время создания строки",  
	updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT "Время обновления строки"	
	)
COMMENT "Справочник категорий отелей";


-- Таблица категрий размещения
CREATE TABLE accommodation (
	id INT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY COMMENT "Идентификатор строки",
	category_name VARCHAR(100) NOT NULL COMMENT "Название категори",
	board VARCHAR(255) NOT NULL COMMENT "Тип питания",
	main_places INT NOT NULL COMMENT "Количество проживающих на основных местах",
	addition_places INT NOT NULL COMMENT "Количество проживающих на дополнителных местах",
	created_at DATETIME DEFAULT CURRENT_TIMESTAMP COMMENT "Время создания строки",  
	updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT "Время обновления строки"
)
COMMENT "Справочник категорий размещения";


-- Таблица городов
CREATE TABLE cities (
	id INT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY COMMENT "Идентификатор строки",
	name VARCHAR(100) NOT NULL COMMENT "Назвние города",
	country_id INT UNSIGNED COMMENT "Ссылка на справочник стран"
)
COMMENT "Справочник городов";

-- Справочник стран
CREATE TABLE countries (
	id INT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY COMMENT "Идентификатор строки",
	name VARCHAR(100) NOT NULL COMMENT "Назвние страны"
)
COMMENT "Справочник стран";

-- Справочник курортов
CREATE TABLE resorts (
	id INT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY COMMENT "Идентификатор строки",
	name VARCHAR(150) NOT NULL COMMENT "Назвние курорта"
)
COMMENT "Справочник курортов";

-- таблица пользователей
CREATE TABLE users (
	id INT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY COMMENT "Идентификатор строки", 
	first_name VARCHAR(100) NOT NULL COMMENT "Имя пользователя",
	last_name VARCHAR(100) NOT NULL COMMENT "Фамилия пользователя",
	email VARCHAR(100) NOT NULL UNIQUE COMMENT "Почта",
	phone VARCHAR(100) NOT NULL UNIQUE COMMENT "Телефон",
	created_at DATETIME DEFAULT CURRENT_TIMESTAMP COMMENT "Время создания строки",  
	updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT "Время обновления строки"
)
COMMENT "Пользователи"; 

-- Таблица профилей
CREATE TABLE profiles (
	user_id INT UNSIGNED NOT NULL PRIMARY KEY COMMENT "Ссылка на пользователя", 
	gender CHAR(1) NOT NULL COMMENT "Пол",
	birthday DATE COMMENT "Дата рождения",
	passport_series VARCHAR(10) NOT NULL COMMENT "Серия паспорта",
	passport_number VARCHAR(30) NOT NULL COMMENT "Номер паспорта", 
	city_id INT UNSIGNED COMMENT "Ссылка на город проживания",
	created_at DATETIME DEFAULT CURRENT_TIMESTAMP COMMENT "Время создания строки",  
	updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT "Время обновления строки"
)
COMMENT "Профили"; 

-- Таблица отзывов туристов
CREATE TABLE review (
	id INT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY COMMENT "Идентификатор строки",
	user_id INT UNSIGNED NOT NULL COMMENT "Ссылка на пользователя",
	hotel_id INT UNSIGNED COMMENT "Ссылка на справочник отелей",
	review_title VARCHAR(100) NOT NULL COMMENT "Название отзыва",
	review_text VARCHAR(2000)  NOT NULL COMMENT "Текст отзыва",
	hotel_rating ENUM('Очень плохо', 'Неудовлетворительно', 'Удовлетворительно', 'Хорошо', 'Отлично') COMMENT "Оценка отеля туристом",
	created_at DATETIME DEFAULT CURRENT_TIMESTAMP COMMENT "Время создания строки",  
	updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT "Время обновления строки"
)
COMMENT "Отзывы туристов";

-- Медиа-файлы отелей
CREATE TABLE hotels_media (
	id INT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY COMMENT "Идентификатор строки",
	hotel_id INT UNSIGNED COMMENT "Ссылка на справочник отелей",
	is_title BOOLEAN NOT NULL DEFAULT 0 COMMENT "Флаг главной картинки",
	filename VARCHAR(255) NOT NULL COMMENT "Путь к файлу",
	file_size INT NOT NULL COMMENT "Размер файла",
	metadata JSON COMMENT "Метаданные файла",
	media_type_id INT UNSIGNED NOT NULL COMMENT "Ссылка на тип контента",
	created_at DATETIME DEFAULT CURRENT_TIMESTAMP COMMENT "Время создания строки",
	updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT "Время обновления строки"
)
COMMENT "Медиа-файлы справочника отелей";


-- Медиа-файлы отзывов туристов
CREATE TABLE review_media (
	id INT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY COMMENT "Идентификатор строки",
	review_id INT UNSIGNED NOT NULL COMMENT "Ссылка на справочник отелей",
	filename VARCHAR(255) NOT NULL COMMENT "Путь к файлу",
	file_size INT NOT NULL COMMENT "Размер файла",
	metadata JSON COMMENT "Метаданные файла",
	media_type_id INT UNSIGNED NOT NULL COMMENT "Ссылка на тип контента",
	created_at DATETIME DEFAULT CURRENT_TIMESTAMP COMMENT "Время создания строки",
	updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT "Время обновления строки"
)
COMMENT "Медиа-файлы отзывов туристов";

-- Таблица типов медиа
CREATE TABLE media_types (
	id INT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY COMMENT "Идентификатор строки",
	name VARCHAR(255) NOT NULL UNIQUE COMMENT "Название типа",
	created_at DATETIME DEFAULT CURRENT_TIMESTAMP COMMENT "Время создания строки",  
	updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT "Время обновления строки"
)
COMMENT "Типы медиафайлов";


-- Таблица с ценами на услуги размещения
CREATE TABLE prices (
	id INT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY COMMENT "Идентификатор строки",
	hotel_id INT UNSIGNED COMMENT "Ссылка на справочник отелей",
	accommodation_id INT UNSIGNED COMMENT "Ссылка на справочник категорий размещения",
	start_date DATE COMMENT "Дата начала действия цены",
	end_date DATE COMMENT "Дата окончания действия цены",
	cost FLOAT (18.2) NOT NULL COMMENT "Цена по прайс-листу",
	stop_list BIT NOT NULL DEFAULT 0 COMMENT "Признак неактивной цены",
	created_at DATETIME DEFAULT CURRENT_TIMESTAMP COMMENT "Время создания строки",  
	updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT "Время обновления строки"
)
COMMENT "Цены на услуги размещения";

-- Заказы пользователей сервиса
CREATE TABLE orders (
	id INT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY COMMENT "Идентификатор строки",
	OrderCode VARCHAR(15) NOT NULL UNIQUE COMMENT "Код заказа",
	user_id INT UNSIGNED NOT NULL COMMENT "Ссылка на пользователя",
	hotel_id INT UNSIGNED COMMENT "Ссылка на справочник отелей",
	accommodation_id INT UNSIGNED COMMENT "Ссылка на справочник категорий размещения",
	checkin_date DATE NOT NULL COMMENT "Дата начала проживания",
	checkout_date DATE NOT NULL  COMMENT "Дата окончания проживания",
	stay_leght INT NOT NULL  COMMENT "Продолжительность проживания (количество ночей)",
	stay_cost FLOAT (18.2) NOT NULL COMMENT "Стоимость пакета проживания",
	created_at DATETIME DEFAULT CURRENT_TIMESTAMP COMMENT "Время создания строки",  
	updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT "Время обновления строки"
)
COMMENT "Заказы пользователей сервиса";

-- Транзакции по заказам
CREATE TABLE order_transactions (
	id INT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY COMMENT "Идентификатор строки",
	order_id INT UNSIGNED NOT NULL COMMENT "Ссылка на заказ",
	amount FLOAT (18.2) NOT NULL COMMENT "Сумма транзакции",
	created_at DATETIME DEFAULT CURRENT_TIMESTAMP COMMENT "Время создания строки"  
)
COMMENT "Транзакции по заказам";
	
	
