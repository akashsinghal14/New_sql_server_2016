-----------------------------------------------
CREATE DATABASE inmemo_celebal   
GO  
  
--------------------------------------  use your database --------------------------------------
-- create database with a memory-optimized filegroup and a container.  
ALTER DATABASE inmemo_celebal ADD FILEGROUP inmemory CONTAINS MEMORY_OPTIMIZED_DATA   
ALTER DATABASE inmemo_celebal ADD FILE (name='inmemory', filename='e:\all_codes_akash_new_server\all_filegroup\inmemory') TO FILEGROUP inmemory   
ALTER DATABASE inmemo_celebal SET MEMORY_OPTIMIZED_ELEVATE_TO_SNAPSHOT=ON  
GO  

USE in_memo 
GO  



USE inmemo_celebal
GO

/****** Object:  Table [dbo].[Asset]    Script Date: 29-Jun-16 5:09:20 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[Asset](
	[AccountId] [nvarchar](4000) NULL,
	[Account_RecordType__c] [nvarchar](4000) NULL,
	[Account__c] [nvarchar](4000) NULL,
	[BFG_Conversion__c] [nvarchar](4000) NULL,
	[Contact_Phone__c] [nvarchar](4000) NULL,
	[Contractor_Rewards_Code__c] [nvarchar](4000) NULL,
	[CreatedById] [nvarchar](4000) NULL,
	[CreatedDate] [nvarchar](4000) NULL,
	[Customer_Purchase_Order__c] [nvarchar](4000) NULL,
	[Date_Code__c] [nvarchar](4000) NULL,
	[Description] [nvarchar](4000) NULL,
	[Email__c] [nvarchar](4000) NULL,
	[ExternalAssetID__c] [nvarchar](4000) NULL,
	[Filter_Warranty_Expiration_AOS_India__c] [nvarchar](4000) NULL,
	[Follow_up_Date__c] [nvarchar](4000) NULL,
	[Front_Panel_Color__c] [nvarchar](4000) NULL,
	[Fuel_Type__c] [nvarchar](4000) NULL,
	[Hidden_Install_State__c] [nvarchar](4000) NULL,
	[Historical_State_Records_Available__c] [nvarchar](4000) NULL,
	[Honeywell_Serial_Number__c] [nvarchar](4000) NULL,
	[Id] [nvarchar](1000) NOT NULL,
	[Installation_Type__c] [nvarchar](4000) NULL,
	[InstallDate] [nvarchar](4000) NULL,
	[Install_City__c] [nvarchar](4000) NULL,
	[Install_Country__c] [nvarchar](4000) NULL,
	[Install_Postal_Code__c] [nvarchar](4000) NULL,
	[Install_State__c] [nvarchar](4000) NULL,
	[Install_Street__c] [nvarchar](4000) NULL,
	[Invoice_Date__c] [nvarchar](4000) NULL,
	[Invoice_Number__c] [nvarchar](4000) NULL,
	[iot_dsn__c] [nvarchar](4000) NULL,
	[Labor_Warranty_Expiration__c] [nvarchar](4000) NULL,
	[LastModifiedById] [nvarchar](4000) NULL,
	[LastModifiedDate] [nvarchar](4000) NULL,
	[Manufacture_Date__c] [nvarchar](4000) NULL,
	[Manufacturing_No__c] [nvarchar](4000) NULL,
	[Model_Number__c] [nvarchar](4000) NULL,
	[Name] [nvarchar](4000) NULL,
	[NA_X3_Yr_PLL__c] [nvarchar](4000) NULL,
	[ParentId] [nvarchar](4000) NULL,
	[Parts_Warranty_Expiration__c] [nvarchar](4000) NULL,
	[Physical_Location__c] [nvarchar](4000) NULL,
	[POP_Received__c] [nvarchar](4000) NULL,
	[Price] [nvarchar](4000) NULL,
	[Product2Id] [nvarchar](4000) NULL,
	[ProductName__c] [nvarchar](4000) NULL,
	[Product_Colour__c] [nvarchar](4000) NULL,
	[Product_Family_New__c] [nvarchar](4000) NULL,
	[Product_Name__c] [nvarchar](4000) NULL,
	[Professionally_Installed__c] [nvarchar](4000) NULL,
	[PurchaseDate] [nvarchar](4000) NULL,
	[Quantity] [nvarchar](4000) NULL,
	[Registered_Owner__c] [nvarchar](4000) NULL,
	[Registration_Method__c] [nvarchar](4000) NULL,
	[Registration_Notes__c] [nvarchar](4000) NULL,
	[Replacement_Unit_Name__c] [nvarchar](4000) NULL,
	[Replacement__c] [nvarchar](4000) NULL,
	[Sales_Order_Number__c] [nvarchar](4000) NULL,
	[SAP_Material_Number__c] [nvarchar](4000) NULL,
	[SCM_Registration_ID__c] [nvarchar](4000) NULL,
	[SerialNumber] [nvarchar](4000) NULL,
	[Status] [nvarchar](4000) NULL,
	[Tank_Warranty_Expiration__c] [nvarchar](4000) NULL,
	[Telephone__c] [nvarchar](4000) NULL,
	[UsageEndDate] [nvarchar](4000) NULL,
	[Version__c] [nvarchar](4000) NULL,
	[Void_Reason__c] [nvarchar](4000) NULL,
	[Warranty_End_Date_AOSI__c] [nvarchar](4000) NULL,
	[Warranty_Expiration_Date_AOS_India__c] [nvarchar](4000) NULL,
	[Warranty_Final_End_Date_AOSI__c] [nvarchar](4000) NULL,
	[Warranty_Status__c] [nvarchar](4000) NULL,
	[WC_Plant__c] [nvarchar](4000) NULL,
	[WC_Sales_Org__c] [nvarchar](4000) NULL,
	CONSTRAINT PK_ID PRIMARY KEY NONCLUSTERED ( ID ASC )
    )
    WITH (
         MEMORY_OPTIMIZED =
         ON,
         DURABILITY =
         SCHEMA_ONLY)

GO

select count(*) from asset


select top 10 * from asset

select  top 10 * from asset 
where account_recordtype__c=(select top 1 account_recordtype__c from asset where account_recordtype__c='distributor') and Account__c='LOWES OF ROCKFORD              1440' 
order by date_code__C

select top 10 * from asset 
where account_recordtype__c=(select top 1 account_recordtype__c from asset where account_recordtype__c='distributor') 
and Account__c=(select top 1 account__c from asset where account__c='LOWES OF ROCKFORD              1440') 
order by date_code__C