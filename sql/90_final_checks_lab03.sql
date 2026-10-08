/*
ЛР3 — итоговые проверки.
Скрипт рассчитан на обязательные имена VIEW из задания.
*/

USE TechStore_DWH;
GO

-- 1. Обязательные VIEW.
SELECT
    s.name AS SchemaName,
    v.name AS ViewName
FROM sys.views AS v
JOIN sys.schemas AS s
    ON s.schema_id = v.schema_id
WHERE s.name = N'mart'
  AND v.name IN (
      N'vw_SalesByMonthCategory',
      N'vw_ProductPerformance',
      N'vw_CustomerValue',
      N'vw_SalesByCity'
  )
ORDER BY v.name;
GO

-- 2. Row count и сверка аддитивных итогов.
SELECT
    N'mart.vw_SalesByMonthCategory' AS ObjectName,
    COUNT(*) AS RowCount,
    SUM(UnitsSold) AS TotalUnits,
    CAST(SUM(Revenue) AS DECIMAL(18,2)) AS TotalRevenue
FROM mart.vw_SalesByMonthCategory
UNION ALL
SELECT
    N'mart.vw_ProductPerformance',
    COUNT(*),
    SUM(UnitsSold),
    CAST(SUM(Revenue) AS DECIMAL(18,2))
FROM mart.vw_ProductPerformance
UNION ALL
SELECT
    N'mart.vw_CustomerValue',
    COUNT(*),
    SUM(UnitsPurchased),
    CAST(SUM(TotalSpent) AS DECIMAL(18,2))
FROM mart.vw_CustomerValue
UNION ALL
SELECT
    N'mart.vw_SalesByCity',
    COUNT(*),
    SUM(UnitsSold),
    CAST(SUM(Revenue) AS DECIMAL(18,2))
FROM mart.vw_SalesByCity;
GO

-- 3. Контрольные лидеры.
WITH BestMonthCategory AS (
    SELECT TOP (1)
        CONCAT([Year], N'-', RIGHT(N'0' + CAST(MonthNumber AS NVARCHAR(2)), 2),
               N' / ', Category) AS Leader,
        UnitsSold AS UnitsValue,
        Revenue
    FROM mart.vw_SalesByMonthCategory
    ORDER BY Revenue DESC, [Year], MonthNumber, Category
),
BestProduct AS (
    SELECT TOP (1)
        ProductName AS Leader,
        UnitsSold AS UnitsValue,
        Revenue
    FROM mart.vw_ProductPerformance
    ORDER BY Revenue DESC, ProductName
),
BestCustomer AS (
    SELECT TOP (1)
        CONCAT(FirstName, N' ', LastName) AS Leader,
        OrdersCount AS UnitsValue,
        TotalSpent AS Revenue
    FROM mart.vw_CustomerValue
    ORDER BY TotalSpent DESC, LastName, FirstName
),
BestCity AS (
    SELECT TOP (1)
        City AS Leader,
        OrdersCount AS UnitsValue,
        Revenue
    FROM mart.vw_SalesByCity
    ORDER BY Revenue DESC, City
)
SELECT N'MonthCategory' AS CheckName, Leader, UnitsValue, CAST(Revenue AS DECIMAL(18,2)) AS Revenue
FROM BestMonthCategory
UNION ALL
SELECT N'Product', Leader, UnitsValue, CAST(Revenue AS DECIMAL(18,2))
FROM BestProduct
UNION ALL
SELECT N'Customer', Leader, UnitsValue, CAST(Revenue AS DECIMAL(18,2))
FROM BestCustomer
UNION ALL
SELECT N'City', Leader, UnitsValue, CAST(Revenue AS DECIMAL(18,2))
FROM BestCity;
GO

-- 4. Структура одного VIEW через системные представления.
SELECT
    c.column_id AS ColumnId,
    c.name AS ColumnName,
    t.name AS DataType,
    c.max_length AS MaxLength,
    c.precision AS [Precision],
    c.scale AS Scale
FROM sys.columns AS c
JOIN sys.types AS t
    ON t.user_type_id = c.user_type_id
WHERE c.object_id = OBJECT_ID(N'mart.vw_SalesByMonthCategory')
ORDER BY c.column_id;
GO

-- Ожидаемые ключевые значения:
-- VIEW = 4
-- vw_SalesByMonthCategory: 40 строк, 62 units, 2279410.00 revenue
-- vw_ProductPerformance:    20 строк, 62 units, 2279410.00 revenue
-- vw_CustomerValue:         15 строк, 62 units, 2279410.00 total spent
-- vw_SalesByCity:           10 строк, 62 units, 2279410.00 revenue
--
-- Лидеры:
-- MonthCategory: 2026-03 / Ноутбуки, 3 units, 300000.00
-- Product: Ноутбук Pro 14, 6 units, 720000.00
-- Customer: Иван Иванов, 3 orders, 368000.00
-- City: Москва, 7 orders, 775000.00
