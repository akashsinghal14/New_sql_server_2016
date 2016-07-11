create database column_ar
use column_ar

CREATE TABLE SampleTable
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

   CREATE CLUSTERED COLUMNSTORE INDEX cci_Simple ON SampleTable;  


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
                INSERT  INTO dbo.SampleTable
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


EXEC dbo.usp_insert_data_noncompiled @records_to_insert = 1000

use column_ar
select top 10 * from sampletable
---------------------------------------------------------------------------------------------------------

---------------------combine columnar and in memory---------------------------------------------



ALTER DATABASE column_ar ADD FILEGROUP columnar_inmemo CONTAINS MEMORY_OPTIMIZED_DATA   
ALTER DATABASE column_ar ADD FILE (name='columnar_inmemo', filename='e:\all_codes_akash_new_server\all_filegroup\columnar_inmemo') TO FILEGROUP columnar_inmemo   
ALTER DATABASE column_ar SET MEMORY_OPTIMIZED_ELEVATE_TO_SNAPSHOT=ON  
GO 
 

 -- This example creates a memory-optimized table with a columnstore index.  
CREATE TABLE t_account (  
    ID INT IDENTITY(1, 1)
             NOT NULL ,
      Value1 INT NOT NULL ,
      Value2 INT NOT NULL ,
      Value3 DECIMAL(10, 2) NOT NULL ,
      Value4 DATETIME NOT NULL ,
      Value5 DATETIME NOT NULL ,
      CONSTRAINT PK_ID1 PRIMARY KEY NONCLUSTERED ( ID ASC )
    )
    WITH (
         MEMORY_OPTIMIZED =
         ON,
         DURABILITY =
         SCHEMA_ONLY)



CREATE PROCEDURE usp_insert_data_compiled_columnar
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
                INSERT  INTO dbo.t_account
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


EXEC dbo.usp_insert_data_compiled_columnar @records_to_insert = 1000

select  count(*) from t_account

-------------------------------------------------------------------------------------------

