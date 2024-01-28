// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouterGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:auto_route/auto_route.dart' as _i15;
import 'package:flutter/material.dart' as _i16;
import 'package:fyp/features/admin-dashboard/admin_homepage.dart' as _i2;
import 'package:fyp/features/food-mgmt/add_food_screen.dart' as _i1;
import 'package:fyp/features/food-mgmt/food_mgmt_screen.dart' as _i4;
import 'package:fyp/features/homepage/homepage.dart' as _i5;
import 'package:fyp/features/landing-screen/landing_screen.dart' as _i6;
import 'package:fyp/features/login/login.dart' as _i7;
import 'package:fyp/features/order-mgmt/online-order/online_order_screen.dart'
    as _i8;
import 'package:fyp/features/order-mgmt/onsite-order/onsite_order_screen.dart'
    as _i9;
import 'package:fyp/features/people-mgmt/disable_history_screen.dart' as _i3;
import 'package:fyp/features/people-mgmt/staff-mgmt/staff-inspect/staff_details.dart'
    as _i10;
import 'package:fyp/features/people-mgmt/staff-mgmt/staff_management_screen.dart'
    as _i12;
import 'package:fyp/features/people-mgmt/user-mgmt/user-inspect/user_details.dart'
    as _i13;
import 'package:fyp/features/people-mgmt/user-mgmt/user_management_screen.dart'
    as _i14;
import 'package:fyp/features/staff/staff_homepage.dart' as _i11;
import 'package:fyp/model/foodmgmt/food_menu.dart' as _i17;

abstract class $AppRouter extends _i15.RootStackRouter {
  $AppRouter({super.navigatorKey});

  @override
  final Map<String, _i15.PageFactory> pagesMap = {
    AddFoodScreenRoute.name: (routeData) {
      final args = routeData.argsAs<AddFoodScreenRouteArgs>(
          orElse: () => const AddFoodScreenRouteArgs());
      return _i15.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i1.AddFoodScreen(
          key: args.key,
          foodMenu: args.foodMenu,
        ),
      );
    },
    AdminHomepageRoute.name: (routeData) {
      return _i15.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i2.AdminHomepage(),
      );
    },
    DisableHistoryScreenRoute.name: (routeData) {
      final args = routeData.argsAs<DisableHistoryScreenRouteArgs>();
      return _i15.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i3.DisableHistoryScreen(
          key: args.key,
          id: args.id,
        ),
      );
    },
    FoodManagementScreenRoute.name: (routeData) {
      return _i15.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i4.FoodManagementScreen(),
      );
    },
    HomepageRoute.name: (routeData) {
      return _i15.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i5.Homepage(),
      );
    },
    LandingPageScreenRoute.name: (routeData) {
      return _i15.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i6.LandingPageScreen(),
      );
    },
    LoginScreenRoute.name: (routeData) {
      return _i15.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i7.LoginScreen(),
      );
    },
    OnlineOrderScreenRoute.name: (routeData) {
      return _i15.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i8.OnlineOrderScreen(),
      );
    },
    OnsiteOrderScreenRoute.name: (routeData) {
      return _i15.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i9.OnsiteOrderScreen(),
      );
    },
    StaffDetailsScreenRoute.name: (routeData) {
      final args = routeData.argsAs<StaffDetailsScreenRouteArgs>();
      return _i15.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i10.StaffDetailsScreen(
          key: args.key,
          id: args.id,
        ),
      );
    },
    StaffHomepageRoute.name: (routeData) {
      return _i15.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i11.StaffHomepage(),
      );
    },
    StaffManagementScreenRoute.name: (routeData) {
      return _i15.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i12.StaffManagementScreen(),
      );
    },
    UserDetailsScreenRoute.name: (routeData) {
      final args = routeData.argsAs<UserDetailsScreenRouteArgs>();
      return _i15.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i13.UserDetailsScreen(
          key: args.key,
          id: args.id,
        ),
      );
    },
    UserManagementScreenRoute.name: (routeData) {
      return _i15.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i14.UserManagementScreen(),
      );
    },
  };
}

/// generated route for
/// [_i1.AddFoodScreen]
class AddFoodScreenRoute extends _i15.PageRouteInfo<AddFoodScreenRouteArgs> {
  AddFoodScreenRoute({
    _i16.Key? key,
    _i17.FoodMenu? foodMenu,
    List<_i15.PageRouteInfo>? children,
  }) : super(
          AddFoodScreenRoute.name,
          args: AddFoodScreenRouteArgs(
            key: key,
            foodMenu: foodMenu,
          ),
          initialChildren: children,
        );

  static const String name = 'AddFoodScreenRoute';

  static const _i15.PageInfo<AddFoodScreenRouteArgs> page =
      _i15.PageInfo<AddFoodScreenRouteArgs>(name);
}

class AddFoodScreenRouteArgs {
  const AddFoodScreenRouteArgs({
    this.key,
    this.foodMenu,
  });

  final _i16.Key? key;

  final _i17.FoodMenu? foodMenu;

  @override
  String toString() {
    return 'AddFoodScreenRouteArgs{key: $key, foodMenu: $foodMenu}';
  }
}

/// generated route for
/// [_i2.AdminHomepage]
class AdminHomepageRoute extends _i15.PageRouteInfo<void> {
  const AdminHomepageRoute({List<_i15.PageRouteInfo>? children})
      : super(
          AdminHomepageRoute.name,
          initialChildren: children,
        );

  static const String name = 'AdminHomepageRoute';

  static const _i15.PageInfo<void> page = _i15.PageInfo<void>(name);
}

/// generated route for
/// [_i3.DisableHistoryScreen]
class DisableHistoryScreenRoute
    extends _i15.PageRouteInfo<DisableHistoryScreenRouteArgs> {
  DisableHistoryScreenRoute({
    _i16.Key? key,
    required int id,
    List<_i15.PageRouteInfo>? children,
  }) : super(
          DisableHistoryScreenRoute.name,
          args: DisableHistoryScreenRouteArgs(
            key: key,
            id: id,
          ),
          initialChildren: children,
        );

  static const String name = 'DisableHistoryScreenRoute';

  static const _i15.PageInfo<DisableHistoryScreenRouteArgs> page =
      _i15.PageInfo<DisableHistoryScreenRouteArgs>(name);
}

class DisableHistoryScreenRouteArgs {
  const DisableHistoryScreenRouteArgs({
    this.key,
    required this.id,
  });

  final _i16.Key? key;

  final int id;

  @override
  String toString() {
    return 'DisableHistoryScreenRouteArgs{key: $key, id: $id}';
  }
}

/// generated route for
/// [_i4.FoodManagementScreen]
class FoodManagementScreenRoute extends _i15.PageRouteInfo<void> {
  const FoodManagementScreenRoute({List<_i15.PageRouteInfo>? children})
      : super(
          FoodManagementScreenRoute.name,
          initialChildren: children,
        );

  static const String name = 'FoodManagementScreenRoute';

  static const _i15.PageInfo<void> page = _i15.PageInfo<void>(name);
}

/// generated route for
/// [_i5.Homepage]
class HomepageRoute extends _i15.PageRouteInfo<void> {
  const HomepageRoute({List<_i15.PageRouteInfo>? children})
      : super(
          HomepageRoute.name,
          initialChildren: children,
        );

  static const String name = 'HomepageRoute';

  static const _i15.PageInfo<void> page = _i15.PageInfo<void>(name);
}

/// generated route for
/// [_i6.LandingPageScreen]
class LandingPageScreenRoute extends _i15.PageRouteInfo<void> {
  const LandingPageScreenRoute({List<_i15.PageRouteInfo>? children})
      : super(
          LandingPageScreenRoute.name,
          initialChildren: children,
        );

  static const String name = 'LandingPageScreenRoute';

  static const _i15.PageInfo<void> page = _i15.PageInfo<void>(name);
}

/// generated route for
/// [_i7.LoginScreen]
class LoginScreenRoute extends _i15.PageRouteInfo<void> {
  const LoginScreenRoute({List<_i15.PageRouteInfo>? children})
      : super(
          LoginScreenRoute.name,
          initialChildren: children,
        );

  static const String name = 'LoginScreenRoute';

  static const _i15.PageInfo<void> page = _i15.PageInfo<void>(name);
}

/// generated route for
/// [_i8.OnlineOrderScreen]
class OnlineOrderScreenRoute extends _i15.PageRouteInfo<void> {
  const OnlineOrderScreenRoute({List<_i15.PageRouteInfo>? children})
      : super(
          OnlineOrderScreenRoute.name,
          initialChildren: children,
        );

  static const String name = 'OnlineOrderScreenRoute';

  static const _i15.PageInfo<void> page = _i15.PageInfo<void>(name);
}

/// generated route for
/// [_i9.OnsiteOrderScreen]
class OnsiteOrderScreenRoute extends _i15.PageRouteInfo<void> {
  const OnsiteOrderScreenRoute({List<_i15.PageRouteInfo>? children})
      : super(
          OnsiteOrderScreenRoute.name,
          initialChildren: children,
        );

  static const String name = 'OnsiteOrderScreenRoute';

  static const _i15.PageInfo<void> page = _i15.PageInfo<void>(name);
}

/// generated route for
/// [_i10.StaffDetailsScreen]
class StaffDetailsScreenRoute
    extends _i15.PageRouteInfo<StaffDetailsScreenRouteArgs> {
  StaffDetailsScreenRoute({
    _i16.Key? key,
    required int id,
    List<_i15.PageRouteInfo>? children,
  }) : super(
          StaffDetailsScreenRoute.name,
          args: StaffDetailsScreenRouteArgs(
            key: key,
            id: id,
          ),
          initialChildren: children,
        );

  static const String name = 'StaffDetailsScreenRoute';

  static const _i15.PageInfo<StaffDetailsScreenRouteArgs> page =
      _i15.PageInfo<StaffDetailsScreenRouteArgs>(name);
}

class StaffDetailsScreenRouteArgs {
  const StaffDetailsScreenRouteArgs({
    this.key,
    required this.id,
  });

  final _i16.Key? key;

  final int id;

  @override
  String toString() {
    return 'StaffDetailsScreenRouteArgs{key: $key, id: $id}';
  }
}

/// generated route for
/// [_i11.StaffHomepage]
class StaffHomepageRoute extends _i15.PageRouteInfo<void> {
  const StaffHomepageRoute({List<_i15.PageRouteInfo>? children})
      : super(
          StaffHomepageRoute.name,
          initialChildren: children,
        );

  static const String name = 'StaffHomepageRoute';

  static const _i15.PageInfo<void> page = _i15.PageInfo<void>(name);
}

/// generated route for
/// [_i12.StaffManagementScreen]
class StaffManagementScreenRoute extends _i15.PageRouteInfo<void> {
  const StaffManagementScreenRoute({List<_i15.PageRouteInfo>? children})
      : super(
          StaffManagementScreenRoute.name,
          initialChildren: children,
        );

  static const String name = 'StaffManagementScreenRoute';

  static const _i15.PageInfo<void> page = _i15.PageInfo<void>(name);
}

/// generated route for
/// [_i13.UserDetailsScreen]
class UserDetailsScreenRoute
    extends _i15.PageRouteInfo<UserDetailsScreenRouteArgs> {
  UserDetailsScreenRoute({
    _i16.Key? key,
    required int id,
    List<_i15.PageRouteInfo>? children,
  }) : super(
          UserDetailsScreenRoute.name,
          args: UserDetailsScreenRouteArgs(
            key: key,
            id: id,
          ),
          initialChildren: children,
        );

  static const String name = 'UserDetailsScreenRoute';

  static const _i15.PageInfo<UserDetailsScreenRouteArgs> page =
      _i15.PageInfo<UserDetailsScreenRouteArgs>(name);
}

class UserDetailsScreenRouteArgs {
  const UserDetailsScreenRouteArgs({
    this.key,
    required this.id,
  });

  final _i16.Key? key;

  final int id;

  @override
  String toString() {
    return 'UserDetailsScreenRouteArgs{key: $key, id: $id}';
  }
}

/// generated route for
/// [_i14.UserManagementScreen]
class UserManagementScreenRoute extends _i15.PageRouteInfo<void> {
  const UserManagementScreenRoute({List<_i15.PageRouteInfo>? children})
      : super(
          UserManagementScreenRoute.name,
          initialChildren: children,
        );

  static const String name = 'UserManagementScreenRoute';

  static const _i15.PageInfo<void> page = _i15.PageInfo<void>(name);
}
