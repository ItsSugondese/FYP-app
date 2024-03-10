import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:fyp/features/feedback/feedback-service/feedback_service.dart';
import 'package:fyp/helper/pagination/pagination_data.dart';
import 'package:fyp/model/feedback/feedback.dart';
import 'package:fyp/podo/feedback/feedback_pagination.dart';
import 'package:fyp/utils/drawer/drawer.dart';

@RoutePage()
class FeedbackInspectScreen extends StatefulWidget {
  final int foodId;
  const FeedbackInspectScreen({super.key, required this.foodId});

  @override
  State<FeedbackInspectScreen> createState() => _FeedbackInspectScreenState();
}

class _FeedbackInspectScreenState extends State<FeedbackInspectScreen> {
  final PageController _pageController = PageController(initialPage: 1);
  final List<ScrollController> _scrollControllerList = [];
  FeedbackService feedbackService = FeedbackService();

  late Future<PaginatedData<FeedbackModel>> feedbackFuture;

  late FeedbackPagination paginationPayload;

  @override
  void initState() {
    super.initState();
    paginationPayload = FeedbackPagination(foodId: widget.foodId);
    feedbackFuture = feedbackService.getFeedbacks(paginationPayload.toJson());
  }

  @override
  void dispose() {
    super.dispose();
    for (ScrollController controller in _scrollControllerList) {
      controller.dispose();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Disable History'),
      ),
      drawer: MyDrawer(),
      body: FutureBuilder<PaginatedData<FeedbackModel>>(
          future: feedbackFuture,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              List<FeedbackModel> listOfFeedbacks = snapshot.data!.content;
              for (int i = 0; i < snapshot.data!.totalPages; i++) {
                _scrollControllerList.add(ScrollController());
              }
              return PageView.builder(
                controller: _pageController,
                onPageChanged: (value) {
                  setState(() {
                    paginationPayload.page = value + 1;
                    feedbackFuture = feedbackService
                        .getFeedbacks(paginationPayload.toJson());
                  });
                },
                itemCount: snapshot.data!.totalPages,
                itemBuilder: ((context, index) {
                  return Center(
                    heightFactor: 1,
                    child: SingleChildScrollView(
                      controller: _scrollControllerList[index],
                      scrollDirection: Axis.vertical,
                      child: DataTable(
                        dataRowHeight: 200,
                        columnSpacing: 200,
                        columns: [
                          DataColumn(label: Text('Id')),
                          DataColumn(label: Text('Date')),
                          DataColumn(label: Text('Is Disabled')),
                          DataColumn(label: Text('Remarks')),
                          DataColumn(label: Text('Remarks')),
                          DataColumn(label: Text('Remarks')),
                        ],
                        rows: listOfFeedbacks.map((feedbackMap) {
                          return DataRow(cells: [
                            DataCell(Text("${feedbackMap.id}")),
                            DataCell(Text(feedbackMap.date)),
                            DataCell(Text("${feedbackMap.feedbacks}")),
                            DataCell(Text("${feedbackMap.feedbackStatus}")),
                            DataCell(Text("${feedbackMap.isAnonymous}")),
                            DataCell(Image.network(feedbackMap.userProfileUrl)),
                          ]);
                        }).toList(),
                      ),
                    ),
                  );
                }),
              );
            } else if (snapshot.hasError) {
              return Column(
                children: [Text("${snapshot.error}")],
              );
            } else {
              return const CircularProgressIndicator();
            }
          }),
    );
  }
}
