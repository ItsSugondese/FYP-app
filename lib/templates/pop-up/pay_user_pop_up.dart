import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fyp/constants/currency_constant.dart';
import 'package:fyp/model/people/user.dart';
import 'package:fyp/podo/user-payment/pay_remaining_amount_payload.dart';
import 'package:fyp/services/payment/payment_service.dart';

class PayUserPopUp extends StatefulWidget {
  final User user;
  final Function(bool) callback;
  const PayUserPopUp({super.key, required this.user, required this.callback});

  @override
  State<PayUserPopUp> createState() => _PayUserPopUpState();
}

class _PayUserPopUpState extends State<PayUserPopUp> {
  final TextEditingController amountController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
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
      title: Text("Payment for ${widget.user.fullName}"),
      children: <Widget>[
        Text(
            "Remaining Amount: ${CurrencyConstant.currency}${widget.user.remainingAmount}"),
        Form(
            key: _formKey,
            child: Column(
              children: [
                TextFormField(
                  controller: amountController,
                  decoration: InputDecoration(
                    labelText: "Enter amount",
                    hintText: "Amount",
                  ),
                  inputFormatters: [
                    FilteringTextInputFormatter.digitsOnly // Allow only digits
                  ],
                  onChanged: (value) {
                    setState(() {});
                  },
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please valid amount between ${CurrencyConstant.currency}1 - ${CurrencyConstant.currency}${widget.user.remainingAmount}';
                    }
                    return null;
                  },
                ),
                ElevatedButton(
                  onPressed: paying ||
                          amountController.text.isEmpty ||
                          (amountController.text.isNotEmpty &&
                              (double.parse(amountController.text) >
                                      widget.user.remainingAmount! ||
                                  double.parse(amountController.text) < 1))
                      ? null
                      : () async {
                          setStateForLoading(true);
                          if (_formKey.currentState!.validate()) {
                            RemainingPaymentPayload payload =
                                RemainingPaymentPayload(
                                    paidAmount: convertControllerToDouble(),
                                    userId: widget.user.id);

                            bool saved = false;

                            try {
                              saved = await paymentService
                                  .payRemainingAmount(payload.toJson());
                            } catch (e) {
                              setStateForLoading(false);
                            }

                            if (saved) {
                              widget.callback(true);
                              Navigator.pop(context);
                            }
                          }
                          setStateForLoading(true);
                        },
                  child: Text("Pay"),
                ),
              ],
            )),
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
