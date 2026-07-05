public class StringListReverser {
    public static List<String> reverseStringList(List<String> values) {
        if (values == null) {
            return null;
        }

        List<String> reversedList = new List<String>();
        for (Integer i = values.size() - 1; i >= 0; i--) {
            reversedList.add(values[i]);
        }
        return reversedList;
    }
}
