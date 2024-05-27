import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:fyp/features/homepage/make-order/item_selected_modal.dart';
import 'package:fyp/model/foodmgmt/food_menu.dart';
import '../../../model/foodmgmt/Food_menu_item_with_image.dart';
import '../../../podo/foodmgmt/food_ordering_details.dart';
import 'package:fyp/enums/crud_type.dart';
import 'package:fyp/constants/designing/colors.dart';
import 'package:fyp/constants/designing/dimension.dart';
import 'package:fyp/constants/designing/image_path.dart';
import 'package:fyp/constants/designing/screen_name.dart';
import 'package:fyp/templates/counter/counter_button.dart';

import '../payment/make_order_and_payment.dart';

class EditOrderItems extends StatefulWidget {
  final List<FoodOrderingDetails> details;
  final Function(int, int, ActionType) callback;
  final Function(int) orderCallback;
  const EditOrderItems(
      {super.key,
      required this.details,
      required this.callback,
      required this.orderCallback});

  @override
  State<EditOrderItems> createState() => _EditOrderItemsState();
}

class _EditOrderItemsState extends State<EditOrderItems> {
  late List<FoodOrderingDetails> details = widget.details;
  late Function(int, int, ActionType) callback = widget.callback;
  double totalCost = 0;
  List<TextEditingController> quantityController = [];
  bool empty = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Stack(children: [
        Container(
          margin: EdgeInsets.only(top: 10),
          child: Align(
              alignment: Alignment.topCenter,
              child: ListView.builder(
                  itemCount: details.length,
                  itemBuilder: (context, i) {
                    FoodMenu foodMenu = details[i].foodMenu;
                    quantityController.add(
                        TextEditingController(text: "${details[i].quantity}"));
                    return Container(
                      padding:
                          EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                      decoration: BoxDecoration(
                        border: Border(
                          // Top border
                          bottom: BorderSide(
                              width: 2.0,
                              color: CustomColors.borderColor), // Bottom border
                        ),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              GestureDetector(
                                onTap: () {
                                  setState(() {
                                    callback(i, 0, ActionType.remove);
                                  });
                                  Navigator.pop(context);
                                },
                                child: Icon(
                                  Icons.delete,
                                  color: Colors.redAccent,
                                ),
                              ),
                              const SizedBox(
                                width: 5,
                              ),
                              Container(
                                width: Dimension.getScreenWidth(context) * 0.2,
                                height:
                                    Dimension.getScreenHeight(context) * 0.11,
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(
                                      10.0), // Same as the container's border radius
                                  child: Image.memory(
                                    foodMenu.image,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                              const SizedBox(
                                width: 8,
                              ),
                              IntrinsicHeight(
                                child: Container(
                                  width:
                                      Dimension.getScreenWidth(context) * 0.38,
                                  height:
                                      Dimension.getScreenHeight(context) * 0.09,
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        foodMenu.name,
                                        style: const TextStyle(
                                            fontSize: 20,
                                            fontWeight: FontWeight.bold),
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                      RichText(
                                        text: TextSpan(
                                          text: "Rs. ${foodMenu.cost}",
                                          style: const TextStyle(
                                            fontSize: 18,
                                            color: CustomColors.priceCOlor,
                                            fontWeight: FontWeight.w500,
                                          ),
                                          children: <InlineSpan>[
                                            const WidgetSpan(
                                              child: SizedBox(
                                                  width:
                                                      4), // Adjust width as needed
                                            ),
                                            TextSpan(
                                              text: 'x${details[i].quantity}',
                                              style: const TextStyle(
                                                color: Colors.blue,
                                                fontSize: 17,
                                              ),
                                            ),
                                          ],
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                          Container(
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10.0),
                                color: CustomColors.defaultRedColor),
                            child: ItemCount(
                              initialValue: details[i].quantity,
                              minValue: 0,
                              maxValue: 10,
                              decimalPlaces: 0,
                              buttonTextColor: Colors.white,
                              buttonSizeWidth: 30,
                              buttonSizeHeight: 30,
                              textStyle: const TextStyle(
                                  color: Colors.white, fontSize: 18),
                              // textStyle: TextStyle(color: Colors.white),
                              onChanged: (value) {
                                setState(() {
                                  if (value.toInt() != 0) {
                                    details[i].quantity = value.toInt();
                                    callback(i, (details[i].quantity),
                                        ActionType.update);
                                  }
                                });
                              },
                            ),
                          ),
                        ],
                      ),
                    );
                  })),
        ),
        Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              color: Colors.white,
              padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  RichText(
                    text: TextSpan(
                      text: "Total: ",
                      style: const TextStyle(fontSize: 17, color: Colors.black),
                      children: <TextSpan>[
                        TextSpan(
                          text: 'Rs. ${getTotalCostAmount()}',
                          style: const TextStyle(
                              color: CustomColors.priceCOlor, fontSize: 17),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    child: ElevatedButton(
                      style: ButtonStyle(
                          shape:
                              MaterialStateProperty.all(const StadiumBorder()),
                          backgroundColor: MaterialStateProperty.all(
                              CustomColors.defaultRedColor),
                          elevation: MaterialStateProperty.all(0)),
                      onPressed: () async {
                        openModalButtonSheet(context, details, ((navId) {
                          Navigator.pop(context);
                          widget.orderCallback(navId);
                        }));
                      },
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 5.0,
                        ),
                        child: Text(
                          "Checkout",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 17,
                            fontWeight: FontWeight.normal,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ))
      ]),
    );
  }

  double getTotalCostAmount() {
    return widget.details
        .map((element) => element.foodMenu.cost * element.quantity)
        .toList() // Convert Iterable to List
        .fold(0, (prev, curr) => prev + curr);
  }
}


// return Column(
//       children: [
//         Expanded(
//           child: ListView.builder(
//               itemCount: details.length,
//               itemBuilder: (context, i) {
//                 FoodMenu foodMenu = details[i].foodMenu;
//                 quantityController
//                     .add(TextEditingController(text: "${details[i].quantity}"));
//                 return Card(
//                   child: SizedBox(
//                     width: 300,
//                     height: 100,
//                     child: Row(
//                       children: [
//                         Expanded(
//                           child: Image.memory(
//                             foodMenu.image ?? Uint8List(0),
//                             width: 100,
//                             height: 100,
//                             fit: BoxFit.cover,
//                           ),
//                         ),
//                         Expanded(
//                           child: Column(
//                             children: [
//                               Text(foodMenu.name),
//                               Text("Rs. ${foodMenu.cost}"),
//                             ],
//                           ),
//                         ),
//                         Expanded(
//                           child: TextField(
//                               controller: quantityController[i],
//                               decoration: InputDecoration(
//                                 labelText: "Enter Quantity you want to order",
//                                 hintText: "Quantity",
//                                 errorText:
//                                     empty ? "Quantity can't be empty" : null,
//                               ),
//                               keyboardType: TextInputType.number,
//                               onEditingComplete: () {
//                                 FocusScope.of(context).unfocus();
//                                 setState(() {
//                                   if (quantityController[i].text.trim() == '' ||
//                                       int.parse(quantityController[i].text) <
//                                           1) {
//                                     empty = true;
//                                   } else {
//                                     empty = false;
//                                     callback(
//                                         i,
//                                         int.parse(quantityController[i].text),
//                                         ActionType.update);
//                                   }
//                                 });
//                                 // Call your method when the TextField loses focus
//                               }),
//                         ),
//                         Expanded(
//                           child: IconButton(
//                             icon: Icon(Icons.delete),
//                             // You can change the icon to any other icon you prefer
//                             onPressed: () {
//                               setState(() {
//                                 callback(i, 0, ActionType.remove);
//                               });
//                             },
//                             tooltip: 'Delete',
//                           ),
//                         )
//                       ],
//                     ),
//                   ),
//                 );
//               }),
//         ),
//         ElevatedButton(
//             onPressed: details.length > 0
//                 ? () {
//                     widget.payCallback(true);
//                   }
//                 : null,
//             child: const Text("Pay"))
//       ],
//     );
