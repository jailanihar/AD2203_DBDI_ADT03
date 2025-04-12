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