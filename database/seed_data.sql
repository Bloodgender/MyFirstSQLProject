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
('Festék', 'l', 10.00, 200),
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