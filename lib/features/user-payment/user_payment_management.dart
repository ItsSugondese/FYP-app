import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:fyp/constants/currency_constant.dart';
import 'package:fyp/constants/designing/dimension.dart';
import 'package:fyp/constants/designing/image_path.dart';
import 'package:fyp/constants/designing/screen_name.dart';
import 'package:fyp/constants/filter-map/pay_filter_map.dart';
import 'package:fyp/features/order-history/current-order/widgets/ordered_food_card.dart';
import 'package:fyp/features/order-history/order-history-service/order_history_service.dart';
import 'package:fyp/features/people-mgmt/user-mgmt/user-mgmt-service/user_management_service.dart';
import 'package:fyp/helper/pagination/pagination_data.dart';
import 'package:fyp/helper/widgets/global/pay_filter_widgets.dart';
import 'package:fyp/helper/widgets/search_widget.dart';
import 'package:fyp/model/order/onsite_order.dart';
import 'package:fyp/model/people/user.dart';
import 'package:fyp/podo/user-order/order_history_management_pagination.dart';
import 'package:fyp/podo/user-payment/user_payment_management_pagination.dart';
import 'package:fyp/templates/button/default_button.dart';
import 'package:fyp/templates/not-found/no_data.dart';
import 'package:fyp/templates/pop-up/pay_user_pop_up.dart';
import 'package:fyp/templates/text/food_type_text.dart';
import 'package:fyp/utils/appbar/custom-appbar.dart';
import 'package:fyp/utils/drawer/drawer.dart';

@RoutePage()
class UserPaymentManagementScreen extends StatefulWidget {
  const UserPaymentManagementScreen({super.key});

  @override
  State<UserPaymentManagementScreen> createState() =>
      _UserPaymentManagementScreenState();
}

class _UserPaymentManagementScreenState
    extends State<UserPaymentManagementScreen> {
  final ScrollController _scrollController = ScrollController();
  late UserManagementService userManagementService;
  late Future<PaginatedData<OnsiteOrder>> onsiteOrderHistoryFuture;

  List<User> userList = [];
  ManageUserPaymentPagination paginationPayload = ManageUserPaymentPagination(
    userType: ['USER', 'EXTERNAL_USER'],
  );

  bool isLoading = false;
  bool initialLoading = true;
  int totalPage = 1;
  String? errMessage;
  @override
  void initState() {
    super.initState();
    userManagementService = UserManagementService(context);

    setAndFetchUsers();
    _scrollController.addListener(loadMoreData);
  }

  @override
  void dispose() {
    super.dispose();
  }

  setAndFetchUsers() {
    setState(() {
      initialLoading = true;
    });
    paginationPayload.page = 1;
    paginationPayload.row = 10;
    userList = [];
    getUsers(true);
  }

  Future<void> getUsers(bool first) async {
    if (!first) {
      setState(() {
        isLoading = true;
      });
    }

    PaginatedData<User> onsiteOrderPagination;
    try {
      onsiteOrderPagination =
          await userManagementService.getAllUsers(paginationPayload.toJson());
      errMessage = null;
    } catch (e) {
      setState(() {
        isLoading = false;
        initialLoading = false;
        errMessage = e.toString();
      });
      throw Exception(e);
    }
    setState(() {
      isLoading = false;
      initialLoading = false;
      totalPage = onsiteOrderPagination.totalPages;
      userList.addAll(onsiteOrderPagination.content);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: const CustomAppbar(),
        drawer: MyDrawer(),
        body: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(right: 20, top: 10),
              child: SearchWidget(
                searchText: "Search User",
                typedText: (val) {
                  paginationPayload.name = val.trim() == "" ? null : val;
                  setState(() {
                    setAndFetchUsers();
                  });
                },
              ),
            ),
            GlobalPayFilterWidget(
                options: PayFilterMap.payfilterWithoutPartial,
                selectedFilter: (val) {
                  paginationPayload.payStatus = val;
                  setState(() {
                    setAndFetchUsers();
                  });
                }),
            if (errMessage != null)
              Center(child: Text(errMessage!))
            else
              !initialLoading
                  ? userList.isEmpty
                      ? RefreshIndicator(
                          onRefresh: refresh,
                          child: SingleChildScrollView(
                            physics: const AlwaysScrollableScrollPhysics(),
                            child: Center(
                              child: NoData.getNoDataImage(context, null, 0.7),
                            ),
                          ),
                        )
                      : Expanded(
                          child: RefreshIndicator(
                            onRefresh: refresh,
                            child: ListView.builder(
                              physics: const AlwaysScrollableScrollPhysics(),
                              controller: _scrollController,
                              shrinkWrap: true,
                              itemCount: userList.length,
                              itemBuilder: (context, index) {
                                return Container(
                                  margin: EdgeInsets.symmetric(horizontal: 15),
                                  width: Dimension.getScreenWidth(context),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Container(
                                        width:
                                            Dimension.getScreenWidth(context) *
                                                0.75,
                                        color: Colors.amber,
                                        child: Row(
                                          children: [
                                            ClipOval(
                                              child: userList[index]
                                                          .profilePath ==
                                                      null
                                                  ? Image.asset(
                                                      ImagePath.getImagePath(
                                                          ScreenName.landing,
                                                          "anon.jpg"),

                                                      // width: 80,
                                                      height: Dimension
                                                              .getScreenHeight(
                                                                  context) *
                                                          0.08,
                                                      fit: BoxFit.cover,
                                                    )
                                                  : Image.network(
                                                      userList[index]
                                                          .profilePath!,
                                                      height: Dimension
                                                              .getScreenHeight(
                                                                  context) *
                                                          0.08,
                                                      fit: BoxFit.cover,
                                                    ),
                                            ),
                                            const SizedBox(
                                              width: 5,
                                            ),
                                            Expanded(
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                mainAxisAlignment:
                                                    MainAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    userList[index].fullName,
                                                    style: const TextStyle(
                                                      fontWeight:
                                                          FontWeight.w500,
                                                      fontSize: 20,
                                                    ),
                                                  ),
                                                  Text(userList[index].email),
                                                  Text(
                                                    "${CurrencyConstant.currency}${userList[index].remainingAmount} ",
                                                  )
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      Expanded(
                                        child: ElevatedButton(
                                            onPressed: userList[index]
                                                        .remainingAmount ==
                                                    0
                                                ? null
                                                : () {
                                                    showDialog(
                                                      context: context,
                                                      builder: (BuildContext
                                                          context) {
                                                        return PayUserPopUp(
                                                            user:
                                                                userList[index],
                                                            callback: (val) {
                                                              if (val) {
                                                                setAndFetchUsers();
                                                              }
                                                            });
                                                      },
                                                    );
                                                  },
                                            child: Text("Pay")),
                                      )
                                    ],
                                  ),
                                );
                              },
                            ),
                          ),
                        )
                  : const Expanded(
                      child: Center(
                        child: CircularProgressIndicator(),
                      ),
                    ),
            if (isLoading)
              const Center(
                child: CircularProgressIndicator(),
              )
          ],
        ));
  }

  Future<void> refresh() async {
    setAndFetchUsers();
  }

  void loadMoreData() {
    if (_scrollController.position.pixels ==
            _scrollController.position.maxScrollExtent &&
        paginationPayload.page < totalPage) {
      paginationPayload.page++;
      getUsers(false);
    }
  }
}
