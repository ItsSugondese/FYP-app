import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:fyp/config/network/api/GoogleSignInApi.dart';
import 'package:fyp/features/food-mgmt/food-mgmt-service/food_management_service.dart';
import 'package:fyp/helper/pagination/pagination_data.dart';
import 'package:fyp/model/foodmgmt/food_menu.dart';
import 'package:fyp/podo/foodmgmt/food_menu_pagination.dart';
import 'package:fyp/podo/foodmgmt/food_ordering_details.dart';
import 'package:fyp/routes/routes_import.gr.dart';

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

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    foodManagementService = FoodManagementService(context);
    foodMenuFuture = foodManagementService
        .getFoodDetailsPaginated(paginationPayload.toJson());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Food Management"),
      ),
      floatingActionButton:
          // foodSelectedForOrderingList.length == 0?
          FloatingActionButton(
              child: const Icon(Icons.add),
              onPressed: () =>
                  AutoRouter.of(context).push(AddFoodScreenRoute())),
      // : null,
      body: Container(
        child: FutureBuilder<List<FoodMenu>>(
            // future: homepageService.getFoodMenusWithImages(),
            future: foodManagementService.getFoodDetails(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return Center(
                  child: ListView.builder(
                      shrinkWrap: true,
                      itemCount: snapshot.data?.length,
                      itemBuilder: (BuildContext context, int index) {
                        FoodMenu foodMenu = snapshot.data![index];
                        return Column(
                          children: [
                            GestureDetector(
                              onTap: () async {
                                // AutoRouter.of(context).push(
                                //     AddFoodScreenRoute(foodMenu: foodMenu));
                                AutoRouter.of(context).push(
                                    FeedbackInspectScreenRoute(
                                        foodId: foodMenu.id));

                                // showDialog(
                                //     context: context,
                                //     builder: (BuildContext context) {
                                //       return FeedbackForm(
                                //         foodId: foodMenu.id,
                                //       );
                                //     });
                              },
                              child: Card(
                                child: SizedBox(
                                  width: 300,
                                  height: 100,
                                  child: Row(
                                    children: [
                                      Image.memory(
                                        foodMenu.image,
                                        width: 100,
                                        height: 100,
                                        fit: BoxFit.cover,
                                      ),
                                      Column(
                                        children: [
                                          Text(foodMenu.name),
                                          Text("Rs. ${foodMenu.cost}"),
                                        ],
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            )
                          ],
                        );
                      }),
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
      ),
    );
  }
}
