public with sharing class OpportunityDiscountService {
    public class InvalidDiscountException extends Exception {}
    public static Decimal calculate(Decimal amount, Decimal percent) {
        if (amount == null || amount < 0 || percent == null || percent < 0 || percent > 100) {
            throw new InvalidDiscountException('Invalid amount or discount percentage.');
        }
        return (amount * (1 - percent / 100)).setScale(2, RoundingMode.HALF_UP);
    }
}
