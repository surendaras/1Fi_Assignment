import 'dart:math';
import 'package:flutter/foundation.dart';
import '../models/product_model.dart';
import '../models/variant_model.dart';
import '../models/emi_plan_model.dart';
import '../models/order_model.dart';

class CheckoutProvider with ChangeNotifier {
  double _availableCreditLimit = 250000.0;
  final List<OrderModel> _orderHistory = [];

  bool _isProcessing = false;
  String? _checkoutError;

  // Selected payment / mandate method
  String _selectedBank = 'HDFC Bank';
  final String _bankAccountNumber = 'XXXX-XXXX-8921';
  String _deliveryAddress = 'Flat 402, Prestige Tower, Indiranagar, Bangalore - 560038';

  // Getters
  double get availableCreditLimit => _availableCreditLimit;
  List<OrderModel> get orderHistory => _orderHistory;
  bool get isProcessing => _isProcessing;
  String? get checkoutError => _checkoutError;
  String get selectedBank => _selectedBank;
  String get bankAccountNumber => _bankAccountNumber;
  String get deliveryAddress => _deliveryAddress;

  final List<String> supportedBanks = [
    'HDFC Bank',
    'ICICI Bank',
    'State Bank of India',
    'Axis Bank',
    'Kotak Mahindra Bank',
  ];

  void setBank(String bank) {
    _selectedBank = bank;
    notifyListeners();
  }

  void setAddress(String address) {
    _deliveryAddress = address;
    notifyListeners();
  }

  Future<OrderModel?> placeEmiOrder({
    required ProductModel product,
    required ColorVariant color,
    required StorageVariant storage,
    required double finalPrice,
    required EmiPlanModel emiPlan,
  }) async {
    _isProcessing = true;
    _checkoutError = null;
    notifyListeners();

    try {
      // Simulate credit check & mandate authorization
      await Future.delayed(const Duration(seconds: 2));

      if (finalPrice > _availableCreditLimit) {
        throw Exception('Product price exceeds available 1Fi Credit Limit (₹${_availableCreditLimit.toStringAsFixed(0)}).');
      }

      // Deduct from available limit
      _availableCreditLimit -= finalPrice;

      // Create Order
      final random = Random();
      final orderId = '1FI-ORD-${random.nextInt(899999) + 100000}';
      final loanRefId = '1FI-LN-${random.nextInt(899999) + 100000}';

      final order = OrderModel(
        orderId: orderId,
        loanReferenceId: loanRefId,
        product: product,
        selectedColor: color,
        selectedStorage: storage,
        finalPrice: finalPrice,
        emiPlan: emiPlan,
        orderDate: DateTime.now(),
        deliveryAddress: _deliveryAddress,
        mandateBank: _selectedBank,
        mandateAccountMasked: _bankAccountNumber,
      );

      _orderHistory.insert(0, order);
      _isProcessing = false;
      notifyListeners();
      return order;
    } catch (e) {
      _checkoutError = e.toString().replaceAll('Exception: ', '');
      _isProcessing = false;
      notifyListeners();
      return null;
    }
  }
}
