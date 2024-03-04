import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:fyp/config/network/api/GoogleSignInApi.dart';
import 'package:fyp/constants/data/food-menu/filter_food_menu.dart';
import 'package:fyp/constants/designing/colors.dart';
import 'package:fyp/constants/designing/dimension.dart';
import 'package:fyp/constants/designing/image_path.dart';
import 'package:fyp/constants/designing/screen_name.dart';
import 'package:fyp/enums/crud_type.dart';
import 'package:fyp/features/food-mgmt/food-mgmt-service/food_management_service.dart';
import 'package:fyp/features/homepage/constants/homepage_constant.dart';
import 'package:fyp/features/homepage/make-order/item_selected_modal.dart';
import 'package:fyp/features/homepage/select-to-order/edit_order_items.dart';
import 'package:fyp/features/homepage/selected_food_to_order_screen.dart';
import 'package:fyp/features/homepage/widgets/food_cards.dart';
import 'package:fyp/features/homepage/widgets/homepage_widgets.dart';
import 'package:fyp/helper/pagination/pagination_data.dart';
import 'package:fyp/helper/widgets/global/food_filter_widgets.dart';
import 'package:fyp/helper/widgets/global/header_widgets.dart';
import 'package:fyp/helper/widgets/search_widget.dart';
import 'package:fyp/helper/widgets/simple_dialog.dart';
import 'package:fyp/model/foodmgmt/food_menu.dart';
import 'package:fyp/podo/foodmgmt/food_menu_pagination.dart';
import 'package:fyp/podo/foodmgmt/food_ordering_details.dart';
import 'package:fyp/templates/not-found/no_data.dart';
import 'package:fyp/utils/drawer/drawer.dart';
import 'package:liquid_pull_to_refresh/liquid_pull_to_refresh.dart';

import '../../routes/routes_import.gr.dart';

@RoutePage()
class Homepage extends StatefulWidget {
  const Homepage({Key? key}) : super(key: key);

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  // HomepageService homepageService = HomepageService();
  // FoodManagementService foodManagementService = FoodManagementService();
  late FoodManagementService foodManagementService;
  List<FoodOrderingDetails> foodSelectedForOrderingList = [];
  final ScrollController _scrollController = ScrollController();
  late Future<PaginatedData<FoodMenu>> foodMenuFuture;
  // late Future<PaginatedData<FoodMenu>> foodMenuFuture;
  late HomepageWidgets homeWidget;
  FoodMenuPaginationPayload paginationPayload = FoodMenuPaginationPayload();

  int selectedQuantity = 0; // Initialize with a default value
  int selectedFilterer = 1;
  // int selectedFilterer = 1;
  @override
  void initState() {
    super.initState();
    homeWidget = HomepageWidgets(context: context);
    foodManagementService = FoodManagementService(context);
    paginationPayload.filter = "TODAY";
    fetchFoodMenu();
  }

  fetchFoodMenu() {
    foodMenuFuture = foodManagementService
        .getFoodDetailsPaginated(paginationPayload.toJson());
  }

  Future<void> refresh() async {
    setState(() {
      fetchFoodMenu();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        drawer: MyDrawer(),
        backgroundColor: const Color(0xFFF5F5F0),
        floatingActionButton:
            // foodSelectedForOrderingList.length == 0?
            FloatingActionButton(
          backgroundColor: foodSelectedForOrderingList.length == 0
              ? CustomColors.disableButton
              : CustomColors.defaultRedColor,
          foregroundColor: foodSelectedForOrderingList.length == 0
              ? CustomColors.disableText
              : Colors.white,
          child: Text("${foodSelectedForOrderingList.length}"),
          onPressed: foodSelectedForOrderingList.length == 0
              ? null
              : () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => EditOrderItems(
                                details: foodSelectedForOrderingList,
                                callback: removeOrUpdateItemFromOrderList,
                                payCallback: ((p0) => {}),
                              )));

                  // openModalButtonSheet(context, foodSelectedForOrderingList,
                  //     removeOrUpdateItemFromOrderList);
                },
        ),
        // : null,
        body: RefreshIndicator(
          onRefresh: refresh,
          child: SingleChildScrollView(
            physics: const AlwaysScrollableScrollPhysics(),
            child: Container(
                padding: const EdgeInsets.only(top: 50, left: 20),
                height: Dimension.getScreenHeight(context),
                child: Stack(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(right: 20),
                      child: Builder(
                        builder: (context) =>
                            GlobalHeaderWidget.getHeader(context),
                      ),
                    ),
                    Align(
                      alignment: Alignment.center,
                      child: Container(
                        padding: EdgeInsets.only(
                          top: 70,
                        ),
                        height: Dimension.getScreenHeight(context),
                        child: Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(right: 20),
                              child: SearchWidget(
                                typedText: (val) {
                                  paginationPayload.name =
                                      val.trim() == "" ? null : val;
                                  setState(() {
                                    fetchFoodMenu();
                                  });
                                },
                              ),
                            ),
                            const Spacer(),
                            GlobalFoodFilterWidget(
                                selectedFilterer: selectedFilterer,
                                selectedFilter: (val) {
                                  paginationPayload.foodType =
                                      (val == "All") ? null : val.toUpperCase();
                                  setState(() {
                                    selectedFilterer =
                                        FoodMenuFilterer.findKeyByValue(val);

                                    fetchFoodMenu();
                                  });
                                }),
                            const Spacer(),
                            FutureBuilder<PaginatedData<FoodMenu>>(
                                future: foodMenuFuture,
                                builder: (context, snapshot) {
                                  if (snapshot.connectionState ==
                                      ConnectionState.waiting) {
                                    return homeWidget.getContentContainer(
                                      const Center(
                                        child: CircularProgressIndicator(),
                                      ),
                                    );
                                  } else if (snapshot.hasData) {
                                    List<FoodMenu> foodMenus =
                                        snapshot.data!.content;
                                    return foodMenus.length == 0
                                        ? homeWidget.getContentContainer(
                                            NoData.getNoDataImage())
                                        : homeWidget.getContentContainer(
                                            SingleChildScrollView(
                                              physics:
                                                  const AlwaysScrollableScrollPhysics(),
                                              scrollDirection: Axis.horizontal,
                                              child: Row(
                                                  // mainAxisAlignment:
                                                  //     MainAxisAlignment.end,
                                                  children: [
                                                    for (int i = 0;
                                                        i < foodMenus.length;
                                                        foodMenus.length <= 2
                                                            ? i++
                                                            : i += 2)
                                                      Column(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .spaceAround,
                                                        children: [
                                                          GestureDetector(
                                                            onTap: () {
                                                              // showDialog(
                                                              //   context: context,
                                                              //   builder:
                                                              //       (BuildContext
                                                              //           context) {

                                                              // Navigator.push(
                                                              //     context,
                                                              //     MaterialPageRoute(
                                                              //         builder: (context) => SelectedFoodToOrderScreen(
                                                              //             foodMenu:
                                                              //                 foodMenus[
                                                              //                     i],
                                                              //             callback:
                                                              //                 handleQuantitySelection)));
                                                              //           }
                                                              // );
                                                              selectQuantityToOrderAction(
                                                                  foodMenus[i]);

                                                              // SimpleDialogWidget
                                                              //     .showSimpleDialog(
                                                              //         context,
                                                              //         foodMenus[i],
                                                              //         handleQuantitySelection);
                                                            },
                                                            child: FoodCardWidget(
                                                                foodMenu:
                                                                    foodMenus[
                                                                        i]),
                                                          ),
                                                          (foodMenus.length -
                                                                          1 >=
                                                                      i + 1) &&
                                                                  foodMenus
                                                                          .length >
                                                                      2
                                                              ? GestureDetector(
                                                                  onTap: () {
                                                                    // SimpleDialogWidget
                                                                    //     .showSimpleDialog(
                                                                    //         context,
                                                                    //         foodMenus[
                                                                    //             i + 1],
                                                                    //         handleQuantitySelection);

                                                                    selectQuantityToOrderAction(
                                                                        foodMenus[i +
                                                                            1]);
                                                                  },
                                                                  child: FoodCardWidget(
                                                                      foodMenu:
                                                                          foodMenus[i +
                                                                              1]),
                                                                )
                                                              : Opacity(
                                                                  opacity: 0.0,
                                                                  child: FoodCardWidget(
                                                                      foodMenu:
                                                                          foodMenus[
                                                                              i]),
                                                                ),
                                                        ],
                                                      ),
                                                  ]),
                                            ),
                                          );
                                  } else {
                                    return Column(
                                      children: [
                                        ElevatedButton(
                                            child: const Text("Remove data"),
                                            onPressed: () =>
                                                {GoogleSignInApi.logout()}),
                                        ElevatedButton(
                                            child: const Text("Login"),
                                            onPressed: () => {
                                                  AutoRouter.of(context).push(
                                                      const LoginScreenRoute())
                                                }),
                                        Text("${snapshot.error}")
                                      ],
                                    );
                                  }
                                }),
                            const Spacer()
                          ],
                        ),
                      ),
                    ),
                  ],
                )),
          ),
        ));
  }

  void selectQuantityToOrderAction(FoodMenu foodMenu) {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => SelectedFoodToOrderScreen(
                foodMenu: foodMenu, callback: handleQuantitySelection)));
  }

  void removeOrUpdateItemFromOrderList(
      int index, int quantity, ActionType type) {
    if (type == ActionType.remove) {
      setState(() {
        foodSelectedForOrderingList.removeAt(index);
      });
    } else if (type == ActionType.update) {
      foodSelectedForOrderingList[index].quantity = quantity;
    }
  }

  void handleQuantitySelection(int quantity, FoodMenu foodMenu) {
    selectedQuantity = quantity;
    setState(() {
      bool found = false;
      // Store the selected quantity
      for (int i = 0; i < foodSelectedForOrderingList.length; i++) {
        if (foodSelectedForOrderingList[i].foodMenu.id == foodMenu.id) {
          found = true;
          foodSelectedForOrderingList[i].quantity = quantity;
          break;
        }
      }
      if (!found) {
        foodSelectedForOrderingList
            .add(FoodOrderingDetails(quantity: quantity, foodMenu: foodMenu));
      }
    });
    selectedQuantity = 0;
  }
}

// class _HomepageState extends State<Homepage> {
//   // HomepageService homepageService = HomepageService();
//   FoodManagementService foodManagementService = FoodManagementService();
//   List<FoodOrderingDetails> foodSelectedForOrderingList = [];

//   int selectedQuantity = 0; // Initialize with a default value

//   @override
//   void initState() {
//     // TODO: implement initState
//     super.initState();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text("Homepage"),
//       ),
//       drawer: MyDrawer(),
//       floatingActionButton:
//           // foodSelectedForOrderingList.length == 0?
//           FloatingActionButton(
//         child: Text("${foodSelectedForOrderingList.length}"),
//         onPressed: () {
//           openModalButtonSheet(context, foodSelectedForOrderingList,
//               removeOrUpdateItemFromOrderList);
//         },
//       ),
//       // : null,
//       body: Container(
//         child: FutureBuilder<List<FoodMenu>>(
//             // future: homepageService.getFoodMenusWithImages(),
//             future: foodManagementService.getFoodDetails(),
//             builder: (context, snapshot) {
//               if (snapshot.hasData) {
//                 return Center(
//                   child: ListView.builder(
//                       shrinkWrap: true,
//                       itemCount: snapshot.data?.length,
//                       itemBuilder: (BuildContext context, int index) {
//                         FoodMenu foodMenu = snapshot.data![index];
//                         return Column(
//                           children: [
//                             GestureDetector(
//                               onTap: () {
//                                 SimpleDialogWidget.showSimpleDialog(
//                                     context, foodMenu, handleQuantitySelection);
//                               },
//                               child: Card(
//                                 child: SizedBox(
//                                   width: 300,
//                                   height: 100,
//                                   child: Row(
//                                     children: [
//                                       Image.memory(
//                                         foodMenu.image,
//                                         width: 100,
//                                         height: 100,
//                                         fit: BoxFit.cover,
//                                       ),
//                                       Column(
//                                         children: [
//                                           Text(foodMenu.name),
//                                           Text("Rs. ${foodMenu.cost}"),
//                                         ],
//                                       )
//                                     ],
//                                   ),
//                                 ),
//                               ),
//                             )
//                           ],
//                         );
//                       }),
//                 );
//               } else if (snapshot.hasError) {
//                 return Column(
//                   children: [
//                     ElevatedButton(
//                         child: Text("Remove data"),
//                         onPressed: () => {GoogleSignInApi.logout()}),
//                     ElevatedButton(
//                         child: Text("Login"),
//                         onPressed: () => {
//                               AutoRouter.of(context)
//                                   .push(const LoginScreenRoute())
//                             }),
//                     Text("${snapshot.error}")
//                   ],
//                 );
//               } else {
//                 return CircularProgressIndicator();
//               }
//             }),
//       ),
//     );
//   }

//   void removeOrUpdateItemFromOrderList(
//       int index, int quantity, ActionType type) {
//     if (type == ActionType.remove) {
//       setState(() {
//         foodSelectedForOrderingList.removeAt(index);
//       });
//     } else if (type == ActionType.update) {
//       foodSelectedForOrderingList[index].quantity = quantity;
//     }
//   }

//   void handleQuantitySelection(int quantity, FoodMenu foodMenu) {
//     selectedQuantity = quantity;
//     setState(() {
//       bool found = false;
//       // Store the selected quantity
//       for (int i = 0; i < foodSelectedForOrderingList.length; i++) {
//         if (foodSelectedForOrderingList[i].foodMenu.id == foodMenu.id) {
//           found = true;
//           foodSelectedForOrderingList[i].quantity = quantity;
//           break;
//         }
//       }
//       if (!found) {
//         foodSelectedForOrderingList
//             .add(FoodOrderingDetails(quantity: quantity, foodMenu: foodMenu));
//       }
//     });
//     selectedQuantity = 0;
//   }
// }
