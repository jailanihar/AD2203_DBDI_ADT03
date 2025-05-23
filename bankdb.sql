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

-- Run from here
-- Replacing the end of statement from ; to $$
DELIMITER $$
CREATE PROCEDURE BankTransfer()
BEGIN
	START TRANSACTION;
    UPDATE accounts SET balance = balance - 200 WHERE id=1;
    UPDATE accounts SET balance = balance + 200 WHERE id=2;
    COMMIT;
END$$
-- Change back the end of statement to ;
DELIMITER ;
-- To here

SELECT * FROM accounts;
-- Running the procedure
CALL BankTransfer();
-- Dropping the procedure because we want to improve further.
DROP PROCEDURE BankTransfer;

-- Procedure that needs value for amount to be transferred.
DELIMITER $$
CREATE PROCEDURE BankTransfer(
    IN amount DECIMAL(10,2)
)
BEGIN
	START TRANSACTION;
    UPDATE accounts SET balance = balance - amount WHERE id=1;
    UPDATE accounts SET balance = balance + amount WHERE id=2;
    COMMIT;
END$$
DELIMITER ;

SELECT * FROM accounts;
CALL BankTransfer(400);
SELECT * FROM accounts;
DROP PROCEDURE BankTransfer;

-- Procedure that needs values for account id from, accound id to and amount
DELIMITER $$
CREATE PROCEDURE BankTransfer(
	IN fromAcc INT,
    IN toAcc INT,
    IN amount DECIMAL(10,2)
)
BEGIN
	START TRANSACTION;
    UPDATE accounts SET balance = balance - amount WHERE id=fromAcc;
    UPDATE accounts SET balance = balance + amount WHERE id=toAcc;
    COMMIT;
END$$
DELIMITER ;

CALL BankTransfer(2, 1, 600);
SELECT * FROM accounts;
CALL BankTransfer(2, 1, 1200);
SELECT * FROM accounts;
CALL BankTransfer(1, 2, 1200);
DROP PROCEDURE BankTransfer;

-- Procedure to include check if from account has balance more than or
-- equal to amount transferred.
DELIMITER $$
CREATE PROCEDURE BankTransfer(
	IN fromAcc INT,
    IN toAcc INT,
    IN amount DECIMAL(10,2)
)
BEGIN
	DECLARE fromBalance DECIMAL(10,2);
    
	START TRANSACTION;
    SELECT balance INTO fromBalance FROM accounts WHERE id = fromAcc;
    
    IF fromBalance >= amount THEN
		UPDATE accounts SET balance = balance - amount WHERE id=fromAcc;
		UPDATE accounts SET balance = balance + amount WHERE id=toAcc;
		COMMIT;
	ELSE
		ROLLBACK;
	END IF;
END$$
DELIMITER ;

SELECT * FROM accounts;
CALL BankTransfer(1,2,200);
SELECT * FROM accounts;
CALL BankTransfer(1,2,3000);
SELECT * FROM accounts;
DROP PROCEDURE BankTransfer;

-- Procedure to include check if account ids exist
-- and to include check if from account has balance more than or
-- equal to amount transferred.
DELIMITER $$
CREATE PROCEDURE BankTransfer(
	IN fromAcc INT,
    IN toAcc INT,
    IN amount DECIMAL(10,2)
)
BEGIN
	DECLARE fromBalance DECIMAL(10,2);
    DECLARE fromAccExists INT;
    DECLARE toAccExists INT;
    
	START TRANSACTION;
    SELECT COUNT(*) INTO fromAccExists FROM accounts WHERE id = fromAcc;
    SELECT COUNT(*) INTO toAccExists FROM accounts WHERE id = toAcc;
    
    IF fromAccExists = 1 AND toAccExists = 1 THEN
		SELECT balance INTO fromBalance FROM accounts WHERE id = fromAcc;
		
		IF fromBalance >= amount THEN
			UPDATE accounts SET balance = balance - amount WHERE id=fromAcc;
			UPDATE accounts SET balance = balance + amount WHERE id=toAcc;
			COMMIT;
		ELSE
			ROLLBACK;
		END IF;
	ELSE
		ROLLBACK;
	END IF;
END$$
DELIMITER ;

SELECT * FROM accounts;
CALL BankTransfer(3,2,200);
SELECT * FROM accounts;