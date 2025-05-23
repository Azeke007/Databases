create table dealer (
    id integer primary key ,
    name varchar(255),
    location varchar(255),
    commission float
);

INSERT INTO dealer (id, name, location, commission) VALUES (101, 'Oleg', 'Astana', 0.15);
INSERT INTO dealer (id, name, location, commission) VALUES (102, 'Amirzhan', 'Almaty', 0.13);
INSERT INTO dealer (id, name, location, commission) VALUES (105, 'Ademi', 'Taldykorgan', 0.11);
INSERT INTO dealer (id, name, location, commission) VALUES (106, 'Azamat', 'Kyzylorda', 0.14);
INSERT INTO dealer (id, name, location, commission) VALUES (107, 'Rahat', 'Satpayev', 0.13);
INSERT INTO dealer (id, name, location, commission) VALUES (103, 'Damir', 'Aktobe', 0.12);

create table client (
    id integer primary key ,
    name varchar(255),
    city varchar(255),
    priority integer,
    dealer_id integer references dealer(id)
);

INSERT INTO client (id, name, city, priority, dealer_id) VALUES (802, 'Bekzat', 'Satpayev', 100, 101);
INSERT INTO client (id, name, city, priority, dealer_id) VALUES (807, 'Aruzhan', 'Almaty', 200, 101);
INSERT INTO client (id, name, city, priority, dealer_id) VALUES (805, 'Али', 'Almaty', 200, 102);
INSERT INTO client (id, name, city, priority, dealer_id) VALUES (808, 'Yerkhan', 'Taraz', 300, 102);
INSERT INTO client (id, name, city, priority, dealer_id) VALUES (804, 'Aibek', 'Kyzylorda', 300, 106);
INSERT INTO client (id, name, city, priority, dealer_id) VALUES (809, 'Arsen', 'Taldykorgan', 100, 103);
INSERT INTO client (id, name, city, priority, dealer_id) VALUES (803, 'Alen', 'Shymkent', 200, 107);
INSERT INTO client (id, name, city, priority, dealer_id) VALUES (801, 'Zhandos', 'Astana', null, 105);

create table sell (
    id integer primary key,
    amount float,
    date timestamp,
    client_id integer references client(id),
    dealer_id integer references dealer(id)
);

INSERT INTO sell (id, amount, date, client_id, dealer_id) VALUES (201, 150.5, '2021-10-05 00:00:00.000000', 805, 102);
INSERT INTO sell (id, amount, date, client_id, dealer_id) VALUES (209, 270.65, '2021-09-10 00:00:00.000000', 801, 105);
INSERT INTO sell (id, amount, date, client_id, dealer_id) VALUES (202, 65.26, '2021-10-05 00:00:00.000000', 802, 101);
INSERT INTO sell (id, amount, date, client_id, dealer_id) VALUES (204, 110.5, '2021-08-17 00:00:00.000000', 809, 103);
INSERT INTO sell (id, amount, date, client_id, dealer_id) VALUES (207, 948.5, '2021-09-10 00:00:00.000000', 805, 102);
INSERT INTO sell (id, amount, date, client_id, dealer_id) VALUES (205, 2400.6, '2021-07-27 00:00:00.000000', 807, 101);
INSERT INTO sell (id, amount, date, client_id, dealer_id) VALUES (208, 5760, '2021-09-10 00:00:00.000000', 802, 101);
INSERT INTO sell (id, amount, date, client_id, dealer_id) VALUES (210, 1983.43, '2021-10-10 00:00:00.000000', 804, 106);
INSERT INTO sell (id, amount, date, client_id, dealer_id) VALUES (203, 2480.4, '2021-10-10 00:00:00.000000', 809, 103);
INSERT INTO sell (id, amount, date, client_id, dealer_id) VALUES (212, 250.45, '2021-06-27 00:00:00.000000', 808, 102);
INSERT INTO sell (id, amount, date, client_id, dealer_id) VALUES (211, 75.29, '2021-08-17 00:00:00.000000', 803, 107);
INSERT INTO sell (id, amount, date, client_id, dealer_id) VALUES (213, 3045.6, '2021-04-25 00:00:00.000000', 802, 101);

-- drop table client;
-- drop table dealer;
-- drop table sell;


-- 1A
SELECT * FROM client
WHERE PRIORITY < 300;

-- 1B
SELECT * FROM client C
JOIN dealer D ON C.dealer_id = D.ID;

-- 1C
SELECT C.NAME, C.CITY, C.PRIORITY, S.ID, S.DATE, S.AMOUNT
FROM DEALER D
    JOIN CLIENT C ON D.ID = C.dealer_id
    JOIN SELL S ON D.ID = S.dealer_id;

-- 1D
SELECT C.NAME AS CLIENT, D.NAME AS DEALER FROM CLIENT C
JOIN DEALER D ON D.LOCATION = C.CITY;

-- 1E
SELECT S.ID, S.AMOUNT, C.NAME, C.CITY FROM SELL S
JOIN CLIENT C ON C.ID = S.client_id
WHERE S.AMOUNT <= 500 AND S.AMOUNT >=200;

-- 1F
SELECT * FROM DEALER D
RIGHT OUTER JOIN CLIENT C ON C.dealer_id = D.ID;

-- 1G
SELECT C.NAME, C.CITY, D.NAME, D.COMMISSION FROM CLIENT C
JOIN DEALER D ON D.ID= C.dealer_id;

-- 1H
SELECT C.NAME, C.CITY, D.NAME, D.COMMISSION FROM CLIENT C
JOIN DEALER D ON D.ID = C.dealer_id
WHERE D.COMMISSION > 0.13;

-- 1I
SELECT C.NAME, C.CITY, S.ID, S.DATE, S.AMOUNT, D.NAME, D.COMMISSION
FROM CLIENT C
LEFT OUTER JOIN SELL S ON S.client_id = C.id
LEFT OUTER JOIN DEALER D ON D.ID = C.dealer_id;

-- 1J
SELECT C.NAME, C.PRIORITY, D.NAME, S.ID, S.AMOUNT FROM CLIENT C
RIGHT OUTER JOIN DEALER D ON D.ID = C.dealer_id
LEFT OUTER JOIN SELL S ON S.client_id = C.ID;

-- 2A
CREATE OR REPLACE VIEW TOTAL
AS SELECT COUNT(DISTINCT CLIENT.ID),
          AVG(SELL.AMOUNT),
          SUM(SELL.AMOUNT) FROM CLIENT, sell
GROUP BY SELL.DATE;

-- 2B
CREATE OR REPLACE VIEW TOP
AS SELECT DATE, SUM(AMOUNT)
FROM sell
GROUP BY DATE
ORDER BY SUM(AMOUNT) DESC LIMIT 5;

-- 2C
CREATE OR REPLACE VIEW C
AS SELECT COUNT(SELL.ID),
          AVG(SELL.AMOUNT), SUM(SELL.AMOUNT)
FROM SELL, dealer
WHERE SELL.dealer_id = DEALER.id
GROUP BY DEALER.ID;

-- 2D
CREATE OR REPLACE VIEW TOTAL_COM
AS SELECT SUM(SELL.AMOUNT*COMMISSION)
FROM SELL, dealer
GROUP BY DEALER.LOCATION;


-- 2E
CREATE OR REPLACE VIEW LOCATION_DEALER
AS SELECT DEALER.LOCATION, COUNT(DEALER.ID) AS COUNT, AVG(SELL.AMOUNT) AS AVERAGE, SUM(SELL.AMOUNT) AS TOTAL
FROM SELL, DEALER
WHERE SELL.dealer_id = DEALER.ID
GROUP BY DEALER.LOCATION;

-- 2F
CREATE OR REPLACE VIEW CLIENT_CITY
AS SELECT CLIENT.CITY, COUNT(CLIENT.ID) AS COUNT, AVG(SELL.AMOUNT) AS AVERAGE, SUM(SELL.AMOUNT) AS TOTAL
FROM CLIENT, SELL
WHERE CLIENT.ID = SELL.client_id
GROUP BY CLIENT.CITY;

-- 2G
SELECT CLIENT_CITY.CITY FROM CLIENT_CITY
JOIN LOCATION_DEALER ON CLIENT_CITY.CITY = LOCATION_DEALER.LOCATION
                        WHERE CLIENT_CITY.TOTAL > LOCATION_DEALER.TOTAL;