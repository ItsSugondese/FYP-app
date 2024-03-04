import 'package:flutter/material.dart';
import 'package:fyp/constants/data/food-menu/filter_food_menu.dart';
import 'package:fyp/constants/designing/colors.dart';

// ignore: must_be_immutable
class GlobalFoodFilterWidget extends StatefulWidget {
  int selectedFilterer;
  Function(String) selectedFilter;
  GlobalFoodFilterWidget(
      {super.key,
      required this.selectedFilterer,
      required this.selectedFilter});

  @override
  State<GlobalFoodFilterWidget> createState() => _GlobalFoodFilterWidgetState();
}

class _GlobalFoodFilterWidgetState extends State<GlobalFoodFilterWidget> {
  @override
  Widget build(BuildContext context) {
    return Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: FoodMenuFilterer.foodVal.entries
            .map((e) => Container(
                  margin: EdgeInsets.only(left: e.key == 1 ? 0 : 3.0),
                  child: ElevatedButton(
                    style: ButtonStyle(
                        padding: MaterialStateProperty.all<EdgeInsetsGeometry>(
                            EdgeInsets
                                .zero // Adjust the horizontal padding as needed
                            ),
                        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                        shape: MaterialStateProperty.all(const StadiumBorder()),
                        backgroundColor: e.key == widget.selectedFilterer
                            ? MaterialStateProperty.all(
                                CustomColors.defaultRedColor)
                            : MaterialStateProperty.all(Color(0xFFFAE7E6)),
                        elevation: MaterialStateProperty.all(0)),
                    onPressed: () {
                      // AutoRouter.of(context)
                      //     .push(const LoginScreenRoute());
                      setState(() {
                        widget.selectedFilterer = e.key;
                      });
                      widget.selectedFilter(e.value);
                    },
                    child: Text(
                      "${e.value}",
                      style: TextStyle(
                          color: e.key == widget.selectedFilterer
                              ? Colors.white
                              : CustomColors.defaultRedColor,
                          // fontSize: LandingScreenConstants.buttonFontSize,
                          fontWeight: FontWeight.w400),
                    ),
                  ),
                ))
            .toList());
  }
}
