USE booking;
-- Индекс по таблице пользователей для поиска по ФИО

CREATE INDEX idx_last_name_first_name
ON Users (last_name, first_name);

-- Создание внешних ключей, индексов по таблице orders

ALTER TABLE orders
ADD CONSTRAINT order_hotel_id_fk 
FOREIGN KEY (hotel_id) REFERENCES hotels (id)
ON DELETE CASCADE;

ALTER TABLE orders
ADD CONSTRAINT order_user_id_fk 
FOREIGN KEY (user_id) REFERENCES users (id)
ON DELETE CASCADE;

ALTER TABLE orders
ADD CONSTRAINT order_accommodation_id_fk 
FOREIGN KEY (accommodation_id) REFERENCES accommodation (id)
ON DELETE CASCADE;
     
     
CREATE INDEX idx_ordercode
ON Orders (OrderCode);

-- Создание внешних ключей order_transactions

ALTER TABLE order_transactions
ADD CONSTRAINT transaction_order_id_fk 
FOREIGN KEY (order_id) REFERENCES orders (id)
ON DELETE CASCADE;

-- Создание внешних ключей hotels_media

ALTER TABLE hotels_media
ADD CONSTRAINT hotels_media_hotel_id_fk 
FOREIGN KEY (hotel_id) REFERENCES hotels (id)
ON DELETE CASCADE;

ALTER TABLE hotels_media
ADD CONSTRAINT hotels_media_media_type_id_fk 
FOREIGN KEY (media_type_id) REFERENCES media_types (id)
ON DELETE CASCADE;

-- Создание внешних ключей hotels

ALTER TABLE hotels
ADD CONSTRAINT hotels_category_id_fk 
FOREIGN KEY (category_id) REFERENCES hotel_catigories (id)
ON DELETE CASCADE;

ALTER TABLE hotels
ADD CONSTRAINT hotels_resort_id_fk 
FOREIGN KEY (resort_id) REFERENCES resorts (id)
ON DELETE CASCADE;

ALTER TABLE hotels
ADD CONSTRAINT hotels_city_id_fk 
FOREIGN KEY (city_id) REFERENCES cities (id)
ON DELETE CASCADE;

-- Создание внешних ключей cities

ALTER TABLE cities
ADD CONSTRAINT cities_country_id_fk 
FOREIGN KEY (country_id) REFERENCES countries (id)
ON DELETE CASCADE;

-- Создание внешних ключей prices

ALTER TABLE prices
ADD CONSTRAINT prices_hotel_id_fk 
FOREIGN KEY (hotel_id) REFERENCES hotels (id)
ON DELETE CASCADE;

ALTER TABLE prices
ADD CONSTRAINT prices_accommodation_id_fk 
FOREIGN KEY (accommodation_id) REFERENCES accommodation (id)
ON DELETE CASCADE;

-- Создание внешних ключей profiles

ALTER TABLE profiles
ADD CONSTRAINT profiles_user_id_fk 
FOREIGN KEY (user_id) REFERENCES users (id)
ON DELETE CASCADE;

ALTER TABLE profiles 
ADD CONSTRAINT profiles_cities_id_fk 
FOREIGN KEY (city_id) REFERENCES cities (id)
ON DELETE CASCADE;

-- Создание внешних ключей review

ALTER TABLE review
ADD CONSTRAINT review_user_id_fk 
FOREIGN KEY (user_id) REFERENCES users (id)
ON DELETE CASCADE;

ALTER TABLE review
ADD CONSTRAINT review_hotel_id_fk 
FOREIGN KEY (hotel_id) REFERENCES hotels (id)
ON DELETE CASCADE;

-- Создание внешних ключей review_media

ALTER TABLE review_media
ADD CONSTRAINT review_media_review_id_fk 
FOREIGN KEY (review_id) REFERENCES review (id)
ON DELETE CASCADE;

ALTER TABLE review_media 
ADD CONSTRAINT review_media_media_type_id_fk 
FOREIGN KEY (media_type_id) REFERENCES media_types (id)
ON DELETE CASCADE;