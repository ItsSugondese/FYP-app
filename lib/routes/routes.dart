part of 'routes_import.dart';

@AutoRouterConfig(replaceInRouteName: 'Route')
class AppRouter extends $AppRouter {
  @override
  RouteType get defaultRouteType => RouteType.adaptive();

  @override
  List<AutoRoute> get routes => [
        /// routes go here
        AutoRoute(
          page: LandingPageScreenRoute.page,
        ),
        AutoRoute(page: ForgotPasswordScreenRoute.page),
        AutoRoute(page: LoginScreenRoute.page),
        AutoRoute(page: HomepageRoute.page),
        AutoRoute(page: UserLayoutRoute.page, initial: true),
        AutoRoute(page: SelectedFoodToOrderScreenRoute.page),
        AutoRoute(
          page: OrderedFoodScreenRoute.page,
        ),
        AutoRoute(page: StaffHomepageRoute.page),
        AutoRoute(page: AdminHomepageRoute.page),
        AutoRoute(page: FoodManagementScreenRoute.page),
        AutoRoute(page: OnlineOrderScreenRoute.page),
        AutoRoute(page: OnsiteOrderScreenRoute.page),
        AutoRoute(page: UserManagementScreenRoute.page),
        AutoRoute(page: StaffManagementScreenRoute.page),
        AutoRoute(page: UserDetailsScreenRoute.page),
        AutoRoute(page: StaffDetailsScreenRoute.page),
        AutoRoute(page: DisableHistoryScreenRoute.page),
        AutoRoute(page: FeedbackInspectScreenRoute.page),
        AutoRoute(
          page: CurrentOrderScreenRoute.page,
        ),
        AutoRoute(page: OrderHistoryManagementScreenRoute.page),
        AutoRoute(page: UserPaymentManagementScreenRoute.page),
        AutoRoute(page: FeedbackProvideScreenRoute.page),
        AutoRoute(page: NotificationScreenRoute.page),
        AutoRoute(page: OrderHistoryScreenRoute.page),
      ];
}
