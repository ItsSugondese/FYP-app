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
    PaginatedData<NotificationModel> notificationsPagination =
        await notificationService
            .getAllNotification(paginationPayload.toJson());

    setState(() {
      totalPage = notificationsPagination.totalPages;
      notifications.addAll(notificationsPagination.content);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        drawer: MyDrawer(),
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
                    Padding(
                      padding: const EdgeInsets.only(right: 0),
                      child: Builder(
                        builder: (context) =>
                            GlobalHeaderWidget.getHeader(context),
                      ),
                    ),
                    Align(
                        alignment: Alignment.center,
                        child: ListView.builder(
                          physics: const AlwaysScrollableScrollPhysics(),
                          controller: _scrollController,
                          shrinkWrap: false,
                          itemCount: notifications.length,
                          itemBuilder: (context, index) {
                            return ListTile(
                              leading: Image.asset(ImagePath.getImagePath(
                                  ScreenName.landing, "anon.jpg")),
                              title: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(notifications[index].message),
                                  if (notifications[index].remark != null)
                                    Text(
                                      notifications[index].remark!,
                                      style: TextStyle(
                                          fontStyle: FontStyle.italic),
                                    ),
                                ],
                              ),
                              subtitle: Text(notifications[index].date),
                            );
                          },
                        )),
                  ],
                )),
          ),
        ));
  }

  void loadMoreData() {
    if (_scrollController.position.pixels ==
            _scrollController.position.maxScrollExtent &&
        notifications.length < totalPage) {
      paginationPayload.page++;
      getNotifications();
    }
  }
}
