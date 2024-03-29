import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:fyp/constants/designing/colors.dart';
import 'package:fyp/constants/designing/dimension.dart';
import 'package:fyp/model/foodmgmt/food_menu.dart';
import 'package:fyp/templates/counter/counter_button.dart';
import 'package:fyp/templates/text/food_type_text.dart';

@RoutePage()
class SelectedFoodToOrderScreen extends StatefulWidget {
  final FoodMenu foodMenu;
  final Function(int, FoodMenu) callback;
  const SelectedFoodToOrderScreen(
      {super.key, required this.foodMenu, required this.callback});

  @override
  State<SelectedFoodToOrderScreen> createState() =>
      _SelectedFoodToOrderScreenState();
}

class _SelectedFoodToOrderScreenState extends State<SelectedFoodToOrderScreen> {
  int quantitySelected = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(),
        resizeToAvoidBottomInset: false,
        backgroundColor: const Color(0xFFF5F5F0),
        body: Container(
            padding: const EdgeInsets.only(top: 10, left: 20, right: 20),
            child: Stack(children: [
              // Padding(
              //   padding: const EdgeInsets.only(),
              //   child: Builder(
              //     builder: (context) => GlobalHeaderWidget.getHeader(context),
              //   ),
              // ),
              Align(
                alignment: Alignment.topCenter,
                child: SizedBox(
                    height: Dimension.getScreenHeight(context) * 0.77,
                    child: SingleChildScrollView(
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Center(
                              child: SizedBox(
                                width: Dimension.getScreenWidth(context),
                                height:
                                    Dimension.getScreenHeight(context) * 0.4,
                                child: Image.memory(
                                  widget.foodMenu.image,
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                FoodTypeText.getFoodType("Individual", 14),
                                Text(
                                  "Rs. ${widget.foodMenu.cost}",
                                  style: const TextStyle(
                                      color: CustomColors.priceCOlor,
                                      fontSize: 20,
                                      fontWeight: FontWeight.w500),
                                ),
                              ],
                            ),
                            const SizedBox(
                              height: 5,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                SizedBox(
                                  width:
                                      Dimension.getScreenWidth(context) * 0.6,
                                  child: Text(
                                    widget.foodMenu.name,
                                    style: const TextStyle(fontSize: 23),
                                  ),
                                ),
                                Container(
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10.0),
                                      color: CustomColors.defaultRedColor),
                                  child: ItemCount(
                                    initialValue: quantitySelected,
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
                                      // Handle counter value changes
                                      setState(() {
                                        quantitySelected = value.toInt();
                                      });
                                    },
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(
                              height: 5,
                            ),
                            Text(
                              widget.foodMenu.description,
                              style: const TextStyle(fontSize: 16),
                            ),
                          ]),
                    )),
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: Container(
                  margin: EdgeInsets.only(bottom: 5),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      RichText(
                        text: TextSpan(
                          text: "Total: ",
                          style: const TextStyle(
                              fontSize: 17, color: Color(0xFF989898)),
                          children: <TextSpan>[
                            TextSpan(
                              text:
                                  'Rs. ${widget.foodMenu.cost * quantitySelected}',
                              style: const TextStyle(
                                  color: CustomColors.priceCOlor, fontSize: 17),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        width: 150,
                        child: ElevatedButton(
                          style: ButtonStyle(
                              shape: MaterialStateProperty.all(
                                  const StadiumBorder()),
                              backgroundColor: MaterialStateProperty.all(
                                  quantitySelected != 0
                                      ? CustomColors.defaultRedColor
                                      : Colors.grey),
                              side: MaterialStateProperty.all(const BorderSide(
                                color: Colors.black,
                                width: 1.0,
                                style: BorderStyle.solid,
                              )),
                              elevation: MaterialStateProperty.all(0)),
                          onPressed: quantitySelected == 0
                              ? null
                              : () async {
                                  widget.callback(
                                      quantitySelected, widget.foodMenu);
                                  Navigator.pop(context);
                                },
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const SizedBox(
                                width: 20,
                                child: Icon(
                                  Icons.shopping_cart,
                                  size: 17,
                                ),
                              ),
                              Text(
                                "Add To Cart",
                                style: TextStyle(
                                  color: quantitySelected != 0
                                      ? Colors.white
                                      : Colors.black45,
                                  fontSize: 17,
                                  fontWeight: FontWeight.normal,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              )
            ])));
  }
}
