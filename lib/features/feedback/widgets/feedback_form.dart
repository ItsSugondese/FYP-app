import 'package:flutter/material.dart';
import 'package:fyp/features/feedback/feedback-service/feedback_service.dart';
import 'package:fyp/podo/feedback/feedback_payload.dart';
import 'package:fyp/podo/feedback/food_menu_for_feedback.dart';

class FeedbackForm extends StatefulWidget {
  final FoodMenuForFeedback menu;
  final Function(bool) callback;
  const FeedbackForm({super.key, required this.menu, required this.callback});

  @override
  State<FeedbackForm> createState() => _FeedbackFormState();
}

class _FeedbackFormState extends State<FeedbackForm> {
  bool isToggled = false;
  late FeedbackService feedbackService;
  late Future<List<String>> getFeedbackStatusFuture;
  final _formKey = GlobalKey<FormState>();
  final TextEditingController feedbackRemarksController =
      TextEditingController();
  String? selected;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    feedbackService = FeedbackService(context);
    getFeedbackStatusFuture = feedbackService.getFeedbackStatus();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<String>>(
        future: getFeedbackStatusFuture,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return SimpleDialog(
              title: Text("Feedback for ${widget.menu.foodName}"),
              children: <Widget>[
                Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        DropdownButtonFormField<String>(
                          value: selected,
                          onChanged: (String? value) {
                            setState(() {
                              selected = value;
                            });
                          },
                          items: snapshot.data!
                              .map((String value) => DropdownMenuItem<String>(
                                    value: value,
                                    child: Text(value),
                                  ))
                              .toList(),
                          decoration: InputDecoration(
                            labelText: "Select your shit",
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please select a role';
                            }
                            return null;
                          },
                        ),
                        Center(child: Text("Rs. ")),
                        TextFormField(
                          controller: feedbackRemarksController,
                          decoration: InputDecoration(
                            labelText: "Write review",
                            hintText: "Feedback",
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter a quantity';
                            }
                            return null;
                          },
                        ),
                        Row(
                          children: [
                            Text("Anonymous: "),
                            Switch(
                              value: isToggled,
                              onChanged: (value) {
                                setState(() {
                                  isToggled = value;
                                });
                              },
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            ElevatedButton(
                              onPressed: () async {
                                if (_formKey.currentState!.validate()) {
                                  FeedbackPayload feedbackPayload =
                                      FeedbackPayload(
                                          feedbackStatus: selected!,
                                          foodId: widget.menu.foodId,
                                          feedbacks:
                                              feedbackRemarksController.text,
                                          isAnonymous: isToggled);

                                  bool saved = await feedbackService
                                      .saveFeedbacks(feedbackPayload.toJson());

                                  if (saved) {
                                    widget.callback(true);
                                    Navigator.pop(context);
                                  }
                                }
                              },
                              child: Text("Review"),
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
                    )),
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
