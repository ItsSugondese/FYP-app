import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fyp/constants/currency_constant.dart';
import 'package:fyp/model/order/onsite_order.dart';
import 'package:fyp/model/people/user.dart';
import 'package:fyp/podo/user-payment/pay_remaining_amount_payload.dart';
import 'package:fyp/podo/user-payment/payment_payload.dart';
import 'package:fyp/services/payment/payment_service.dart';

class PayOrderPopUp extends StatefulWidget {
  final OnsiteOrder order;
  final Function(bool) callback;
  const PayOrderPopUp({super.key, required this.order, required this.callback});

  @override
  State<PayOrderPopUp> createState() => _PayOrderPopUpState();
}

class _PayOrderPopUpState extends State<PayOrderPopUp> {
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
      title: Text("Payment for ${widget.order.fullName}"),
      children: <Widget>[
        Text(
            "Current Order cost: ${CurrencyConstant.currency}${widget.order.totalPrice}"),
        Text(
            "Previous Due Amount: ${CurrencyConstant.currency}${widget.order.remainingAmount - widget.order.totalPrice}"),
        Text(
            "Remaining Amount To pay: ${CurrencyConstant.currency}${widget.order.remainingAmount}"),
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
                      return 'Please valid amount between ${CurrencyConstant.currency}1 - ${CurrencyConstant.currency}${widget.order.remainingAmount}';
                    }
                    return null;
                  },
                ),
                ElevatedButton(
                  onPressed: paying ||
                          amountController.text.isEmpty ||
                          (amountController.text.isNotEmpty &&
                              (double.parse(amountController.text) >
                                      widget.order.remainingAmount ||
                                  double.parse(amountController.text) < 1))
                      ? null
                      : () async {
                          setStateForLoading(true);
                          if (_formKey.currentState!.validate()) {
                            PaymentPayload payload = PaymentPayload(
                                totalAmount: widget.order.totalPrice,
                                paidAmount: convertControllerToDouble(),
                                dueAmount: convertControllerToDouble() >
                                        widget.order.totalPrice
                                    ? 0
                                    : widget.order.totalPrice -
                                        convertControllerToDouble(),
                                onsiteOrderId: widget.order.id,
                                userId: widget.order.userId);

                            try {
                              await paymentService
                                  .payForOrder(payload.toJson());
                            } catch (e) {
                              setStateForLoading(false);
                            }

                            widget.callback(true);
                            Navigator.pop(context);
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
