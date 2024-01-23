part of 'routes_import.dart';

@AutoRouterConfig(replaceInRouteName: 'Route')
class AppRouter extends $AppRouter {
  @override
  RouteType get defaultRouteType => RouteType.adaptive();

  @override
  List<AutoRoute> get routes => [
        /// routes go here
        AutoRoute(
          page: LoginScreenRoute.page,
        ),
        // AutoRoute(page: LoginScreenRoute.page),
        AutoRoute(page: HomepageRoute.page),
        // AutoRoute(page: HomepageRoute.page),
        AutoRoute(page: StaffHomepageRoute.page),
        AutoRoute(page: AdminHomepageRoute.page),
        AutoRoute(page: FoodManagementScreenRoute.page),
        // AutoRoute(page: FoodManagementScreenRoute.page, initial: true),
        AutoRoute(page: AddFoodScreenRoute.page),
        AutoRoute(page: OnlineOrderScreenRoute.page),
        AutoRoute(page: OnsiteOrderScreenRoute.page),
        AutoRoute(page: UserManagementScreenRoute.page, initial: true),
      ];
}
