use colin_celebal

CREATE CLUSTERED COLUMNSTORE INDEX cci_Simple ON asset; 


ALTER DATABASE colin_celebal ADD FILEGROUP colin_mix CONTAINS MEMORY_OPTIMIZED_DATA   
ALTER DATABASE colin_celebal ADD FILE (name='colin_mix', filename='e:\all_codes_akash_new_server\all_filegroup\colin_mix') TO FILEGROUP colin_mix   
ALTER DATABASE colin_celebal SET MEMORY_OPTIMIZED_ELEVATE_TO_SNAPSHOT=ON  
GO 


-- This example creates a memory-optimized table with a columnstore index.  
CREATE TABLE t_account (  
    accountkey int NOT NULL PRIMARY KEY NONCLUSTERED,  
    Accountdescription nvarchar (50),  
    accounttype nvarchar(50),  
    unitsold int,  
    INDEX t_account_cci CLUSTERED COLUMNSTORE  
    )  
    WITH (MEMORY_OPTIMIZED = ON );  
GO 
--------------------------------------------------------

CREATE TABLE [dbo].[Asset](
	[AccountId] [nvarchar](50) NULL,
	[Account_RecordType__c] [nvarchar](50) NULL,
	[Account__c] [nvarchar](50) NULL,
	[BFG_Conversion__c] [nvarchar](50) NULL,
	[Contact_Phone__c] [nvarchar](50) NULL,
	[Contractor_Rewards_Code__c] [nvarchar](50) NULL,
	[CreatedById] [nvarchar](50) NULL,
	[CreatedDate] [nvarchar](50) NULL,
	[Customer_Purchase_Order__c] [nvarchar](50) NULL,
	[Date_Code__c] [nvarchar](50) NULL,
	[Description] [nvarchar](50) NULL,
	[Email__c] [nvarchar](50) NULL,
	[ExternalAssetID__c] [nvarchar](50) NULL,
	[Filter_Warranty_Expiration_AOS_India__c] [nvarchar](50) NULL,
	[Follow_up_Date__c] [nvarchar](50) NULL,
	[Front_Panel_Color__c] [nvarchar](50) NULL,
	[Fuel_Type__c] [nvarchar](50) NULL,
	[Hidden_Install_State__c] [nvarchar](50) NULL,
	[Historical_State_Records_Available__c] [nvarchar](50) NULL,
	[Honeywell_Serial_Number__c] [nvarchar](50) NULL,
	[Id] [nvarchar](50) NOT NULL PRIMARY KEY NONCLUSTERED,
	[Installation_Type__c] [nvarchar](50) NULL,
	[InstallDate] [nvarchar](50) NULL,
	[Install_City__c] [nvarchar](50) NULL,
	[Install_Country__c] [nvarchar](50) NULL,
	[Install_Postal_Code__c] [nvarchar](50) NULL,
	[Install_State__c] [nvarchar](50) NULL,
	[Install_Street__c] [nvarchar](50) NULL,
	[Invoice_Date__c] [nvarchar](50) NULL,
	[Invoice_Number__c] [nvarchar](50) NULL,
	[iot_dsn__c] [nvarchar](50) NULL,
	[Labor_Warranty_Expiration__c] [nvarchar](50) NULL,
	[LastModifiedById] [nvarchar](50) NULL,
	[LastModifiedDate] [nvarchar](50) NULL,
	[Manufacture_Date__c] [nvarchar](50) NULL,
	[Manufacturing_No__c] [nvarchar](50) NULL,
	[Model_Number__c] [nvarchar](50) NULL,
	[Name] [nvarchar](50) NULL,
	[NA_X3_Yr_PLL__c] [nvarchar](50) NULL,
	[ParentId] [nvarchar](50) NULL,
	[Parts_Warranty_Expiration__c] [nvarchar](50) NULL,
	[Physical_Location__c] [nvarchar](50) NULL,
	[POP_Received__c] [nvarchar](50) NULL,
	[Price] [nvarchar](50) NULL,
	[Product2Id] [nvarchar](50) NULL,
	[ProductName__c] [nvarchar](50) NULL,
	[Product_Colour__c] [nvarchar](50) NULL,
	[Product_Family_New__c] [nvarchar](50) NULL,
	[Product_Name__c] [nvarchar](50) NULL,
	[Professionally_Installed__c] [nvarchar](50) NULL,
	[PurchaseDate] [nvarchar](50) NULL,
	[Quantity] [nvarchar](50) NULL,
	[Registered_Owner__c] [nvarchar](50) NULL,
	[Registration_Method__c] [nvarchar](50) NULL,
	[Registration_Notes__c] [nvarchar](50) NULL,
	[Replacement_Unit_Name__c] [nvarchar](50) NULL,
	[Replacement__c] [nvarchar](50) NULL,
	[Sales_Order_Number__c] [nvarchar](50) NULL,
	[SAP_Material_Number__c] [nvarchar](50) NULL,
	[SCM_Registration_ID__c] [nvarchar](50) NULL,
	[SerialNumber] [nvarchar](50) NULL,
	[Status] [nvarchar](50) NULL,
	[Tank_Warranty_Expiration__c] [nvarchar](50) NULL,
	[Telephone__c] [nvarchar](50) NULL,
	[UsageEndDate] [nvarchar](50) NULL,
	[Version__c] [nvarchar](50) NULL,
	[Void_Reason__c] [nvarchar](50) NULL,
	[Warranty_End_Date_AOSI__c] [nvarchar](50) NULL,
	[Warranty_Expiration_Date_AOS_India__c] [nvarchar](50) NULL,
	[Warranty_Final_End_Date_AOSI__c] [nvarchar](50) NULL,
	[Warranty_Status__c] [nvarchar](50) NULL,
	[WC_Plant__c] [nvarchar](50) NULL,
	[WC_Sales_Org__c] [nvarchar](50) NULL,
	INDEX Asset_cci CLUSTERED COLUMNSTORE  
    )
    WITH (
         MEMORY_OPTIMIZED =
         ON);

--CREATE CLUSTERED COLUMNSTORE INDEX cci_Simple ON asset1; 

select count(*) from asset

select  top 10 * from asset 
where account_recordtype__c=(select top 1 account_recordtype__c from asset where account_recordtype__c='distributor') and Account__c='LOWES OF ROCKFORD              1440' 
order by date_code__C