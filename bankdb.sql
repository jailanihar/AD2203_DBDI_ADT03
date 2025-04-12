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

-- Make the changes permanent by using commit
START TRANSACTION;
UPDATE accounts SET balance = balance - 200 WHERE id=1;
SELECT * FROM accounts;
UPDATE accounts SET balance = balance + 200 WHERE id=2;
SELECT * FROM accounts;
COMMIT;

-- Rolling back the whole transaction
START TRANSACTION;
UPDATE accounts SET balance = balance - 200 WHERE id=1;
SELECT * FROM accounts;
UPDATE accounts SET balance = balance + 200 WHERE id=99;
SELECT * FROM accounts;
ROLLBACK;

SELECT * FROM accounts;

-- Rolling back to savepoint
START TRANSACTION;
UPDATE accounts SET balance = balance - 200 WHERE id=1;
SAVEPOINT withdraw_money;
UPDATE accounts SET balance = balance + 200 WHERE id=2;
SAVEPOINT deposit_money;
SELECT * FROM accounts;
ROLLBACK TO SAVEPOINT withdraw_money;
SELECT * FROM accounts;
-- Rolling back the whole transaction
ROLLBACK;

-- To show row lock mechanism in transaction
START TRANSACTION;
UPDATE accounts SET balance = balance - 200 WHERE id=1;
-- Try running the same statement in other sql client.
SELECT * FROM accounts;
UPDATE accounts SET balance = balance + 200 WHERE id=2;
SELECT * FROM accounts;
COMMIT;

-- Simulating deadlock (run this in this session)
START TRANSACTION;
UPDATE accounts SET balance = balance - 200 WHERE id=1;
-- Stop here for now and run another transaction in
-- another sql session.
SELECT * FROM accounts;
UPDATE accounts SET balance = balance + 200 WHERE id=2;
-- There will be a deadlock here
SELECT * FROM accounts;
COMMIT;

-- Run this transaction in another sql session.
START TRANSACTION;
UPDATE accounts SET balance = balance - 200 WHERE id=2;
-- Stop here for now, and continue running statements in
-- the another transaction.
SELECT * FROM accounts;
UPDATE accounts SET balance = balance + 200 WHERE id=1;
SELECT * FROM accounts;
COMMIT;

-- Simulating inconsistent data
-- In another sql client, only deduct balance by 200 from id 1
-- But did not add balance to id 2,
UPDATE accounts SET balance = balance - 200 WHERE id=1;
UPDATE accounts SET balance = balance + 200 WHERE id=2;
-- Since transaction is not used.
-- Now there is a missing balance of 200 from the transfer.
SELECT * FROM accounts;