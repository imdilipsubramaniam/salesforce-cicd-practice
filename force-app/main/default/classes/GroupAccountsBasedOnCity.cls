public with sharing class GroupAccountsBasedOnCity {
    public static Map<String,List<Account>> getAccountsByCity(){
        Map<String,List<Account>> accountGroup = new Map<String,List<Account>>();
        for(Account acc : [SELECT Id, Name, BillingCity FROM Account WHERE BillingCity != Null ]){
            if(!accountGroup.containsKey(acc.BillingCity)){
                accountGroup.put(acc.BillingCity, new List<Account> {acc});
            }else{
                accountGroup.get(acc.BillingCity).add(acc);
            }
        }
        return accountGroup;
    }
}