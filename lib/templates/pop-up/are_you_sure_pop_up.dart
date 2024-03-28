import 'package:flutter/material.dart';
import 'package:fyp/constants/designing/colors.dart';
import 'package:fyp/services/payment/payment_service.dart';
import 'package:fyp/templates/button/default_button_no_infinity.dart';

class AreYouSurePopUp extends StatefulWidget {
  final String header;
  final String description;
  final Function(bool) callback;
  const AreYouSurePopUp(
      {super.key,
      required this.header,
      required this.description,
      required this.callback});

  @override
  State<AreYouSurePopUp> createState() => _AreYouSurePopUpState();
}

class _AreYouSurePopUpState extends State<AreYouSurePopUp> {
  final TextEditingController amountController = TextEditingController();
  late PaymentService paymentService;
  bool paying = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    paymentService = PaymentService(context);
  }

  @override
  Widget build(BuildContext context) {
    return SimpleDialog(
      title: Text(widget.header),
      children: <Widget>[
        Text(widget.description),
        Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
          DefaultButtonNoInfinity(
              text: "No",
              color: CustomColors.defaultRedColor,
              hasBorder: true,
              bgColor: Colors.white,
              onPressed: () {
                widget.callback(false);
                Navigator.pop(context);
              }),
          DefaultButtonNoInfinity(
              text: "Yes",
              onPressed: () {
                widget.callback(true);
                Navigator.pop(context);
              }),
        ]),
      ],
    );
  }

  double convertControllerToDouble() {
    return double.parse(amountController.text);
  }

  void setStateForLoading(bool val) {
    setState(() {
      paying = val;
    });
  }
}
