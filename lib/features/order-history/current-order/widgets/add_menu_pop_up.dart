import 'package:flutter/material.dart';
import 'package:fyp/constants/currency_constant.dart';
import 'package:fyp/constants/designing/colors.dart';
import 'package:fyp/features/food-mgmt/food-mgmt-service/food_management_service.dart';
import 'package:fyp/model/foodmgmt/food_menu.dart';
import 'package:fyp/model/order/online_order.dart';
import 'package:fyp/model/user-order/user_order_history.dart';
import 'package:fyp/podo/foodmgmt/food_menu_pagination.dart';
import 'package:fyp/podo/foodmgmt/food_order_response.dart';
import 'package:fyp/podo/foodmgmt/food_ordering_details.dart';
import 'package:fyp/podo/orders/online-order/online_order_response.dart';
import 'package:fyp/services/order-services/online_order_service.dart';
import 'package:fyp/templates/counter/counter_button.dart';

class AddMenuPopUp extends StatefulWidget {
  // Function(OnlineOrder) memberCallBack;
  final UserOrderHistory orderHistory;
  AddMenuPopUp({required this.orderHistory});

  @override
  State<AddMenuPopUp> createState() => _AddMenuPopUpState();
}

class _AddMenuPopUpState extends State<AddMenuPopUp> {
  TextEditingController contactController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  bool? memberExists;
  late Future<OnlineOrder?> searchedMember;
  late OnlineOrder selectedMember;
  late FoodManagementService foodManagementService;
  FoodMenuPaginationPayload paginationPayload =
      FoodMenuPaginationPayload(filter: true);
  int addedQuantity = 0;

  FoodMenu? selectedMenu;
  bool disableUpdate = true;
  late OnlineOrderService onlineOrderService;

  Future<List<FoodMenu>> fetchFoodMenu() async {
    return Future.value((await foodManagementService
            .getFoodDetailsPaginated(paginationPayload.toJson()))
        .content);
  }

  TimeOfDay? selectedTime;

  Future<void> _selectTime(BuildContext context) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: selectedTime ?? TimeOfDay.now(),
    );
    if (picked != null && picked != selectedTime) {
      setState(() {
        selectedTime = picked;
      });
    }
  }

  changeUpdateToTrue() {
    setState(() {
      if (getStringConvertedTime(selectedTime) + ":00" ==
              widget.orderHistory.arrivalTime24 &&
          (selectedMenu == null || addedQuantity == 0)) {
        disableUpdate = true;
      } else {
        disableUpdate = false;
      }
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    List<String> timeSplit = widget.orderHistory.arrivalTime24.split(":");
    selectedTime = TimeOfDay(
        hour: int.parse(timeSplit[0]), minute: int.parse(timeSplit[1]));
    foodManagementService = FoodManagementService(context);
    onlineOrderService = OnlineOrderService(context);
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Member Popup'),
      content: SingleChildScrollView(
        child: IntrinsicHeight(
          child: Column(
            children: [
              Row(
                children: [
                  Expanded(
                    child: Column(
                      children: [
                        Text("Add Menu"),
                        Autocomplete<FoodMenu>(
                          displayStringForOption: (food) => food.name,
                          optionsBuilder:
                              (TextEditingValue textEditingValue) async {
                            if (textEditingValue.text == '') {
                              return const Iterable.empty();
                            }
                            final foodMenu = await fetchFoodMenu();
                            return foodMenu.where((element) => element.name
                                .toLowerCase()
                                .contains(textEditingValue.text.toLowerCase()));
                          },
                          onSelected: (item) {
                            setState(() {
                              selectedMenu = item;
                            });
                          },
                          fieldViewBuilder: (context, controller, focusNode,
                              onFieldSubmitted) {
                            // Your logic to build the text field
                            return TextField(
                              controller: controller,
                              focusNode: focusNode,
                              onChanged: (text) {
                                // Your logic to check the text written in the field
                                print("Text field content: $text");

                                if (selectedMenu != null &&
                                    selectedMenu!.name != text) {
                                  setState(() {
                                    selectedMenu = null;
                                  });
                                }
                              },
                            );
                          },
                          optionsViewBuilder: (context, onSelected, options) {
                            return Align(
                              alignment:
                                  Alignment.topCenter, // Positioning at the top
                              child: Material(
                                elevation: 4.0,
                                child: ConstrainedBox(
                                  constraints: BoxConstraints(maxHeight: 200),
                                  child: ListView.builder(
                                    shrinkWrap: true,
                                    itemCount: options.length,
                                    itemBuilder:
                                        (BuildContext context, int index) {
                                      final option = options.elementAt(index);
                                      return GestureDetector(
                                        onTap: () {
                                          onSelected(option);
                                          changeUpdateToTrue();
                                        },
                                        child: ListTile(
                                          title: Text(option.name),
                                          subtitle: Text(
                                              "${CurrencyConstant.currency}${option.cost}"),
                                          leading: Image.memory(option.image),
                                        ),
                                      );
                                    },
                                  ),
                                ),
                              ),
                            );
                          },
                        ),
                        if (selectedMenu != null)
                          Column(
                            children: [
                              Text("Quantity"),
                              Container(
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10.0),
                                    color: CustomColors.defaultRedColor),
                                child: ItemCount(
                                  initialValue: addedQuantity,
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
                                    setState(() {
                                      if (value.toInt() != 0) {
                                        addedQuantity = value.toInt();
                                        changeUpdateToTrue();
                                      }
                                    });
                                  },
                                ),
                              ),
                            ],
                          ),
                        const SizedBox(
                          height: 20,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text("Arrival Time: "),
                            ElevatedButton(
                                style: ButtonStyle(
                                    side: MaterialStateProperty.all(
                                        const BorderSide(
                                      color: CustomColors.defaultRedColor,
                                      width: 1.0,
                                      style: BorderStyle.solid,
                                    )),
                                    backgroundColor:
                                        MaterialStateProperty.all(Colors.white),
                                    elevation: MaterialStateProperty.all(0)),
                                onPressed: () async {
                                  await _selectTime(context);
                                  changeUpdateToTrue();
                                },
                                child: Text(
                                  selectedTime == null
                                      ? "Click to select time"
                                      : getStringConvertedTime(selectedTime),
                                  style: const TextStyle(
                                      color: CustomColors.defaultRedColor),
                                )),
                          ],
                        )
                      ],
                    ),
                  ),
                ],
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: disableUpdate
                    ? null
                    : () async {
                        List<FoodOrderResponse> foodOrderList = [
                          FoodOrderResponse(
                            foodId: selectedMenu!.id,
                            quantity: addedQuantity,
                          ),
                        ];
                        OnlineOrderResponse onlineOrderResponse =
                            OnlineOrderResponse(
                                id: widget.orderHistory.id,
                                foodOrderList: foodOrderList,
                                arrivalTime:
                                    getStringConvertedTime(selectedTime),
                                totalPrice: widget.orderHistory.totalPrice +
                                    (selectedMenu!.cost * addedQuantity));

                        await onlineOrderService
                            .makeOnlineOrder(onlineOrderResponse.toJson());

                        Navigator.pop(context);
                      },
                child: Text('Update'),
              ),
              // memberExists == null
              //     ? const SizedBox()
              //     : memberExists == false
              //         ? ifMemberFalse()
              //         : ifMemberTrue()
            ],
          ),
        ),
      ),
    );
  }

  Column ifMemberFalse() {
    return Column(
      children: [
        TextField(
          controller: nameController,
          decoration: InputDecoration(labelText: 'Name'),
        ),
        SizedBox(height: 20),
        ElevatedButton(
          onPressed: () async {
            // Perform the search operation and send the response to the backend
            // selectedMember = await MemberService.saveMember(
            //     context,
            //     MemberRequest(
            //             name: nameController.text,
            //             phoneNumber: contactController.text)
            //         .toJson());

            // callback(selectedMember);
            // Navigator.of(context).pop();
            // Close the popup
            // Navigator.of(context).pop();
          },
          child: Text('Submit'),
        ),
      ],
    );
  }

  List<FoodOrderResponse> getFoodOrderList(List<FoodOrderingDetails> details) {
    List<FoodOrderResponse> foodOrderList = details.map((element) {
      return FoodOrderResponse(
        foodId: element.foodMenu.id,
        quantity: element.quantity,
      );
    }).toList();

    return foodOrderList;
  }

  String getStringConvertedTime(TimeOfDay? selectedTime) {
    return "${selectedTime?.hour.toString().padLeft(2, '0') ?? '00'}:${selectedTime?.minute.toString().padLeft(2, '0') ?? '00'}";
  }
}
