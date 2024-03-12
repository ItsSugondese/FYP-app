import 'package:flutter/material.dart';
import 'package:fyp/constants/designing/colors.dart';
import 'package:fyp/constants/designing/dimension.dart';
import 'package:fyp/features/feedback/widgets/feedback_form.dart';
import 'package:fyp/features/feedback/widgets/view_feedback_screen.dart';
import 'package:fyp/model/foodmgmt/food_menu.dart';
import 'package:fyp/podo/feedback/food_menu_for_feedback.dart';
import 'package:fyp/templates/button/default_button.dart';

class FoodForFeedbackCardWidget extends StatefulWidget {
  final FoodMenuForFeedback foodMenu;
  final Function(bool) callback;
  const FoodForFeedbackCardWidget(
      {super.key, required this.foodMenu, required this.callback});

  @override
  State<FoodForFeedbackCardWidget> createState() =>
      _FoodForFeedbackCardWidgetState();
}

class _FoodForFeedbackCardWidgetState extends State<FoodForFeedbackCardWidget> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 10),
      child: Container(
        width: Dimension.getScreenWidth(context) * 0.4,
        padding: EdgeInsets.symmetric(horizontal: 8, vertical: 10),
        color: Colors.white,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Container(
                margin: EdgeInsets.only(right: 10),
                alignment: Alignment.topCenter,
                width: 100,
                height: 100,
                child: Image.memory(
                  widget.foodMenu.image,
                  fit: BoxFit.cover,
                  width: 100,
                  height: 100,
                ),
              ),
            ),
            SizedBox(height: 3),
            Text(
              "${widget.foodMenu.foodName}",
              style: const TextStyle(
                fontWeight: FontWeight.w500,
                fontSize: 18,
              ),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
            Text(
              "Rs. ${widget.foodMenu.price}",
              style: const TextStyle(
                color: CustomColors.priceCOlor,
                fontWeight: FontWeight.w500,
                fontSize: 15,
              ),
            ),
            SizedBox(height: 15),
            Center(
              child: Container(
                child: widget.foodMenu.isGiven
                    ? Center(
                        child: IconButton(
                            onPressed: () {
                              viewFeedbackGiven(widget.foodMenu);
                            },
                            icon: Icon(Icons.visibility)))
                    : DefaultButton(
                        onPressed: () {
                          showPopUpToFeedback(widget.foodMenu);
                        },
                        text: "Feedback"),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [],
            ),
          ],
        ),
      ),
    );
  }

  showPopUpToFeedback(FoodMenuForFeedback menu) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return FeedbackForm(
            menu: menu,
            callback: (val) {
              widget.callback(val);
            });
      },
    );
  }

  viewFeedbackGiven(FoodMenuForFeedback menu) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return ViewFeedbackScreen(
            menu: menu,
            callback: (val) {
              widget.callback(val);
            });
      },
    );
  }
}
