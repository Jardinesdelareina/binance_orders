-- Тестовые таблицы, демонстрирующие работу JOIN

DROP TABLE IF EXISTS users;
DROP TABLE IF EXISTS transactions;

CREATE TABLE users
(
    user_id INT PRIMARY KEY,
    wallet VARCHAR(256) NOT NULL
);

CREATE TABLE transactions
(
    id INT PRIMARY KEY,
    user_id INT NOT NULL,
    symbol VARCHAR CHECK (symbol IN ('BTCUSDT', 'XRPUSDT', 'BNBUSDT')),
    amount FLOAT NOT NULL,
    time TIMESTAMP DEFAULT NOW()
);

INSERT INTO users(user_id, wallet) VALUES(1, 'uygy3ygud'), (2, '387fgt76g3d'), (3, '72etgg2iudgi');
INSERT INTO transactions(id, user_id, symbol, amount) VALUES(1, 1, 'BNBUSDT', 20.0),
                                                        (2, 1, 'BTCUSDT', 32.9),
                                                        (3, 2, 'XRPUSDT', 223.2),
                                                        (4, 3, 'BTCUSDT', 2.3);

/* 
Cоединить две таблицы по колонке id, данные которой одинаковы для обеих таблиц
INNER JOIN = JOIN
*/
SELECT symbol, amount, time 
FROM users 
INNER JOIN transactions ON users.user_id = transactions.user_id
WHERE users.user_id = 1;

-- Аналогичный вариант записи JOIN
SELECT symbol, amount, time
FROM users
JOIN transactions USING(user_id)
WHERE users.user_id = 1