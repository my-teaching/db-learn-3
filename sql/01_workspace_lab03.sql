/*
ПРАКТИЧЕСКАЯ РАБОТА №3
TechStore — логическая витрина продаж.

Исходное состояние: корректно завершённая ЛР2.

Перед каждым CREATE VIEW в комментарии зафиксировать:
1) аналитический вопрос;
2) grain — что означает одна строка;
3) используемые measures;
4) используемые dimensions.
*/

USE TechStore_DWH;
GO

/* 
   Шаг 1. Схема mart
 */

-- Создать схему mart, если она отсутствует.


/* 
   Шаг 2. mart.vw_SalesByMonthCategory
   Grain: одна строка = один год + месяц + категория.
 */

-- CREATE OR ALTER VIEW ...
-- GO


/* 
   Шаг 3. mart.vw_ProductPerformance
   Grain: одна строка = один товар.
 */

-- CREATE OR ALTER VIEW ...
-- GO


/* 
   Шаг 4. mart.vw_CustomerValue
   Grain: одна строка = один клиент.
 */

-- CREATE OR ALTER VIEW ...
-- GO


/* 
   Шаг 5. mart.vw_SalesByCity
   Grain: одна строка = один город клиента.
 */

-- CREATE OR ALTER VIEW ...
-- GO


/* 
   Шаг 6. Проверка через системный каталог
 */

-- Вывести четыре обязательных VIEW схемы mart через sys.views + sys.schemas.
-- Вывести столбцы и типы mart.vw_SalesByMonthCategory через sys.columns + sys.types.


/* 
   Шаг 7. Аналитика только через mart.*
 */

-- 1. TOP 5 товаров по Revenue.
-- 2. TOP 3 клиентов по TotalSpent.
-- 3. Город-лидер по Revenue.
-- 4. Комбинация год + месяц + категория с максимальной Revenue.


/* 
   Шаг 8. Итоговые проверки
 */

-- После завершения выполнить 90_final_checks_lab03.sql.
