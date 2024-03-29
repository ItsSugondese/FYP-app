import 'package:auto_route/annotations.dart';
import 'package:flutter/material.dart';
import 'package:fyp/constants/currency_constant.dart';
import 'package:fyp/features/food-mgmt/food-mgmt-service/food_management_service.dart';
import 'package:fyp/helper/pagination/pagination_data.dart';
import 'package:fyp/model/foodmgmt/food_menu.dart';
import 'package:fyp/podo/foodmgmt/food_menu_pagination.dart';

@RoutePage()
class StaffHomepage extends StatefulWidget {
  const StaffHomepage({Key? key}) : super(key: key);

  @override
  State<StaffHomepage> createState() => _StaffHomepageState();
}

class _StaffHomepageState extends State<StaffHomepage> {
  List<FoodMenu> foodMenuList = [];
  FoodMenuPaginationPayload paginationPayload = FoodMenuPaginationPayload();
  late Future<PaginatedData<FoodMenu>> foodMenuFuture;
  late FoodManagementService foodManagementService;
  FoodMenu? selectedMenu;

  Future<List<FoodMenu>> fetchFoodMenu() async {
    return Future.value((await foodManagementService
            .getFoodDetailsPaginated(paginationPayload.toJson()))
        .content);
  }

  List<String> items = ["Apple", "Orange", "Banana", "Orange"];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    foodManagementService = FoodManagementService(context);
    paginationPayload.filter = true;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        children: [
          Text("${selectedMenu == null ? 'Oh no' : selectedMenu!.id}"),
          Autocomplete<FoodMenu>(
            displayStringForOption: (food) => food.name,
            optionsBuilder: (TextEditingValue textEditingValue) async {
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
            fieldViewBuilder:
                (context, controller, focusNode, onFieldSubmitted) {
              // Your logic to build the text field
              return TextField(
                controller: controller,
                focusNode: focusNode,
                onChanged: (text) {
                  // Your logic to check the text written in the field
                  print("Text field content: $text");

                  if (selectedMenu != null && selectedMenu!.name != text) {
                    setState(() {
                      selectedMenu = null;
                    });
                  }
                },
              );
            },
            optionsViewBuilder: (context, onSelected, options) {
              return Align(
                alignment: Alignment.topCenter, // Positioning at the top
                child: Material(
                  elevation: 4.0,
                  child: ConstrainedBox(
                    constraints: BoxConstraints(maxHeight: 200),
                    child: ListView.builder(
                      shrinkWrap: true,
                      itemCount: options.length,
                      itemBuilder: (BuildContext context, int index) {
                        final option = options.elementAt(index);
                        return GestureDetector(
                          onTap: () {
                            onSelected(option);
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
        ],
      ),
    );
  }
}
