import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../../providers/marketplace_provider.dart';
import '../../../../theme/app_colors.dart';
import '../../../../utils/formatters.dart';

class FilterSheet extends StatefulWidget {
  const FilterSheet({super.key});

  @override
  State<FilterSheet> createState() => _FilterSheetState();
}

class _FilterSheetState extends State<FilterSheet> {
  late String _selectedBrand;
  late RangeValues _priceRange;
  late bool _noCostOnly;
  late String _sortBy;

  @override
  void initState() {
    super.initState();
    final provider = context.read<MarketplaceProvider>();
    _selectedBrand = provider.selectedBrand;
    _priceRange = RangeValues(provider.minPrice, provider.maxPrice);
    _noCostOnly = provider.noCostEmiOnly;
    _sortBy = provider.sortBy;
  }

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<MarketplaceProvider>();

    return Container(
      padding: EdgeInsets.only(
        left: 20,
        right: 20,
        top: 20,
        bottom: MediaQuery.of(context).viewInsets.bottom + 20,
      ),
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Filter & Sort',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w800,
                  color: AppColors.textDark,
                ),
              ),
              TextButton(
                onPressed: () {
                  setState(() {
                    _selectedBrand = 'All Brands';
                    _priceRange = const RangeValues(0, 250000);
                    _noCostOnly = false;
                    _sortBy = 'default';
                  });
                },
                child: const Text(
                  'Reset All',
                  style: TextStyle(
                    color: AppColors.error,
                    fontWeight: FontWeight.w700,
                    fontSize: 13,
                  ),
                ),
              ),
            ],
          ),

          const Divider(height: 24),

          // Sort By
          const Text(
            'Sort By',
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w700,
              color: AppColors.textDark,
            ),
          ),
          const SizedBox(height: 8),
          Wrap(
            spacing: 8,
            children: [
              _buildChoiceChip('Recommended', 'default', _sortBy, (val) => setState(() => _sortBy = val)),
              _buildChoiceChip('Price: Low to High', 'price_low_high', _sortBy, (val) => setState(() => _sortBy = val)),
              _buildChoiceChip('Price: High to Low', 'price_high_low', _sortBy, (val) => setState(() => _sortBy = val)),
              _buildChoiceChip('Customer Rating', 'rating', _sortBy, (val) => setState(() => _sortBy = val)),
              _buildChoiceChip('Lowest EMI', 'emi_low_high', _sortBy, (val) => setState(() => _sortBy = val)),
            ],
          ),

          const SizedBox(height: 16),

          // Price Range Slider
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Price Range',
                style: TextStyle(fontSize: 14, fontWeight: FontWeight.w700, color: AppColors.textDark),
              ),
              Text(
                '${Formatters.formatCurrency(_priceRange.start)} - ${Formatters.formatCurrency(_priceRange.end)}',
                style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w700, color: AppColors.primaryDark),
              ),
            ],
          ),
          RangeSlider(
            values: _priceRange,
            min: 0,
            max: 250000,
            divisions: 25,
            activeColor: AppColors.primary,
            inactiveColor: AppColors.borderLight,
            onChanged: (values) {
              setState(() {
                _priceRange = values;
              });
            },
          ),

          const SizedBox(height: 12),

          // Brands
          const Text(
            'Brand',
            style: TextStyle(fontSize: 14, fontWeight: FontWeight.w700, color: AppColors.textDark),
          ),
          const SizedBox(height: 8),
          Wrap(
            spacing: 8,
            children: provider.brands.map((b) {
              return _buildChoiceChip(b, b, _selectedBrand, (val) => setState(() => _selectedBrand = val));
            }).toList(),
          ),

          const SizedBox(height: 14),

          // No Cost EMI toggle
          SwitchListTile(
            contentPadding: EdgeInsets.zero,
            title: const Text(
              'Only Show 0% No Cost EMI',
              style: TextStyle(fontSize: 14, fontWeight: FontWeight.w700, color: AppColors.textDark),
            ),
            subtitle: const Text(
              'Zero interest & zero downpayment offers',
              style: TextStyle(fontSize: 12, color: AppColors.textMedium),
            ),
            value: _noCostOnly,
            activeThumbColor: AppColors.primary,
            onChanged: (val) {
              setState(() {
                _noCostOnly = val;
              });
            },
          ),

          const SizedBox(height: 20),

          // Apply Button
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () {
                provider.setBrand(_selectedBrand);
                provider.setPriceRange(_priceRange.start, _priceRange.end);
                provider.setNoCostEmiOnly(_noCostOnly);
                provider.setSortBy(_sortBy);
                Navigator.pop(context);
              },
              child: const Text('Apply Filters'),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildChoiceChip(String label, String value, String selectedValue, Function(String) onSelected) {
    final isSelected = value == selectedValue;
    return ChoiceChip(
      label: Text(
        label,
        style: TextStyle(
          fontSize: 12,
          fontWeight: isSelected ? FontWeight.w700 : FontWeight.w500,
          color: isSelected ? Colors.white : AppColors.textDark,
        ),
      ),
      selected: isSelected,
      selectedColor: AppColors.textDark,
      backgroundColor: Colors.white,
      side: BorderSide(
        color: isSelected ? AppColors.textDark : AppColors.borderLight,
      ),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      onSelected: (_) => onSelected(value),
    );
  }
}
