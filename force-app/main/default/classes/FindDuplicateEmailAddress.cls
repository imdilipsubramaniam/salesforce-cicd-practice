public with sharing class FindDuplicateEmailAddress {
    public static Set<String> getDuplicateEmails(List<Contact> contactList){
        Set<String> emailsToCheck = new Set<String>();
        for(Contact con : contactList){
            if(con.Email != null){
                emailsToCheck.add(con.Email);
            }
        }

        Map<String,Contact> emailMap = new  Map<String,Contact>();
        Set<String> duplicateEmails = new Set<String>();
        for(Contact con : [SELECT id,email,lastname FROM Contact WHERE email IN :emailsToCheck ]){
            if(!emailMap.containsKey(con.email)){
                emailMap.put(con.email,con);
            }else{
                duplicateEmails.add(con.email);
            }
        }
        return duplicateEmails;
    }
}