CREATE TABLE CUSTOMERS (
    CustId NUMBER(20) not null,
    Username varchar(255) not null UNIQUE,
    Passwrd varchar(255) not null,
    Email varchar(255) not null,
    FirstName varchar(255) not null,
    LastName varchar(255) not null,
	DateOfBirth date not null,
    Address varchar(255) not null,
    Phonenumber NUMBER(20) not null,
    CONSTRAINT CUSTOMERS_CUSTID_PK PRIMARY KEY (CustId)
    
);
ALTER TABLE CUSTOMERS
add CONSTRAINT CHK_Phonenumber CHECK (length(Phonenumber)=10 and Phonenumber not like '0%');

CREATE TABLE ACCOUNTS (
    AccNumber varchar(255) not null,
    CustId NUMBER(20) not null,
    IfscCode varchar(255) not null,
    Branch varchar(255) not null,
    Balanace DECIMAL(20, 2) not null,
    CONSTRAINT ACCOUNTS_AccNumber_PK PRIMARY KEY (AccNumber),
    CONSTRAINT CustId_FK FOREIGN KEY (CustId)
    REFERENCES CUSTOMERS(CustId)
);

ALTER TABLE ACCOUNTS
MODIFY Balanace DEFAULT 0.00;




CREATE SEQUENCE seq_custId MINVALUE 0 START WITH 1 INCREMENT BY 1 CACHE 10;

