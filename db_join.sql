-- Тестовые таблицы, демонстрирующие работу INNER JOIN

DROP TABLE IF EXISTS users;
DROP TABLE IF EXISTS transactions;

CREATE TABLE users
(
    id INT PRIMARY KEY,
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

INSERT INTO users(id, wallet) VALUES(1, 'uygy3ygud'), (2, '387fgt76g3d'), (3, '72etgg2iudgi');
INSERT INTO transactions(id, user_id, symbol, amount) VALUES(1, 1, 'BNBUSDT', 20.0),
                                                        (2, 1, 'BTCUSDT', 32.9),
                                                        (3, 2, 'XRPUSDT', 223.2),
                                                        (4, 3, 'BTCUSDT', 2.3);
SELECT symbol, amount, time 
FROM users 
INNER JOIN transactions ON users.id = transactions.user_id
WHERE users.id = 1