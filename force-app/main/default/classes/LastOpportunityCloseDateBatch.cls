public with sharing class LastOpportunityCloseDateBatch implements Database.Batchable<SObject>{
    public LastOpportunityCloseDateBatch() {

    }
    public Database.QueryLocator start(Database.BatchableContext bc){
        
        return Database.getQueryLocator('SELECT Id FROM Account');
    }

    public void execute(Database.BatchableContext bc,List<Account> scope){
        Set<Id> accIds = new Set<Id>();
        for(Account acc : scope){
            accIds.add(acc.Id);
        }

        Map<Id,Date> accMap = new Map<Id,Date>();
        //agg query to get latest closed date
        for(AggregateResult ar : [SELECT AccountId, MAX(CloseDate) closeDate FROM Opportunity 
        WHERE AccountId != NULL GROUP BY AccountId]){
            accMap.put((Id)ar.get('AccountId'),(Date)ar.get('closeDate'));
        }

        //create a list of acc - map the date and update

        List<Account> accsToUpdate = new List<Account>();
        for(Account acc : Scope){
            acc.Last_Opportunity_Close_Date__c = accMap.get(acc.Id);
            accsToUpdate.add(acc);
        }

        if(!accsToUpdate.isEmpty()){
            update accsToUpdate;
        }
    }

    public void finish (Database.BatchableContext bc){
        System.debug ('Batch Completed : Last Opportunity close date updated');
    }
}