-- How to use the Delete statement
-- The "D" in CRUD 

-- Caution, backup before using delete (or truncate table)

delete from [dbo].[SalesByProductSummary]
where [SalesYear] = 2010

select * from [dbo].[SalesByProductSummary]

