public with sharing class ContactTriggerHandler {
    public ContactTriggerHandler() {

    }
    public static void emailDuplicateValidation(List<Contact> conList){
        Set<String> newemailIds = new Set<String>();
        if(!conList.isEmpty()){
            for(Contact con : conList){
                if(con.Email != null){
                    newemailIds.add(con.Email.toLowerCase());
                }
                
            }
        }
        Map<String,Contact> existingConMap = new Map<String,Contact>();
        for(Contact con : [SELECT Id,Email from Contact WHERE Email IN : newemailIds]){
            existingConMap.put(con.Email.toLowerCase(),con);
        }

        for(Contact con : conList){
            if(con.Email!= null && existingConMap.containsKey(con.Email.toLowerCase())){
                con.Email.addError('Email already exists');
            }
        }
    }
}