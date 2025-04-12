CREATE DATABASE bankdb;

USE bankdb;

CREATE TABLE accounts (
	id INT PRIMARY KEY,
    name VARCHAR(255),
    balance DECIMAL(10,2) -- 99999999.99
);

INSERT INTO accounts VALUES
(1, 'Abu', 1000.00),
(2, 'Bakar', 1000.00);

SELECT * from accounts;
-- withdraw
UPDATE accounts SET balance = balance - 200 WHERE id=1;

SELECT * from accounts;

-- deposit
UPDATE accounts SET balance = balance + 200 WHERE id=2;

SELECT * from accounts;

START TRANSACTION;
UPDATE accounts SET balance = balance - 200 WHERE id=1;
SELECT * FROM accounts;
UPDATE accounts SET balance = balance + 200 WHERE id=2;
SELECT * FROM accounts;
COMMIT;

START TRANSACTION;
UPDATE accounts SET balance = balance - 200 WHERE id=1;
SELECT * FROM accounts;
UPDATE accounts SET balance = balance + 200 WHERE id=99;
SELECT * FROM accounts;
ROLLBACK;

SELECT * FROM accounts;

START TRANSACTION;
UPDATE accounts SET balance = balance - 200 WHERE id=1;
SAVEPOINT withdraw_money;
UPDATE accounts SET balance = balance + 200 WHERE id=2;
SAVEPOINT deposit_money;
SELECT * FROM accounts;
ROLLBACK TO SAVEPOINT withdraw_money;
SELECT * FROM accounts;
ROLLBACK;

