import 'package:flutter/material.dart';
import 'package:fyp/features/feedback/feedback-service/feedback_service.dart';
import 'package:fyp/podo/feedback/feedback_payload.dart';

class FeedbackForm extends StatefulWidget {
  final int foodId;
  const FeedbackForm({super.key, required this.foodId});

  @override
  State<FeedbackForm> createState() => _FeedbackFormState();
}

class _FeedbackFormState extends State<FeedbackForm> {
  bool isToggled = false;
  FeedbackService feedbackService = FeedbackService();
  late Future<List<String>> getFeedbackStatusFuture;
  final _formKey = GlobalKey<FormState>();
  final TextEditingController feedbackRemarksController =
      TextEditingController();
  String? selected;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getFeedbackStatusFuture = feedbackService.getFeedbackStatus();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<String>>(
        future: getFeedbackStatusFuture,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return SimpleDialog(
              title: Text("Order "),
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
                                          foodId: widget.foodId,
                                          feedbacks:
                                              feedbackRemarksController.text,
                                          isAnonymous: isToggled);

                                  bool saved = await feedbackService
                                      .saveFeedbacks(feedbackPayload.toJson());

                                  if (saved) {
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
            return CircularProgressIndicator();
          }
        });
  }
}
