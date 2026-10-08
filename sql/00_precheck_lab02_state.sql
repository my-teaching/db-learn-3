/*
ЛР3 TechStore — контроль исходного состояния после ЛР2.
Скрипт ничего не изменяет.
*/

IF DB_ID(N'TechStore_DWH') IS NULL
    THROW 51000, N'База TechStore_DWH не найдена.', 1;
GO

USE TechStore_DWH;
GO

SELECT 'DimCustomer' AS ObjectName, COUNT(*) AS RowCount, 15 AS ExpectedRows
FROM dbo.DimCustomer
UNION ALL
SELECT 'DimProduct', COUNT(*), 20 FROM dbo.DimProduct
UNION ALL
SELECT 'DimDate', COUNT(*), 25 FROM dbo.DimDate
UNION ALL
SELECT 'FactSales', COUNT(*), 53 FROM dbo.FactSales;
GO

SELECT
    SUM(Quantity) AS TotalUnits,
    CAST(SUM(Amount) AS DECIMAL(18,2)) AS TotalRevenue,
    62 AS ExpectedUnits,
    CAST(2279410.00 AS DECIMAL(18,2)) AS ExpectedRevenue
FROM dbo.FactSales;
GO

IF (SELECT COUNT(*) FROM dbo.DimCustomer) <> 15
   OR (SELECT COUNT(*) FROM dbo.DimProduct) <> 20
   OR (SELECT COUNT(*) FROM dbo.DimDate) <> 25
   OR (SELECT COUNT(*) FROM dbo.FactSales) <> 53
   OR (SELECT SUM(Quantity) FROM dbo.FactSales) <> 62
   OR (SELECT SUM(Amount) FROM dbo.FactSales) <> 2279410.00
BEGIN
    THROW 51001, N'Исходное состояние не совпадает с финалом ЛР2. Сначала восстановить ЛР2.', 1;
END;
GO

SELECT N'READY_FOR_LAB03' AS Status;
GO
