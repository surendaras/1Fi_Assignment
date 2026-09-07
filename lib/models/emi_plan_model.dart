class EmiScheduleItem {
  final int installmentNumber;
  final DateTime dueDate;
  final double principal;
  final double interest;
  final double totalAmount;
  final double remainingBalance;

  EmiScheduleItem({
    required this.installmentNumber,
    required this.dueDate,
    required this.principal,
    required this.interest,
    required this.totalAmount,
    required this.remainingBalance,
  });
}

class EmiPlanModel {
  final int tenureMonths;
  final double monthlyEmi;
  final double principalAmount;
  final double annualInterestRate;
  final bool isNoCost;
  final double processingFee;
  final double totalInterest;
  final double totalPayable;
  final double savingsAmount;
  final String offerTag;
  final List<EmiScheduleItem> schedule;

  EmiPlanModel({
    required this.tenureMonths,
    required this.monthlyEmi,
    required this.principalAmount,
    required this.annualInterestRate,
    required this.isNoCost,
    this.processingFee = 0.0,
    required this.totalInterest,
    required this.totalPayable,
    this.savingsAmount = 0.0,
    required this.offerTag,
    required this.schedule,
  });

  String get tenureDisplay => '$tenureMonths Months';
}
