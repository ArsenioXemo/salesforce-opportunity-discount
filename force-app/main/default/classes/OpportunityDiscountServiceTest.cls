@IsTest
private class OpportunityDiscountServiceTest {
    @IsTest static void calculatesBoundaries() {
        System.assertEquals(100, OpportunityDiscountService.calculate(100, 0));
        System.assertEquals(75, OpportunityDiscountService.calculate(100, 25));
        System.assertEquals(0, OpportunityDiscountService.calculate(100, 100));
        System.assertEquals(9.00, OpportunityDiscountService.calculate(10, 10));
        System.assertEquals(0.67, OpportunityDiscountService.calculate(1, 33.33));
    }
    @IsTest static void rejectsInvalidInputs() {
        for (Decimal p : new List<Decimal>{null, -1, 101}) {
            try {
                OpportunityDiscountService.calculate(100, p);
                System.assert(false, 'Expected invalid discount');
            } catch (OpportunityDiscountService.InvalidDiscountException expected) {}
        }
    }
}
