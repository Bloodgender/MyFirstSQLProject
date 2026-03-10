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

-- Merchandise table

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
    location_address VARCHAR(50) NOT NULL
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
    UPDATE shipment
    SET instock = instock - NEW.quantity
    WHERE merchandise_id = NEW.merchandise_id;
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

CREATE VIEW driver_deliveries AS
SELECT
    d.delivery_id AS delivery_id,
    d.driver_id AS driver_id,
    dd.driver_name AS driver_name
FROM deliveries AS d
LEFT JOIN drivers AS dd
    ON d.driver_id = dd.driver_id;

-- Partner deliveries

CREATE VIEW partners_deliveries AS
SELECT
    d.delivery_id AS delivery_id,
    p.partner_id AS partner_id,
    p.partner_name AS partner_name
FROM deliveries AS d
LEFT JOIN partners AS p
    ON d.partner_id = p.partner_id;

-- Delivery timeline
-- deliveries table used as bridge between status, drivers and partners

CREATE VIEW delivery_timeline AS
SELECT
    ds.delivery_id AS delivery_id,
    d.driver_name AS driver_name,
    p.partner_name AS partner_name,
    ds.actualstatus_time AS actualstatus_time,
    ds.delivery_actualstatus AS delivery_actualstatus
FROM delivery_status AS ds
LEFT JOIN deliveries AS dv
    ON ds.delivery_id = dv.delivery_id
LEFT JOIN drivers AS d 
    ON d.driver_id = dv.driver_id
LEFT JOIN partners AS p 
    ON p.partner_id = dv.partner_id;

-- Index prios

CREATE INDEX idx_delivery_id
ON delivery_status (delivery_id);

CREATE INDEX idx_vehicle_id
ON deliveries (vehicle_id);

CREATE INDEX idx_merchandise_id
ON deliveries (merchandise_id);

CREATE INDEX idx_warehouse_worker_id
ON deliveries (warehouse_worker_id);

CREATE INDEX idx_partner_id
ON deliveries (partner_id);

CREATE INDEX idx_delivery_actualstatus 
ON delivery_status (delivery_actualstatus);

CREATE INDEX idx_actualstatus_time 
ON delivery_status (actualstatus_time);