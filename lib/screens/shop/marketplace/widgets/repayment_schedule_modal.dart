import 'package:flutter/material.dart';
import '../../../../models/emi_plan_model.dart';
import '../../../../theme/app_colors.dart';
import '../../../../utils/formatters.dart';

class RepaymentScheduleModal extends StatelessWidget {
  final EmiPlanModel plan;

  const RepaymentScheduleModal({
    super.key,
    required this.plan,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: BoxConstraints(
        maxHeight: MediaQuery.of(context).size.height * 0.75,
      ),
      padding: const EdgeInsets.all(20),
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '${plan.tenureMonths}-Month Repayment Schedule',
                    style: const TextStyle(
                      fontSize: 17,
                      fontWeight: FontWeight.w800,
                      color: AppColors.textDark,
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    'Auto-debit on 5th of every month',
                    style: const TextStyle(
                      fontSize: 12,
                      color: AppColors.textMedium,
                    ),
                  ),
                ],
              ),
              IconButton(
                icon: const Icon(Icons.close_rounded),
                onPressed: () => Navigator.pop(context),
              ),
            ],
          ),
          const Divider(height: 20),

          // Plan Summary Bar
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: AppColors.surfaceLight,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _buildMetric('Monthly EMI', Formatters.formatCurrency(plan.monthlyEmi)),
                _buildMetric('Interest', plan.isNoCost ? '₹0 (0%)' : Formatters.formatCurrency(plan.totalInterest)),
                _buildMetric('Total Payable', Formatters.formatCurrency(plan.totalPayable)),
              ],
            ),
          ),

          const SizedBox(height: 16),

          const Text(
            'Month-by-Month Amortization Breakdown',
            style: TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.w700,
              color: AppColors.textDark,
            ),
          ),

          const SizedBox(height: 8),

          // Table Header
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            decoration: BoxDecoration(
              color: AppColors.cardLight,
              border: Border.all(color: AppColors.borderLight),
              borderRadius: const BorderRadius.vertical(top: Radius.circular(8)),
            ),
            child: const Row(
              children: [
                Expanded(flex: 1, child: Text('#', style: TextStyle(fontSize: 11, fontWeight: FontWeight.w700, color: AppColors.textMuted))),
                Expanded(flex: 3, child: Text('Due Date', style: TextStyle(fontSize: 11, fontWeight: FontWeight.w700, color: AppColors.textMuted))),
                Expanded(flex: 2, child: Text('Principal', style: TextStyle(fontSize: 11, fontWeight: FontWeight.w700, color: AppColors.textMuted))),
                Expanded(flex: 2, child: Text('Interest', style: TextStyle(fontSize: 11, fontWeight: FontWeight.w700, color: AppColors.textMuted))),
                Expanded(flex: 2, child: Text('EMI', textAlign: TextAlign.right, style: TextStyle(fontSize: 11, fontWeight: FontWeight.w700, color: AppColors.textDark))),
              ],
            ),
          ),

          // Schedule List
          Expanded(
            child: ListView.separated(
              itemCount: plan.schedule.length,
              separatorBuilder: (context, index) => const Divider(height: 1, color: AppColors.borderLight),
              itemBuilder: (context, index) {
                final item = plan.schedule[index];
                return Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                  color: index.isEven ? Colors.white : AppColors.surfaceLight.withAlpha(50),
                  child: Row(
                    children: [
                      Expanded(
                        flex: 1,
                        child: Text(
                          '${item.installmentNumber}',
                          style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w600, color: AppColors.textDark),
                        ),
                      ),
                      Expanded(
                        flex: 3,
                        child: Text(
                          Formatters.formatDate(item.dueDate),
                          style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w500, color: AppColors.textMedium),
                        ),
                      ),
                      Expanded(
                        flex: 2,
                        child: Text(
                          Formatters.formatCurrency(item.principal),
                          style: const TextStyle(fontSize: 12, color: AppColors.textDark),
                        ),
                      ),
                      Expanded(
                        flex: 2,
                        child: Text(
                          Formatters.formatCurrency(item.interest),
                          style: TextStyle(
                            fontSize: 12,
                            color: item.interest == 0 ? AppColors.success : AppColors.textMedium,
                            fontWeight: item.interest == 0 ? FontWeight.w700 : FontWeight.w400,
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 2,
                        child: Text(
                          Formatters.formatCurrency(item.totalAmount),
                          textAlign: TextAlign.right,
                          style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w700, color: AppColors.textDark),
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
          const SizedBox(height: 12),
          SizedBox(
            width: double.infinity,
            child: OutlinedButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Close Schedule'),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMetric(String label, String value) {
    return Column(
      children: [
        Text(
          label,
          style: const TextStyle(fontSize: 11, color: AppColors.textMuted, fontWeight: FontWeight.w500),
        ),
        const SizedBox(height: 3),
        Text(
          value,
          style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w800, color: AppColors.textDark),
        ),
      ],
    );
  }
}
