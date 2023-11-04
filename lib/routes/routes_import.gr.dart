// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouterGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:auto_route/auto_route.dart' as _i6;
import 'package:fyp/features/admin/admin_homepage.dart' as _i1;
import 'package:fyp/features/everyone/login/login.dart' as _i3;
import 'package:fyp/features/everyone/test.dart' as _i5;
import 'package:fyp/features/staff/staff_homepage.dart' as _i4;
import 'package:fyp/features/users/homepage/homepage.dart' as _i2;

abstract class $AppRouter extends _i6.RootStackRouter {
  $AppRouter({super.navigatorKey});

  @override
  final Map<String, _i6.PageFactory> pagesMap = {
    AdminHomepageRoute.name: (routeData) {
      return _i6.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i1.AdminHomepage(),
      );
    },
    HomepageRoute.name: (routeData) {
      return _i6.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i2.Homepage(),
      );
    },
    LoginScreenRoute.name: (routeData) {
      return _i6.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i3.LoginScreen(),
      );
    },
    StaffHomepageRoute.name: (routeData) {
      return _i6.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i4.StaffHomepage(),
      );
    },
    TestScreenRoute.name: (routeData) {
      return _i6.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i5.TestScreen(),
      );
    },
  };
}

/// generated route for
/// [_i1.AdminHomepage]
class AdminHomepageRoute extends _i6.PageRouteInfo<void> {
  const AdminHomepageRoute({List<_i6.PageRouteInfo>? children})
      : super(
          AdminHomepageRoute.name,
          initialChildren: children,
        );

  static const String name = 'AdminHomepageRoute';

  static const _i6.PageInfo<void> page = _i6.PageInfo<void>(name);
}

/// generated route for
/// [_i2.Homepage]
class HomepageRoute extends _i6.PageRouteInfo<void> {
  const HomepageRoute({List<_i6.PageRouteInfo>? children})
      : super(
          HomepageRoute.name,
          initialChildren: children,
        );

  static const String name = 'HomepageRoute';

  static const _i6.PageInfo<void> page = _i6.PageInfo<void>(name);
}

/// generated route for
/// [_i3.LoginScreen]
class LoginScreenRoute extends _i6.PageRouteInfo<void> {
  const LoginScreenRoute({List<_i6.PageRouteInfo>? children})
      : super(
          LoginScreenRoute.name,
          initialChildren: children,
        );

  static const String name = 'LoginScreenRoute';

  static const _i6.PageInfo<void> page = _i6.PageInfo<void>(name);
}

/// generated route for
/// [_i4.StaffHomepage]
class StaffHomepageRoute extends _i6.PageRouteInfo<void> {
  const StaffHomepageRoute({List<_i6.PageRouteInfo>? children})
      : super(
          StaffHomepageRoute.name,
          initialChildren: children,
        );

  static const String name = 'StaffHomepageRoute';

  static const _i6.PageInfo<void> page = _i6.PageInfo<void>(name);
}

/// generated route for
/// [_i5.TestScreen]
class TestScreenRoute extends _i6.PageRouteInfo<void> {
  const TestScreenRoute({List<_i6.PageRouteInfo>? children})
      : super(
          TestScreenRoute.name,
          initialChildren: children,
        );

  static const String name = 'TestScreenRoute';

  static const _i6.PageInfo<void> page = _i6.PageInfo<void>(name);
}
