-- Transport Performance & Cost Management System
-- Database Schema
-- Author: Soós Martin
-- Description: Transport cost and performance tracking system

DROP TABLE IF EXISTS vehicles;
DROP TABLE IF EXISTS drivers;
DROP TABLE IF EXISTS shipment;
DROP TABLE IF EXISTS warehouse_workers;
DROP TABLE IF EXISTS partners;
DROP TABLE IF EXISTS deliveries;
DROP TABLE IF EXISTS deliverie_status;

-- Vehicles table

CREATE TABLE vehicles (
    vehicle_id INT AUTO_INCREMENT PRIMARY KEY,
    plate_number VARCHAR(20) NOT NULL UNIQUE,
    model VARCHAR(100),
    purchase_date DATE,
    status VARCHAR(20) DEFAULT 'active'
);

-- Drivers table

CREATE TABLE drivers ( 
    driver_id INT AUTO_INCREMENT PRIMARY KEY, 
    driver_name VARCHAR(50) NOT NULL,
    licence_number VARCHAR(50) UNIQUE, 
    licence_type CHAR(1) CHECK (licence_type IN ('B','C','D')),
    entry_date DATE
);

-- Merchandise talbe

CREATE TABLE shipment ( 
    merchandise_id INT AUTO_INCREMENT PRIMARY KEY, 
    merchandise_name VARCHAR(50) NOT NULL UNIQUE, 
    unit VARCHAR(2), 
    price DECIMAL(10,2), 
    instock INT DEFAULT 0 CHECK (instock >= 0)
);

-- Warehouse worker table

CREATE TABLE warehouse_workers ( 
    warehouse_worker_id INT AUTO_INCREMENT PRIMARY KEY, 
    warehouse_worker_name VARCHAR(50) NOT NULL, 
    department VARCHAR(100), 
    permit_level INT CHECK (permit_level BETWEEN 1 AND 5)
);

-- Partners table

CREATE TABLE partners ( 
    partner_id INT AUTO_INCREMENT PRIMARY KEY, 
    partner_name VARCHAR(100) NOT NULL, 
    location_city VARCHAR(50) NOT NULL, 
    location_adress VARCHAR(50) NOT NULL
);

-- Deliveries table for dayli activities

CREATE TABLE deliveries (
    delivery_id INT AUTO_INCREMENT PRIMARY KEY,
    driver_id INT,
    vehicle_id INT,
    merchandise_id INT,
    warehouse_worker_id INT,
    partner_id INT,
    quantity INT NOT NULL,
    delivery_time TIMESTAMP DEFAULT CURRENT_TIMESTAMP,

    FOREIGN KEY (driver_id) REFERENCES drivers(driver_id),
    FOREIGN KEY (vehicle_id) REFERENCES vehicles(vehicle_id),
    FOREIGN KEY (merchandise_id) REFERENCES shipment(merchandise_id),
    FOREIGN KEY (warehouse_worker_id) REFERENCES warehouse_workers(warehouse_worker_id),
    FOREIGN KEY (partner_id) REFERENCES partners(partner_id)
);

-- Deliverie_status table

CREATE TABLE delivery_status (
    delivery_id INT NOT NULL,
    delivery_actualstatus VARCHAR(20) 
        CHECK (delivery_actualstatus IN ('warehouse_done','driver_loaded','partner_received','delivered')),
    actualstatus_time TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    PRIMARY KEY (delivery_id, actualstatus_time),
    FOREIGN KEY (delivery_id) REFERENCES deliveries(delivery_id)
);

-- Audit table

CREATE TABLE login ( 
    worker_id INT NOT NULL, 
    delivery_id INT, 
    worker_type VARCHAR(20) CHECK (worker_type IN ('warehouse', 'driver', 'office')), 
    action_time TIMESTAMP DEFAULT CURRENT_TIMESTAMP, 
    PRIMARY KEY (delivery_id, action_time), 
    FOREIGN KEY (delivery_id) REFERENCES deliveries(delivery_id)
);

-- TRIGGERS
-- Stock calculator trigger

DELIMITER $$

CREATE TRIGGER decrease_stock
AFTER INSERT ON deliveries
FOR EACH ROW
BEGIN
    IF NEW.quantity < shipment.instock THEN
        UPDATE shipment 
        SET instock = instock - NEW.quantity 
        WHERE merchandise_id = NEW.merchandise_id;
    END IF;
END$$

DELIMITER ;

-- After Delete a delivery trigger

DELIMITER $$

CREATE TRIGGER restock_on_delete
AFTER DELETE ON deliveries
FOR EACH ROW
BEGIN
    UPDATE shipment 
    SET instock = instock + OLD.quantity
    WHERE merchandise_id = OLD.merchandise_id;
END$$

DELIMITER ;

-- After Update a delivery trigger

DELIMITER $$

CREATE TRIGGER restock_on_update
AFTER UPDATE ON deliveries
FOR EACH ROW
BEGIN
    UPDATE shipment
    SET instock = instock + OLD.quantity - NEW.quantity
    WHERE merchandise_id = OLD.merchandise_id;
END$$

DELIMITER ;


-- TEST INSERTS

INSERT INTO vehicles (plate_number, model, purchase_date, status) 
VALUES
('ABC-123', 'Mercedes Sprinter', '2021-05-12', 'active'),
('DEF-456', 'Volvo FH', '2020-11-03', 'active'),
('GHI-789', 'Scania R500', '2022-01-20', 'active'),
('JKL-321', 'MAN TGX', '2019-07-15', 'inactive'),
('MNO-654', 'Mercedes Actros', '2021-09-10', 'active'),
('PQR-987', 'Iveco Stralis', '2020-03-05', 'active'),
('STU-147', 'DAF XF', '2022-06-22', 'active'),
('VWX-258', 'Renault T', '2019-12-12', 'inactive'),
('YZA-369', 'Volvo FM', '2021-08-30', 'active'),
('BCD-741', 'Scania S450', '2022-04-17', 'active');

INSERT INTO drivers (driver_name, licence_number, licence_type, entry_date)
VALUES
('József Nagy', 'AB12345', 'B', '2021-02-10'),
('Eszter Kiss', 'CD67890', 'C', '2020-06-15'),
('Péter Szabó', 'EF11223', 'B', '2022-01-05'),
('Anna Tóth', 'GH44556', 'C', '2019-09-12'),
('Gábor Kovács', 'IJ77889', 'D', '2021-11-23'),
('Mária Farkas', 'KL99001', 'B', '2022-05-17'),
('László Molnár', 'MN22334', 'C', '2020-12-30'),
('Katalin Varga', 'OP55667', 'B', '2021-08-04'),
('Tamás Horváth', 'QR88990', 'D', '2019-03-21'),
('Zsuzsanna Balogh', 'ST11224', 'B', '2022-07-19');

INSERT INTO shipment (merchandise_name, unit, price, instock)
VALUES
('Farönk', 'db', 50.00, 100),
('Tégla', 'db', 20.00, 500),
('Cement', 'kg', 3.50, 1000),
('Vasalat', 'db', 5.00, 200),
('Cserép', 'db', 15.00, 300),
('Tetőfedő lemez', 'db', 80.00, 150),
('Ablak', 'db', 120.00, 50),
('Ajtó', 'db', 150.00, 70),
('Festék', 'liter', 10.00, 200),
('Gipszkarton', 'db', 25.00, 180),
('Padlóburkolat', 'm2', 12.50, 300),
('Csavar', 'db', 0.50, 1000),
('Szigetelő anyag', 'm2', 8.00, 250),
('Vízcső', 'm', 6.00, 400),
('Elektromos kábel', 'm', 2.00, 500),
('Kapcsoló', 'db', 3.50, 150),
('Dugó', 'db', 1.00, 1000),
('Csaptelep', 'db', 45.00, 80),
('Lámpatest', 'db', 30.00, 120),
('Radiátor', 'db', 200.00, 40);

INSERT INTO warehouse_workers (warehouse_worker_name, department, permit_level)
VALUES
('László Nagy', 'Receiving', 3),
('Éva Kovács', 'Shipping', 4),
('Péter Tóth', 'Inventory', 2);

INSERT INTO partners (partner_name, location_city, location_adress)
VALUES
('Építő Kft.', 'Budapest', 'Fő u. 12'),
('Lakásépítő Bt.', 'Debrecen', 'Kossuth Lajos u. 34'),
('Mester Bau', 'Szeged', 'Ady Endre u. 56'),
('Tégla és Társai', 'Pécs', 'Petőfi u. 22'),
('Cement Plus', 'Győr', 'Széchenyi u. 11'),
('Tető Építő', 'Miskolc', 'Dózsa Gy. u. 5'),
('Ablak Mester', 'Nyíregyháza', 'Kossuth u. 18'),
('Ajtó Centrum', 'Székesfehérvár', 'Rákóczi u. 8'),
('Festékbolt Kft.', 'Eger', 'Dobó u. 10'),
('Gipszkarton Kft.', 'Veszprém', 'Petőfi u. 20'),
('Padló Express', 'Sopron', 'Fő tér 3'),
('Csavarbolt Bt.', 'Zalaegerszeg', 'Kossuth u. 12'),
('Szigetelő Kft.', 'Kaposvár', 'Ady u. 9'),
('Vízmester', 'Szolnok', 'Kossuth Lajos u. 21'),
('Elektro Kft.', 'Tatabánya', 'Fő u. 7'),
('Épület Kft.', 'Szombathely', 'Petőfi u. 15'),
('Lakópark Kft.', 'Békéscsaba', 'Jókai u. 30');

-- VIEW segment

-- Instock quantity 

CREATE VIEW v_instock_quantity AS
SELECT 
    merchandise_id, 
    merchandise_name, 
    instock 
FROM shipment;

-- Delivery status overview

CREATE VIEW v_delivery_status_overview AS
SELECT 
    d.delivery_id AS delivery_id, 
    l.worker_id AS worker_id, 
    d.delivery_actualstatus AS status, 
    d.actualstatus_time AS status_time
FROM delivery_status AS d
LEFT JOIN login AS l 
    ON d.delivery_id = l.delivery_id;

-- Driver deliveries
-- Partner deliveries
-- Delivery timeline