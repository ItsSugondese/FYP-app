part of 'routes_import.dart';

@AutoRouterConfig(replaceInRouteName: 'Route')
class AppRouter extends $AppRouter {

  @override
  RouteType get defaultRouteType => RouteType.adaptive();

  @override
  List<AutoRoute> get routes => [
    /// routes go here
    AutoRoute(page: LoginScreenRoute.page,),
    // AutoRoute(page: LoginScreenRoute.page, initial: true),
    AutoRoute(page: HomepageRoute.page, initial: true),
    // AutoRoute(page: HomepageRoute.page),
    AutoRoute(page: StaffHomepageRoute.page),
    AutoRoute(page: AdminHomepageRoute.page)
  ];
}