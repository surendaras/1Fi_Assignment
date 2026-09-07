import 'package:flutter_test/flutter_test.dart';
import 'package:onefi_app/services/emi_calculator_service.dart';

void main() {
  group('EmiCalculatorService Tests', () {
    test('Calculates 3-Month and 6-Month No Cost EMI accurately with 0% interest', () {
      const price = 60000.0;
      final plans = EmiCalculatorService.calculateAllPlans(price);

      expect(plans.length, 5);

      final plan3M = plans.firstWhere((p) => p.tenureMonths == 3);
      expect(plan3M.isNoCost, true);
      expect(plan3M.monthlyEmi, 20000.0);
      expect(plan3M.totalInterest, 0.0);
      expect(plan3M.totalPayable, 60000.0);
      expect(plan3M.schedule.length, 3);

      final plan6M = plans.firstWhere((p) => p.tenureMonths == 6);
      expect(plan6M.isNoCost, true);
      expect(plan6M.monthlyEmi, 10000.0);
      expect(plan6M.totalInterest, 0.0);
      expect(plan6M.totalPayable, 60000.0);
      expect(plan6M.schedule.length, 6);
    });

    test('Calculates standard reducing balance EMI for 9 and 12-month tenures', () {
      const price = 100000.0;
      final plans = EmiCalculatorService.calculateAllPlans(price);

      final plan9M = plans.firstWhere((p) => p.tenureMonths == 9);
      expect(plan9M.isNoCost, false);
      expect(plan9M.totalInterest, greaterThan(0.0));
      expect(plan9M.totalPayable, greaterThan(price));
      expect(plan9M.schedule.length, 9);
      expect(plan9M.processingFee, 199.0);

      final plan12M = plans.firstWhere((p) => p.tenureMonths == 12);
      expect(plan12M.isNoCost, false);
      expect(plan12M.monthlyEmi, greaterThan(8000));
      expect(plan12M.schedule.length, 12);
    });

    test('Amortization schedule balance decreases to 0 at the end of loan', () {
      const price = 50000.0;
      final plans = EmiCalculatorService.calculateAllPlans(price);
      final plan12M = plans.firstWhere((p) => p.tenureMonths == 12);

      expect(plan12M.schedule.last.remainingBalance, closeTo(0.0, 1.0));
    });
  });
}
