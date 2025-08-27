import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:tosspayments_widget_sdk_flutter/model/payment_info.dart';
import 'package:tosspayments_widget_sdk_flutter/model/payment_widget_options.dart';
import 'package:tosspayments_widget_sdk_flutter/model/tosspayments_result.dart';
import 'package:tosspayments_widget_sdk_flutter/payment_widget.dart';
import 'package:tosspayments_widget_sdk_flutter/widgets/agreement.dart';
import 'package:tosspayments_widget_sdk_flutter/widgets/payment_method.dart';
import 'package:uuid/uuid.dart';

class TossPurchaseScreen extends StatefulWidget {
  const TossPurchaseScreen({super.key});

  @override
  State<TossPurchaseScreen> createState() => _TossPurchaseScreenState();
}

class _TossPurchaseScreenState extends State<TossPurchaseScreen> {
  late PaymentWidget _paymentWidget;
  PaymentMethodWidgetControl? _paymentMethodWidgetControl;
  AgreementWidgetControl? _agreementWidgetControl;
  late String orderId;
  Dio dio = Dio();

  @override
  void initState() {
    super.initState();

    _paymentWidget = PaymentWidget(
      clientKey: "",
      customerKey: "DMUzsqymWLbBDXb2x6pe0",
      // 결제위젯에 브랜드페이 추가하기
      // paymentWidgetOptions: PaymentWidgetOptions(brandPayOption: BrandPayOption("리다이렉트 URL")) // Access Token 발급에 사용되는 리다이렉트 URL
    );

    _paymentWidget
        .renderPaymentMethods(
            selector: 'purchase',
            amount: Amount(value: 5000, currency: Currency.KRW, country: "KR"),
            options: RenderPaymentMethodsOptions(variantKey: "DEFAULT"))
        .then((control) {
      _paymentMethodWidgetControl = control;
    });

    _paymentWidget.renderAgreement(selector: 'agreement').then((control) {
      _agreementWidgetControl = control;
    });

    orderId = Uuid().v4();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            PaymentMethodWidget(
                paymentWidget: _paymentWidget, selector: "purchase"),
            TextButton(
                onPressed: () async {
                  final response = await _paymentWidget.requestPayment(
                      paymentInfo:
                          PaymentInfo(orderId: orderId, orderName: "만두"));

                  print("결제 응답 : ${response.success}");
                  if (response.success != null) {
                    _checkConfirm(response.success!);
                  }
                },
                child: Text("결제하기")),
          ],
        ),
      ),
    );
  }

  Future<dynamic> _checkConfirm(Success success) async {
    final requestData = {
      "paymentKey": success.paymentKey ?? "",
      "orderId": success.orderId ?? "",
      "amount": success.amount ?? 0
    };

    final response = await dio.post("http://192.168.0.78:8080/api/test",
        data: json.encode(requestData));
    print(response);
    return response;
  }
}
