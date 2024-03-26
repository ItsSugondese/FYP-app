import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:fyp/config/network/api/GoogleSignInApi.dart';
import 'package:fyp/constants/data/food-menu/filter_food_menu.dart';
import 'package:fyp/constants/designing/colors.dart';
import 'package:fyp/constants/designing/dimension.dart';
import 'package:fyp/features/food-mgmt/food-mgmt-service/food_management_service.dart';
import 'package:fyp/helper/pagination/pagination_data.dart';
import 'package:fyp/helper/widgets/global/food_filter_widgets.dart';
import 'package:fyp/helper/widgets/global/header_widgets.dart';
import 'package:fyp/helper/widgets/search_widget.dart';
import 'package:fyp/model/foodmgmt/food_menu.dart';
import 'package:fyp/podo/foodmgmt/food_menu_pagination.dart';
import 'package:fyp/podo/foodmgmt/food_ordering_details.dart';
import 'package:fyp/routes/routes_import.gr.dart';
import 'package:fyp/utils/appbar/custom-appbar.dart';
import 'package:fyp/utils/drawer/drawer.dart';

@RoutePage()
class FoodManagementScreen extends StatefulWidget {
  const FoodManagementScreen({super.key});

  @override
  State<FoodManagementScreen> createState() => _FoodManagementScreenState();
}

class _FoodManagementScreenState extends State<FoodManagementScreen> {
  // HomepageService homepageService = HomepageService();
  // FoodManagementService foodManagementService = FoodManagementService();
  late FoodManagementService foodManagementService;
  // late Stream<PaginatedData<FoodMenu>> foodMenuFuture;
  late Future<PaginatedData<FoodMenu>> foodMenuFuture;

  FoodMenuPaginationPayload paginationPayload = FoodMenuPaginationPayload();
  List<FoodOrderingDetails> foodSelectedForOrderingList = [];

  int selectedQuantity = 0; // Initialize with a default value
  bool isToggled = true;
  int selectedFilterer = 1;

  Future<void> refresh() async {
    setState(() {
      fetchFoodMenu();
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    foodManagementService = FoodManagementService(context);
    fetchFoodMenu();
  }

  void fetchFoodMenu() {
    foodMenuFuture = foodManagementService
        .getFoodDetailsPaginated(paginationPayload.toJson());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppbar(),
      drawer: MyDrawer(),
      // floatingActionButton:
      //     FloatingActionButton(
      //         child: const Icon(Icons.add),
      //         onPressed: () =>
      //             AutoRouter.of(context).push(AddFoodScreenRoute())),
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        height: Dimension.getScreenHeight(context),
        child: Column(children: [
          SearchWidget(
            filterItems: const {
              'All': null,
              'Available': true,
              'Not Available': false
            },
            typedText: (val) {
              paginationPayload.name = val.trim() == "" ? null : val;
              setState(() {
                fetchFoodMenu();
              });
            },
            selectedFilter: (val) {
              paginationPayload.filter = val;
              setState(() {
                fetchFoodMenu();
              });
            },
          ),
          GlobalFoodFilterWidget(
              selectedFilterer: selectedFilterer,
              selectedFilter: (val) {
                paginationPayload.foodType =
                    (val == "All") ? null : val.toUpperCase();
                setState(() {
                  selectedFilterer = FoodMenuFilterer.findKeyByValue(val);

                  fetchFoodMenu();
                });
              }),
          FutureBuilder<PaginatedData<FoodMenu>>(
              future: foodMenuFuture,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                } else if (snapshot.hasData) {
                  return Expanded(
                    child: RefreshIndicator(
                      onRefresh: refresh,
                      child: ListView.builder(
                          shrinkWrap: true,
                          itemCount: snapshot.data?.content.length,
                          itemBuilder: (BuildContext context, int index) {
                            FoodMenu foodMenu = snapshot.data!.content[index];
                            return Column(
                              children: [
                                GestureDetector(
                                  onTap: () async {
                                    AutoRouter.of(context).push(
                                        FeedbackInspectScreenRoute(
                                            foodId: foodMenu.id));
                                  },
                                  child: Container(
                                    width: Dimension.getScreenWidth(context),
                                    child: Card(
                                      child: SizedBox(
                                        width:
                                            Dimension.getScreenWidth(context),
                                        child: Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Image.memory(
                                              foodMenu.image,
                                              width: Dimension.getScreenWidth(
                                                      context) *
                                                  0.25,
                                              height: Dimension.getScreenHeight(
                                                      context) *
                                                  0.15,
                                              fit: BoxFit.cover,
                                            ),
                                            SizedBox(
                                              width: 5,
                                            ),
                                            Container(
                                              height: 100,
                                              width: Dimension.getScreenWidth(
                                                      context) *
                                                  0.38,
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    foodMenu.name,
                                                    style:
                                                        TextStyle(fontSize: 18),
                                                    maxLines: 1,
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                  ),
                                                  Text(
                                                    "Rs. ${foodMenu.cost}",
                                                    style: TextStyle(
                                                        color: CustomColors
                                                            .priceCOlor,
                                                        fontSize: 15),
                                                  ),
                                                  SizedBox(
                                                    height: 5,
                                                  ),
                                                  Text(
                                                    foodMenu.description,
                                                    style:
                                                        TextStyle(fontSize: 13),
                                                    maxLines: 3,
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                  ),
                                                ],
                                              ),
                                            ),
                                            Switch(
                                              value: foodMenu.isAvailableToday,
                                              onChanged: (value) {
                                                setState(() {
                                                  isToggled = value;
                                                });
                                              },
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                )
                              ],
                            );
                          }),
                    ),
                  );
                } else if (snapshot.hasError) {
                  return Column(
                    children: [
                      ElevatedButton(
                          child: Text("Remove data"),
                          onPressed: () => {GoogleSignInApi.logout()}),
                      ElevatedButton(
                          child: Text("Login"),
                          onPressed: () => {
                                AutoRouter.of(context)
                                    .push(const LoginScreenRoute())
                              }),
                      Text("${snapshot.error}")
                    ],
                  );
                } else {
                  return CircularProgressIndicator();
                }
              }),
        ]),
      ),
    );
  }
}
