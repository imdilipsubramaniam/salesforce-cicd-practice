public with sharing class FindDuplicateValues {
    public static List<String> findingDuplicates(List<String> stringList){
        Set<String> values = new Set<string>();
        List<String> duplicateValues = new List<String>();
        if(!stringList.isEmpty()){
            for(String str : stringList){
            if(!values.contains(str)){
                values.add(str);
            }else{
                duplicateValues.add(str);
            }
        }
        }
        
        return duplicateValues;
    }
}