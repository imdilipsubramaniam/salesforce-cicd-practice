public with sharing class ContactCountOnAccount {
    public static Map<Id,Integer> getContactCount(){
        Map<Id,Integer> contactCount= new Map<Id,Integer>();

        List<Id> accIds = new List<Id>();
        for(Account acc : [SELECT Id, Name FROM Account]){
            accIds.add(acc.Id);
        }
        //query contact with accountId

        for(Contact con : [SELECT Id,AccountId FROM Contact WHERE AccountId IN :accIds]){
            //this approach when using aggregate
            //select count(id)conCount,AccountId from Contact where accountId IN : accids group by AccountId 
            //aggregateResult - contactCount.put(ar.get('AccountId'),ar.get('conCount'));
            if(!contactCount.containsKey(con.AccountId)){
                contactCount.put(con.AccountId,1);
            }else{
                contactCount.put(con.AccountId,contactCount.get(con.AccountId)+1);
            }
        }

        return contactCount;
    }
}