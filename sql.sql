use assignment;
create table supplier(
SUPP_ID int,
SUPP_NAME varchar(50) NOT NULL,
SUPP_CITY varchar(50) NOT NULL,
SUPP_PHONE varchar(50) NOT NULL,
primary key (SUPP_ID)
);

create table customer(
CUS_ID int,
CUS_NAME varchar(20) NOT null,
CUS_PHONE varchar(10) NOT NULL,
CUS_CITY VARCHAR (30) NOT NULL,
CUS_GENDER CHAR,
primary key (CUS_ID)
);

CREATE TABLE category(
CAT_ID INT,
CAT_NAME VARCHAR(20) NOT NULL,
PRIMARY KEY(CAT_ID)
);

create TABLE product(
PRO_ID INT,
PRO_NAME VARCHAR(20) NOT NULL DEFAULT("DUMMY"),
PRO_DESC VARCHAR(60),
CAT_ID INT,
PRIMARY KEY(PRO_ID),
foreign key(CAT_ID) references category(CAT_ID)
);
CREATE table supplier_pricing(
PRICING_ID INT,
PRO_ID INT,
SUPP_ID INT,
SUPP_PRICE INT DEFAULT 0,
PRIMARY KEY(PRICING_ID),
foreign key(PRO_ID) references product(PRO_ID),
foreign key(SUPP_ID) references supplier(SUPP_ID)
);

CREATE table orders(
ORD_ID INT,
ORD_AMOUNT INT NOT NULL,
ORD_DATE DATE NOT NULL,
CUS_ID INT,
PRICING_ID INT,
PRIMARY KEY(ORD_ID),
FOREIGN KEY(CUS_ID) references customer(CUS_ID),
FOREIGN KEY(PRICING_ID) references supplier_pricing(PRICING_ID)
);

CREATE table rating(
RAT_ID INT,
ORD_ID INT,
RAT_RATSTARS INT NOT NULL,
PRIMARY KEY(RAT_ID),
foreign key(ORD_ID) references ORDERS(ORD_ID)
);

insert INTO supplier
values(1, 'Rajesh Retails', 'Delhi', 1234567890),
	  (2, 'Appario Ltd.', 'Mumbai',  2589631470),
      (3, 'Knome products', 'Banglore', 9785462315),
      (4,  'Bansal Retails', 'Kochi', 8975463285),
      (5, 'Mittal Ltd.', 'Lucknow', 7898456532);

INSERT INTO customer
values(1, 'AAKASH', 999999999, 'DELHI', 'M'),
	  (2, 'AMAN', 9785463215, 'NOIDA', 'M'),
      (3, 'NEHA', 9999999999, 'MUMBAI', 'F'),
      (4, 'MEGHA', 9994562399, 'KOLKATA', 'F'),
      (5, 'PULKIT', 7895999999, 'LUCKNOW', 'M');

INSERT INTO category
values(1, 'BOOKS'),
	  (2, 'GAMES'),
      (3, 'GROCERIES'),
      (4, 'ELECTRONICS'),
      (5, 'CLOTHES');
      
INSERT INTO product
values(1, 'GTA V', 'Windows 7 and above with i5 processor and 8GB RAM', 2),
	  (2, 'TSHIRT', 'SIZE-L with Black, Blue and White variations', 5),
      (3, 'ROG LAPTOP', 'Windows 10 with 15inch screen, i7 processor, 1TB SSD', 4),
      (4, 'OATS', 'Highly Nutritious from Nestle', 3),
      (5, 'HARRY POTTER', 'Best Collection of all time by J.K Rowling', 1),
      (6, 'MILK', '1L Toned Milk', 3),
      (7, 'Boat Earphones', '1.5Meter long Dolby Atmos', 4),
      (8, 'Jeans', 'Stretchable Denim Jeans with various sizes and color', 5),
      (9, 'Project IGI', 'compatible with windows 7 and above', 2),
      (10, 'Hoddie', 'Black GUCCI for 13 yrs and above', 5),
      (11, 'Rich Dad Poor Dad', 'Written by Robert Kiyosaki', 1),
      (12, 'Train Your Brain' , 'By Shireen Stephen', 1);
      

INSERT INTO supplier_pricing
values(1, 1, 2, 1500),
	  (2, 3, 5, 30000),
      (3, 5, 1, 3000),
      (4, 2, 3, 2500),
      (5, 4, 1, 1000);
      SET foreign_key_checks=0;
INSERT INTO orders
Values(101, 1500, '2021-10-06', 2, 1),
	  (102, 1000, '2021-10-12', 3, 5),
      (103, 30000, '2021-09-16', 5, 2),
      (104, 1500, '2021-10-05', 1, 1),
      (105, 3000, '2021-08-16', 4, 3),
      (106, 1450, '2021-08-16', 1, 9),
      (107, 789, '2021-09-01', 3, 7),
      (108, 780, '2021-09-07', 5, 6),
      (109, 3000, '2021-00-10', 5, 3),
      (110, 2500, '2021-09-10', 2, 4),
      (111, 1000, '2021-09-15', 4, 5),
      (112, 789, '2021-09-16', 4, 7),
      (113, 31000, '2021-09-16', 1, 8),
      (114, 1000, '2021-09-16', 3, 5),
      (115, 3000, '2021-09-16', 5, 3),
      (116, 99,  '2021-09-17', 2, 14);
      
INSERT INTO rating
values(1, 101, 4),
	  (2, 102, 3),
      (3, 103, 1),
      (4, 104, 2),
      (5, 105, 4),
      (6, 106, 3),
      (7, 107, 4),
      (8, 108, 4),
      (9, 109, 3),
      (10, 110, 5),
      (11, 111, 3),
      (12, 112, 4),
      (13, 113, 2),
      (14, 114, 1),
      (15, 115, 1),
      (16, 116, 0);
	set foreign_key_checks=1;
    
    /* QUESTION 3*/
 SELECT Count(c.CUS_ID) AS Count, c.CUS_GENDER 
 FROM customer c 
 INNER JOIN orders o on c.CUS_ID= o.CUS_ID
 where o.ORD_AMOUNT>=3000
 group by c.CUS_GENDER;

   /*QUESTION 5*/ 
 SELECT s.* FROM supplier s INNER JOIN supplier_pricing on
 s.SUPP_ID= supplier_pricing.SUPP_ID
 GROUP BY supplier_pricing.SUPP_ID
 HAVING COUNT(supplier_pricing.SUPP_ID)>1;

 /*QUESTION 7*/  
 SELECT PRO_ID, PRO_NAME FROM product where PRO_ID=ANY 
 (SELECT sp.PRO_ID 
 FROM orders o 
 INNER JOIN supplier_pricing sp on o.PRICING_ID= sp.PRICING_ID
 WHERE o.ORD_DATE > '2021-10-05');
 
 
 /*QUESTION 8*/
 SELECT CUS_NAME, CUS_GENDER FROM customer
 where CUS_NAME LIKE'A%' or CUS_NAME LIKE '%A';




