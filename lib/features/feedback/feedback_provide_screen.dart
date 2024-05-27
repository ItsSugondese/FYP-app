import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:fyp/config/network/api/GoogleSignInApi.dart';
import 'package:fyp/constants/designing/dimension.dart';
import 'package:fyp/features/feedback/feedback-service/feedback_service.dart';
import 'package:fyp/features/feedback/widgets/FoodForFeedbackCardWidget.dart';
import 'package:fyp/helper/widgets/global/header_widgets.dart';
import 'package:fyp/podo/feedback/food_menu_for_feedback.dart';
import 'package:fyp/routes/routes_import.gr.dart';
import 'package:fyp/utils/drawer/drawer.dart';

@RoutePage()
class FeedbackProvideScreen extends StatefulWidget {
  const FeedbackProvideScreen({super.key});

  @override
  State<FeedbackProvideScreen> createState() => _FeedbackProvideScreenState();
}

class _FeedbackProvideScreenState extends State<FeedbackProvideScreen> {
  late FeedbackService feedbackService;
  late Future<List<FoodMenuForFeedback>> menuToFeedbackFuture;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    feedbackService = FeedbackService(context);
    fetchMenuToFeedback();
  }

  fetchMenuToFeedback() {
    menuToFeedbackFuture = feedbackService.getMenusToFeedback();
  }

  Future<void> refresh() async {
    setState(() {
      fetchMenuToFeedback();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        // drawer: MyDrawer(),
        appBar: AppBar(
          title: Text("Feedback"),
        ),
        backgroundColor: const Color(0xFFF5F5F0),
        body: RefreshIndicator(
          onRefresh: refresh,
          child: SingleChildScrollView(
            physics: const AlwaysScrollableScrollPhysics(),
            child: Container(
                padding: const EdgeInsets.only(top: 50, left: 20, right: 20),
                height: Dimension.getScreenHeight(context),
                child: Stack(
                  children: [
                    Align(
                      alignment: Alignment.center,
                      child: Container(
                        padding: EdgeInsets.only(),
                        height: Dimension.getScreenHeight(context),
                        child: FutureBuilder<List<FoodMenuForFeedback>>(
                            future: menuToFeedbackFuture,
                            builder: (context, snapshot) {
                              if (snapshot.connectionState ==
                                  ConnectionState.waiting) {
                                return const Center(
                                  child: CircularProgressIndicator(),
                                );
                              } else if (snapshot.hasData) {
                                List<FoodMenuForFeedback> foodMenus =
                                    snapshot.data!;
                                return Container(
                                  width: Dimension.getScreenWidth(context),
                                  height: Dimension.getScreenHeight(context),
                                  child: SingleChildScrollView(
                                    child: Column(
                                      children: [
                                        for (int i = 0;
                                            i < foodMenus.length;
                                            i += 2)
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              FoodForFeedbackCardWidget(
                                                foodMenu: foodMenus[i],
                                                callback: (val) {
                                                  if (val) {
                                                    setState(() {
                                                      fetchMenuToFeedback();
                                                    });
                                                  }
                                                },
                                              ),
                                              if ((foodMenus.length - 1 >=
                                                      i + 1) &&
                                                  foodMenus.length > 2)
                                                FoodForFeedbackCardWidget(
                                                    foodMenu: foodMenus[i + 1],
                                                    callback: (val) {
                                                      if (val) {
                                                        setState(() {
                                                          fetchMenuToFeedback();
                                                        });
                                                      }
                                                    }),
                                            ],
                                          ),
                                      ],
                                    ),
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
                      ),
                    ),
                  ],
                )),
          ),
        ));
  }
}
