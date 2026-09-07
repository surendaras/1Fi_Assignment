import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../providers/checkout_provider.dart';
import '../../theme/app_colors.dart';
import '../../utils/formatters.dart';

class CreditScreen extends StatelessWidget {
  const CreditScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final checkoutProvider = context.watch<CheckoutProvider>();

    return Scaffold(
      backgroundColor: AppColors.backgroundLight,
      appBar: AppBar(
        title: const Text('1Fi Credit & Loans'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.all(18),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: AppColors.borderLight),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('Active Loan Against Mutual Funds', style: TextStyle(fontSize: 14, fontWeight: FontWeight.w800, color: AppColors.textDark)),
                  const SizedBox(height: 12),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text('Total Approved Limit', style: TextStyle(fontSize: 12, color: AppColors.textMedium)),
                      Text(Formatters.formatCurrency(250000), style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w700, color: AppColors.textDark)),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text('Available to Spend', style: TextStyle(fontSize: 12, color: AppColors.textMedium)),
                      Text(Formatters.formatCurrency(checkoutProvider.availableCreditLimit), style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w800, color: AppColors.primaryDark)),
                    ],
                  ),
                  const Divider(height: 20),
                  const Text('Pledged Portfolio: ₹5,10,000 (CAMS & KFintech Verified)', style: TextStyle(fontSize: 11, color: AppColors.textMuted, fontWeight: FontWeight.w600)),
                ],
              ),
            ),

            const SizedBox(height: 20),

            const Text('Active EMI Orders & Mandates', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w800, color: AppColors.textDark)),

            const SizedBox(height: 12),

            if (checkoutProvider.orderHistory.isEmpty)
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(24),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(color: AppColors.borderLight),
                ),
                child: Column(
                  children: const [
                    Icon(Icons.receipt_long_rounded, size: 40, color: AppColors.textMuted),
                    SizedBox(height: 8),
                    Text('No active EMI loans yet', style: TextStyle(fontWeight: FontWeight.w700, fontSize: 13, color: AppColors.textDark)),
                    SizedBox(height: 4),
                    Text('Shop products in 1Fi Marketplace to activate instant 0% EMI.', style: TextStyle(fontSize: 12, color: AppColors.textMedium)),
                  ],
                ),
              )
            else
              ...checkoutProvider.orderHistory.map((order) {
                return Container(
                  margin: const EdgeInsets.only(bottom: 12),
                  padding: const EdgeInsets.all(14),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(14),
                    border: Border.all(color: AppColors.borderLight),
                  ),
                  child: Row(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(8),
                        child: Container(
                          width: 48,
                          height: 48,
                          color: AppColors.surfaceLight,
                          child: order.product.images.isNotEmpty
                              ? Image.network(order.product.images.first, fit: BoxFit.cover)
                              : const Icon(Icons.devices_rounded),
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(order.product.title, maxLines: 1, overflow: TextOverflow.ellipsis, style: const TextStyle(fontWeight: FontWeight.w700, fontSize: 13)),
                            Text('${order.emiPlan.tenureDisplay} • ${Formatters.formatCurrency(order.emiPlan.monthlyEmi)}/mo', style: const TextStyle(fontSize: 11, color: AppColors.primaryDark, fontWeight: FontWeight.w700)),
                          ],
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                        decoration: BoxDecoration(color: AppColors.primaryLight, borderRadius: BorderRadius.circular(6)),
                        child: const Text('Active', style: TextStyle(fontSize: 10, fontWeight: FontWeight.w800, color: AppColors.primaryDark)),
                      ),
                    ],
                  ),
                );
              }),
          ],
        ),
      ),
    );
  }
}
