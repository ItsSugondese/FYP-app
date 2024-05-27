import 'package:flutter/material.dart';
import 'package:fyp/enums/crud_type.dart';
import 'package:fyp/features/homepage/payment/make_order_and_payment.dart';

import '../../../podo/foodmgmt/food_ordering_details.dart';

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

// void openModalButtonSheet(
//     BuildContext context,
//     List<FoodOrderingDetails> details,
//     Function(int, int, ActionType) callback) {
//   bool isOrdering = false;
//   showModalBottomSheet(
//     isScrollControlled: true,
//     context: context,
//     builder: (context) => StatefulBuilder(
//       builder: (context, setState) {
//         return isOrdering
//             ? MakeOrderAndPayment(details: details)
//             : EditOrderItems(
//                 details: details,
//                 callback: callback,
//                 payCallback: (boo) => {setState(() => isOrdering = boo)});
//       },
//     ),
//   );
// }

void openModalButtonSheet(BuildContext context,
    List<FoodOrderingDetails> details, Function(int) callback) {
  showModalBottomSheet(
    context: context,
    builder: (context) => StatefulBuilder(builder: (context, setState) {
      return MakeOrderAndPayment(
          details: details,
          callback: (val) {
            Navigator.pop(context);
            callback(val);
          });
    }),
  );
}
