DROP TABLE IF EXISTS personal_details;
DROP TABLE IF EXISTS applicants_programmes;
DROP TABLE IF EXISTS file_uploads;
DROP TABLE IF EXISTS programmes;
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

INSERT INTO programmes VALUES
('DADT', 'Diploma in Applications Development'),
('DWTY', 'Diploma in Web Technologies'),
('DCNG', 'Diploma in Cloud and Networking'),
('DDAT', 'Diploma in Data Analytics');

INSERT INTO applicants_programmes(programme_short_code, applicant_id)
VALUES
('DADT', 1),
('DWTY', 1),
('DADT', 2),
('DDAT', 2),
('DWTY', 2);

CREATE TABLE file_uploads(
	id BIGINT(20) AUTO_INCREMENT,
    applicant_id BIGINT(20),
    file_type VARCHAR(255),
    file_location VARCHAR(255),
    PRIMARY KEY(id),
    FOREIGN KEY(applicant_id) REFERENCES applicants(id),
    UNIQUE(file_location)
);

INSERT INTO file_uploads(applicant_id, file_type, file_location)
VALUES
(1, 'ic', 'ic/00-123456.png'),
(1, 'photo', 'photo/00-123456.png'),
(2, 'ic', 'ic/00-111222.png'),
(2, 'result', 'result/00-111222_1.png'),
(2, 'result', 'result/00-111222_2.png');

SELECT * FROM applicants_programmes, applicants
WHERE applicants_programmes.applicant_id=applicants.id AND applicants.id=1;

SELECT ap.programme_short_code, a.ic_number, pd.first_name, pd.last_name
FROM applicants_programmes ap, applicants a, personal_details pd
WHERE ap.applicant_id=a.id AND a.id=1 AND a.id=pd.applicant_id;