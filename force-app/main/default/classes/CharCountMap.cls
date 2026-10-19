public with sharing class CharCountMap {
    public CharCountMap() {

    }
    public static Map<String,Integer> charCount(String stringToCheck){
        Map<String,Integer> countMap = new Map<String,Integer>();
        for(Integer i=0;i<stringToCheck.length();i++){
            String ch = stringToCheck.substring(i, i+1).toLowerCase();

            if(!countMap.containsKey(ch)){
                countMap.put(ch,1);
            }else{
                countMap.put(ch,countMap.get(ch)+1);
            }
        }
        return countMap;
    }
}