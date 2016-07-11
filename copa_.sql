create database copa;

use copa

CREATE TABLE copa_table_new3("Client" NVARCHAR(3) NOT NULL , "Ledger" NVARCHAR(1) NOT NULL , "Record_Type" NVARCHAR(3) NOT NULL , 
"Version" NVARCHAR(3) NOT NULL , "Fiscal_Period_Year" VARCHAR(7) NOT NULL , "Document_No" NVARCHAR(10) NOT NULL , 
"Item" NVARCHAR(5) NOT NULL , "Fiscal_Year" VARCHAR(4), "Fiscal_month" VARCHAR(3), "Sales_Org" NVARCHAR(4), 
"Distribution_Channel" NVARCHAR(2), "Division" NVARCHAR(2), "Business_Area" NVARCHAR(4), "Sales_Rep_1" NVARCHAR(5), 
"Customer" NVARCHAR(5), "Ship_to_Party" NVARCHAR(5), "Profit Center" NVARCHAR(10), "Material" NVARCHAR(10), 
"Valuation_Type" TINYINT , "Accounts" NVARCHAR(10), "Currency" NVARCHAR(3), "Unit" NVARCHAR(3), "Sales_Qty" DECIMAL , 
"Net_Invoice_Sales" DECIMAL , "Adjustments" DECIMAL , "Discount" DECIMAL , "Net_Invoice_Sales0" DECIMAL , 
"Cost_of_Goods" DECIMAL , "Promotions" DECIMAL , "Marketing" DECIMAL , "Commissions" DECIMAL , "Budget" DECIMAL , 
"ROW_COUNT" INT);


BULK INSERT copa_table_new2
FROM 'F:\COPA ACTUAL DATA\index\SYSTEM\CE\CE1STPC_GNRC_ACT_NEW\data_clean.csv'
WITH
(
    FIRSTROW = 1,
    FIELDTERMINATOR = ',',  --CSV field delimiter
    ROWTERMINATOR = '\n',   --Use to shift the control to next row
    TABLOCK
)

select count(*) from copa_table_new1
