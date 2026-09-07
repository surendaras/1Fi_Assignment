import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../models/product_model.dart';
import '../../models/variant_model.dart';
import '../../models/emi_plan_model.dart';
import '../../providers/checkout_provider.dart';
import '../../theme/app_colors.dart';
import '../../utils/formatters.dart';
import 'order_success_screen.dart';

class CheckoutScreen extends StatefulWidget {
  final ProductModel product;
  final ColorVariant selectedColor;
  final StorageVariant selectedStorage;
  final double finalPrice;
  final EmiPlanModel emiPlan;

  const CheckoutScreen({
    super.key,
    required this.product,
    required this.selectedColor,
    required this.selectedStorage,
    required this.finalPrice,
    required this.emiPlan,
  });

  @override
  State<CheckoutScreen> createState() => _CheckoutScreenState();
}

class _CheckoutScreenState extends State<CheckoutScreen> {
  bool _agreedToTerms = true;

  @override
  Widget build(BuildContext context) {
    final checkoutProvider = context.watch<CheckoutProvider>();

    return Scaffold(
      backgroundColor: AppColors.backgroundLight,
      appBar: AppBar(
        title: const Text('1Fi EMI Application & Mandate'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Stepper Indicator
            _buildStepIndicator(),

            const SizedBox(height: 20),

            // 1. Order Summary Card
            _buildProductSummary(),

            const SizedBox(height: 16),

            // 2. Selected EMI Tenure Summary
            _buildEmiPlanSummary(),

            const SizedBox(height: 16),

            // 3. E-Mandate Auto-Debit Setup Card
            _buildMandateCard(checkoutProvider),

            const SizedBox(height: 16),

            // 4. Delivery Address
            _buildDeliveryAddress(checkoutProvider),

            const SizedBox(height: 16),

            // 5. Terms & Agreement
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Checkbox(
                  value: _agreedToTerms,
                  activeColor: AppColors.primary,
                  onChanged: (val) {
                    setState(() {
                      _agreedToTerms = val ?? false;
                    });
                  },
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(top: 8),
                    child: RichText(
                      text: const TextSpan(
                        style: TextStyle(fontSize: 12, color: AppColors.textMedium, height: 1.4),
                        children: [
                          TextSpan(text: 'I agree to the '),
                          TextSpan(
                            text: '1Fi Credit Line Loan Agreement',
                            style: TextStyle(color: AppColors.accent, fontWeight: FontWeight.w700),
                          ),
                          TextSpan(text: ', Auto-Debit NACH Mandate, and understand the monthly installment of '),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),

            if (checkoutProvider.checkoutError != null) ...[
              const SizedBox(height: 12),
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: AppColors.error.withAlpha(20),
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: AppColors.error.withAlpha(50)),
                ),
                child: Row(
                  children: [
                    const Icon(Icons.error_outline_rounded, color: AppColors.error, size: 18),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Text(
                        checkoutProvider.checkoutError!,
                        style: const TextStyle(color: AppColors.error, fontSize: 12, fontWeight: FontWeight.w600),
                      ),
                    ),
                  ],
                ),
              ),
            ],

            const SizedBox(height: 24),

            // Big CTA Button
            SizedBox(
              width: double.infinity,
              height: 52,
              child: ElevatedButton(
                onPressed: (!_agreedToTerms || checkoutProvider.isProcessing)
                    ? null
                    : () async {
                        final nav = Navigator.of(context);
                        final order = await checkoutProvider.placeEmiOrder(
                          product: widget.product,
                          color: widget.selectedColor,
                          storage: widget.selectedStorage,
                          finalPrice: widget.finalPrice,
                          emiPlan: widget.emiPlan,
                        );

                        if (order != null) {
                          nav.pushReplacement(
                            MaterialPageRoute(
                              builder: (_) => OrderSuccessScreen(order: order),
                            ),
                          );
                        }
                      },
                child: checkoutProvider.isProcessing
                    ? const Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SizedBox(
                            width: 20,
                            height: 20,
                            child: CircularProgressIndicator(color: Colors.white, strokeWidth: 2),
                          ),
                          SizedBox(width: 12),
                          Text('Authorizing 1Fi Mandate...'),
                        ],
                      )
                    : Text('Authorize & Confirm (${Formatters.formatCurrency(widget.emiPlan.monthlyEmi)}/mo)'),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStepIndicator() {
    return Row(
      children: [
        _buildStepItem('1', 'Select Plan', true),
        _buildStepConnector(true),
        _buildStepItem('2', 'Mandate', true),
        _buildStepConnector(false),
        _buildStepItem('3', 'Approved', false),
      ],
    );
  }

  Widget _buildStepItem(String number, String label, bool isCompleted) {
    return Column(
      children: [
        Container(
          width: 28,
          height: 28,
          decoration: BoxDecoration(
            color: isCompleted ? AppColors.primary : AppColors.surfaceLight,
            shape: BoxShape.circle,
            border: Border.all(color: isCompleted ? AppColors.primary : AppColors.borderLight),
          ),
          child: Center(
            child: Text(
              number,
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w800,
                color: isCompleted ? Colors.white : AppColors.textMuted,
              ),
            ),
          ),
        ),
        const SizedBox(height: 4),
        Text(
          label,
          style: TextStyle(
            fontSize: 11,
            fontWeight: isCompleted ? FontWeight.w700 : FontWeight.w500,
            color: isCompleted ? AppColors.textDark : AppColors.textMuted,
          ),
        ),
      ],
    );
  }

  Widget _buildStepConnector(bool isActive) {
    return Expanded(
      child: Container(
        height: 2,
        margin: const EdgeInsets.only(bottom: 16, left: 4, right: 4),
        color: isActive ? AppColors.primary : AppColors.borderLight,
      ),
    );
  }

  Widget _buildProductSummary() {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.borderLight),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: Container(
              width: 70,
              height: 70,
              color: AppColors.surfaceLight,
              child: widget.product.images.isNotEmpty
                  ? Image.network(widget.product.images.first, fit: BoxFit.cover)
                  : const Icon(Icons.devices_rounded),
            ),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.product.title,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w800,
                    color: AppColors.textDark,
                  ),
                ),
                const SizedBox(height: 4),
                Row(
                  children: [
                    Container(
                      width: 10,
                      height: 10,
                      decoration: BoxDecoration(
                        color: widget.selectedColor.colorCode,
                        shape: BoxShape.circle,
                        border: Border.all(color: AppColors.borderLight),
                      ),
                    ),
                    const SizedBox(width: 6),
                    Text(
                      '${widget.selectedColor.name} • ${widget.selectedStorage.label}',
                      style: const TextStyle(fontSize: 12, color: AppColors.textMedium),
                    ),
                  ],
                ),
                const SizedBox(height: 4),
                Text(
                  Formatters.formatCurrency(widget.finalPrice),
                  style: const TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w900,
                    color: AppColors.textDark,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildEmiPlanSummary() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.borderLight),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                '1Fi EMI Loan Details',
                style: TextStyle(fontSize: 14, fontWeight: FontWeight.w800, color: AppColors.textDark),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                decoration: BoxDecoration(
                  color: AppColors.primaryLight,
                  borderRadius: BorderRadius.circular(6),
                ),
                child: Text(
                  widget.emiPlan.isNoCost ? '0% No Cost EMI' : '${widget.emiPlan.annualInterestRate}% p.a.',
                  style: const TextStyle(
                    fontSize: 11,
                    fontWeight: FontWeight.w800,
                    color: AppColors.primaryDark,
                  ),
                ),
              ),
            ],
          ),
          const Divider(height: 20),
          _buildRow('Tenure', widget.emiPlan.tenureDisplay),
          const SizedBox(height: 6),
          _buildRow('Monthly Auto-Debit', Formatters.formatCurrency(widget.emiPlan.monthlyEmi), isBold: true),
          const SizedBox(height: 6),
          _buildRow('Down Payment', '₹0 (Zero Downpayment)', valueColor: AppColors.success),
          const SizedBox(height: 6),
          _buildRow('First EMI Due Date', Formatters.formatDate(widget.emiPlan.schedule.first.dueDate)),
          const SizedBox(height: 6),
          _buildRow('Processing Fee', widget.emiPlan.processingFee == 0 ? 'FREE' : Formatters.formatCurrency(widget.emiPlan.processingFee)),
          const Divider(height: 20),
          _buildRow('Total Loan Amount', Formatters.formatCurrency(widget.emiPlan.totalPayable), isBold: true),
        ],
      ),
    );
  }

  Widget _buildMandateCard(CheckoutProvider provider) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.borderLight),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: const [
              Text(
                'Auto-Debit Mandate (e-NACH)',
                style: TextStyle(fontSize: 14, fontWeight: FontWeight.w800, color: AppColors.textDark),
              ),
              Icon(Icons.lock_rounded, size: 16, color: AppColors.primaryDark),
            ],
          ),
          const SizedBox(height: 12),
          DropdownButtonFormField<String>(
            initialValue: provider.selectedBank,
            decoration: const InputDecoration(
              labelText: 'Select Primary Bank Account',
              contentPadding: EdgeInsets.symmetric(horizontal: 14, vertical: 10),
            ),
            items: provider.supportedBanks.map((b) {
              return DropdownMenuItem(value: b, child: Text(b));
            }).toList(),
            onChanged: (val) {
              if (val != null) provider.setBank(val);
            },
          ),
          const SizedBox(height: 10),
          Row(
            children: [
              const Icon(Icons.check_circle_rounded, size: 16, color: AppColors.success),
              const SizedBox(width: 6),
              Text(
                'Account verified: ${provider.bankAccountNumber}',
                style: const TextStyle(fontSize: 12, color: AppColors.textMedium, fontWeight: FontWeight.w600),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildDeliveryAddress(CheckoutProvider provider) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.borderLight),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: const [
              Text(
                'Delivery Address',
                style: TextStyle(fontSize: 14, fontWeight: FontWeight.w800, color: AppColors.textDark),
              ),
              Icon(Icons.local_shipping_outlined, size: 18, color: AppColors.textMedium),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            provider.deliveryAddress,
            style: const TextStyle(fontSize: 13, color: AppColors.textDark, height: 1.3),
          ),
        ],
      ),
    );
  }

  Widget _buildRow(String label, String value, {bool isBold = false, Color? valueColor}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: 12,
            fontWeight: isBold ? FontWeight.w700 : FontWeight.w500,
            color: isBold ? AppColors.textDark : AppColors.textMedium,
          ),
        ),
        Text(
          value,
          style: TextStyle(
            fontSize: 12,
            fontWeight: isBold ? FontWeight.w800 : FontWeight.w600,
            color: valueColor ?? (isBold ? AppColors.textDark : AppColors.textMedium),
          ),
        ),
      ],
    );
  }
}
