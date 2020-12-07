CREATE TABLE PERSON
(Fname			VARCHAR(30),
Lname			VARCHAR(30),
Person_id		NUMBER(15),
Age			NUMBER(2),
Sex			CHAR(1),
Line_one		VARCHAR(30),
Line_two		VARCHAR(30),
City			VARCHAR(30),
State			CHAR(2),
Zip			NUMBER(5),
PRIMARY KEY (Person_id) );

CREATE TABLE  PHONE_NUM
(Person_id		NUMBER(15),
Phone_num		NUMBER(10),
PRIMARY KEY (Person_id, Phone_num),
FOREIGN KEY (Person_id) REFERENCES PERSON(Person_id) );

CREATE TABLE CUSTOMER
(Person_id		NUMBER(15),
Pref_salesman		VARCHAR(30),
PRIMARY KEY (Person_id),
FOREIGN KEY (Person_id) REFERENCES PERSON(Person_id) );


CREATE TABLE POTENTIAL_EMPLOYEE
(Person_id		NUMBER(15),
PRIMARY KEY (Person_id),
FOREIGN KEY (Person_id) REFERENCES PERSON(Person_id) );

CREATE TABLE DEPARTMENT
(Department_id		NUMBER(15),
Department_name	VARCHAR(30),
PRIMARY KEY (Department_id) );

CREATE TABLE CURR_DEPT
(Dept_id		NUMBER(15),
Person_id		NUMBER(15),
Curr_dept		BOOLEAN,
PRIMARY KEY (Department_id, Person_id),
FOREIGN KEY (Dept_id) REFERENCES DEPARTMENT(Department_id), 
FOREIGN KEY (Person_id) REFERENCES PERSON(Person_id) );


CREATE TABLE EMPLOYEE
(Person_id		NUMBER(15),
Dept_id			NUMBER(15),
Rank			VARCHAR(30),
PRIMARY KEY (Person_id, Dept_id),
FOREIGN KEY (Person_id) REFERENCES PERSON(Person_id),
FOREIGN KEY (Dept_id) REFERENCES DEPARTMENT(Department_id)  );

CREATE TABLE APPLICANT
(Person_id		NUMBER(15),
PRIMARY KEY (Person_id),
FOREIGN KEY (Person_id) REFERENCES PERSON(Person_id) );


CREATE TABLE SHIFT
(Person_id		NUMBER(15),
Dept_id			NUMBER(15),
Time_begin		TIMESTAMP,
Time_end		TIMESTAMP,
PRIMARY KEY (Person_id, Dept_id, Time_begin, Time_end),
FOREIGN KEY (Person_id) REFERENCES PERSON(Person_id),
FOREIGN KEY (Dept_id) REFERENCES DEPARTMENT(Department_id) );


CREATE TABLE JOB
(Job_id			NUMBER(15),
Dept_id			NUMBER(15),
Description		VARCHAR(150),
Posted_date		DATE,
PRIMARY KEY (Job_id),
FOREIGN KEY (Dept_id) REFERENCES DEPARTMENT(Department_id) );


CREATE TABLE INTERVIEW
(Job_id			NUMBER(15),
Person_id		NUMBER(15),
Interview_num		NUMBER(1),
Interviewer_id		NUMBER(15),
Interview_grade	CHAR(1),
Interview_time		TIME,
PRIMARY KEY (Job_id, Person_id, Interview_num),
FOREIGN KEY (Person_id) REFERENCES PERSON(Person_id),
FOREIGN KEY (Job_id) REFERENCES JOB(Job_id) );


CREATE TABLE MONTHLY_SALARY
(Transaction_num	NUMBER(15),
Person_id		NUMBER(15),
Pay_date		DATE,
Amount		DECIMAL(10,2),
PRIMARY KEY (Transaction_num, Person_id),
FOREIGN KEY (Person_id) REFERENCES PERSON(Person_id) );


CREATE TABLE SUPERVISOR
(Person_id		NUMBER(15),
PRIMARY KEY (Person_id),
FOREIGN KEY (Person_id) REFERENCES PERSON(Person_id) );

CREATE TABLE SITE
(Site_id			NUMBER(15),
Location		VARCHAR(30),
Site_name		VARCHAR(30),
PRIMARY KEY (Site_id) );

CREATE TABLE PRODUCT
(Product_id		NUMBER(15),
Product_type		VARCHAR(30),
Size			DECIMAL(10,2),
Style			VARCHAR(30),
Weight			DECIMAL(10,2),
Product_price		DECIMAL(10,2),
PRIMARY KEY (Product_id) );

CREATE TABLE SELLS
(Product_id		NUMBER(15),
Time			TIME,
Salesman_id		NUMBER(15),
Customer_id		NUMBER(15),
Site_id			NUMBER(15),
PRIMARY KEY (Product_id, Time, Salesman_id, Customer_id, Site_id),
FOREIGN KEY (Product_id) REFERENCES PRODUCT(Product_id),
FOREIGN KEY (Salesman_id) REFERENCES PERSON(Person_id),
FOREIGN KEY (Customer_id) REFERENCES PERSON(Person_id),
FOREIGN KEY (Site_id) REFERENCES SITE(Site_id) );

CREATE TABLE VENDOR
(Vendor_id		NUMBER(15),
Vendor_URL		VARCHAR(30),
Vendor_acc_num	NUMBER(15),
Credit_rating		NUMBER(15),
Vendor_addr		VARCHAR(30),
Vendor_name		VARCHAR(30),
PRIMARY KEY (Vendor_id) );

CREATE TABLE PARTS
(Vendor_id		NUMBER(15),
Part_type		VARCHAR(30),
Part_cost		DECIMAL(10,2),
PRIMARY KEY (Vendor_id, Part_type),
FOREIGN KEY (Vendor_id) REFERENCES VENDOR(Vendor_id) );

CREATE TABLE PROD_PARTS
(Product_id		NUMBER(15),
 Vendor_id		NUMBER(15),
 Part_type		VARCHAR(30),
 Num_parts		NUMBER(4),
PRIMARY KEY (Product_id, Vendor_id, Part_type),
FOREIGN KEY (Product_id) REFERENCES PRODUCT(Product_id),
FOREIGN KEY (Vendor_id) REFERENCES VENDOR(Vendor_id),
FOREIGN KEY (Part_type) REFERENCES PARTS(Part_type) );



