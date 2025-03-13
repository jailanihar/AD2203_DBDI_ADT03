# DROP DATABASE IF EXISTS dbdi_example1;

# CREATE DATABASE dbdi_example1;

# USE dbdi_example1;

DROP TABLE IF EXISTS applicants;

CREATE TABLE applicants (
	id BIGINT(20) AUTO_INCREMENT,
    ic_number VARCHAR(255),
    email VARCHAR(255) NOT NULL,
    password VARCHAR(255) NOT NULL,
    created_at TIMESTAMP DEFAULT NOW(),
    updated_at TIMESTAMP DEFAULT NOW(),
    PRIMARY KEY (id),
    UNIQUE (ic_number),
    UNIQUE (email)
);

-- CREATE TABLE applicants (
-- 	id BIGINT(20) PRIMARY KEY,
--     ic_number VARCHAR(255),
--     email VARCHAR(255) NOT NULL,
--     password VARCHAR(255) NOT NULL,
--     created_at TIMESTAMP,
--     updated_at TIMESTAMP
-- );

-- DESCRIBE applicants; 

-- INSERT INTO applicants VALUES 
-- (101, '00-123456', 'antah@antah.com', SHA2('antah123', 256), NOW(), NOW());

-- INSERT INTO applicants(id, ic_number, email, password, created_at, updated_at)
-- VALUES 
-- (103, '00-123456', 'antah@antah.com', SHA2('antah123', 256), NOW(), NOW());

-- INSERT INTO applicants(ic_number, id, email, password, created_at, updated_at)
-- VALUES 
-- ('00-123456', 104, 'antah@antah.com', SHA2('antah123', 256), NOW(), NOW());

-- INSERT INTO applicants(id, email, password)
-- VALUES 
-- (105, 'antah@antah.com', SHA2('antah123', 256));

-- INSERT INTO applicants(email, password)
-- VALUES 
-- ('berantah@berantah.com', SHA2('berantah123', 256));

ALTER TABLE applicants ADD (agree_privacy_policy TINYINT(1)); 

ALTER TABLE applicants MODIFY COLUMN ic_number CHAR(9);

ALTER TABLE applicants DROP COLUMN agree_privacy_policy;

UPDATE applicants SET ic_number='00-123456' WHERE id=1;

DELETE FROM applicants where id=4;

SELECT * FROM applicants;