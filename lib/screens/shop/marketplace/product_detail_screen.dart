import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../models/product_model.dart';
import '../../../models/emi_plan_model.dart';
import '../../../providers/product_detail_provider.dart';
import '../../../providers/marketplace_provider.dart';
import '../../../theme/app_colors.dart';
import '../../../utils/formatters.dart';
import 'widgets/repayment_schedule_modal.dart';
import '../../checkout/checkout_screen.dart';

class ProductDetailScreen extends StatelessWidget {
  final ProductModel product;

  const ProductDetailScreen({
    super.key,
    required this.product,
  });

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => ProductDetailProvider(product: product),
      child: const _ProductDetailView(),
    );
  }
}

class _ProductDetailView extends StatefulWidget {
  const _ProductDetailView();

  @override
  State<_ProductDetailView> createState() => _ProductDetailViewState();
}

class _ProductDetailViewState extends State<_ProductDetailView> {
  final TextEditingController _pincodeController = TextEditingController(text: '560001');

  @override
  void dispose() {
    _pincodeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final detailProvider = context.watch<ProductDetailProvider>();
    final marketplaceProvider = context.watch<MarketplaceProvider>();
    final product = detailProvider.product;
    final isWishlisted = marketplaceProvider.isInWishlist(product.id);

    return Scaffold(
      backgroundColor: AppColors.backgroundLight,
      appBar: AppBar(
        title: Text(product.brand),
        actions: [
          IconButton(
            icon: Icon(
              isWishlisted ? Icons.favorite_rounded : Icons.favorite_border_rounded,
              color: isWishlisted ? AppColors.error : AppColors.textDark,
            ),
            onPressed: () => marketplaceProvider.toggleWishlist(product.id),
          ),
          IconButton(
            icon: const Icon(Icons.share_outlined),
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Product link copied to clipboard!')),
              );
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Image Carousel Gallery
            _buildImageGallery(detailProvider, product),

            const SizedBox(height: 16),

            // Product Header & Price Block
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Badges
                  Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                        decoration: BoxDecoration(
                          color: AppColors.primaryLight,
                          borderRadius: BorderRadius.circular(6),
                        ),
                        child: const Row(
                          children: [
                            Icon(Icons.verified_rounded, size: 13, color: AppColors.primaryDark),
                            SizedBox(width: 4),
                            Text(
                              '1Fi Guaranteed Genuine',
                              style: TextStyle(
                                fontSize: 11,
                                fontWeight: FontWeight.w700,
                                color: AppColors.primaryDark,
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(width: 8),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                        decoration: BoxDecoration(
                          color: AppColors.goldLight,
                          borderRadius: BorderRadius.circular(6),
                        ),
                        child: Row(
                          children: [
                            const Icon(Icons.star_rounded, size: 14, color: AppColors.gold),
                            const SizedBox(width: 2),
                            Text(
                              '${product.rating} (${product.reviewCount} reviews)',
                              style: const TextStyle(
                                fontSize: 11,
                                fontWeight: FontWeight.w700,
                                color: Color(0xFF946200),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 10),

                  // Title & Subtitle
                  Text(
                    product.title,
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w800,
                      color: AppColors.textDark,
                      letterSpacing: -0.5,
                      height: 1.25,
                    ),
                  ),

                  const SizedBox(height: 6),

                  Text(
                    product.subtitle,
                    style: const TextStyle(
                      fontSize: 13,
                      color: AppColors.textMedium,
                    ),
                  ),

                  const SizedBox(height: 16),

                  // Dynamic Price Container
                  Container(
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
                          crossAxisAlignment: CrossAxisAlignment.baseline,
                          textBaseline: TextBaseline.alphabetic,
                          children: [
                            Text(
                              Formatters.formatCurrency(detailProvider.currentPrice),
                              style: const TextStyle(
                                fontSize: 24,
                                fontWeight: FontWeight.w900,
                                color: AppColors.textDark,
                                letterSpacing: -0.5,
                              ),
                            ),
                            const SizedBox(width: 8),
                            if (detailProvider.currentBasePrice > detailProvider.currentPrice) ...[
                              Text(
                                Formatters.formatCurrency(detailProvider.currentBasePrice),
                                style: const TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.w500,
                                  color: AppColors.textMuted,
                                  decoration: TextDecoration.lineThrough,
                                ),
                              ),
                              const SizedBox(width: 8),
                              Container(
                                padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                                decoration: BoxDecoration(
                                  color: AppColors.error.withAlpha(25),
                                  borderRadius: BorderRadius.circular(4),
                                ),
                                child: Text(
                                  '${detailProvider.currentDiscountPercentage}% OFF',
                                  style: const TextStyle(
                                    color: AppColors.error,
                                    fontSize: 11,
                                    fontWeight: FontWeight.w800,
                                  ),
                                ),
                              ),
                            ],
                          ],
                        ),

                        if (product.cashbackAmount > 0) ...[
                          const SizedBox(height: 8),
                          Row(
                            children: [
                              const Icon(Icons.stars_rounded, size: 16, color: AppColors.gold),
                              const SizedBox(width: 6),
                              Text(
                                'Get ${Formatters.formatCurrency(product.cashbackAmount)} Instant Cashback on 1Fi Credit',
                                style: const TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w700,
                                  color: Color(0xFFB45309),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ],
                    ),
                  ),

                  const SizedBox(height: 20),

                  // Color Variant Selector
                  _buildColorSelector(detailProvider, product),

                  const SizedBox(height: 20),

                  // Storage Variant Selector
                  _buildStorageSelector(detailProvider, product),

                  const SizedBox(height: 24),

                  // EMI Selector Section
                  _buildEmiSection(context, detailProvider),

                  const SizedBox(height: 24),

                  // 1Fi Credit Limit Banner
                  _buildCreditLimitBanner(detailProvider),

                  const SizedBox(height: 20),

                  // Delivery Pincode Checker
                  _buildDeliveryChecker(detailProvider),

                  const SizedBox(height: 20),

                  // Highlights & Specifications
                  _buildHighlights(product),

                  const SizedBox(height: 20),

                  _buildSpecifications(product),

                  const SizedBox(height: 100), // padding for sticky bottom bar
                ],
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: _buildStickyBottomBar(context, detailProvider),
    );
  }

  Widget _buildImageGallery(ProductDetailProvider provider, ProductModel product) {
    return Container(
      color: Colors.white,
      padding: const EdgeInsets.symmetric(vertical: 12),
      child: Column(
        children: [
          SizedBox(
            height: 260,
            child: PageView.builder(
              itemCount: product.images.length,
              onPageChanged: (idx) => provider.setSelectedImageIndex(idx),
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(16),
                    child: Image.network(
                      product.images[index],
                      fit: BoxFit.contain,
                      errorBuilder: (context, error, stackTrace) => const Center(
                        child: Icon(Icons.devices_rounded, size: 64, color: AppColors.textMuted),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
          const SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: List.generate(product.images.length, (index) {
              final isSelected = provider.selectedImageIndex == index;
              return AnimatedContainer(
                duration: const Duration(milliseconds: 250),
                margin: const EdgeInsets.symmetric(horizontal: 3),
                height: 5,
                width: isSelected ? 20 : 6,
                decoration: BoxDecoration(
                  color: isSelected ? AppColors.primary : AppColors.borderLight,
                  borderRadius: BorderRadius.circular(3),
                ),
              );
            }),
          ),
        ],
      ),
    );
  }

  Widget _buildColorSelector(ProductDetailProvider provider, ProductModel product) {
    if (product.colors.isEmpty) return const SizedBox.shrink();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            const Text(
              'Color: ',
              style: TextStyle(fontSize: 14, fontWeight: FontWeight.w700, color: AppColors.textDark),
            ),
            Text(
              provider.selectedColor.name,
              style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w600, color: AppColors.primaryDark),
            ),
          ],
        ),
        const SizedBox(height: 10),
        Wrap(
          spacing: 12,
          children: product.colors.map((c) {
            final isSelected = provider.selectedColor.id == c.id;
            return GestureDetector(
              onTap: () => provider.selectColor(c),
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 200),
                padding: const EdgeInsets.all(3),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: isSelected ? AppColors.primary : Colors.transparent,
                    width: 2,
                  ),
                ),
                child: Container(
                  width: 32,
                  height: 32,
                  decoration: BoxDecoration(
                    color: c.colorCode,
                    shape: BoxShape.circle,
                    border: Border.all(color: AppColors.borderLight, width: 1),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withAlpha(20),
                        blurRadius: 4,
                        offset: const Offset(0, 1),
                      ),
                    ],
                  ),
                  child: isSelected
                      ? Icon(
                          Icons.check,
                          size: 16,
                          color: c.colorCode.computeLuminance() > 0.5 ? Colors.black : Colors.white,
                        )
                      : null,
                ),
              ),
            );
          }).toList(),
        ),
      ],
    );
  }

  Widget _buildStorageSelector(ProductDetailProvider provider, ProductModel product) {
    if (product.storageOptions.isEmpty) return const SizedBox.shrink();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Select Configuration / Variant',
          style: TextStyle(fontSize: 14, fontWeight: FontWeight.w700, color: AppColors.textDark),
        ),
        const SizedBox(height: 10),
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: product.storageOptions.map((s) {
            final isSelected = provider.selectedStorage.id == s.id;
            return InkWell(
              onTap: () => provider.selectStorage(s),
              borderRadius: BorderRadius.circular(10),
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 200),
                padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
                decoration: BoxDecoration(
                  color: isSelected ? AppColors.primaryLight : Colors.white,
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(
                    color: isSelected ? AppColors.primary : AppColors.borderLight,
                    width: isSelected ? 1.5 : 1,
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      s.label,
                      style: TextStyle(
                        fontSize: 13,
                        fontWeight: isSelected ? FontWeight.w800 : FontWeight.w600,
                        color: isSelected ? AppColors.primaryDark : AppColors.textDark,
                      ),
                    ),
                    if (s.priceDelta > 0)
                      Text(
                        '+${Formatters.formatCurrency(s.priceDelta)}',
                        style: const TextStyle(
                          fontSize: 10,
                          fontWeight: FontWeight.w500,
                          color: AppColors.textMuted,
                        ),
                      ),
                  ],
                ),
              ),
            );
          }).toList(),
        ),
      ],
    );
  }

  Widget _buildEmiSection(BuildContext context, ProductDetailProvider provider) {
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
              const Row(
                children: [
                  Icon(Icons.account_balance_wallet_rounded, size: 18, color: AppColors.primary),
                  SizedBox(width: 6),
                  Text(
                    'Select 1Fi EMI Plan',
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w800,
                      color: AppColors.textDark,
                    ),
                  ),
                ],
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                decoration: BoxDecoration(
                  color: AppColors.primaryLight,
                  borderRadius: BorderRadius.circular(6),
                ),
                child: const Text(
                  '0% Downpayment',
                  style: TextStyle(
                    fontSize: 10,
                    fontWeight: FontWeight.w700,
                    color: AppColors.primaryDark,
                  ),
                ),
              ),
            ],
          ),

          const SizedBox(height: 14),

          // Horizontal scrollable EMI tenure cards
          SizedBox(
            height: 115,
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              itemCount: provider.emiPlans.length,
              separatorBuilder: (context, index) => const SizedBox(width: 10),
              itemBuilder: (context, index) {
                final plan = provider.emiPlans[index];
                final isSelected = provider.selectedEmiPlan.tenureMonths == plan.tenureMonths;

                return GestureDetector(
                  onTap: () => provider.selectEmiPlan(plan),
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 200),
                    width: 145,
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: isSelected ? AppColors.surfaceDark : Colors.white,
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(
                        color: isSelected ? AppColors.primary : AppColors.borderLight,
                        width: isSelected ? 2 : 1,
                      ),
                      boxShadow: isSelected
                          ? [
                              BoxShadow(
                                color: AppColors.primary.withAlpha(50),
                                blurRadius: 8,
                                offset: const Offset(0, 2),
                              ),
                            ]
                          : null,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              plan.tenureDisplay,
                              style: TextStyle(
                                fontSize: 13,
                                fontWeight: FontWeight.w800,
                                color: isSelected ? Colors.white : AppColors.textDark,
                              ),
                            ),
                            if (plan.isNoCost)
                              Container(
                                padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 1),
                                decoration: BoxDecoration(
                                  color: AppColors.primary,
                                  borderRadius: BorderRadius.circular(4),
                                ),
                                child: const Text(
                                  '0%',
                                  style: TextStyle(
                                    fontSize: 9,
                                    fontWeight: FontWeight.w900,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                          ],
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              Formatters.formatCurrency(plan.monthlyEmi),
                              style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.w900,
                                color: isSelected ? AppColors.primary : AppColors.textDark,
                              ),
                            ),
                            Text(
                              'per month',
                              style: TextStyle(
                                fontSize: 10,
                                color: isSelected ? Colors.white.withAlpha(180) : AppColors.textMuted,
                              ),
                            ),
                          ],
                        ),
                        Text(
                          plan.isNoCost ? 'No Cost EMI' : '${plan.annualInterestRate}% p.a.',
                          style: TextStyle(
                            fontSize: 10,
                            fontWeight: FontWeight.w600,
                            color: plan.isNoCost
                                ? AppColors.primary
                                : (isSelected ? Colors.white.withAlpha(180) : AppColors.textMedium),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),

          const SizedBox(height: 16),

          // Selected Plan Breakdown Card
          _buildSelectedPlanBreakdown(context, provider.selectedEmiPlan),
        ],
      ),
    );
  }

  Widget _buildSelectedPlanBreakdown(BuildContext context, EmiPlanModel plan) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: AppColors.surfaceLight,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Plan Breakdown (${plan.tenureDisplay})',
                style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w700, color: AppColors.textDark),
              ),
              InkWell(
                onTap: () {
                  showModalBottomSheet(
                    context: context,
                    isScrollControlled: true,
                    backgroundColor: Colors.transparent,
                    builder: (_) => RepaymentScheduleModal(plan: plan),
                  );
                },
                child: const Text(
                  'View Amortization Schedule >',
                  style: TextStyle(
                    fontSize: 11,
                    fontWeight: FontWeight.w700,
                    color: AppColors.primaryDark,
                  ),
                ),
              ),
            ],
          ),
          const Divider(height: 16),
          _buildBreakdownRow('Monthly Installment', Formatters.formatCurrency(plan.monthlyEmi), isBold: true),
          const SizedBox(height: 4),
          _buildBreakdownRow('Principal Amount', Formatters.formatCurrency(plan.principalAmount)),
          const SizedBox(height: 4),
          _buildBreakdownRow(
            'Interest Charges',
            plan.isNoCost ? '₹0 (1Fi 0% Subvention)' : Formatters.formatCurrency(plan.totalInterest),
            valueColor: plan.isNoCost ? AppColors.success : null,
          ),
          const SizedBox(height: 4),
          _buildBreakdownRow(
            'Processing Fee',
            plan.processingFee == 0 ? 'FREE' : Formatters.formatCurrency(plan.processingFee),
            valueColor: plan.processingFee == 0 ? AppColors.success : null,
          ),
          const Divider(height: 16),
          _buildBreakdownRow(
            'Total Payable Amount',
            Formatters.formatCurrency(plan.totalPayable),
            isBold: true,
            valueColor: AppColors.textDark,
          ),
        ],
      ),
    );
  }

  Widget _buildBreakdownRow(String label, String value, {bool isBold = false, Color? valueColor}) {
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

  Widget _buildCreditLimitBanner(ProductDetailProvider provider) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        gradient: AppColors.cardGradientDark,
        borderRadius: BorderRadius.circular(14),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: AppColors.primary.withAlpha(30),
              shape: BoxShape.circle,
            ),
            child: const Icon(Icons.shield_rounded, color: AppColors.primary, size: 20),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  '1Fi Credit Limit Available: ₹2,50,000',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 13,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  'Your order of ${Formatters.formatCurrency(provider.currentPrice)} qualifies for instant zero down payment approval.',
                  style: TextStyle(
                    color: Colors.white.withAlpha(180),
                    fontSize: 11,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDeliveryChecker(ProductDetailProvider provider) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: AppColors.borderLight),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Delivery & Availability',
            style: TextStyle(fontSize: 14, fontWeight: FontWeight.w700, color: AppColors.textDark),
          ),
          const SizedBox(height: 10),
          Row(
            children: [
              Expanded(
                child: SizedBox(
                  height: 42,
                  child: TextField(
                    controller: _pincodeController,
                    keyboardType: TextInputType.number,
                    maxLength: 6,
                    decoration: const InputDecoration(
                      hintText: 'Enter 6-digit PIN code',
                      counterText: '',
                      contentPadding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 8),
              SizedBox(
                height: 42,
                child: ElevatedButton(
                  onPressed: () => provider.checkPincode(_pincodeController.text),
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                  ),
                  child: const Text('Check', style: TextStyle(fontSize: 13)),
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Row(
            children: [
              Icon(
                provider.isPincodeValid ? Icons.check_circle_rounded : Icons.error_rounded,
                size: 16,
                color: provider.isPincodeValid ? AppColors.success : AppColors.error,
              ),
              const SizedBox(width: 6),
              Text(
                provider.pincodeDeliveryText,
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                  color: provider.isPincodeValid ? AppColors.success : AppColors.error,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildHighlights(ProductModel product) {
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
          const Text(
            'Key Highlights',
            style: TextStyle(fontSize: 15, fontWeight: FontWeight.w800, color: AppColors.textDark),
          ),
          const SizedBox(height: 12),
          ...product.highlights.map((h) {
            return Padding(
              padding: const EdgeInsets.only(bottom: 8),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Icon(Icons.check_circle_outline_rounded, size: 16, color: AppColors.primary),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      h,
                      style: const TextStyle(fontSize: 13, color: AppColors.textDark, height: 1.3),
                    ),
                  ),
                ],
              ),
            );
          }),
        ],
      ),
    );
  }

  Widget _buildSpecifications(ProductModel product) {
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
          const Text(
            'Product Specifications',
            style: TextStyle(fontSize: 15, fontWeight: FontWeight.w800, color: AppColors.textDark),
          ),
          const SizedBox(height: 12),
          ...product.specifications.entries.map((e) {
            return Padding(
              padding: const EdgeInsets.symmetric(vertical: 6),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    flex: 2,
                    child: Text(
                      e.key,
                      style: const TextStyle(fontSize: 12, color: AppColors.textMuted, fontWeight: FontWeight.w600),
                    ),
                  ),
                  Expanded(
                    flex: 3,
                    child: Text(
                      e.value,
                      style: const TextStyle(fontSize: 12, color: AppColors.textDark, fontWeight: FontWeight.w600),
                    ),
                  ),
                ],
              ),
            );
          }),
        ],
      ),
    );
  }

  Widget _buildStickyBottomBar(BuildContext context, ProductDetailProvider provider) {
    final selectedPlan = provider.selectedEmiPlan;

    return Container(
      padding: EdgeInsets.only(
        left: 16,
        right: 16,
        top: 12,
        bottom: MediaQuery.of(context).padding.bottom + 12,
      ),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withAlpha(15),
            blurRadius: 10,
            offset: const Offset(0, -3),
          ),
        ],
      ),
      child: Row(
        children: [
          Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                Formatters.formatCurrency(selectedPlan.monthlyEmi),
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w900,
                  color: AppColors.textDark,
                ),
              ),
              Text(
                'for ${selectedPlan.tenureMonths} Months (${selectedPlan.isNoCost ? '0% Interest' : '${selectedPlan.annualInterestRate}%'})',
                style: const TextStyle(
                  fontSize: 11,
                  fontWeight: FontWeight.w600,
                  color: AppColors.primaryDark,
                ),
              ),
            ],
          ),
          const SizedBox(width: 16),
          Expanded(
            child: ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => CheckoutScreen(
                      product: provider.product,
                      selectedColor: provider.selectedColor,
                      selectedStorage: provider.selectedStorage,
                      finalPrice: provider.currentPrice,
                      emiPlan: selectedPlan,
                    ),
                  ),
                );
              },
              child: Text('Proceed with ${selectedPlan.tenureMonths}M Plan'),
            ),
          ),
        ],
      ),
    );
  }
}
