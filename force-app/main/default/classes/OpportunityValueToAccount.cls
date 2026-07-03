public with sharing class OpportunityValueToAccount {
    public OpportunityValueToAccount() {

    }

    public static void getOpportunityValueToAccount(List<Opportunity> oppList,List<Opportunity> oldList , Boolean isDelete){
        //get opp list, collect acc id , collect ag. values add to map , loop ag and update
        //value based on new tirgger values

        //insert,update,delete - after
        Set<Id> accIds = new Set<Id>();
         if(isDelete) {
            for(Opportunity opp : oldList) {
                if(opp.AccountId != null) accIds.add(opp.AccountId);
            }
        } else {
            for(Opportunity opp : oppList) {
                if(opp.AccountId != null) accIds.add(opp.AccountId);
            }
        }

        List<AggregateResult> accAggregateList =[SELECT Count(Id) activeOpportinities,Sum(Amount) totalAccountValue,AccountId 
            FROM Opportunity WHERE AccountId IN : accIds GROUP BY AccountId];
           
        //loop agg result to get values and store it in Map<id,list<integer>>    
        Map<Id,Account> aggMap = new Map<Id,Account>();

        for(AggregateResult ar : accAggregateList ){
            if(aggMap.containsKey(ar.get('AccountId'))){
                aggMap.get(ar.get('AccountId')).Total_Active_Opportunities__c = (Integer)ar.get('activeOpportinities');
                aggMap.get(ar.get('AccountId')).Total_Opportunity_Value__c = (Integer)ar.get('totalAccountValue');
            }else {
                aggMap.put(ar.get('AccountId'),new Account(Total_Active_Opportunities__c = 0,Total_Opportunity_Value__c=0));
            }
        }

        List<Account> accList = [SELECT Id, Total_Active_Opportunities__c , Total_Opportunity_Value__c 
                FROM Account WHERE Id IN : accIds ];
        
        
        if(!aggMap.isEmpty()){
            
            for(Account acc : accList){
                acc.Total_Active_Opportunities__c = aggMap.get(acc.Id).Total_Active_Opportunities__c;
                acc.Total_Opportunity_Value__c = aggMap.get(acc.Id).Total_Opportunity_Value__c;
            }
        }

        update accList;

    }
}