@isTest
private class StringListReverserTest {
    @isTest
    static void testReverseStringListReturnsReversedOrder() {
        List<String> inputValues = new List<String>{'one', 'two', 'three'};

        Test.startTest();
        List<String> result = StringListReverser.reverseStringList(inputValues);
        Test.stopTest();

        System.assertEquals(3, result.size());
        System.assertEquals('three', result[0]);
        System.assertEquals('two', result[1]);
        System.assertEquals('one', result[2]);
    }

    @isTest
    static void testReverseStringListHandlesNullAndEmptyValues() {
        Test.startTest();
        List<String> nullResult = StringListReverser.reverseStringList(null);
        List<String> emptyResult = StringListReverser.reverseStringList(new List<String>());
        Test.stopTest();

        System.assertEquals(null, nullResult);
        System.assertEquals(0, emptyResult.size());
    }
}
