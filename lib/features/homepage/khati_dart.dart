import 'package:auto_route/annotations.dart';
import 'package:flutter/material.dart';
import 'package:fyp/podo/foodmgmt/onsite_order_response.dart';
import 'package:fyp/services/order-services/onsite_order_service.dart';
import 'package:khalti_flutter/khalti_flutter.dart';
import 'package:fyp/services/payment/payment_service.dart';

payWithKhaltiInApp(
    BuildContext context,
    PaymentService paymentService,
    OnsiteOrderService onsiteOrderService,
    Map<String, dynamic> response) async {
  KhaltiScope.of(context).pay(
    config: PaymentConfig(
      amount: 1000,
      //in paisa
      productIdentity: 'Product Id',
      productName: 'Product Name',
      mobileReadOnly: false,
      mobile: '9810527260',
    ),
    preferences: [
      PaymentPreference.khalti,
    ],
    onSuccess: (success) async {
      Map<String, dynamic> map = {
        "token": success.token,
        "amount": success.amount
      };
      await paymentService.verifyTransaction(map);
      await onsiteOrderService.makeOnsiteOrder(response);
      onSuccess(context, success);
    },
    onFailure: onFailure,
    onCancel: onCancel,
  );
}

void onSuccess(
  BuildContext context,
  PaymentSuccessModel success,
) async {
  showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        title: const Text('Order has been placed successfully.'),
        actions: [
          SimpleDialogOption(
              child: const Text('OK'),
              onPressed: () {
                Navigator.pop(context);
              })
        ],
      );
    },
  );
}

void onFailure(PaymentFailureModel failure) {
  debugPrint(
    failure.toString(),
  );
}

void onCancel() {
  print("here it is");
  debugPrint('Cancelled');
}
