import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:fyp/model/foodmgmt/food_menu.dart';
import '../../../model/foodmgmt/Food_menu_item_with_image.dart';
import '../../../podo/foodmgmt/food_ordering_details.dart';
import 'package:fyp/enums/crud_type.dart';

import '../payment/make_order_and_payment.dart';

class EditOrderItems extends StatefulWidget {
  List<FoodOrderingDetails> details;
  Function(int, int, ActionType) callback;
  Function(bool) payCallback;
  EditOrderItems(
      {required this.details,
      required this.callback,
      required this.payCallback});

  @override
  State<EditOrderItems> createState() => _EditOrderItemsState();
}

class _EditOrderItemsState extends State<EditOrderItems> {
  late List<FoodOrderingDetails> details = widget.details;
  late Function(int, int, ActionType) callback = widget.callback;

  List<TextEditingController> quantityController = [];
  bool empty = false;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: ListView.builder(
              itemCount: details.length,
              itemBuilder: (context, i) {
                FoodMenu foodMenu = details[i].foodMenu;
                quantityController
                    .add(TextEditingController(text: "${details[i].quantity}"));
                return Card(
                  child: SizedBox(
                    width: 300,
                    height: 100,
                    child: Row(
                      children: [
                        Expanded(
                          child: Image.memory(
                            foodMenu.image ?? Uint8List(0),
                            width: 100,
                            height: 100,
                            fit: BoxFit.cover,
                          ),
                        ),
                        Expanded(
                          child: Column(
                            children: [
                              Text(foodMenu.name),
                              Text("Rs. ${foodMenu.cost}"),
                            ],
                          ),
                        ),
                        Expanded(
                          child: TextField(
                              controller: quantityController[i],
                              decoration: InputDecoration(
                                labelText: "Enter Quantity you want to order",
                                hintText: "Quantity",
                                errorText:
                                    empty ? "Quantity can't be empty" : null,
                              ),
                              keyboardType: TextInputType.number,
                              onEditingComplete: () {
                                FocusScope.of(context).unfocus();
                                setState(() {
                                  if (quantityController[i].text.trim() == '' ||
                                      int.parse(quantityController[i].text) <
                                          1) {
                                    empty = true;
                                  } else {
                                    empty = false;
                                    callback(
                                        i,
                                        int.parse(quantityController[i].text),
                                        ActionType.update);
                                  }
                                });
                                // Call your method when the TextField loses focus
                              }),
                        ),
                        Expanded(
                          child: IconButton(
                            icon: Icon(Icons.delete),
                            // You can change the icon to any other icon you prefer
                            onPressed: () {
                              setState(() {
                                callback(i, 0, ActionType.remove);
                              });
                            },
                            tooltip: 'Delete',
                          ),
                        )
                      ],
                    ),
                  ),
                );
              }),
        ),
        ElevatedButton(
            onPressed: details.length > 0
                ? () {
                    widget.payCallback(true);
                  }
                : null,
            child: const Text("Pay"))
      ],
    );
  }
}
