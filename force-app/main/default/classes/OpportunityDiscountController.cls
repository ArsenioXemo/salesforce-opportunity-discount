public with sharing class OpportunityDiscountController {
    @AuraEnabled
    public static Decimal applyDiscount(Id recordId, Decimal percent) {
        if (recordId == null || recordId.getSObjectType() != Opportunity.SObjectType) {
            throw new AuraHandledException('Select a valid opportunity.');
        }
        try {
            Opportunity record = [SELECT Id, Amount FROM Opportunity WHERE Id = :recordId WITH USER_MODE LIMIT 1 FOR UPDATE];
            Decimal total = OpportunityDiscountService.calculate(record.Amount, percent);
            Opportunity change = new Opportunity(Id = record.Id, Discount_Percent__c = percent, Discounted_Amount__c = total);
            update as user change;
            return total;
        } catch (Exception e) {
            throw new AuraHandledException('Unable to apply discount. Check the amount, percentage and your access.');
        }
    }
}
