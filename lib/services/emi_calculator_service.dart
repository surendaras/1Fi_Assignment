import 'dart:math';
import '../models/emi_plan_model.dart';

class EmiCalculatorService {
  /// Calculate all available EMI plans for a given product price
  static List<EmiPlanModel> calculateAllPlans(double price) {
    return [
      _calculatePlan(
        price: price,
        tenureMonths: 3,
        annualRate: 0.0,
        isNoCost: true,
        processingFee: 0.0,
        offerTag: '⭐ No Cost EMI • 0% Interest',
        savingsRate: 0.03, // 3% subvention savings
      ),
      _calculatePlan(
        price: price,
        tenureMonths: 6,
        annualRate: 0.0,
        isNoCost: true,
        processingFee: 0.0,
        offerTag: '🔥 Most Popular • 0% Interest',
        savingsRate: 0.06, // 6% subvention savings
      ),
      _calculatePlan(
        price: price,
        tenureMonths: 9,
        annualRate: 11.99,
        isNoCost: false,
        processingFee: 199.0,
        offerTag: '⚡ Low Cost EMI • ₹199 Fee',
        savingsRate: 0.0,
      ),
      _calculatePlan(
        price: price,
        tenureMonths: 12,
        annualRate: 13.49,
        isNoCost: false,
        processingFee: 299.0,
        offerTag: '💳 Extended Tenure • Zero Downpayment',
        savingsRate: 0.0,
      ),
      _calculatePlan(
        price: price,
        tenureMonths: 18,
        annualRate: 14.99,
        isNoCost: false,
        processingFee: 399.0,
        offerTag: '📅 Lowest Monthly Installment',
        savingsRate: 0.0,
      ),
    ];
  }

  static EmiPlanModel _calculatePlan({
    required double price,
    required int tenureMonths,
    required double annualRate,
    required bool isNoCost,
    required double processingFee,
    required String offerTag,
    required double savingsRate,
  }) {
    double monthlyEmi;
    double totalInterest;
    double totalPayable;

    if (isNoCost || annualRate == 0) {
      monthlyEmi = price / tenureMonths;
      totalInterest = 0.0;
      totalPayable = price + processingFee;
    } else {
      // Standard Reducing Balance EMI Formula: E = P * r * (1 + r)^n / ((1 + r)^n - 1)
      final monthlyRate = (annualRate / 12) / 100;
      final factor = pow(1 + monthlyRate, tenureMonths);
      monthlyEmi = (price * monthlyRate * factor) / (factor - 1);
      totalPayable = (monthlyEmi * tenureMonths) + processingFee;
      totalInterest = (monthlyEmi * tenureMonths) - price;
    }

    final savingsAmount = isNoCost ? (price * savingsRate) : 0.0;

    // Generate schedule
    final schedule = _generateSchedule(
      principal: price,
      tenureMonths: tenureMonths,
      monthlyEmi: monthlyEmi,
      annualRate: annualRate,
      isNoCost: isNoCost,
    );

    return EmiPlanModel(
      tenureMonths: tenureMonths,
      monthlyEmi: monthlyEmi,
      principalAmount: price,
      annualInterestRate: annualRate,
      isNoCost: isNoCost,
      processingFee: processingFee,
      totalInterest: totalInterest,
      totalPayable: totalPayable,
      savingsAmount: savingsAmount,
      offerTag: offerTag,
      schedule: schedule,
    );
  }

  static List<EmiScheduleItem> _generateSchedule({
    required double principal,
    required int tenureMonths,
    required double monthlyEmi,
    required double annualRate,
    required bool isNoCost,
  }) {
    final List<EmiScheduleItem> list = [];
    double remaining = principal;
    final now = DateTime.now();

    final monthlyRate = isNoCost ? 0.0 : ((annualRate / 12) / 100);

    for (int i = 1; i <= tenureMonths; i++) {
      // Due date is 5th of each consecutive month
      final dueDate = DateTime(now.year, now.month + i, 5);
      
      double interest = 0.0;
      double principalPart = monthlyEmi;

      if (!isNoCost && monthlyRate > 0) {
        interest = remaining * monthlyRate;
        principalPart = monthlyEmi - interest;
      }

      remaining = max(0, remaining - principalPart);

      list.add(
        EmiScheduleItem(
          installmentNumber: i,
          dueDate: dueDate,
          principal: principalPart,
          interest: interest,
          totalAmount: monthlyEmi,
          remainingBalance: remaining,
        ),
      );
    }

    return list;
  }
}
