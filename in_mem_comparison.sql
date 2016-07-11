-----------------------------------------------
CREATE DATABASE in_memo   
GO  
  
--------------------------------------  use your database --------------------------------------
-- create database with a memory-optimized filegroup and a container.  
ALTER DATABASE in_memo ADD FILEGROUP inmemory_mod CONTAINS MEMORY_OPTIMIZED_DATA   
ALTER DATABASE in_memo ADD FILE (name='inmemory_mod', filename='e:\all_codes_akash_new_server\all_filegroup\inmemory_mod') TO FILEGROUP inmemory_mod   
ALTER DATABASE in_memo SET MEMORY_OPTIMIZED_ELEVATE_TO_SNAPSHOT=ON  
GO  

USE in_memo 
GO  
--------------------------------------------------------------------


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


CREATE TABLE SampleTable_disk
    (
      ID INT IDENTITY(1, 1)
             NOT NULL ,
      Value1 INT NOT NULL ,
      Value2 INT NOT NULL ,
      Value3 DECIMAL(10, 2) NOT NULL ,
      Value4 DATETIME NOT NULL ,
      Value5 DATETIME NOT NULL ,
      CONSTRAINT PK_ID1 PRIMARY KEY NONCLUSTERED ( ID ASC )
    )
  




--CREATE NON-COMPILED 'INSERT' STORED PROCEDURE
CREATE PROCEDURE usp_insert_data_noncompiled
    (
      @records_to_insert int
    )
AS
    BEGIN
        SET NOCOUNT ON;
        DECLARE @var INT = 0
        WHILE @var < @records_to_insert
            BEGIN
                INSERT  INTO dbo.SampleTable_disk
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


	--CREATE NATIVELY COMPILED 'INSERT' STORED PROCEDURE
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


	--CREATE NON-COMPILED 'UPDATE' STORED PROCEDURE
CREATE PROCEDURE usp_update_data_noncompiled
AS
    BEGIN
        SET NOCOUNT ON;
        DECLARE @var INT = 0
        DECLARE @record_ct INT
        SELECT  @record_ct = MAX(ID)
        FROM    dbo.SampleTable
        WHILE @var < @record_ct
            BEGIN
                UPDATE  dbo.SampleTable_disk
                SET     Value1 = 20 * RAND() ,
                        Value2 = 10 * RAND() ,
                        Value3 = 10000 * RAND() / 1000 ,
                        Value4 = DATEADD(ss, -@var, Value4) ,
                        Value5 = DATEADD(ss, -@var, Value4)
                WHERE   ID = @var;
                SET @var = @var + 1
            END
    END

	--CREATE NATIVELY COMPILED 'UPDATE' STORED PROCEDURE
CREATE PROCEDURE usp_update_data_compiled
    WITH NATIVE_COMPILATION,
         SCHEMABINDING,
         EXECUTE AS OWNER
AS
    BEGIN ATOMIC WITH ( TRANSACTION ISOLATION LEVEL = SNAPSHOT, LANGUAGE =
        N'us_english' )
        DECLARE @var INT = 0
        DECLARE @record_ct INT
        SELECT  @record_ct = MAX(ID)
        FROM    dbo.SampleTable_inmemo
 
        WHILE @var < @record_ct
            BEGIN
                UPDATE  dbo.SampleTable_inmemo
                SET     Value1 = 20 * RAND() ,
                        Value2 = 10 * RAND() ,
                        Value3 = 10000 * RAND() / 1000 ,
                        Value4 = DATEADD(ss, -@var, Value4) ,
                        Value5 = DATEADD(ss, -@var, Value4)
                WHERE   ID = @var;
                SET @var = @var + 1
            END
    END



	--EXECUTE COMPILED 'Insert' STORED PROCEDURE
EXEC dbo.usp_insert_data_compiled @records_to_insert = 1000000
GO
--EXECUTE NON-COMPILED 'Insert' STORED PROCEDURE
EXEC dbo.usp_insert_data_noncompiled @records_to_insert = 1000000
GO


EXEC dbo.usp_update_data_compiled 

EXEC dbo.usp_update_data_noncompiled

use inmemory
select top 100000 value1,value2 from SampleTable_disk 

select * from SampleTable_disk


select count(*) from SampleTable_disk


select top 10 * from SampleTable_inmemo 

select value1 , value2 from  SampleTable_inmemo where value4='2016-06-27 14:05:07.050' and value5='2016-06-27 13:50:02.050'


select top 10 * from SampleTable_disk 

select value1 , value2 from  SampleTable_disk where value4='2016-06-27 13:50:05.823' and value5='2016-06-27 13:50:05.850'