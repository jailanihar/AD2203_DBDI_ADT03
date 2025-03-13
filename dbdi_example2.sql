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
(2, 'Berantah', 'Hatnareb', '2002-03-20', '044123456789');

CREATE TABLE programmes (
	short_code VARCHAR(10),
    description VARCHAR(255),
    PRIMARY KEY (short_code)
);

CREATE TABLE applicants_programmes(
	id BIGINT(20) AUTO_INCREMENT,
    programme_short_code VARCHAR(10),
    applicant_id BIGINT(20),
    PRIMARY KEY(id),
    FOREIGN KEY(programme_short_code) REFERENCES programmes(short_code),
    FOREIGN KEY(applicant_id) REFERENCES applicants(id),
    UNIQUE(programme_short_code, applicant_id)
);

