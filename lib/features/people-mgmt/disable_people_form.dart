import 'package:flutter/material.dart';
import 'package:fyp/features/people-mgmt/people-mgmt-service/people_management_service.dart';
import 'package:fyp/podo/people/disable_user.dart';

class DisablePeopleForm<T> extends StatefulWidget {
  final T user;
  const DisablePeopleForm({super.key, required this.user});

  @override
  State<DisablePeopleForm> createState() => _DisablePeopleFormState();
}

class _DisablePeopleFormState extends State<DisablePeopleForm> {
  bool isToggled = false;
  PeopleManagementService peopleService = PeopleManagementService();
  late Future<List<String>> getFeedbackStatusFuture;
  final _formKey = GlobalKey<FormState>();
  final TextEditingController remarksController = TextEditingController();
  String? selected;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SimpleDialog(
      title: Text("Disable User"),
      children: <Widget>[
        Form(
            key: _formKey,
            child: Column(
              children: [
                TextFormField(
                  controller: remarksController,
                  decoration: InputDecoration(
                    labelText: "Write the reason",
                    hintText: "Remarks",
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
                    ElevatedButton(
                      onPressed: () async {
                        if (_formKey.currentState!.validate()) {
                          DisableUserPayload disableUserPayload =
                              DisableUserPayload(
                                  remarks: remarksController.text,
                                  userId: widget.user.id,
                                  isDisabled: widget.user.accountNonLocked
                                      ? true
                                      : false);

                          bool saved = await peopleService.saveToDisableUser(
                              context, disableUserPayload.toJson());

                          if (saved) {
                            Navigator.pop(context);
                          }
                        }
                      },
                      child: Text("Disable"),
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
  }
}
