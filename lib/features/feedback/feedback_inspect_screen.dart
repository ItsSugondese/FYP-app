import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:fyp/constants/designing/dimension.dart';
import 'package:fyp/features/feedback/feedback-service/feedback_service.dart';
import 'package:fyp/features/feedback/widgets/feedback_card.dart';
import 'package:fyp/helper/pagination/pagination_data.dart';
import 'package:fyp/model/feedback/feedback.dart';
import 'package:fyp/podo/feedback/feedback_pagination.dart';
import 'package:fyp/templates/not-found/no_data.dart';

@RoutePage()
class FeedbackInspectScreen extends StatefulWidget {
  final int foodId;
  final String header;
  const FeedbackInspectScreen(
      {super.key, required this.foodId, required this.header});

  @override
  State<FeedbackInspectScreen> createState() => _FeedbackInspectScreenState();
}

class _FeedbackInspectScreenState extends State<FeedbackInspectScreen> {
  final ScrollController _scrollController = ScrollController();
  late FeedbackService feedbackService;
  late Future<PaginatedData<FeedbackModel>> feedbackFuture;

  List<FeedbackModel> feedbackList = [];
  late FeedbackPagination paginationPayload;

  DateTime _startDate = DateTime.now();
  DateTime _endDate = DateTime.now();

  bool isLoading = false;
  bool initialLoading = true;
  int totalPage = 1;
  String? errMessage;
  @override
  void initState() {
    super.initState();
    paginationPayload = FeedbackPagination(
        fromDate: DateTime.now().toString().split(' ')[0],
        toDate: DateTime.now().toString().split(' ')[0],
        foodId: widget.foodId);
    feedbackService = FeedbackService(context);

    setAndFetchFeedback();
    _scrollController.addListener(loadMoreData);
  }

  @override
  void dispose() {
    super.dispose();
  }

  Future<void> _selectDateRange() async {
    final DateTimeRange? picked = await showDateRangePicker(
      context: context,
      initialDateRange: DateTimeRange(
        start: _startDate,
        end: _endDate,
      ),
      firstDate: DateTime(2020),
      lastDate: DateTime(2025),
    );

    if (picked != null) {
      setState(() {
        _startDate = picked.start;
        _endDate = picked.end;

        setAndFetchFeedback();
      });
    }
  }

  setAndFetchFeedback() {
    convertDateToString();
    setState(() {
      initialLoading = true;
    });
    paginationPayload.page = 1;
    paginationPayload.row = 10;
    feedbackList = [];
    getOrders(true);
  }

  Future<void> getOrders(bool first) async {
    if (!first) {
      setState(() {
        isLoading = true;
      });
    }

    PaginatedData<FeedbackModel> feedbackPagination;
    try {
      feedbackPagination =
          await feedbackService.getFeedbacks(paginationPayload.toJson());
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
      totalPage = feedbackPagination.totalPages;
      feedbackList.addAll(feedbackPagination.content);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(widget.header),
        ),
        body: Container(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          width: Dimension.getScreenWidth(context),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              ElevatedButton(
                  onPressed: _selectDateRange,
                  child: Text(
                      '${paginationPayload.fromDate!} - ${paginationPayload.toDate!}')),
              if (errMessage != null)
                Center(child: Text(errMessage!))
              else
                !initialLoading
                    ? (feedbackList.length == 0)
                        ? Expanded(
                            child: Center(
                            child: NoData.getNoDataImage(
                                context, "No Feedback", null),
                          ))
                        : Expanded(
                            child: RefreshIndicator(
                              onRefresh: refresh,
                              child: ListView.separated(
                                separatorBuilder: (context, index) => SizedBox(
                                  height: 20,
                                ),
                                physics: const AlwaysScrollableScrollPhysics(),
                                controller: _scrollController,
                                shrinkWrap: true,
                                itemCount: feedbackList.length,
                                itemBuilder: (context, index) {
                                  FeedbackModel feedback = feedbackList[index];
                                  return FeedbackCard(
                                    username: feedback.username,
                                    userImage: feedback.userProfileUrl,
                                    feedbackStatus: feedback.feedbackStatus,
                                    feedbackMessage: feedback.feedbacks,
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
          ),
        ));
  }

  convertDateToString() {
    paginationPayload.fromDate = _startDate.toString().split(' ')[0];
    paginationPayload.toDate = _endDate.toString().split(' ')[0];
  }

  Future<void> refresh() async {
    setAndFetchFeedback();
  }

  void loadMoreData() {
    if (_scrollController.position.pixels ==
            _scrollController.position.maxScrollExtent &&
        paginationPayload.page < totalPage) {
      paginationPayload.page++;
      getOrders(false);
    }
  }
}
