/*
============================
Create database and schemas
============================
Create a new database names 'DataWarehous'. The script sets up three schemas
withing the database: 'bronze', 'silver', and 'gold'
*/
USE master;
GO
--Create the 'DataWarehouse' database
CREATE DATABASE DataWarehouse;

USE DataWarehouse;
GO
--Create Schemas
CREATE SCHEMA bronze;
GO

CREATE SCHEMA silver;
GO

CREATE SCHEMA gold;
GO
