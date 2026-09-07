import 'product_model.dart';
import 'variant_model.dart';
import 'emi_plan_model.dart';

enum OrderStatus {
  confirmed,
  processing,
  dispatched,
  delivered
}

class OrderModel {
  final String orderId;
  final String loanReferenceId;
  final ProductModel product;
  final ColorVariant selectedColor;
  final StorageVariant selectedStorage;
  final double finalPrice;
  final EmiPlanModel emiPlan;
  final DateTime orderDate;
  final String deliveryAddress;
  final OrderStatus status;
  final String mandateBank;
  final String mandateAccountMasked;

  OrderModel({
    required this.orderId,
    required this.loanReferenceId,
    required this.product,
    required this.selectedColor,
    required this.selectedStorage,
    required this.finalPrice,
    required this.emiPlan,
    required this.orderDate,
    required this.deliveryAddress,
    this.status = OrderStatus.confirmed,
    required this.mandateBank,
    required this.mandateAccountMasked,
  });
}
