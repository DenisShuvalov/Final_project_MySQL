-- Функция. Возвращает уникальный код Заказа по id заказа для таблицы orders, формируя его из: Первые 3 буквы в названии курорта , даты в формате yymmdd и id пользователя

USE booking;

DELIMITER //

CREATE FUNCTION get_unique_code (set_orderid int) RETURNS VARCHAR(15) DETERMINISTIC

BEGIN

	DECLARE OrderCode VARCHAR(15);

	SET OrderCode = 
(SELECT 
CONCAT(
	UPPER(LEFT(resorts.name,3)),
	DATE_FORMAT(orders.checkin_date,'%y%m%d'),
	LPAD(orders.user_id, 6,'0')
)
FROM orders 
INNER JOIN hotels ON hotels.id = orders.hotel_id
INNER JOIN resorts ON resorts.id = hotels.resort_id
where 
orders.id = set_orderid);

RETURN OrderCode;


END; 
// 
DELIMITER ;

select get_unique_code (11);