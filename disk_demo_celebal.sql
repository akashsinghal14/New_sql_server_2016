select  top 10 * from asset 
where account_recordtype__c=(select top 1 account_recordtype__c from asset where account_recordtype__c='distributor') and Account__c='LOWES OF ROCKFORD              1440'
order by date_code__C


select  top 10 * from asset 
where account_recordtype__c=(select top 1 account_recordtype__c from asset where account_recordtype__c='distributor') and Account__c='SEARS, ROEBUCK AND CO' 
order by date_code__C



select top 10 * from asset 
where account_recordtype__c=(select top 1 account_recordtype__c from asset where account_recordtype__c='distributor') 
and Account__c=(select top 1 account__c from asset where account__c='LOWES OF ROCKFORD              1440') 
order by date_code__C


select count(*) from asset

--select  top 100 * from asset 
DBCC MEMORYSTATUS

DBCC FREEPROCCACHE


