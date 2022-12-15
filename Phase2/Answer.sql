-- CS4400: Introduction to Database Systems (Fall 4022)
-- Phase II: Create Table & Insert Statements [v0] Monday, September 5, 2022 @ 7:50pm (Local/EDT)
-- Team 117
-- Liam Jones ljones315
-- Kevin Jiang kjiang72
-- Justin Hopf jhopf6
-- Kyungmin Park kpark370
-- Directions:
-- Please follow all instructions for Phase II as listed on Canvas.
-- Fill in the team number and names and GT usernames for all members above.
-- Create Table statements must be manually written, not taken from an SQL Dump file.
-- This file must run without error for credit.
-- ------------------------------------------------------
-- CREATE TABLE STATEMENTS AND INSERT STATEMENTS BELOW
-- ------------------------------------------------------

DROP DATABASE IF EXISTS delivery;
CREATE DATABASE IF NOT EXISTS delivery;
USE delivery;

DROP TABLE IF EXISTS ingredient;
CREATE TABLE ingredient (
  barcode varchar(40) NOT NULL,
  iname varchar(40) NOT NULL,
  weight int NOT NULL,
  PRIMARY KEY (barcode)
)engine = innodb;

DROP TABLE IF EXISTS drone;
CREATE TABLE drone (
	tag int NOT NULL,
    serviceId varchar(40) NOT NULL,
    fuel int NOT NULL,
    capacity int NOT NULL,
    sales int NOT NULL,
    location varchar(40) NOT NULL,
    pilot varchar(40),
    lead_serviceId varchar(40),
    lead_tag int,
    PRIMARY KEY (tag, serviceId),
    CONSTRAINT fk9 FOREIGN KEY (lead_tag, lead_serviceId) REFERENCES drone(tag, serviceId),
    CHECK (capacity >= 0),
    CHECK (sales >= 0),
    CHECK (fuel >= 0)
)engine = innodb;
    
DROP TABLE IF EXISTS contain;
CREATE TABLE contain (
	barcode varchar(40) NOT NULL,
    serviceId varchar(10) NOT NULL,
    droneTag int NOT NULL,
    price int NOT NULL,
    quantity int NOT NULL,
    PRIMARY KEY (barcode, serviceId, droneTag),
    CONSTRAINT fk12 FOREIGN KEY (barcode) REFERENCES ingredient(barcode),
    CONSTRAINT fk13 FOREIGN KEY (droneTag, serviceId) REFERENCES drone(tag, serviceId),
    CHECK (price >= 0),
    CHECK (quantity >= 0)
)engine = innodb;
    
DROP TABLE IF EXISTS user;
CREATE TABLE user (
	username varchar(40) NOT NULL,
    first_name varchar(100) NOT NULL,
    last_name varchar(100) NOT NULL,
    address varchar(500) NOT NULL,
    birthdate date NOT NULL,
    PRIMARY KEY (username),
	CHECK (birthdate <= '2022-11-03')
    )engine = innodb;
    
DROP TABLE IF EXISTS employee;
CREATE TABLE employee (
	taxId char(11) NOT NULL,
    username varchar(40) NOT NULL,
    hired date NOT NULL,
    salary int NOT NULL,
    experience int NOT NULL,
    PRIMARY KEY (username),
    UNIQUE KEY (taxId),
    CONSTRAINT fk2 FOREIGN KEY (username) REFERENCES user(username),
    CHECK (salary >= 0),
    CHECK (experience >= 0),
    CHECK (hired <= '2022-11-03')
)engine = innodb;

DROP TABLE IF EXISTS pilot;
CREATE TABLE pilot (
	username varchar(40) NOT NULL,
    license_type varchar(40) NOT NULL,
    experience int NOT NULL,
    PRIMARY KEY (username),
    CONSTRAINT fk4 FOREIGN KEY (username) REFERENCES user(username),
    CHECK (experience >= 0)
)engine = innodb;

DROP TABLE IF EXISTS worker;
CREATE TABLE worker (
	username varchar(40) NOT NULL,
    serviceId varchar(40),
    PRIMARY KEY (username),
    CONSTRAINT fk5 FOREIGN KEY (username) REFERENCES user(username)
)engine = innodb;

DROP TABLE IF EXISTS works_for;
CREATE TABLE works_for (
	username varchar(40) NOT NULL,
    serviceId varchar(40) NOT NULL,
    PRIMARY KEY (username, serviceId),
    CONSTRAINT fk16 FOREIGN KEY (username) REFERENCES worker(username)
)engine = innodb;

DROP TABLE IF EXISTS owner;
CREATE TABLE owner (
	username varchar(40) NOT NULL,
    CONSTRAINT fk3 FOREIGN KEY (username) REFERENCES user(username)
)engine = innodb;

DROP TABLE IF EXISTS location;
CREATE TABLE location (
	label varchar(40) NOT NULL,
    x_coord int NOT NULL,
    y_coord int NOT NULL,
    space int,
    PRIMARY KEY (label)
)engine = innodb;

DROP TABLE IF EXISTS restaurant;
CREATE TABLE restaurant (
	name varchar(100) NOT NULL,
    spent int NOT NULL,
    rating int NOT NULL,
    location_label varchar(40) NOT NULL,
	PRIMARY KEY (name),
    CONSTRAINT fk6 FOREIGN KEY (location_label) REFERENCES location(label),
    CHECK (spent >= 0),
    CHECK (RATING > 0),
    CHECK (RATING <= 5)
)engine = innodb;

DROP TABLE IF EXISTS service;
CREATE TABLE service(
	name varchar(100) NOT NULL,
    ID varchar(40) NOT NULL,
    location_label varchar(40) NOT NULL,
    PRIMARY KEY (ID),
    CONSTRAINT fk7 FOREIGN KEY (location_label) REFERENCES location(label)
)engine = innodb;

DROP TABLE IF EXISTS fund;
CREATE TABLE fund (
	username varchar(40) NOT NULL,
    restaurant_name varchar(100) NOT NULL,
    invested int NOT NULL,
    dt_invested date NOT NULL,
    PRIMARY KEY (username, restaurant_name),
    CONSTRAINT fk14 FOREIGN KEY (username) REFERENCES owner(username),
    CONSTRAINT fk15 FOREIGN KEY (restaurant_name) REFERENCES restaurant(name),
    CHECK (invested >= 0),
    CHECK (dt_invested <= '2022-11-03')
)engine = innodb;


ALTER TABLE drone ADD CONSTRAINT fk1 FOREIGN KEY (serviceId) REFERENCES service(ID);
ALTER TABLE drone ADD CONSTRAINT fk10 FOREIGN KEY (location) REFERENCES location(label);
ALTER TABLE drone ADD CONSTRAINT fk8 FOREIGN KEY (pilot) REFERENCES pilot(username);
ALTER TABLE works_for ADD CONSTRAINT fk17 FOREIGN KEY (serviceId) REFERENCES service(ID);
ALTER TABLE worker ADD CONSTRAINT fk11 FOREIGN KEY (serviceId) REFERENCES service(ID);

insert into location values
('southside',1,-16,5),
('buckhead',7,10,8),
('airport',5,-6,15),
('avalon',2,15,Null),
('midtown', 2, 1, 7),
('mercedes', -8, 5, NULL),
('plaza', -4, -3, 10),
('highpoint',11,3,4);

insert into restaurant values
('Bishoku',10,5,'plaza'),
('Casi Cielo',30,5,'plaza'),
('Ecco',0,3,'buckhead'),
('Fogo de Chao',30,4,'buckhead'),
('Hearth',0,4,'avalon'),
('Il Giallo',10,4,'mercedes'),
('Lure',20,5,'midtown'),
('Micks',0,2,'southside'),
('South City Kitchen',30,5,'midtown'),
('Tre Vele',10,4,'plaza');

insert into user values
('agarcia7','Alejandro','Garcia','710 Living Water Drive','1966-10-29'),
('awilson5','Aaron','Wilson','220 Peachtree Street','1963-11-11'),
('bsummers4','Brie','Summers','5105 Dragon Star Circle','1976-02-09'),
('cjordan5','Clark','Jordan','77 Infinite Stars Road','1966-06-05'),
('ckann5','Carrot','Kann','64 Knights Square Trail','1972-09-01'),
('csoares8','Claire','Soares','706 Living Stone Way','1965-09-03'),
('echarles19','Ella','Charles','22 Peachtree Street','1974-05-06'),
('eross10','Erica','Ross','22 Peachtree Street','1975-04-02'),
('fprefontaine6','Ford','Prefontaine','10 Hitch Hikers Lane','1961-01-28'),
('hstark16','Harmon','Stark','53 Tanker Top Lane','1971-10-27'),
('jstone5','Jared','Stone','101 Five Finger Way','1961-01-06'),
('lrodriguez5','Lina','Rodriguez','360 Corkscrew Circle','1975-04-02'),
('mrobot1','Mister','Robot','10 Autonomy Trace','1988-11-02'),
('mrobot2','Mister','Robot','10 Clone Me Circle','1988-11-02'),
('rlopez6','Radish','Lopez','8 Queens Route','1999-09-03'),
('sprince6','Sarah','Prince','22 Peachtree Street','1968-06-15'),
('tmccall5','Trey','McCall','360 Corkscrew Circle','1973-03-19');

insert into employee values
('999-99-9999','agarcia7','2019-03-17',41000,24),
('111-11-1111','awilson5','2020-03-15',46000,9),
('000-00-0000','bsummers4','2018-12-06',35000,17),
('640-81-2357','ckann5','2019-08-03',46000,27),
('888-88-8888','csoares8','2019-02-25',57000,26),
('777-77-7777','echarles19','2021-01-02',27000,3),
('444-44-4444','eross10','2020-04-17',61000,10),
('121-21-2121','fprefontaine6','2020-04-19',20000,5),
('555-55-5555','hstark16','2018-07-23',59000,20),
('222-22-2222','lrodriguez5','2019-04-15',58000,20),
('101-01-0101','mrobot1','2015-05-27',38000,8),
('010-10-1010','mrobot2','2015-05-27',38000,8),
('123-58-1321','rlopez6','2017-02-05',64000,51),
('333-33-3333','tmccall5','2018-10-17',33000,29);

insert into owner values
('cjordan5'),
('jstone5'),
('sprince6');

insert into pilot values
('agarcia7','610623',38),
('awilson5','314159',41),
('bsummers4','411911',35),
('csoares8','343563',7),
('echarles19','236001',10),
('fprefontaine6','657483',2),
('lrodriguez5','287182',67),
('mrobot1','101010',18),
('rlopez6','235711',58),
('tmccall5','181633',10);

insert into service values
('Herban Feast','hf','southside'),
('On Safari Foods','osf','southside'),
('Ravishing Radish','rr','avalon');

insert into worker values
('ckann5', NULL),
('csoares8', NULL),
('echarles19', 'rr'),
('eross10', 'osf'),
('hstark16', 'hf'),
('mrobot2', NULL),
('tmccall5', NULL);

insert into works_for values
('ckann5','osf'),
('echarles19','rr'),
('eross10','osf'),
('hstark16','hf'),
('tmccall5','hf');

insert into drone values
(1,'hf',100,6,0,'southside','fprefontaine6',NULL,NULL),
(5,'hf',27,7,100,'buckhead','fprefontaine6',NULL,NULL),
(8,'hf',100,8,0,'southside','bsummers4',NULL,NULL),
(11,'hf',25,10,0,'buckhead',NULL,'hf',5),
(16,'hf',17,5,40,'buckhead','fprefontaine6',NULL,NULL),
(1,'osf',100,9,0,'airport','awilson5',NULL,NULL),
(2,'osf',75,7,0,'airport',NULL,'osf',1),
(3,'rr',100,5,50,'avalon','agarcia7',NULL,NULL),
(7,'rr',53,5,100,'avalon','agarcia7',NULL,NULL),
(8,'rr',100,6,0,'highpoint','agarcia7',NULL,NULL),
(11,'rr',90,6,0,'highpoint',NULL,'rr',8);

insert into fund values
('jstone5','Ecco',20,'2022-10-25'),
('sprince6','Il Giallo',10,'2022-03-06'),
('jstone5','Lure',30,'2022-09-08'),
('jstone5','South City Kitchen',5,'2022-07-25');

insert into ingredient values
('bv_4U5L7M','balsamic vinegar',4),
('clc_4T9U25X','caviar',5),
('ap_9T25E36L','foie gras',4),
('pr_3C6A9R','prosciutto',6),
('ss_2D4E6L','saffron',3),
('hs_5E7L23M','truffles',3);

insert into contain values
('clc_4T9U25X','rr',3,28,2),
('clc_4T9U25X','hf',5,30,1),
('pr_3C6A9R','osf',1,20,5),
('pr_3C6A9R','hf',8,18,4),
('ss_2D4E6L','osf',1,23,3),
('ss_2D4E6L','hf',11,19,3),
('ss_2D4E6L','hf',1,27,6),
('hs_5E7L23M','osf',2,14,7),
('hs_5E7L23M','rr',3,15,2),
('hs_5E7L23M','hf',5,17,4);