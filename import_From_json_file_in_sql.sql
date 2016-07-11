C:\Users\akash\Downloads



SELECT BulkColumn
 FROM OPENROWSET (BULK 'C:\Users\akash\Downloads\books.json', SINGLE_CLOB) as j

 --not working--
 SELECT @json = BulkColumn
 FROM OPENROWSET (BULK 'C:\Users\akash\Downloads\books.json', SINGLE_CLOB) as k

  SELECT BulkColumn
 INTO #temp
 FROM OPENROWSET (BULK 'C:\Users\akash\Downloads\books.json', SINGLE_CLOB) as j

 select * from #temp


 SELECT value
 FROM OPENROWSET (BULK 'C:\Users\akash\Downloads\books.json', SINGLE_CLOB) as j
 CROSS APPLY OPENJSON(BulkColumn)


 SELECT book.*
 FROM OPENROWSET (BULK 'C:\Users\akash\Downloads\books.json', SINGLE_CLOB) as j
 CROSS APPLY OPENJSON(BulkColumn)
 WITH( id nvarchar(100), name nvarchar(100), price float,
 pages_i int, author nvarchar(100)) AS book



