/* Create Database */
use master;

DROP DATABASE IF EXISTS "db_hr_dts";

CREATE DATABASE "db_hr_dts";

USE "db_hr_dts";

/* Create Tables */

CREATE TABLE job
(
    id         VARCHAR(10) PRIMARY KEY,
    title      VARCHAR(35) NOT NULL,
    min_salary INT,
    max_salary INT
);

CREATE TABLE region
(
    id   INT IDENTITY PRIMARY KEY,
    name VARCHAR(25) NOT NULL
);

CREATE TABLE country
(
    id     VARCHAR(2) PRIMARY KEY,
    name   VARCHAR(40) NOT NULL,
    region INT         NOT NULL
);

CREATE TABLE location
(
    id             INT PRIMARY KEY,
    street_address VARCHAR(40),
    postal_code    VARCHAR(12),
    city           VARCHAR(30) NOT NULL,
    state_province VARCHAR(25),
    country        VARCHAR(2)
);

CREATE TABLE department
(
    id       INT PRIMARY KEY,
    name     VARCHAR(30) NOT NULL,
    location INT         NOT NULL,
    manager  INT
);

CREATE TABLE employee
(
    id            INT PRIMARY KEY,
    first_name    VARCHAR(20)        NOT NULL,
    last_name     VARCHAR(25),
    email         VARCHAR(25) UNIQUE NOT NULL,
    phone_number  VARCHAR(20),
    hire_date     DATE               NOT NULL,
    salary        INT,
    commision_pct FLOAT,
    manager       int,
    job           VARCHAR(10)        NOT NULL,
    department    INT                NOT NULL
);

CREATE TABLE history
(
    start_date    DATE        NOT NULL,
    end_date      DATE        NOT NULL,
    department_id INT         NOT NULL,
    employee_id   INT         NOT NULL,
    job_id        VARCHAR(10) NOT NULL
)

/* Table Relations */

ALTER TABLE country
    ADD FOREIGN KEY (region) REFERENCES region (id);

ALTER TABLE location
    ADD FOREIGN KEY (country) REFERENCES country (id);

ALTER TABLE department
    ADD FOREIGN KEY (location) REFERENCES location (id);

ALTER TABLE department
    ADD FOREIGN KEY (manager) REFERENCES employee (id);

ALTER TABLE history
    ADD CONSTRAINT PK_EmployeeStartDate PRIMARY KEY (start_date, employee_id);

ALTER TABLE history
    ADD FOREIGN KEY (department_id) REFERENCES department (id);

ALTER TABLE history
    ADD FOREIGN KEY (employee_id) REFERENCES employee (id);

ALTER TABLE history
    ADD FOREIGN KEY (job_id) REFERENCES job (id);

ALTER TABLE employee
    ADD FOREIGN KEY (manager) REFERENCES employee (id);

ALTER TABLE employee
    ADD FOREIGN KEY (job) REFERENCES job (id);

ALTER TABLE employee
    ADD FOREIGN KEY (department) REFERENCES department (id);

/* insert dummy data */

INSERT INTO region(name)
VALUES ('Europe'),
       ('Americas'),
       ('Asia'),
       ('Middle East and Africa');

INSERT INTO country(id, name, region)
VALUES ('AR', 'Argentina', 2),
       ('AU', 'Australia', 3),
       ('BE', 'Belgium', 1),
       ('BR', 'Brazil', 2),
       ('CA', 'Canada', 2),
       ('CH', 'Switzerland', 1),
       ('CN', 'China', 3),
       ('DE', 'Germany', 1),
       ('DK', 'Denmark', 1),
       ('EG', 'Egypt', 4),
       ('FR', 'France', 1),
       ('IL', 'Israel', 4),
       ('IN', 'India', 3),
       ('IT', 'Italy', 1),
       ('JP', 'Japan', 3),
       ('KW', 'Kuwait', 4),
       ('ML', 'Malaysia', 3),
       ('MX', 'Mexico', 2),
       ('NG', 'Nigeria', 4),
       ('NL', 'Netherlands', 1),
       ('SG', 'Singapore', 3),
       ('UK', 'United Kingdom', 1),
       ('US', 'United States of America', 2),
       ('ZM', 'Zambia', 4),
       ('ZW', 'Zimbabwe', 4),
       ('ID', 'Indonesia', 3);

INSERT INTO location(id, street_address, postal_code, city, state_province, country)
VALUES (1000, '1297 Via Cola di Rie', '989', 'Roma', NULL, 'IT'),
       (1100, '93091 Calle della Testa', '10934', 'Venice', NULL, 'IT'),
       (1200, '2017 Shinjuku-ku', '1689', 'Tokyo', 'Tokyo Prefecture', 'JP'),
       (1300, '9450 Kamiya-cho', '6823', 'Hiroshima', NULL, 'JP'),
       (1400, '2014 Jabberwocky Rd', '26192', 'Southlake', 'Texas', 'US'),
       (1500, '2011 Interiors Blvd', '99236', 'South San Francisco', 'California', 'US'),
       (1600, '2007 Zagora St', '50090', 'South Brunswick', 'New Jersey', 'US'),
       (1700, '2004 Charade Rd', '98199', 'Seattle', 'Washington', 'US'),
       (1800, '147 Spadina Ave', 'M5V 2L7', 'Toronto', 'Ontario', 'CA'),
       (1900, '6092 Boxwood St', 'YSW 9T2', 'Whitehorse', 'Yukon', 'CA'),
       (2000, '40-5-12 Laogianggen', '190518', 'Beijing', NULL, 'CN'),
       (2100, '1298 Vileparle (E)', '490231', 'Bombay', 'Maharashtra', 'IN'),
       (2200, '12-98 Victoria Street', '2901', 'Sydney', 'New South Wales', 'AU'),
       (2300, '198 Clementi North', '540198', 'Singapore', NULL, 'SG'),
       (2400, '8204 Arthur St', NULL, 'London', NULL, 'UK'),
       (2500, 'Magdalen Centre, The Oxford Science Park', 'OX9 9ZB', 'Oxford', 'Oxford', 'UK'),
       (2600, '9702 Chester Road', '9629850293', 'Stretford', 'Manchester', 'UK'),
       (2700, 'Schwanthalerstr. 7031', '80925', 'Munich', 'Bavaria', 'DE'),
       (2800, 'Rua Frei Caneca 1360', '01307-002', 'Sao Paulo', 'Sao Paulo', 'BR'),
       (2900, '20 Rue des Corps-Saints', '1730', 'Geneva', 'Geneve', 'CH'),
       (3000, 'Murtenstrasse 921', '3095', 'Bern', 'BE', 'CH'),
       (3100, 'Pieter Breughelstraat 837', '3029SK', 'Utrecht', 'Utrecht', 'NL'),
       (3200, 'Mariano Escobedo 9991', '11932', 'Mexico City', 'Distrito Federal', 'MX');

INSERT INTO department(id, name, location)
VALUES (10, 'Administration', 1700),
       (20, 'Marketing', 1800),
       (30, 'Purchasing', 1700),
       (40, 'Human Resources', 2400),
       (50, 'Shipping', 1500),
       (60, 'IT', 1400),
       (70, 'Public Relations', 2700),
       (80, 'Sales', 2500),
       (90, 'Executive', 1700),
       (100, 'Finance', 1700),
       (110, 'Accounting', 1700),
       (120, 'Treasury', 1700),
       (130, 'Corporate Tax', 1700),
       (140, 'Control And Credit', 1700),
       (150, 'Shareholder Services', 1700),
       (160, 'Benefits', 1700),
       (170, 'Manufacturing', 1700),
       (180, 'Construction', 1700),
       (190, 'Contracting', 1700),
       (200, 'Operations', 1700),
       (210, 'IT Support', 1700),
       (220, 'NOC', 1700),
       (230, 'IT Helpdesk', 1700),
       (240, 'Government Sales', 1700),
       (250, 'Retail Sales', 1700),
       (260, 'Recruiting', 1700),
       (270, 'Payroll', 1700);

INSERT INTO job(id, title, min_salary, max_salary)
VALUES ('AD_PRES', 'President', 20080, 40000),
       ('AD_VP', 'Administration Vice President', 15000, 30000),
       ('AD_ASST', 'Administration Assistant', 3000, 6000),
       ('FI_MGR', 'Finance Manager', 8200, 16000),
       ('FI_ACCOUNT', 'Accountant', 4200, 9000),
       ('AC_MGR', 'Accounting Manager', 8200, 16000),
       ('AC_ACCOUNT', 'Public Accountant', 4200, 9000),
       ('SA_MAN', 'Sales Manager', 10000, 20080),
       ('SA_REP', 'Sales Representative', 6000, 12008),
       ('PU_MAN', 'Purchasing Manager', 8000, 15000),
       ('PU_CLERK', 'Purchasing Clerk', 2500, 5500),
       ('ST_MAN', 'Stock Manager', 5500, 8500),
       ('ST_CLERK', 'Stock Clerk', 2008, 5000),
       ('SH_CLERK', 'Shipping Clerk', 2500, 5500),
       ('IT_PROG', 'Programmer', 4000, 10000),
       ('MK_MAN', 'Marketing Manager', 9000, 15000),
       ('MK_REP', 'Marketing Representative', 4000, 9000),
       ('HR_REP', 'Human Resources Representative', 4000, 9000),
       ('PR_REP', 'Public Relations Representative', 4500, 10500);

INSERT INTO employee (id, first_name, last_name, email, phone_number, hire_date, salary, commision_pct, manager,
                      job, department)
VALUES (100, N'Steven', N'King', N'SKING', N'5,151,234,567', N'2003-06-17', 24000, NULL, NULL, N'AD_PRES', 90),
       (101, N'Neena', N'Kochhar', N'NKOCHHAR', N'5,151,234,568', N'2005-09-21', 17000, NULL, 100, N'AD_VP', 90),
       (102, N'Lex', N'De Haan', N'LDEHAAN', N'5,151,234,569', N'2001-01-13', 17000, NULL, 100, N'AD_VP', 90),
       (103, N'Alexander', N'Hunold', N'AHUNOLD', N'5,904,234,567', N'2006-03-01', 9000, NULL, 102, N'IT_PROG', 60),
       (104, N'Bruce', N'Ernst', N'BERNST', N'5,904,234,568', N'2007-05-21', 6000, NULL, 103, N'IT_PROG', 60),
       (105, N'David', N'Austin', N'DAUSTIN', N'5,904,234,569', N'2005-06-25', 4800, NULL, 103, N'IT_PROG', 60),
       (106, N'Valli', N'Pataballa', N'VPATABAL', N'5,904,234,560', N'2006-05-02', 4800, NULL, 103, N'IT_PROG', 60),
       (107, N'Diana', N'Lorentz', N'DLORENTZ', N'5,904,235,567', N'2007-07-02', 4200, NULL, 103, N'IT_PROG', 60),
       (108, N'Nancy', N'Greenberg', N'NGREENBE', N'5,151,244,569', N'2002-08-17', 12008, NULL, 101, N'FI_MGR', 100),
       (109, N'Daniel', N'Faviet', N'DFAVIET', N'5,151,244,169', N'2002-08-16', 9000, NULL, 108, N'FI_ACCOUNT', 100),
       (110, N'John', N'Chen', N'JCHEN', N'5,151,244,269', N'2005-09-28', 8200, NULL, 108, N'FI_ACCOUNT', 100),
       (111, N'Ismael', N'Sciarra', N'ISCIARRA', N'5,151,244,369', N'2005-09-30', 7700, NULL, 108, N'FI_ACCOUNT', 100),
       (112, N'Jose Manuel', N'Urman', N'JMURMAN', N'5,151,244,469', N'2006-07-03', 7800, NULL, 108, N'FI_ACCOUNT',
        100),
       (113, N'Luis', N'Popp', N'LPOPP', N'5,151,244,567', N'2007-07-12', 6900, NULL, 108, N'FI_ACCOUNT', 100),
       (114, N'Den', N'Raphaely', N'DRAPHEAL', N'5,151,274,561', N'2002-07-12', 11000, NULL, 100, N'PU_MAN', 30),
       (115, N'Alexander', N'Khoo', N'AKHOO', N'5,151,274,562', N'2003-05-18', 3100, NULL, 114, N'PU_CLERK', 30),
       (116, N'Shelli', N'Baida', N'SBAIDA', N'5,151,274,563', N'2005-12-24', 2900, NULL, 114, N'PU_CLERK', 30),
       (117, N'Sigal', N'Tobias', N'STOBIAS', N'5,151,274,564', N'2005-07-24', 2800, NULL, 114, N'PU_CLERK', 30),
       (118, N'Guy', N'Himuro', N'GHIMURO', N'5,151,274,565', N'2006-11-15', 2600, NULL, 114, N'PU_CLERK', 30),
       (119, N'Karen', N'Colmenares', N'KCOLMENA', N'5,151,274,566', N'2007-10-08', 2500, NULL, 114, N'PU_CLERK', 30),
       (120, N'Matthew', N'Weiss', N'MWEISS', N'6,501,231,234', N'2004-07-18', 8000, NULL, 100, N'ST_MAN', 50),
       (121, N'Adam', N'Fripp', N'AFRIPP', N'6,501,232,234', N'2005-10-04', 8200, NULL, 100, N'ST_MAN', 50),
       (122, N'Payam', N'Kaufling', N'PKAUFLIN', N'6,501,233,234', N'2003-01-05', 7900, NULL, 100, N'ST_MAN', 50),
       (123, N'Shanta', N'Vollman', N'SVOLLMAN', N'6,501,234,234', N'2005-10-10', 6500, NULL, 100, N'ST_MAN', 50),
       (124, N'Kevin', N'Mourgos', N'KMOURGOS', N'6,501,235,234', N'2007-11-16', 5800, NULL, 100, N'ST_MAN', 50),
       (125, N'Julia', N'Nayer', N'JNAYER', N'6,501,241,214', N'2005-07-16', 3200, NULL, 120, N'ST_CLERK', 50),
       (126, N'Irene', N'Mikkilineni', N'IMIKKILI', N'6,501,241,224', N'2006-09-28', 2700, NULL, 120, N'ST_CLERK', 50),
       (127, N'James', N'Landry', N'JLANDRY', N'6,501,241,334', N'2007-01-14', 2400, NULL, 120, N'ST_CLERK', 50),
       (128, N'Steven', N'Markle', N'SMARKLE', N'6,501,241,434', N'2008-08-03', 2200, NULL, 120, N'ST_CLERK', 50),
       (129, N'Laura', N'Bissot', N'LBISSOT', N'6,501,245,234', N'2005-08-20', 3300, NULL, 121, N'ST_CLERK', 50),
       (130, N'Mozhe', N'Atkinson', N'MATKINSO', N'6,501,246,234', N'2005-10-30', 2800, NULL, 121, N'ST_CLERK', 50),
       (131, N'James', N'Marlow', N'JAMRLOW', N'6,501,247,234', N'2005-02-16', 2500, NULL, 121, N'ST_CLERK', 50),
       (132, N'TJ', N'Olson', N'TJOLSON', N'6,501,248,234', N'2007-10-04', 2100, NULL, 121, N'ST_CLERK', 50),
       (133, N'Jason', N'Mallin', N'JMALLIN', N'6,501,271,934', N'2004-06-14', 3300, NULL, 122, N'ST_CLERK', 50),
       (134, N'Michael', N'Rogers', N'MROGERS', N'6,501,271,834', N'2006-08-26', 2900, NULL, 122, N'ST_CLERK', 50),
       (135, N'Ki', N'Gee', N'KGEE', N'6,501,271,734', N'2007-12-12', 2400, NULL, 122, N'ST_CLERK', 50),
       (136, N'Hazel', N'Philtanker', N'HPHILTAN', N'6,501,271,634', N'2008-06-02', 2200, NULL, 122, N'ST_CLERK', 50),
       (137, N'Renske', N'Ladwig', N'RLADWIG', N'6,501,211,234', N'2003-07-14', 3600, NULL, 123, N'ST_CLERK', 50),
       (138, N'Stephen', N'Stiles', N'SSTILES', N'6,501,212,034', N'2005-10-26', 3200, NULL, 123, N'ST_CLERK', 50),
       (139, N'John', N'Seo', N'JSEO', N'6,501,212,019', N'2006-12-02', 2700, NULL, 123, N'ST_CLERK', 50),
       (140, N'Joshua', N'Patel', N'JPATEL', N'6,501,211,834', N'2006-06-04', 2500, NULL, 123, N'ST_CLERK', 50),
       (141, N'Trenna', N'Rajs', N'TRAJS', N'6,501,218,009', N'2003-10-17', 3500, NULL, 124, N'ST_CLERK', 50),
       (142, N'Curtis', N'Davies', N'CDAVIES', N'6,501,212,994', N'2005-01-29', 3100, NULL, 124, N'ST_CLERK', 50),
       (143, N'Randall', N'Matos', N'RMATOS', N'6,501,212,874', N'2006-03-15', 2600, NULL, 124, N'ST_CLERK', 50),
       (144, N'Peter', N'Vargas', N'PVARGAS', N'6,501,212,004', N'2006-09-07', 2500, NULL, 124, N'ST_CLERK', 50),
       (145, N'John', N'Russell', N'JRUSSEL', N'011.44.1344.429268', N'2004-01-10', 14000, 0.4, 100, N'SA_MAN', 80),
       (146, N'Karen', N'Partners', N'KPARTNER', N'011.44.1344.467268', N'2005-05-01', 13500, 0.3, 100, N'SA_MAN', 80),
       (147, N'Alberto', N'Errazuriz', N'AERRAZUR', N'011.44.1344.429278', N'2005-10-03', 12000, 0.3, 100, N'SA_MAN',
        80),
       (148, N'Gerald', N'Cambrault', N'GCAMBRAU', N'011.44.1344.619268', N'2007-10-15', 11000, 0.3, 100, N'SA_MAN',
        80),
       (149, N'Eleni', N'Zlotkey', N'EZLOTKEY', N'011.44.1344.429018', N'2008-01-29', 10500, 0.2, 100, N'SA_MAN', 80),
       (150, N'Peter', N'Tucker', N'PTUCKER', N'011.44.1344.129268', N'2005-01-30', 10000, 0.3, 145, N'SA_REP', 80),
       (151, N'David', N'Bernstein', N'DBERNSTE', N'011.44.1344.345268', N'2005-03-24', 9500, 0.25, 145, N'SA_REP', 80),
       (152, N'Peter', N'Hall', N'PHALL', N'011.44.1344.478968', N'2005-08-20', 9000, 0.25, 145, N'SA_REP', 80),
       (153, N'Christopher', N'Olsen', N'COLSEN', N'011.44.1344.498718', N'2006-03-30', 8000, 0.2, 145, N'SA_REP', 80),
       (154, N'Nanette', N'Cambrault', N'NCAMBRAU', N'011.44.1344.987668', N'2006-09-12', 7500, 0.2, 145, N'SA_REP',
        80),
       (155, N'Oliver', N'Tuvault', N'OTUVAULT', N'011.44.1344.486508', N'2007-11-23', 7000, 0.15, 145, N'SA_REP', 80),
       (156, N'Janette', N'King', N'JKING', N'011.44.1345.429268', N'2004-01-30', 10000, 0.35, 146, N'SA_REP', 80),
       (157, N'Patrick', N'Sully', N'PSULLY', N'011.44.1345.929268', N'2004-04-03', 9500, 0.35, 146, N'SA_REP', 80),
       (158, N'Allan', N'McEwen', N'AMCEWEN', N'011.44.1345.829268', N'2004-01-08', 9000, 0.35, 146, N'SA_REP', 80),
       (159, N'Lindsey', N'Smith', N'LSMITH', N'011.44.1345.729268', N'2005-10-03', 8000, 0.3, 146, N'SA_REP', 80),
       (160, N'Louise', N'Doran', N'LDORAN', N'011.44.1345.629268', N'2005-12-15', 7500, 0.3, 146, N'SA_REP', 80),
       (161, N'Sarath', N'Sewall', N'SSEWALL', N'011.44.1345.529268', N'2006-03-11', 7000, 0.25, 146, N'SA_REP', 80),
       (162, N'Clara', N'Vishney', N'CVISHNEY', N'011.44.1346.129268', N'2005-11-11', 10500, 0.25, 147, N'SA_REP', 80),
       (163, N'Danielle', N'Greene', N'DGREENE', N'011.44.1346.229268', N'2007-03-19', 9500, 0.15, 147, N'SA_REP', 80),
       (164, N'Mattea', N'Marvins', N'MMARVINS', N'011.44.1346.329268', N'2008-01-24', 7200, 0.1, 147, N'SA_REP', 80),
       (165, N'David', N'Lee', N'DLEE', N'011.44.1346.529268', N'2008-02-23', 6800, 0.1, 147, N'SA_REP', 80),
       (166, N'Sundar', N'Ande', N'SANDE', N'011.44.1346.629268', N'2008-03-24', 6400, 0.1, 147, N'SA_REP', 80),
       (167, N'Amit', N'Banda', N'ABANDA', N'011.44.1346.729268', N'2008-04-21', 6200, 0.1, 147, N'SA_REP', 80),
       (168, N'Lisa', N'Ozer', N'LOZER', N'011.44.1343.929268', N'2005-11-03', 11500, 0.25, 148, N'SA_REP', 80),
       (169, N'Harrison', N'Bloom', N'HBLOOM', N'011.44.1343.829268', N'2006-03-23', 10000, 0.2, 148, N'SA_REP', 80),
       (170, N'Tayler', N'Fox', N'TFOX', N'011.44.1343.729268', N'2006-01-24', 9600, 0.2, 148, N'SA_REP', 80),
       (171, N'William', N'Smith', N'WSMITH', N'011.44.1343.629268', N'2007-02-23', 7400, 0.15, 148, N'SA_REP', 80),
       (172, N'Elizabeth', N'Bates', N'EBATES', N'011.44.1343.529268', N'2007-03-24', 7300, 0.15, 148, N'SA_REP', 80),
       (173, N'Sundita', N'Kumar', N'SKUMAR', N'011.44.1343.329268', N'2008-04-21', 6100, 0.1, 148, N'SA_REP', 80),
       (174, N'Ellen', N'Abel', N'EABEL', N'011.44.1644.429267', N'2004-11-05', 11000, 0.3, 149, N'SA_REP', 80),
       (175, N'Alyssa', N'Hutton', N'AHUTTON', N'011.44.1644.429266', N'2005-03-19', 8800, 0.25, 149, N'SA_REP', 80),
       (176, N'Jonathon', N'Taylor', N'JTAYLOR', N'011.44.1644.429265', N'2006-03-24', 8600, 0.2, 149, N'SA_REP', 80),
       (177, N'Jack', N'Livingston', N'JLIVINGS', N'011.44.1644.429264', N'2006-04-23', 8400, 0.2, 149, N'SA_REP', 80),
       (178, N'Kimberely', N'Grant', N'KGRANT', N'011.44.1644.429263', N'2007-05-24', 7000, 0.15, 149, N'SA_REP', 80),
       (179, N'Charles', N'Johnson', N'CJOHNSON', N'011.44.1644.429262', N'2008-04-01', 6200, 0.1, 149, N'SA_REP', 80),
       (180, N'Winston', N'Taylor', N'WTAYLOR', N'6,505,079,876', N'2006-01-24', 3200, NULL, 120, N'SH_CLERK', 50),
       (181, N'Jean', N'Fleaur', N'JFLEAUR', N'6,505,079,877', N'2006-02-23', 3100, NULL, 120, N'SH_CLERK', 50),
       (182, N'Martha', N'Sullivan', N'MSULLIVA', N'6,505,079,878', N'2007-06-21', 2500, NULL, 120, N'SH_CLERK', 50),
       (183, N'Girard', N'Geoni', N'GGEONI', N'6,505,079,879', N'2008-03-02', 2800, NULL, 120, N'SH_CLERK', 50),
       (184, N'Nandita', N'Sarchand', N'NSARCHAN', N'6,505,091,876', N'2004-01-27', 4200, NULL, 121, N'SH_CLERK', 50),
       (185, N'Alexis', N'Bull', N'ABULL', N'6,505,092,876', N'2005-02-20', 4100, NULL, 121, N'SH_CLERK', 50),
       (186, N'Julia', N'Dellinger', N'JDELLING', N'6,505,093,876', N'2006-06-24', 3400, NULL, 121, N'SH_CLERK', 50),
       (187, N'Anthony', N'Cabrio', N'ACABRIO', N'6,505,094,876', N'2007-07-02', 3000, NULL, 121, N'SH_CLERK', 50),
       (188, N'Kelly', N'Chung', N'KCHUNG', N'6,505,051,876', N'2005-06-14', 3800, NULL, 122, N'SH_CLERK', 50),
       (189, N'Jennifer', N'Dilly', N'JDILLY', N'6,505,052,876', N'2005-08-13', 3600, NULL, 122, N'SH_CLERK', 50),
       (190, N'Timothy', N'Gates', N'TGATES', N'6,505,053,876', N'2006-11-07', 2900, NULL, 122, N'SH_CLERK', 50),
       (191, N'Randall', N'Perkins', N'RPERKINS', N'6,505,054,876', N'2007-12-19', 2500, NULL, 122, N'SH_CLERK', 50),
       (192, N'Sarah', N'Bell', N'SBELL', N'6,505,011,876', N'2004-04-02', 4000, NULL, 123, N'SH_CLERK', 50),
       (193, N'Britney', N'Everett', N'BEVERETT', N'6,505,012,876', N'2005-03-03', 3900, NULL, 123, N'SH_CLERK', 50),
       (194, N'Samuel', N'McCain', N'SMCCAIN', N'6,505,013,876', N'2006-01-07', 3200, NULL, 123, N'SH_CLERK', 50),
       (195, N'Vance', N'Jones', N'VJONES', N'6,505,014,876', N'2007-03-17', 2800, NULL, 123, N'SH_CLERK', 50),
       (196, N'Alana', N'Walsh', N'AWALSH', N'6,505,079,811', N'2006-04-24', 3100, NULL, 124, N'SH_CLERK', 50),
       (197, N'Kevin', N'Feeney', N'KFEENEY', N'6,505,079,822', N'2006-05-23', 3000, NULL, 124, N'SH_CLERK', 50),
       (198, N'Donald', N'OConnell', N'DOCONNEL', N'6,505,079,833', N'2007-06-21', 2600, NULL, 124, N'SH_CLERK', 50),
       (199, N'Douglas', N'Grant', N'DGRANT', N'6,505,079,844', N'2008-01-13', 2600, NULL, 124, N'SH_CLERK', 50),
       (200, N'Jennifer', N'Whalen', N'JWHALEN', N'5,151,234,444', N'2003-09-17', 4400, NULL, 101, N'AD_ASST', 10),
       (201, N'Michael', N'Hartstein', N'MHARTSTE', N'5,151,235,555', N'2004-02-17', 13000, NULL, 100, N'MK_MAN', 20),
       (202, N'Pat', N'Fay', N'PFAY', N'6,031,236,666', N'2005-08-17', 6000, NULL, 201, N'MK_REP', 20),
       (203, N'Susan', N'Mavris', N'SMAVRIS', N'5,151,237,777', N'2002-07-06', 6500, NULL, 101, N'HR_REP', 40),
       (204, N'Hermann', N'Baer', N'HBAER', N'5,151,238,888', N'2002-07-06', 10000, NULL, 101, N'PR_REP', 70),
       (205, N'Shelley', N'Higgins', N'SHIGGINS', N'5,151,238,080', N'2002-07-06', 12008, NULL, 101, N'AC_MGR', 110),
       (206, N'William', N'Gietz', N'WGIETZ', N'5,151,238,181', N'2002-07-06', 8300, NULL, 205, N'AC_ACCOUNT', 110);

INSERT INTO history (start_date, end_date, department_id, employee_id, job_id)
VALUES (N'1995-09-17', N'2001-06-17', 90, 200, N'AD_ASST'),
       (N'1997-09-21', N'2001-10-27', 110, 101, N'AC_ACCOUNT'),
       (N'2001-01-13', N'2006-07-24', 60, 102, N'IT_PROG'),
       (N'2001-10-28', N'2005-03-15', 110, 101, N'AC_MGR'),
       (N'2002-01-07', N'2006-12-31', 90, 200, N'AC_ACCOUNT'),
       (N'2004-02-17', N'2007-12-19', 20, 201, N'MK_REP'),
       (N'2006-03-24', N'2007-12-31', 50, 114, N'ST_CLERK'),
       (N'2006-03-24', N'2006-12-31', 80, 176, N'SA_REP'),
       (N'2007-01-01', N'2007-12-31', 50, 122, N'ST_CLERK'),
       (N'2007-01-01', N'2007-12-31', 80, 176, N'SA_MAN');

UPDATE department
SET manager = 200
WHERE id = 10;
UPDATE department
SET manager = 201
WHERE id = 20;
UPDATE department
SET manager = 114
WHERE id = 30;
UPDATE department
SET manager = 203
WHERE id = 40;
UPDATE department
SET manager = 121
WHERE id = 50;
UPDATE department
SET manager = 103
WHERE id = 60;
UPDATE department
SET manager = 204
WHERE id = 70;
UPDATE department
SET manager = 145
WHERE id = 80;
UPDATE department
SET manager = 100
WHERE id = 90;
UPDATE department
SET manager = 108
WHERE id = 100;
UPDATE department
SET manager = 205
WHERE id = 110;
