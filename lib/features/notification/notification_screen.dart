import 'package:auto_route/annotations.dart';
import 'package:flutter/material.dart';
import 'package:fyp/constants/designing/dimension.dart';
import 'package:fyp/constants/designing/image_path.dart';
import 'package:fyp/constants/designing/screen_name.dart';
import 'package:fyp/features/notification/notification-service/notification_service.dart';
import 'package:fyp/helper/pagination/pagination_data.dart';
import 'package:fyp/helper/widgets/global/header_widgets.dart';
import 'package:fyp/model/notification/notification_model.dart';
import 'package:fyp/podo/notification/notification_pagination.dart';
import 'package:fyp/utils/drawer/drawer.dart';

@RoutePage()
class NotificationScreen extends StatefulWidget {
  const NotificationScreen({super.key});

  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  final ScrollController _scrollController = ScrollController();
  late NotificationService notificationService;
  NotificationPaginationPayload paginationPayload =
      NotificationPaginationPayload();

  late Future<PaginatedData<NotificationModel>> notificationFuture;

  List<NotificationModel> notifications = [];
  int totalPage = 1;
  bool isLoading = false;
  bool initialLoading = true;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    notificationService = NotificationService(context);
    // notificationFuture =
    //     notificationService.getAllNotification(paginationPayload.toJson());
    getNotifications();
    _scrollController.addListener(loadMoreData);
  }

  Future<void> refresh() async {}

  Future<void> getNotifications() async {
    setState(() {
      isLoading = true;
    });

    PaginatedData<NotificationModel> notificationsPagination =
        await notificationService
            .getAllNotification(paginationPayload.toJson());
    Future.delayed(Duration(seconds: 6));
    setState(() {
      isLoading = false;
      initialLoading = false;
      totalPage = notificationsPagination.totalPages;
      notifications.addAll(notificationsPagination.content);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          title: const Text("Notifications"),
          // centerTitle: true,
        ),
        body: RefreshIndicator(
          onRefresh: refresh,
          child: !initialLoading
              ? Container(
                  height: Dimension.getScreenHeight(context),
                  child: ListView.builder(
                    physics: const AlwaysScrollableScrollPhysics(),
                    controller: _scrollController,
                    shrinkWrap: false,
                    itemCount: notifications.length,
                    itemBuilder: (context, index) {
                      return Column(
                        children: [
                          ListTile(
                            leading: Image.asset(ImagePath.getImagePath(
                                ScreenName.landing, "anon.jpg")),
                            title: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(notifications[index].message),
                                if (notifications[index].remark != null)
                                  Text(
                                    notifications[index].remark!,
                                    style:
                                        TextStyle(fontStyle: FontStyle.italic),
                                  ),
                              ],
                            ),
                            subtitle: Text(notifications[index].date),
                          ),
                          if (index == notifications.length - 1 && isLoading)
                            const Padding(
                              padding: EdgeInsets.all(10),
                              child: CircularProgressIndicator(),
                            )
                        ],
                      );
                    },
                  ))
              : Container(
                  height: Dimension.getScreenHeight(context),
                  child: const Center(child: CircularProgressIndicator()),
                ),
        ));
  }

  void loadMoreData() {
    if (_scrollController.position.pixels ==
            _scrollController.position.maxScrollExtent &&
        paginationPayload.page < totalPage) {
      paginationPayload.page++;
      getNotifications();
    }
  }
}
