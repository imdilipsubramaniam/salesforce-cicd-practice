public with sharing class FirstNonRepeatingChar {
    public static void getFirstNonRepeatingChar(String stringToCheck){
        Map<String,Integer> charCountMap = new Map<String,Integer>();
        if(stringToCheck !=null ){
            for(Integer i=0;i< stringToCheck.length();i++){
            if(!charCountMap.containsKey(stringToCheck.substring(i, i+1))){
                charCountMap.put(stringToCheck.substring(i, i+1),1);
            }else{
                charCountMap.put(stringToCheck.substring(i, i+1),charCountMap.get(stringToCheck.substring(i, i+1))+1);
            }

        }
        
        }
        for(Integer i=0;i< stringToCheck.length();i++){
            if(charCountMap.get(stringToCheck.substring(i, i+1))==1){
                System.debug('The first non repeating char is :' +stringToCheck.substring(i, i+1));
                break;
            }
        }
        system.debug(charCountMap);
    }
}