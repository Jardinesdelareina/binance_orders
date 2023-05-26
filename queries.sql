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

-- вывести среднее округленное qty из xrpusdt
SELECT ROUND(AVG(qty)) FROM xrpusdt;
