/*
ЛР3 — сброс только обязательных VIEW лабораторной работы.
Таблицы DWH и объекты предыдущих работ не изменяются.
*/

USE TechStore_DWH;
GO

IF OBJECT_ID(N'mart.vw_SalesByCity', N'V') IS NOT NULL
    DROP VIEW mart.vw_SalesByCity;
GO
IF OBJECT_ID(N'mart.vw_CustomerValue', N'V') IS NOT NULL
    DROP VIEW mart.vw_CustomerValue;
GO
IF OBJECT_ID(N'mart.vw_ProductPerformance', N'V') IS NOT NULL
    DROP VIEW mart.vw_ProductPerformance;
GO
IF OBJECT_ID(N'mart.vw_SalesByMonthCategory', N'V') IS NOT NULL
    DROP VIEW mart.vw_SalesByMonthCategory;
GO
