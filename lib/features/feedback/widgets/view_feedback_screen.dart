import 'package:flutter/material.dart';
import 'package:fyp/features/feedback/feedback-service/feedback_service.dart';
import 'package:fyp/podo/feedback/food_menu_for_feedback.dart';
import 'package:fyp/podo/feedback/view_feedback.dart';
import 'package:fyp/templates/button/default_button.dart';

class ViewFeedbackScreen extends StatefulWidget {
  final FoodMenuForFeedback menu;
  final Function(bool) callback;
  const ViewFeedbackScreen(
      {super.key, required this.menu, required this.callback});

  @override
  State<ViewFeedbackScreen> createState() => _ViewFeedbackScreenState();
}

class _ViewFeedbackScreenState extends State<ViewFeedbackScreen> {
  bool isToggled = false;
  late FeedbackService feedbackService;
  late Future<ViewFeedback> getFeedbackGivenFuture;
  final _formKey = GlobalKey<FormState>();
  final TextEditingController feedbackRemarksController =
      TextEditingController();
  String? selected;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    feedbackService = FeedbackService(context);
    getFeedbackGivenFuture =
        feedbackService.viewFeedbackGiven(widget.menu.foodId);
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<ViewFeedback>(
        future: getFeedbackGivenFuture,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            ViewFeedback feedback = snapshot.data!;
            return SimpleDialog(
              title: Text("Feedback for ${widget.menu.foodName}"),
              children: <Widget>[
                Row(
                  children: [Text("Is Anon:"), Text("${feedback.isAnonymous}")],
                ),
                Row(
                  children: [Text("Status:"), Text(feedback.feedbackStatus)],
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [Text("Feedback:"), Text(feedback.feedbacks)],
                ),
                DefaultButton(
                    text: "Delete",
                    onPressed: () async {
                      bool saved =
                          await feedbackService.deleteFeedback(feedback.id);

                      if (saved) {
                        widget.callback(true);
                        Navigator.pop(context);
                      }
                      // feedbackService.deleteFeedback(feedback.id).then((value) {
                      //   if (value) {
                      //     widget.callback(true);
                      //     Navigator.pop(context);
                      //   }
                      // });
                    })
              ],
            );
          } else if (snapshot.hasError) {
            // ServiceHelper.showErrorSnackBar(context, "Error");
            throw Exception("Error");
          } else {
            return SizedBox(
              child: Center(
                  child: CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
              )),
              height: 10.0,
              width: 10.0,
            );
          }
        });
  }
}
