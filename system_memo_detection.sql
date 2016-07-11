SELECT COUNT(*) AS cached_pages_count , 
    ( COUNT(*) * 8.0 ) / 1024 AS MB , 
    CASE database_id 
      WHEN 32767 THEN 'ResourceDb' 
      ELSE DB_NAME(database_id) 
    END AS Database_name 
FROM sys.dm_os_buffer_descriptors 
GROUP BY database_id
---------------------------------------
SELECT  
(physical_memory_in_use_kb/1024) AS Memory_usedby_Sqlserver_MB,  
(locked_page_allocations_kb/1024) AS Locked_pages_used_Sqlserver_MB,  
(total_virtual_address_space_kb/1024) AS Total_VAS_in_MB,  
process_physical_memory_low,  
process_virtual_memory_low  
FROM sys.dm_os_process_memory;  

----------------------------------------
set nocount on;
set transaction isolation level read uncommitted;
select
   count(*)as cached_pages_count,
   (COUNT(*) * 8.0) / 1024 AS Total_MB_Occupied, -- convert pages into MB -  the page size is 8 KB for sql server
   obj.name as objectname,
   ind.name as indexname,
   obj.index_id as indexid
from sys.dm_os_buffer_descriptors as bd
inner join
(
    select       object_id as objectid,
                       object_name(object_id) as name,
                       index_id,allocation_unit_id
    from sys.allocation_units as au
        inner join sys.partitions as p
            on au.container_id = p.hobt_id
                and (au.type = 1 or au.type = 3)
    union all
    select       object_id as objectid,
                       object_name(object_id) as name,
                       index_id,allocation_unit_id
    from sys.allocation_units as au
        inner join sys.partitions as p
            on au.container_id = p.partition_id
                and au.type = 2
) as obj
    on bd.allocation_unit_id = obj.allocation_unit_id
left outer join sys.indexes ind 
on  obj.objectid = ind.object_id
and  obj.index_id = ind.index_id
where bd.database_id = db_id()
and bd.page_type in ('data_page', 'index_page')
group by obj.name, ind.name, obj.index_id
order by cached_pages_count desc

--------------------------------------------------------------------------------------------
select OBJECT_NAME(object_id) TableName, * from sys.dm_db_xtp_table_memory_stats where object_id > 0
----------------------------------------------------------------------------------

sp_spaceused sampletable_inmemo
select count(*) from sampletable_inmemo
--------------------------------------------------------------------


------------------------free cache-----------------

DBCC FREEPROCCACHE
Go
DBCC DROPCLEANBUFFERS
Go
DBCC FLUSHPROCINDB

DBCC FREESYSTEMCACHE ('ALL')
DBCC FREESESSIONCACHE
DBCC FREEPROCCACHE
DBCC DROPCLEANBUFFERS
---------------------------------------------------


-- finding memory for objects  
SELECT OBJECT_NAME(object_id), * FROM sys.dm_db_xtp_table_memory_stats;



--To find memory for all objects within the database:
SELECT SUM( memory_allocated_for_indexes_kb + memory_allocated_for_table_kb) AS  
 memoryallocated_objects_in_kb   
FROM sys.dm_db_xtp_table_memory_stats;




SELECT type  
     , name  
     , memory_node_id  
     , pages_kb/1024 AS pages_MB   
   FROM sys.dm_os_memory_clerks WHERE type LIKE '%xtp%'  


   SELECT pool_id  
     , Name  
     , min_memory_percent  
     , max_memory_percent  
     , max_memory_kb/1024 AS max_memory_mb  
     , used_memory_kb/1024 AS used_memory_mb   
     , target_memory_kb/1024 AS target_memory_mb  
   FROM sys.dm_resource_governor_resource_pools  


   SELECT state_desc  
 , file_type_desc  
 , COUNT(*) AS [count]  
 , SUM(CASE  
   WHEN state = 5 AND file_type=0 THEN 128*1024*1024  
   WHEN state = 5 AND file_type=1 THEN 8*1024*1024  
   WHEN state IN (6,7) THEN 68*1024*1024  
   ELSE file_size_in_bytes  
    END) / 1024 / 1024 AS [on-disk size MB]   
FROM sys.dm_db_xtp_checkpoint_files  
GROUP BY state, state_desc, file_type, file_type_desc  
ORDER BY state, file_type  



SELECT SUM(df.size) * 8 / 1024 AS [On-disk size in MB]  
FROM sys.filegroups f JOIN sys.database_files df   
   ON f.data_space_id=df.data_space_id  
WHERE f.type=N'FX'  


--Memory is also consumed by system objects, such as, transactional structures, 
--buffers for data and delta files, garbage collection structures, and more. 
--You can find the memory used for these system objects by querying sys.dm_xtp_system_memory_consumers as shown here.

SELECT memory_consumer_desc  
     , allocated_bytes/1024 AS allocated_bytes_kb  
     , used_bytes/1024 AS used_bytes_kb  
     , allocation_count  
   FROM sys.dm_xtp_system_memory_consumers  


   --https://msdn.microsoft.com/en-us/library/dn465869.aspx#bkmk_CreateDB

   SELECT memory_object_address  
     , pages_in_bytes  
     , bytes_used  
     , type  
   FROM sys.dm_os_memory_objects WHERE type LIKE '%xtp%' 

   SELECT  
(physical_memory_in_use_kb/1024) AS Memory_usedby_Sqlserver_MB,  
(locked_page_allocations_kb/1024) AS Locked_pages_used_Sqlserver_MB,  
(total_virtual_address_space_kb/1024) AS Total_VAS_in_MB,  
process_physical_memory_low,  
process_virtual_memory_low  
FROM sys.dm_os_process_memory; 


SELECT name, description FROM sys.dm_os_loaded_modules WHERE description = 'XTP Native DLL'




exec sp_configure 'max server memory', 1024
reconfigure



EXEC sys.sp_configure N'show advanced options', N'1' RECONFIGURE WITH OVERRIDE
GO
EXEC sys.sp_configure N'max server memory (MB)', N'2048'
GO
RECONFIGURE WITH OVERRIDE
GO
EXEC sys.sp_configure N'show advanced options', N'0' RECONFIGURE WITH OVERRIDE
GO


EXEC sys.sp_configure N'show advanced options', N'1' RECONFIGURE WITH OVERRIDE
GO
EXEC sys.sp_configure N'max server memory (MB)', N'1024'
GO
RECONFIGURE WITH OVERRIDE
GO
EXEC sys.sp_configure N'show advanced options', N'0' RECONFIGURE WITH OVERRIDE
GO

--You can check to see which queries are in cache by running the following command

SELECT text,objtype, refcounts, usecounts, size_in_bytes,
    disk_ios_count, context_switches_count, original_cost,
    current_cost
FROM sys.dm_exec_cached_plans p
    CROSS APPLY sys.dm_exec_sql_text(plan_handle)
    JOIN sys.dm_os_memory_cache_entries e
    ON p.memory_object_address = e.memory_object_address
WHERE cacheobjtype = 'Compiled Plan'
ORDER BY objtype desc, usecounts DESC

select * from sys.dm_exec_query_stats