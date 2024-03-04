import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:fyp/constants/designing/colors.dart';
import 'package:fyp/constants/designing/dimension.dart';
import 'package:fyp/constants/designing/image_path.dart';
import 'package:fyp/constants/designing/screen_name.dart';
import 'package:fyp/templates/counter/counter_button.dart';

@RoutePage()
class OrderedFoodScreen extends StatefulWidget {
  const OrderedFoodScreen({super.key});

  @override
  State<OrderedFoodScreen> createState() => _OrderedFoodScreenState();
}

class _OrderedFoodScreenState extends State<OrderedFoodScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(),
        body: Stack(children: [
          Container(
            margin: EdgeInsets.only(top: 10),
            child: Align(
              alignment: Alignment.topCenter,
              child: Column(
                children: [
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
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
                            Icon(
                              Icons.delete,
                              color: Colors.redAccent,
                            ),
                            const SizedBox(
                              width: 5,
                            ),
                            Container(
                              width: Dimension.getScreenWidth(context) * 0.2,
                              height: Dimension.getScreenHeight(context) * 0.11,
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(
                                    10.0), // Same as the container's border radius
                                child: Image.asset(
                                  ImagePath.getImagePath(
                                      ScreenName.landing, "samosa.jpg"),
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                            const SizedBox(
                              width: 8,
                            ),
                            IntrinsicHeight(
                              child: SizedBox(
                                height:
                                    Dimension.getScreenHeight(context) * 0.09,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    const Text(
                                      "Samosa",
                                      style: TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    RichText(
                                      text: const TextSpan(
                                        text: "Rs. 120",
                                        style: TextStyle(
                                          fontSize: 18,
                                          color: CustomColors.priceCOlor,
                                          fontWeight: FontWeight.w500,
                                        ),
                                        children: <InlineSpan>[
                                          WidgetSpan(
                                            child: SizedBox(
                                                width:
                                                    4), // Adjust width as needed
                                          ),
                                          TextSpan(
                                            text: 'x3',
                                            style: TextStyle(
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
                            initialValue: 1,
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
                                // quantitySelected = value.toInt();
                              });
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
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
                            Icon(
                              Icons.delete,
                              color: Colors.redAccent,
                            ),
                            const SizedBox(
                              width: 5,
                            ),
                            Container(
                              width: Dimension.getScreenWidth(context) * 0.2,
                              height: Dimension.getScreenHeight(context) * 0.11,
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(
                                    10.0), // Same as the container's border radius
                                child: Image.asset(
                                  ImagePath.getImagePath(
                                      ScreenName.landing, "samosa.jpg"),
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                            const SizedBox(
                              width: 8,
                            ),
                            IntrinsicHeight(
                              child: SizedBox(
                                height:
                                    Dimension.getScreenHeight(context) * 0.09,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    const Text(
                                      "Samosa",
                                      style: TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    RichText(
                                      text: const TextSpan(
                                        text: "Rs. 120",
                                        style: TextStyle(
                                          fontSize: 18,
                                          color: CustomColors.priceCOlor,
                                          fontWeight: FontWeight.w500,
                                        ),
                                        children: <InlineSpan>[
                                          WidgetSpan(
                                            child: SizedBox(
                                                width:
                                                    4), // Adjust width as needed
                                          ),
                                          TextSpan(
                                            text: 'x3',
                                            style: TextStyle(
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
                            initialValue: 1,
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
                                // quantitySelected = value.toInt();
                              });
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
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
                        style:
                            const TextStyle(fontSize: 17, color: Colors.black),
                        children: <TextSpan>[
                          TextSpan(
                            text: 'Rs. 40',
                            style: const TextStyle(
                                color: CustomColors.priceCOlor, fontSize: 17),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      child: ElevatedButton(
                        style: ButtonStyle(
                            shape: MaterialStateProperty.all(
                                const StadiumBorder()),
                            backgroundColor: MaterialStateProperty.all(
                                CustomColors.defaultRedColor),
                            elevation: MaterialStateProperty.all(0)),
                        onPressed: () async {},
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
        ]));
  }
}
