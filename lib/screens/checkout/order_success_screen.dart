import 'package:flutter/material.dart';
import '../../models/order_model.dart';
import '../../theme/app_colors.dart';
import '../../utils/formatters.dart';
import '../shop/marketplace/widgets/repayment_schedule_modal.dart';

class OrderSuccessScreen extends StatelessWidget {
  final OrderModel order;

  const OrderSuccessScreen({
    super.key,
    required this.order,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text('Order Confirmed'),
        actions: [
          IconButton(
            icon: const Icon(Icons.close_rounded),
            onPressed: () {
              Navigator.of(context).popUntil((route) => route.isFirst);
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          children: [
            const SizedBox(height: 20),

            // Animated Success Checkmark Container
            Container(
              width: 80,
              height: 80,
              decoration: BoxDecoration(
                color: AppColors.primaryLight,
                shape: BoxShape.circle,
              ),
              child: const Icon(
                Icons.check_circle_rounded,
                color: AppColors.primary,
                size: 56,
              ),
            ),

            const SizedBox(height: 20),

            const Text(
              '1Fi EMI Loan Approved!',
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.w900,
                color: AppColors.textDark,
                letterSpacing: -0.5,
              ),
            ),

            const SizedBox(height: 8),

            Text(
              'Your order for ${order.product.title} has been placed successfully.',
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 13,
                color: AppColors.textMedium,
                height: 1.4,
              ),
            ),

            const SizedBox(height: 24),

            // Order & Loan Reference Details Card
            Container(
              padding: const EdgeInsets.all(18),
              decoration: BoxDecoration(
                color: AppColors.surfaceLight,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: AppColors.borderLight),
              ),
              child: Column(
                children: [
                  _buildDetailRow('Order ID', order.orderId),
                  const Divider(height: 16),
                  _buildDetailRow('1Fi Loan Reference', order.loanReferenceId),
                  const Divider(height: 16),
                  _buildDetailRow('Product', '${order.selectedColor.name} • ${order.selectedStorage.label}'),
                  const Divider(height: 16),
                  _buildDetailRow('Monthly EMI', Formatters.formatCurrency(order.emiPlan.monthlyEmi), isBold: true),
                  const Divider(height: 16),
                  _buildDetailRow('Tenure', order.emiPlan.tenureDisplay),
                  const Divider(height: 16),
                  _buildDetailRow('First Auto-Debit Date', Formatters.formatDate(order.emiPlan.schedule.first.dueDate), isBold: true),
                  const Divider(height: 16),
                  _buildDetailRow('Mandate Bank', '${order.mandateBank} (${order.mandateAccountMasked})'),
                ],
              ),
            ),

            const SizedBox(height: 20),

            // Button to View Full Repayment Schedule
            SizedBox(
              width: double.infinity,
              child: OutlinedButton.icon(
                icon: const Icon(Icons.calendar_month_rounded, size: 18),
                label: const Text('View Full Repayment Schedule'),
                onPressed: () {
                  showModalBottomSheet(
                    context: context,
                    isScrollControlled: true,
                    backgroundColor: Colors.transparent,
                    builder: (_) => RepaymentScheduleModal(plan: order.emiPlan),
                  );
                },
              ),
            ),

            const SizedBox(height: 12),

            // Return to Marketplace
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.of(context).popUntil((route) => route.isFirst);
                },
                child: const Text('Continue Shopping in 1Fi Marketplace'),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDetailRow(String label, String value, {bool isBold = false}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: 12,
            color: isBold ? AppColors.textDark : AppColors.textMedium,
            fontWeight: isBold ? FontWeight.w700 : FontWeight.w500,
          ),
        ),
        Flexible(
          child: Text(
            value,
            textAlign: TextAlign.right,
            style: TextStyle(
              fontSize: 12,
              color: AppColors.textDark,
              fontWeight: isBold ? FontWeight.w800 : FontWeight.w600,
            ),
          ),
        ),
      ],
    );
  }
}
