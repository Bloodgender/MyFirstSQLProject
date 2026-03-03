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

CREATE TABLE deliverie_status (
    delivery_id INT NOT NULL,
    delivery_actualstatus VARCHAR(20) 
        CHECK (delivery_actualstatus IN ('warehouse_done','driver_loaded','partner_received','delivered')),
    actualstatus_time TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    PRIMARY KEY (delivery_id, actualstatus_time),
    FOREIGN KEY (delivery_id) REFERENCES deliveries(delivery_id)
);

-- TEST INSERTS

INSERT INTO vehicles (plate_number, model, purchase_date, status) VALUES
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