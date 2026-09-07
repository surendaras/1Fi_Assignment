import 'package:flutter/material.dart';
import '../models/product_model.dart';
import '../models/variant_model.dart';
import '../models/emi_plan_model.dart';
import '../services/emi_calculator_service.dart';

class ProductDetailProvider with ChangeNotifier {
  final ProductModel product;

  late ColorVariant _selectedColor;
  late StorageVariant _selectedStorage;
  late List<EmiPlanModel> _emiPlans;
  late EmiPlanModel _selectedEmiPlan;

  int _selectedImageIndex = 0;
  String _pincode = '560001';
  bool _isPincodeValid = true;
  String _pincodeDeliveryText = 'Fast Delivery by Tomorrow, 5 PM';

  ProductDetailProvider({required this.product}) {
    _selectedColor = product.colors.isNotEmpty 
        ? product.colors.first 
        : const ColorVariant(id: 'c1', name: 'Default', colorCode: Color(0xFF000000));
    
    _selectedStorage = product.storageOptions.isNotEmpty
        ? product.storageOptions.first
        : const StorageVariant(id: 's1', label: 'Standard');

    _calculatePlans();
  }

  // Getters
  ColorVariant get selectedColor => _selectedColor;
  StorageVariant get selectedStorage => _selectedStorage;
  List<EmiPlanModel> get emiPlans => _emiPlans;
  EmiPlanModel get selectedEmiPlan => _selectedEmiPlan;
  int get selectedImageIndex => _selectedImageIndex;
  String get pincode => _pincode;
  bool get isPincodeValid => _isPincodeValid;
  String get pincodeDeliveryText => _pincodeDeliveryText;

  double get currentPrice {
    return product.discountedPrice + _selectedStorage.priceDelta;
  }

  double get currentBasePrice {
    return product.basePrice + _selectedStorage.priceDelta;
  }

  int get currentDiscountPercentage {
    if (currentBasePrice <= 0 || currentPrice >= currentBasePrice) return 0;
    return (((currentBasePrice - currentPrice) / currentBasePrice) * 100).round();
  }

  void _calculatePlans() {
    _emiPlans = EmiCalculatorService.calculateAllPlans(currentPrice);
    // Default select the 6-Month plan or 1st plan
    _selectedEmiPlan = _emiPlans.length > 1 ? _emiPlans[1] : _emiPlans.first;
  }

  void selectColor(ColorVariant color) {
    if (_selectedColor.id != color.id) {
      _selectedColor = color;
      notifyListeners();
    }
  }

  void selectStorage(StorageVariant storage) {
    if (_selectedStorage.id != storage.id) {
      final currentTenure = _selectedEmiPlan.tenureMonths;
      _selectedStorage = storage;
      
      // Recalculate EMI plans based on new variant price
      _calculatePlans();

      // Maintain tenure if possible
      try {
        _selectedEmiPlan = _emiPlans.firstWhere((p) => p.tenureMonths == currentTenure);
      } catch (_) {
        _selectedEmiPlan = _emiPlans.first;
      }

      notifyListeners();
    }
  }

  void selectEmiPlan(EmiPlanModel plan) {
    _selectedEmiPlan = plan;
    notifyListeners();
  }

  void setSelectedImageIndex(int index) {
    _selectedImageIndex = index;
    notifyListeners();
  }

  void checkPincode(String inputPincode) {
    _pincode = inputPincode.trim();
    if (_pincode.length == 6 && int.tryParse(_pincode) != null) {
      _isPincodeValid = true;
      _pincodeDeliveryText = 'Delivery guaranteed in 2-3 days to $_pincode';
    } else {
      _isPincodeValid = false;
      _pincodeDeliveryText = 'Please enter a valid 6-digit PIN code';
    }
    notifyListeners();
  }
}
