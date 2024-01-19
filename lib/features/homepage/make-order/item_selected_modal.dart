import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:fyp/enums/crud_type.dart';
import 'package:fyp/features/homepage/payment/make_order_and_payment.dart';
import 'package:fyp/model/foodmgmt/Food_menu_item_with_image.dart';

import '../../../podo/foodmgmt/food_ordering_details.dart';
import '../select-to-order/edit_order_items.dart';

//  void openModalButtonSheet(
//     BuildContext context,
//     List<FoodOrderingDetails> details,
//     Function(int, int, ActionType) callback) {
//   bool isOrdering = false;
//   showModalBottomSheet(
//       context: context,
//       builder: (context) => isOrdering
//           // ? makePaymentAndOrder()
//           ? MakeOrderAndPayment()
//           :  EditOrderItems(details: details, callback: callback, payCallback: (boo) => {isOrdering = boo}));
//           // : selectItemSheet(context, details, callback));
// }

void openModalButtonSheet(
    BuildContext context,
    List<FoodOrderingDetails> details,
    Function(int, int, ActionType) callback) {
  bool isOrdering = false;
  showModalBottomSheet(
    context: context,
    builder: (context) => StatefulBuilder(
      builder: (context, setState) {
        return isOrdering
            ? MakeOrderAndPayment(details: details)
            : EditOrderItems(
                details: details,
                callback: callback,
                payCallback: (boo) => {setState(() => isOrdering = boo)});
      },
    ),
  );
}
