import 'package:flutter/material.dart';
import 'package:fyp/constants/designing/colors.dart';
import 'package:fyp/enums/pay_status.dart';
import 'package:fyp/features/landing-screen/landing-screen-service/landing_screen_constants.dart';
import 'package:fyp/podo/foodmgmt/food_order_response.dart';
import 'package:fyp/podo/orders/online-order/online_order_response.dart';
import 'package:fyp/podo/orders/onsite-order/onsite_order_response.dart';
import 'package:fyp/services/order-services/online_order_service.dart';
import 'package:fyp/services/order-services/onsite_order_service.dart';
import 'package:fyp/services/payment/payment_service.dart';
import 'package:fyp/templates/button/default_button.dart';

import '../../../constants/api-constant.dart';
import '../../../podo/foodmgmt/food_ordering_details.dart';
import '../khati_dart.dart';
import '../qr_scanner.dart';

class MakeOrderAndPayment extends StatefulWidget {
  final List<FoodOrderingDetails> details;
  const MakeOrderAndPayment({super.key, required this.details});

  @override
  State<MakeOrderAndPayment> createState() => _MakeOrderAndPaymentState();
}

class _MakeOrderAndPaymentState extends State<MakeOrderAndPayment> {
  PaymentService paymentService = PaymentService();
  late OnsiteOrderService onsiteOrderService;
  late OnlineOrderService onlineOrderService;

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
  void initState() {
    super.initState();
    onsiteOrderService = OnsiteOrderService(context);
    onlineOrderService = OnlineOrderService(context);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      child: Column(
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
                    // await QrScanner.showForQr(context, (String text) {
                    //   setState(() {
                    //     if (text.isNotEmpty) {
                    //       tableNumber = text;
                    //       isVerified = true;
                    //     } else {
                    //       isVerified = false;
                    //     }
                    //   });
                    // });

                    setState(() {
                      tableNumber = 10.toString();
                      isVerified = true;
                    });
                  },
                  child: Card(
                      child: Container(
                          decoration: !isOnlineOrder
                              ? BoxDecoration(
                                  border: Border.all(
                                  color: Colors.red, // Border color
                                  width: 2, // Border width
                                ))
                              : null,
                          height: 50,
                          child: Center(child: Text("On-site")))),
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
                  child: Card(
                      child: Container(
                          decoration: isOnlineOrder
                              ? BoxDecoration(
                                  border: Border.all(
                                  color: Colors.red, // Border color
                                  width: 2, // Border width
                                ))
                              : null,
                          height: 50,
                          child: Center(child: Text("Online")))),
                ),
              )
            ],
          ),
          const SizedBox(
            height: 10,
          ),
          (isVerified == null)
              ? const SizedBox(width: 0.0, height: 0.0)
              : (isVerified == true)
                  ? DefaultButton(
                      text: "Make Order",
                      onPressed: () async {
                        OnsiteOrderResponse onsiteOrderResponse =
                            OnsiteOrderResponse(
                                foodOrderList: getFoodOrderList(widget.details),
                                payStatus: PayStatus.UNPAID,
                                tableNumber: int.parse(tableNumber),
                                totalPrice: getTotalCostAmount());
                        // onsiteOrderService
                        //     .makeOnsiteOrder(onsiteOrderResponse.toJson())
                        //     .then((value) {
                        //   if (value) {
                        //     Navigator.pop(context);
                        //   }
                        // });

                        try {
                          bool statusBoolean = await onsiteOrderService
                              .makeOnsiteOrder(onsiteOrderResponse.toJson());
                          if (statusBoolean) {
                            Navigator.pop(context);
                          } else {
                            // Handle case where order was not successfully made
                            // You can show an error message to the user or take appropriate action.
                          }
                        } catch (e) {
                          // Handle exceptions thrown by makeOnsiteOrder
                          print('Error making onsite order: $e');
                          // You can show an error message to the user or take appropriate action.
                        }
                      },
                    )
                  : const Text(
                      "Data from QR didn't matches with on-ste vetification"),
          isOnlineOrder
              ? ElevatedButton(
                  style: ButtonStyle(
                      side: MaterialStateProperty.all(const BorderSide(
                        color: CustomColors.defaultRedColor,
                        width: 1.0,
                        style: BorderStyle.solid,
                      )),
                      backgroundColor: MaterialStateProperty.all(Colors.white),
                      elevation: MaterialStateProperty.all(0)),
                  onPressed: () {
                    _selectTime(context);
                  },
                  child: Text(
                    selectedTime == null
                        ? "Click to select time"
                        : getStringConvertedTime(selectedTime),
                    style: const TextStyle(color: CustomColors.defaultRedColor),
                  ))
              : const SizedBox(width: 0.0, height: 0.0),
          const SizedBox(
            height: 10,
          ),
          selectedTime != null
              ? DefaultButton(
                  text: "Make Order",
                  onPressed: () {
                    OnlineOrderResponse onlineOrderResponse =
                        OnlineOrderResponse(
                            foodOrderList: getFoodOrderList(widget.details),
                            arrivalTime: getStringConvertedTime(selectedTime) ??
                                "hello");

                    onlineOrderService
                        .makeOnlineOrder(onlineOrderResponse.toJson());
                  },
                )
              : const SizedBox(width: 0.0, height: 0.0)
        ],
      ),
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

  double getTotalCostAmount() {
    return widget.details
        .map((element) => element.foodMenu.cost * element.quantity)
        .toList() // Convert Iterable to List
        .fold(0, (prev, curr) => prev + curr);
  }

  String getStringConvertedTime(TimeOfDay? selectedTime) {
    return "${selectedTime?.hour.toString().padLeft(2, '0') ?? '00'}:${selectedTime?.minute.toString().padLeft(2, '0') ?? '00'}";
  }
}
