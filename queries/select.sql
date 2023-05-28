SELECT * FROM bnbusdt;                              -- вывести всё из bnbusdt
SELECT FROM bnbusdt;                               
SELECT COUNT(*) FROM bnbusdt;                       -- вывести количество записей в bnbusdt
SELECT price, qty FROM xrpusdt;                     -- вывести колонки price и qty из xrpusdt
SELECT DISTINCT price FROM xrpusdt;                 -- вывести price из xrpusdt без повторений

-- вывести с 5 по 10 записей price из xrpusdt, где commission_asset - BNB 
SELECT price FROM xrpusdt WHERE commission_asset = 'BNB' OFFSET 5 LIMIT 10;

-- вывести все записи из xrpusdt, где commission_asset одно из вариантов
SELECT * FROM xrpusdt WHERE commission_asset IN ('XRP', 'BNB');

-- вывести order_id всех записей из btcusdt, чье время находится в промежутке с ... до...
SELECT order_id FROM btcusdt WHERE time BETWEEN '2022-01-01 00:00:00' AND '2023-01-01 00:00:00';

/* вывести всё из xrpusdt, у которых в commission_asset где то в середине присутствует 'S'/ 
                                                                        начинается на 'S'/ 
                                                                        оканчивается на 'S' (iLIKE - игнор регистра)
*/
SELECT * FROM xrpusdt WHERE commission_asset LIKE '%S%';

-- вывести данные с псевдонимом колонки
SELECT commission_asset AS com_as FROM linkusdt;

-- вывести максимальную цену btcusdt за предиод
SELECT MAX(price) FROM btcusdt WHERE time BETWEEN '2022-01-01 00:00:00' AND '2023-01-01 00:00:00';

-- вывести ордера, чья price в интервале
SELECT order_id FROM btcusdt WHERE price BETWEEN 20000 AND 30000;

-- вывести среднее округленное qty из xrpusdt
SELECT ROUND(AVG(qty)) FROM xrpusdt;

-- вывести order_id и новый столбец с результатом произведения
SELECT order_id, (price * quote_qty) AS value FROM btcusdt; 

-- вывести order_id ордеров, чьи commission_asset НЕ USDT
SELECT order_id FROM xrpusdt WHERE commission_asset <> 'USDT';

-- вывести ордера, отсортированные по time в порядке убывания
SELECT order_id, time FROM btcusdt ORDER BY time DESC;

-- вывести количество записей, сгруппированных по commission_asset 
SELECT commission_asset, COUNT(*) FROM btcusdt GROUP BY commission_asset;

-- объединенить данные из двух таблиц (UNION устраняет дубликаты, UNION ALL выводит вместе с дубликатами)
SELECT order_id, price FROM bnbusdt UNION SELECT order_id, price FROM linkusdt;

-- вывести commission_asset, которые есть в таблицах btcusdt и xrpusdt
SELECT commission_asset FROM btcusdt INTERSECT SELECT commission_asset FROM xrpusdt;

-- вывести commission_asset, которых нет в таблицах btcusdt и xrpusdt
SELECT commission_asset FROM btcusdt EXCEPT SELECT commission_asset FROM xrpusdt;