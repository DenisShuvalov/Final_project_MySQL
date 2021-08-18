USE booking;

-- Статистика по отелям

SELECT DISTINCT

	hotels.name AS 'Hotel name',																								-- Отель
	FORMAT(SUM(orders.stay_cost ) OVER win_hotels, 2) AS 'Booking SUM by hotels',  												-- Сумма бронирований по отелям
	COUNT(orders.id) OVER win_hotels 'Orders Count by hotels',																	-- всего заказов отелей
	FIRST_VALUE(CONCAT(users.first_name, " ", users.last_name, ", Заказ: ",orders.OrderCode, " Стоимость: ", orders.stay_cost))	-- Наиболее дорогой заказ
		OVER (win_hotels ORDER by orders.stay_cost DESC) 'Most expensive Order',
	FIRST_VALUE(CONCAT(users.first_name, " ", users.last_name, ", Заказ: ",orders.OrderCode, " Стоимость: ", orders.stay_cost)) -- Наиболее дешевый заказ
		OVER (win_hotels ORDER by orders.stay_cost ASC) 'Cheapest Order'

FROM hotels

LEFT OUTER JOIN orders ON hotels.id = orders.hotel_id
LEFT OUTER JOIN users ON users.id = orders.user_id 
LEFT OUTER JOIN profiles ON profiles.user_id = users.id
WINDOW win_hotels AS (PARTITION BY hotels.id)

ORDER BY SUM(orders.stay_cost) OVER win_hotels DESC
;



-- Создание VIEW со средней оценокой отеля пользователями сервиса

CREATE VIEW Hotels_raiting 
AS

SELECT
	hotels.name as 'Hotel',
	hotel_catigories.name as 'Category',
	COUNT(DISTINCT rv.review_id) 'review count',
	FORMAT(SUM(rv.rating) / COUNT(rv.review_id),1) AS 'rating'

FROM hotels

INNER JOIN hotel_catigories ON hotels.category_id = hotel_catigories.id

LEFT OUTER JOIN (
				SELECT 
				id AS review_id,
				hotel_id,
				CASE WHEN review.hotel_rating = 'Очень плохо' THEN 1
				WHEN review.hotel_rating = 'Неудовлетворительно' THEN 2
				WHEN review.hotel_rating = 'Удовлетворительно' THEN 3
				WHEN review.hotel_rating = 'Хорошо' THEN 4
				WHEN review.hotel_rating = 'Великолепно' THEN 5
				ELSE 0 
				END  AS rating				
				FROM review
						
						) AS rv ON hotels.id = rv.hotel_id

						GROUP BY hotels.name
						
ORDER BY rating DESC;

-- SELECT * FROM Hotels_raiting;



-- Создание представления с информацией по чекам и заказам по месяцам

CREATE VIEW check_per_month 
AS

SELECT DISTINCT
	MONTHNAME(checkin_date) AS 'Месяц',
	COUNT(*) AS 'кол-во туров',
	FORMAT(SUM(order_transactions.amount),2) AS 'Сумма чеков',	
	FORMAT(AVG(order_transactions.amount),2) AS 'Средний чек'
					
			FROM orders
		
INNER JOIN order_transactions ON
								order_transactions.order_id  = orders.id 

GROUP BY MONTHNAME(checkin_date)
ORDER BY 2 DESC;

-- SELECT * FROM check_per_month;

