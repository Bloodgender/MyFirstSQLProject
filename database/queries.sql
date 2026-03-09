-- Queries that help frontend work and can be connected to PowerBI. (See later in my PowerBI work.)

-- Actual instock

SELECT merchandise_name, instock
FROM shipment;

-- Deliveries prices

SELECT 
    d.merchandise_id,
    SUM(d.quantity * s.price) AS stackprice
FROM deliveries AS d
LEFT JOIN shipment AS s
    ON d.merchandise_id = s.merchandise_id
GROUP BY d.merchandise_id;

-- Drivers all deliveries

SELECT 
    dr.driver_name,
    COUNT(de.delivery_id) AS driver_workload
FROM drivers AS dr
LEFT JOIN deliveries AS de
    ON dr.driver_id = de.driver_id
GROUP BY dr.driver_id, dr.driver_name;

-- Partner all deliveries

SELECT 
    p.partner_id, p.partner_name,
    COUNT(de.delivery_id) AS all_partner_deliveries
FROM partners AS p
LEFT JOIN deliveries AS de
    ON p.partner_id = de.partner_id
GROUP BY p.partner_id, p.partner_name;

-- Total quantity per merchandise

SELECT 
    s.merchandise_id,
    s.merchandise_name,
    SUM(d.quantity) AS all_m_quantity
FROM shipment AS s
LEFT JOIN deliveries AS d
    ON s.merchandise_id = d.merchandise_id
GROUP BY s.merchandise_id, s.merchandise_name;

-- Active vehicles

SELECT *
FROM vehicles
WHERE status = 'active';

-- Latest delivery status

SELECT 
    ds.delivery_id,
    ds.delivery_actualstatus
FROM delivery_status AS ds
WHERE ds.actualstatus_time = (
    SELECT MAX(actualstatus_time)
    FROM delivery_status
    WHERE delivery_id = ds.delivery_id
);

-- Deliveries today

SELECT COUNT(*) 
FROM deliveries
WHERE delivery_time = CURDATE();

-- Instock is close to empty

SELECT merchandise_id, instock
FROM shipment
WHERE instock <= 50;

-- Latest deliveries per driver

SELECT driver_id, delivery_id
FROM deliveries AS ds
WHERE delivery_time = (
    SELECT MAX(delivery_time)
    FROM deliveries
    WHERE delivery_id = ds.delivery_id
);

-- Partner delivery volume

SELECT partner_id, SUM(quantity) AS all_partner_quantity
FROM deliveries
GROUP BY partner_id;

-- Vehicle usage

SELECT vehicle_id, COUNT(*) AS all_vehicle_deliveries
FROM deliveries
GROUP BY vehicle_id;

-- Warehouse worker activity

SELECT warehouse_worker_id, COUNT(*) AS all_worker_handled_deliveries
FROM deliveries
GROUP BY warehouse_worker_id;

-- Delivery history

SELECT *
FROM delivery_status
ORDER BY delivery_id, actualstatus_time;