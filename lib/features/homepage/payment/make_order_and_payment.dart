import 'package:flutter/material.dart';
import 'package:fyp/enums/pay_status.dart';
import 'package:fyp/podo/foodmgmt/food_order_response.dart';
import 'package:fyp/podo/foodmgmt/online_order_response.dart';
import 'package:fyp/podo/foodmgmt/onsite_order_response.dart';
import 'package:fyp/services/order-services/online_order_service.dart';
import 'package:fyp/services/order-services/onsite_order_service.dart';
import 'package:fyp/services/payment/payment_service.dart';

import '../../../constants/api-constant.dart';
import '../../../podo/foodmgmt/food_ordering_details.dart';
import '../khati_dart.dart';
import '../qr_scanner.dart';

class MakeOrderAndPayment extends StatefulWidget {
  List<FoodOrderingDetails> details;
  MakeOrderAndPayment({required this.details});

  @override
  State<MakeOrderAndPayment> createState() => _MakeOrderAndPaymentState();
}

class _MakeOrderAndPaymentState extends State<MakeOrderAndPayment> {
  PaymentService paymentService = PaymentService();
  OnsiteOrderService onsiteOrderService = OnsiteOrderService();

  bool? isVerified;
  bool isOnlineOrder = false;
  bool payUsingCash = false;
  String tableNumber = "";

  TimeOfDay? selectedTime;

  Future<void> _selectTime(BuildContext context) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: selectedTime ?? TimeOfDay.now(),
    );
    if (picked != null && picked != selectedTime) {
      setState(() {
        selectedTime = picked;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Expanded(
              child: GestureDetector(
                onTap: () async {
                  setState(() {
                    isOnlineOrder = false;
                    selectedTime = null;
                  });
                  await QrScanner.showForQr(context, (String text) {
                    setState(() {
                      if (text.isNotEmpty) {
                        tableNumber = text;
                        isVerified = true;
                      } else {
                        isVerified = false;
                      }
                    });
                  });
                },
                child: const Card(
                    child: SizedBox(
                        height: 50, child: Center(child: Text("On-site")))),
              ),
            ),
            Expanded(
              child: GestureDetector(
                onTap: () {
                  setState(() {
                    isOnlineOrder = true;
                    isVerified = null;
                    payUsingCash = false;
                  });
                },
                child: const Card(
                    child: SizedBox(
                        height: 50, child: Center(child: Text("Online")))),
              ),
            )
          ],
        ),
        (isVerified == null)
            ? const SizedBox(width: 0.0, height: 0.0)
            : (isVerified == true)
                ? Row(
                    children: [
                      Expanded(
                        child: InkWell(
                          onTap: () {
                            OnsiteOrderResponse onsiteOrderResponse =
                                OnsiteOrderResponse(
                                    foodOrderList:
                                        getFoodOrderList(widget.details),
                                    payStatus: PayStatus.PAID,
                                    tableNumber: int.parse(tableNumber));
                            payWithKhaltiInApp(
                                context,
                                paymentService,
                                onsiteOrderService,
                                onsiteOrderResponse.toJson());
                          },
                          child: const Card(
                              child: SizedBox(
                                  height: 50,
                                  child:
                                      Center(child: Text("Pay with Khalti")))),
                        ),
                      ),
                      Expanded(
                        child: GestureDetector(
                          onTap: () {
                            setState(() {
                              payUsingCash = true;
                            });
                            OnsiteOrderResponse onsiteOrderResponse =
                                OnsiteOrderResponse(
                                    foodOrderList:
                                        getFoodOrderList(widget.details),
                                    payStatus: PayStatus.UNPAID,
                                    tableNumber: int.parse(tableNumber));
                            onsiteOrderService
                                .makeOnsiteOrder(onsiteOrderResponse.toJson());
                          },
                          child: const Card(
                              child: SizedBox(
                                  height: 50,
                                  child: Center(child: Text("Pay with cash")))),
                        ),
                      )
                    ],
                  )
                : const Text(
                    "Data from QR didn't matches with on-ste vetification"),
        payUsingCash
            ? ElevatedButton(onPressed: () {}, child: Text("Make order"))
            : const SizedBox(width: 0.0, height: 0.0),
        isOnlineOrder
            ? ElevatedButton(
                onPressed: () {
                  _selectTime(context);
                },
                child: Text(selectedTime == null
                    ? "__ : __ "
                    : getStringConvertedTime(selectedTime)))
            : const SizedBox(width: 0.0, height: 0.0),
        selectedTime != null
            ? ElevatedButton(
                onPressed: () {
                  OnlineOrderService onlineOrderService = OnlineOrderService();
                  OnlineOrderResponse onlineOrderResponse = OnlineOrderResponse(
                      foodOrderList: getFoodOrderList(widget.details),
                      arrivalTime:
                          getStringConvertedTime(selectedTime) ?? "hello");

                  onlineOrderService
                      .makeOnlineOrder(onlineOrderResponse.toJson());
                },
                child: Text("Make Order"))
            : const SizedBox(width: 0.0, height: 0.0)
      ],
    );
  }

  List<FoodOrderResponse> getFoodOrderList(List<FoodOrderingDetails> details) {
    List<FoodOrderResponse> foodOrderList = details.map((element) {
      return FoodOrderResponse(
        foodId: element.foodMenu.id,
        quantity: element.quantity,
      );
    }).toList();

    return foodOrderList;
  }

  String getStringConvertedTime(TimeOfDay? selectedTime) {
    return "${selectedTime?.hour.toString().padLeft(2, '0') ?? '00'}:${selectedTime?.minute.toString().padLeft(2, '0') ?? '00'}";
  }
}
