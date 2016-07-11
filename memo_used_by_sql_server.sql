Create Database DBMemoryTest
Go
Use DBMemoryTest
Go
Create Table TblMemoryTest(Id Int Default 0,NameValue Char(8000) Default 'Mem Test')
Go
Insert Into TblMemoryTest Default Values
Go 20000

select * from TblMemoryTest

exec sp_spaceused 'TblMemoryTest'
Go



DBCC FREEPROCCACHE
Go
DBCC DROPCLEANBUFFERS
Go







SELECT DB_NAME(database_id) AS DatabaseName, (COUNT(*) * 8)/1024.0 AS [Size(MB)]
FROM sys.dm_os_buffer_descriptors
Where Database_Id<>32767
GROUP BY DB_NAME(database_id)


Use DBMemoryTest
Go
Select * FRom TblMemoryTest
Go

SELECT DB_NAME(database_id) AS DatabaseName, (COUNT(*) * 8)/1024.0 AS [Size(MB)]
FROM sys.dm_os_buffer_descriptors
Where Database_Id<>32767
GROUP BY DB_NAME(database_id)