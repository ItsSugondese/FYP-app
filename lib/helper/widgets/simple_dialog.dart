import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fyp/model/foodmgmt/Food_menu_item_with_image.dart';
import 'package:fyp/model/foodmgmt/food_menu.dart';

class SimpleDialogWidget {
  static void showSimpleDialog(BuildContext context, FoodMenu foodMenu,
      Function(int, FoodMenu) callback) {
    TextEditingController quantityController = TextEditingController();
    bool empty = false;

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (context, setState) {
            return SimpleDialog(
              title: Text("Order ${foodMenu.name}"),
              children: <Widget>[
                Image.memory(
                  foodMenu.image ?? Uint8List(0),
                  width: 100,
                  height: 100,
                  fit: BoxFit.cover,
                ),
                Center(child: Text("Rs. ${foodMenu.cost}")),
                TextField(
                  controller: quantityController,
                  decoration: InputDecoration(
                    labelText: "Enter Quantity you want to order",
                    hintText: "Quantity",
                    errorText: empty ? "Quantity can't be empty" : null,
                  ),
                  keyboardType: TextInputType.number,
                ),
                Row(
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        setState(() {
                          if (quantityController.text.isEmpty ||
                              int.parse(quantityController.text) < 1) {
                            empty = true;
                          } else {
                            empty = false;
                          }
                        });

                        if (!empty) {
                          int quantity = int.parse(quantityController
                              .text); // Convert quantity to an integer
                          callback(quantity,
                              foodMenu); // Pass the quantity to the callback function
                          Navigator.pop(context);
                        }
                      },
                      child: Text("Order"),
                    ),
                    SizedBox(width: 20),
                    ElevatedButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: Text("Cancel"),
                    ),
                  ],
                ),
              ],
            );
          },
        );
      },
    );
  }
}
