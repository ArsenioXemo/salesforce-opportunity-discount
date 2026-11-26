@IsTest
private class OpportunityDiscountControllerTest {
    @IsTest static void appliesDiscount() {
        String stage = [SELECT MasterLabel FROM OpportunityStage WHERE IsActive = true LIMIT 1].MasterLabel;
        Account account = new Account(Name='Synthetic Account');
        insert account;
        Opportunity opp = new Opportunity(Name='Synthetic Opportunity', AccountId=account.Id, StageName=stage, CloseDate=Date.today().addDays(30), Amount=100);
        insert opp;
        Test.startTest();
        Decimal result = OpportunityDiscountController.applyDiscount(opp.Id, 25);
        Test.stopTest();
        Opportunity actual = [SELECT Discount_Percent__c, Discounted_Amount__c FROM Opportunity WHERE Id=:opp.Id];
        System.assertEquals(75, result);
        System.assertEquals(25, actual.Discount_Percent__c);
        System.assertEquals(75, actual.Discounted_Amount__c);
        update new Opportunity(Id=opp.Id, Amount=200);
        actual = [SELECT Discounted_Amount__c FROM Opportunity WHERE Id=:opp.Id];
        System.assertEquals(150, actual.Discounted_Amount__c);
    }
    @IsTest static void rejectsMissingId() {
        try {
            OpportunityDiscountController.applyDiscount(null, 25);
            System.assert(false, 'Expected rejection');
        } catch (AuraHandledException expected) {}
    }
}
