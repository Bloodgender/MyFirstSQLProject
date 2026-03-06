# My First SQL Project

Actual ERD below 

<img width="1896" height="1020" alt="MyFirstSQLProjectERD" src="https://github.com/user-attachments/assets/6caa37bc-247e-4e69-b6ad-6b2de569af6a" />


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

Language

The project description is available in English and Hungarian.

The Hungarian version is provided below.
