DROP TABLE IF EXISTS personal_details;
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

CREATE TABLE personal_details(
	id BIGINT(20) AUTO_INCREMENT,
    applicant_id BIGINT(20),
    first_name VARCHAR(255),
    last_name VARCHAR(255),
    date_of_birth DATE,
    phone_number VARCHAR(100),
    PRIMARY KEY(id),
    FOREIGN KEY(applicant_id) REFERENCES applicants(id),
    UNIQUE(applicant_id)
);

INSERT INTO applicants (ic_number, email, password) VALUES 
('00-123456', 'antah@antah.com', SHA2('antah123', 256)),
('00-111222', 'berantah@berantah.com', SHA2('berantah123', 256));

INSERT INTO personal_details
(applicant_id, first_name, last_name, date_of_birth, phone_number)
VALUES
(1, 'Antah', 'Hatna', '2000-01-01', '673123456'),
(1, 'Hatna', 'Antah', '2000-02-01', '0673123456');