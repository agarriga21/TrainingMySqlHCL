#Deleting
Select * from usa_company_cars;

DELETE FROM usa_company_cars WHERE FuelType = 'Gas';
Select * from usa_company_cars;


TRUNCATE TABLE usa_company_cars;
Select * from usa_company_cars;

DROP TABLE usa_company_cars;
Select * from usa_company_cars;
#re-run the CMtableexamples.sql to restore the data
