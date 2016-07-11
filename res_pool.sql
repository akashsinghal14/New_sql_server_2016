CREATE DATABASE IMOLTP_DB  
GO  
use IMOLTP_DB
ALTER DATABASE IMOLTP_DB ADD FILEGROUP IMOLTP_DB_fg CONTAINS MEMORY_OPTIMIZED_DATA  
ALTER DATABASE IMOLTP_DB ADD FILE( NAME = 'IMOLTP_DB_fg' , FILENAME = 'E:\all_codes_akash_new_server\all_filegroup\IMOLTP_DB_fg') TO FILEGROUP IMOLTP_DB_fg;  
GO 



-- set MIN_MEMORY_PERCENT and MAX_MEMORY_PERCENT to the same value  
CREATE RESOURCE POOL Pool_IMOLTPnew  
  WITH   
    ( MIN_MEMORY_PERCENT = 5,   
    MAX_MEMORY_PERCENT = 5 );  
GO  
  
ALTER RESOURCE GOVERNOR RECONFIGURE;  
GO  
---------------------------------------------------------------------
sys.sp_xtp_unbind_db_resource_pool 'IMOLTP_DB'
DROP RESOURCE POOL Pool_IMOLTP;  
GO  
ALTER RESOURCE GOVERNOR RECONFIGURE;  
GO 
----------------------------------------------------------------
EXEC sp_xtp_bind_db_resource_pool 'IMOLTP_DB', 'Pool_IMOLTPnew'  
GO  


SELECT d.database_id, d.name, d.resource_pool_id  
FROM sys.databases d  
GO 


USE master  
GO  
  
ALTER DATABASE IMOLTP_DB SET OFFLINE  
GO  
ALTER DATABASE IMOLTP_DB SET ONLINE  
GO  
  
USE IMOLTP_DB  
GO  

SELECT pool_id  
     , Name  
     , min_memory_percent  
     , max_memory_percent  
     , max_memory_kb/1024 AS max_memory_mb  
     , used_memory_kb/1024 AS used_memory_mb   
     , target_memory_kb/1024 AS target_memory_mb  
   FROM sys.dm_resource_governor_resource_pools  


   CREATE TABLE SampleTable_inmemo
    (
      ID INT IDENTITY(1, 1)
             NOT NULL ,
      Value1 INT NOT NULL ,
      Value2 INT NOT NULL ,
      Value3 DECIMAL(10, 2) NOT NULL ,
      Value4 DATETIME NOT NULL ,
      Value5 DATETIME NOT NULL ,
      CONSTRAINT PK_ID PRIMARY KEY NONCLUSTERED ( ID ASC )
    )
    WITH (
         MEMORY_OPTIMIZED =
         ON,
         DURABILITY =
         SCHEMA_ONLY)



		 CREATE PROCEDURE usp_insert_data_compiled
    (
      @records_to_insert INT
    )
    WITH NATIVE_COMPILATION,
         SCHEMABINDING,
         EXECUTE AS OWNER
AS
    BEGIN ATOMIC WITH ( TRANSACTION ISOLATION LEVEL = SNAPSHOT, LANGUAGE =
        N'us_english' )
        DECLARE @var INT = 0
        WHILE @var < @records_to_insert
            BEGIN
                INSERT  INTO dbo.SampleTable_inmemo
                        ( Value1 ,
                          Value2 ,
                          Value3 ,
                          Value4 ,
                          Value5
                        )
                        SELECT  10 * RAND() ,
                                20 * RAND() ,
                                10000 * RAND() / 100 ,
                                DATEADD(ss, @var, SYSDATETIME()) ,
                                CURRENT_TIMESTAMP;
                SET @var = @var + 1
            END
    END


	EXEC dbo.usp_insert_data_compiled @records_to_insert = 5000

	select count(*) from SampleTable_inmemo

	select top 10 * from SampleTable_inmemo 

	select value1 , value2 from  SampleTable_inmemo where value4='2016-07-10 01:31:20.970' and value5='2016-06-28 11:52:55.967' and value1=6

	exec sp_spaceused 'SampleTable_inmemo'