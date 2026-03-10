# My First SQL Project
Transport Performance & Cost Management System
Project Description

This is my first database project.
The goal of the system is to store and manage structured logistics data and support the core operations of a small–medium sized trucking and transportation company.

The database is designed to support:

delivery tracking

warehouse operations

driver and vehicle management

shipment tracking

real-time delivery status monitoring

The project will also include advanced SQL elements such as:

complex queries

triggers

views

automated status tracking

The aim is to model a realistic logistics workflow where deliveries move through multiple operational stages.

Database Structure

The database currently contains five master tables:

vehicles

drivers

shipment

warehouse_workers

partners

These tables store the core reference data used by the system.

Deliveries Table

The deliveries table stores daily operational records.

This table is populated by warehouse staff through a frontend interface during the shipment release process.

It links together:

driver

vehicle

merchandise

warehouse worker

delivery partner

Each record represents a single shipment leaving the warehouse.

Delivery Status Tracking

A second operational table tracks the lifecycle of each delivery:

deliverie_status

This table logs every status change of a delivery and records a timestamp for each event.

Example delivery stages:

warehouse_done

driver_loaded

partner_received

delivered

Each status update creates a new row, allowing the system to track the full history of the delivery.

A frontend tablet interface is intended to allow drivers and partners to update these statuses in real time.

Audit table

The audit table stores colleagues and the individual actions they performed.

It is part of the login system and helps track certain errors and check work quality. 
(Although actualstatus_time may be redundant due to the audit log, it is worth keeping for its role in the primary key.)

Database Logic Components
 ├ Triggers
 ├ Views
 ├ Indexes
 └ Query Examples

Trigger Segment

Triggers perform automatic actions in the database when certain events occur, such as AFTER INSERT, AFTER UPDATE, or AFTER DELETE.

In this project, triggers are mainly used to maintain stock consistency. When a delivery is inserted, updated, or deleted, the corresponding stock values in the shipment table are automatically adjusted. This ensures that inventory data always reflects the real operational state.

View Segment

Several views were created to simplify commonly used queries and represent logical relationships between tables.

Examples include:

v_instock_quantity

v_delivery_status_overview

delivery_timeline

These views help reduce repetitive joins and provide a simplified interface for frequently used data queries. They also make it easier to connect frontend applications or analytical tools to the database.

Index Segment

Indexes improve query performance, especially when working with larger datasets.

They function similarly to a navigation system within the database, allowing the engine to locate specific records much faster. Indexes were created primarily on frequently searched columns and foreign keys to optimize common queries.

SELECT Queries

Approximately 15 representative SELECT queries were implemented to demonstrate typical data retrieval scenarios within the system.

These queries cover operations such as:

inventory checks

delivery statistics

driver workload analysis

partner delivery volume

delivery history tracking

They also provide a foundation for future integrations with frontend applications or analytical tools such as Power BI, where the data can be visualized and used for reporting or statistical analysis.

Lessons Learned

During the development of this first database project I gained practical experience in:

designing relational database structures

working with foreign keys and table relationships

implementing triggers to maintain data consistency

creating views to simplify complex queries

using indexes to improve query performance

writing representative SELECT queries for real operational scenarios

The project also helped me better understand how backend database logic can support future frontend interfaces and analytical tools.

Future Improvements

While building the system I identified several areas that could be improved in a future iteration:

introducing a central employee table for drivers, warehouse staff, and office workers

improving the warehouse_workers structure (department and permission logic)

expanding the system with financial tracking tables connected to deliveries

implementing more advanced SQL techniques such as window functions and more complex analytics queries

refining the database architecture based on lessons learned in this first project

These improvements will be explored in the next database project, where the system will evolve into a more advanced and structured logistics and finance data model. 😉



Language

The project description is available in English and Hungarian.

The Hungarian version is provided below.

Az első SQL projektem
Transport Performance & Cost Management System
Projekt leírás

Ez az első adatbázis-projektem.
A rendszer célja egy logisztikai adatbázis megtervezése és megvalósítása, amely képes strukturált formában tárolni és kezelni egy kisebb vagy közepes méretű szállítmányozási és fuvarozási vállalat működéséhez kapcsolódó adatokat.

Az adatbázis a következő fő területek támogatására készült:

kiszállítások nyomon követése

raktári műveletek kezelése

sofőrök és járművek kezelése

szállított áruk nyilvántartása

a kiszállítások státuszának valós idejű követése

A projekt tartalmaz több fejlettebb SQL elemet is, például:

összetettebb lekérdezéseket

triggereket

view-kat

automatizált státuszkezelést

A cél egy olyan valósághű logisztikai folyamat modellezése volt, ahol a kiszállítások több operatív állapoton mennek keresztül.

Adatbázis felépítése

Az adatbázis jelenleg öt úgynevezett mester táblát tartalmaz:

vehicles

drivers

shipment

warehouse_workers

partners

Ezek a táblák tárolják a rendszer működéséhez szükséges alap referenciaadatokat.

Deliveries tábla

A deliveries tábla a napi operatív folyamatok adatait tárolja.

Ezt a táblát a raktári dolgozók töltik fel egy frontend felületen keresztül, amikor egy szállítmány elhagyja a raktárt.

A tábla összekapcsolja a következő elemeket:

sofőr

jármű

szállított áru

raktári dolgozó

partner

Minden rekord egy konkrét kiszállítást reprezentál, amely elhagyja a raktárt.

Kiszállítás státusz követése

Egy második operatív tábla a kiszállítások teljes életciklusát követi:

delivery_status

Ez a tábla minden státuszváltozást rögzít, valamint minden eseményhez időbélyeget tárol.

Példák a kiszállítási állapotokra:

warehouse_done

driver_loaded

partner_received

delivered

Minden státuszfrissítés új sort hoz létre, így a rendszer képes a kiszállítás teljes történetének nyomon követésére.

A tervezett működés szerint egy frontend tablet felület segítségével a sofőrök és a partnerek valós időben frissíthetik ezeket az állapotokat.

Audit tábla

Az audit tábla a munkatársakat és az általuk végrehajtott műveleteket tárolja.

Ez a login rendszer részeként működik, és segít az egyes hibák visszakövetésében, valamint a munkafolyamatok ellenőrzésében.

(Bár az actualstatus_time mező részben redundánsnak tűnhet az audit napló mellett, a primer kulcsban betöltött szerepe miatt érdemes megtartani.)

Trigger szegmens

A triggereket automatikus műveletek végrehajtására használjuk bizonyos adatbázis események bekövetkezésekor, például:

AFTER INSERT

AFTER UPDATE

AFTER DELETE

Ebben a projektben a triggereket elsősorban a raktárkészlet konzisztenciájának fenntartására használjuk.
Amikor egy kiszállítás bekerül, módosul vagy törlésre kerül, a shipment tábla készletértékei automatikusan frissülnek.

Ez biztosítja, hogy a készletadatok mindig a valós operatív állapotot tükrözzék.

View szegmens

Több view is létre lett hozva a gyakran használt lekérdezések egyszerűsítésére és a táblák közötti logikai kapcsolatok áttekinthetőbb megjelenítésére.

Példák:

v_instock_quantity

v_delivery_status_overview

delivery_timeline

Ezek a view-k csökkentik az ismétlődő JOIN műveletek szükségességét, és egyszerűbb felületet biztosítanak a gyakran használt adatlekérdezések számára.

Emellett megkönnyítik a frontend alkalmazások vagy analitikai eszközök csatlakoztatását az adatbázishoz.

Index szegmens

Az indexek célja a lekérdezések teljesítményének javítása, különösen nagyobb adatmennyiség esetén.

Az indexek egyfajta navigációs rendszerként működnek az adatbázison belül, lehetővé téve, hogy az adatbázis-motor gyorsabban találja meg a keresett rekordokat.

Az indexek elsősorban a gyakran keresett oszlopokon és az idegen kulcsokon lettek létrehozva a leggyakoribb lekérdezések optimalizálása érdekében.

SELECT lekérdezések

A projektben körülbelül 15 reprezentatív SELECT lekérdezés készült, amelyek a rendszer tipikus adatlekérdezési eseteit mutatják be.

Ezek a lekérdezések többek között az alábbi területeket fedik le:

készletellenőrzés

kiszállítási statisztikák

sofőr terheltség elemzése

partnerenkénti kiszállítási mennyiségek

kiszállítási történet lekérdezése

Ezek a lekérdezések egyben alapot biztosítanak a jövőbeli frontend integrációkhoz vagy analitikai eszközökhöz (például Power BI), ahol az adatok vizualizálhatók és riportok készíthetők belőlük.