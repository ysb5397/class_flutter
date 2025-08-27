import 'package:tosspayments_widget_sdk_flutter/model/payment_info.dart';
import 'package:tosspayments_widget_sdk_flutter/model/payment_widget_options.dart';

class PaymentInfo {
  final String orderId;
  final String orderName;
  final String? customerEmail;
  final String? customerName;
  final String? appScheme;
  final num? taxFreeAmount;
  final String? taxExemptionAmount;
  final bool? cultureExpense;
  final bool? useEscrow;
  final bool? useInternationalCardOnly;
  final List<EscrowProduct>? escrowProducts;
  final String? customerMobilePhone;
  final bool? showCustomerMobilePhone;
  final List<String>? mobileCarrier;
  final List<Product>? products;
  final Shipping? shipping;
  final PaymentMethodOptions? paymentMethodOptions;
  final Map<String, String>? metadata;

  PaymentInfo(this.orderId, this.orderName,
      {this.customerEmail,
      this.customerName,
      this.appScheme,
      this.taxFreeAmount,
      this.taxExemptionAmount,
      this.cultureExpense,
      this.useEscrow,
      this.useInternationalCardOnly,
      this.escrowProducts,
      this.customerMobilePhone,
      this.showCustomerMobilePhone,
      this.mobileCarrier,
      this.products,
      this.shipping,
      this.paymentMethodOptions,
      this.metadata});
}
