// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouterGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:auto_route/auto_route.dart' as _i16;
import 'package:flutter/material.dart' as _i17;
import 'package:fyp/features/admin-dashboard/admin_homepage.dart' as _i2;
import 'package:fyp/features/feedback/feedback_inspect_screen.dart' as _i4;
import 'package:fyp/features/food-mgmt/add_food_screen.dart' as _i1;
import 'package:fyp/features/food-mgmt/food_mgmt_screen.dart' as _i5;
import 'package:fyp/features/homepage/homepage.dart' as _i6;
import 'package:fyp/features/landing-screen/landing_screen.dart' as _i7;
import 'package:fyp/features/login/login.dart' as _i8;
import 'package:fyp/features/order-mgmt/online-order/online_order_screen.dart'
    as _i9;
import 'package:fyp/features/order-mgmt/onsite-order/onsite_order_screen.dart'
    as _i10;
import 'package:fyp/features/people-mgmt/disable_history_screen.dart' as _i3;
import 'package:fyp/features/people-mgmt/staff-mgmt/staff-inspect/staff_details.dart'
    as _i11;
import 'package:fyp/features/people-mgmt/staff-mgmt/staff_management_screen.dart'
    as _i13;
import 'package:fyp/features/people-mgmt/user-mgmt/user-inspect/user_details.dart'
    as _i14;
import 'package:fyp/features/people-mgmt/user-mgmt/user_management_screen.dart'
    as _i15;
import 'package:fyp/features/staff/staff_homepage.dart' as _i12;
import 'package:fyp/model/foodmgmt/food_menu.dart' as _i18;

abstract class $AppRouter extends _i16.RootStackRouter {
  $AppRouter({super.navigatorKey});

  @override
  final Map<String, _i16.PageFactory> pagesMap = {
    AddFoodScreenRoute.name: (routeData) {
      final args = routeData.argsAs<AddFoodScreenRouteArgs>(
          orElse: () => const AddFoodScreenRouteArgs());
      return _i16.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i1.AddFoodScreen(
          key: args.key,
          foodMenu: args.foodMenu,
        ),
      );
    },
    AdminHomepageRoute.name: (routeData) {
      return _i16.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i2.AdminHomepage(),
      );
    },
    DisableHistoryScreenRoute.name: (routeData) {
      final args = routeData.argsAs<DisableHistoryScreenRouteArgs>();
      return _i16.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i3.DisableHistoryScreen(
          key: args.key,
          id: args.id,
        ),
      );
    },
    FeedbackInspectScreenRoute.name: (routeData) {
      final args = routeData.argsAs<FeedbackInspectScreenRouteArgs>();
      return _i16.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i4.FeedbackInspectScreen(
          key: args.key,
          foodId: args.foodId,
        ),
      );
    },
    FoodManagementScreenRoute.name: (routeData) {
      return _i16.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i5.FoodManagementScreen(),
      );
    },
    HomepageRoute.name: (routeData) {
      return _i16.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i6.Homepage(),
      );
    },
    LandingPageScreenRoute.name: (routeData) {
      return _i16.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i7.LandingPageScreen(),
      );
    },
    LoginScreenRoute.name: (routeData) {
      return _i16.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i8.LoginScreen(),
      );
    },
    OnlineOrderScreenRoute.name: (routeData) {
      return _i16.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i9.OnlineOrderScreen(),
      );
    },
    OnsiteOrderScreenRoute.name: (routeData) {
      return _i16.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i10.OnsiteOrderScreen(),
      );
    },
    StaffDetailsScreenRoute.name: (routeData) {
      final args = routeData.argsAs<StaffDetailsScreenRouteArgs>();
      return _i16.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i11.StaffDetailsScreen(
          key: args.key,
          id: args.id,
        ),
      );
    },
    StaffHomepageRoute.name: (routeData) {
      return _i16.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i12.StaffHomepage(),
      );
    },
    StaffManagementScreenRoute.name: (routeData) {
      return _i16.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i13.StaffManagementScreen(),
      );
    },
    UserDetailsScreenRoute.name: (routeData) {
      final args = routeData.argsAs<UserDetailsScreenRouteArgs>();
      return _i16.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i14.UserDetailsScreen(
          key: args.key,
          id: args.id,
        ),
      );
    },
    UserManagementScreenRoute.name: (routeData) {
      return _i16.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i15.UserManagementScreen(),
      );
    },
  };
}

/// generated route for
/// [_i1.AddFoodScreen]
class AddFoodScreenRoute extends _i16.PageRouteInfo<AddFoodScreenRouteArgs> {
  AddFoodScreenRoute({
    _i17.Key? key,
    _i18.FoodMenu? foodMenu,
    List<_i16.PageRouteInfo>? children,
  }) : super(
          AddFoodScreenRoute.name,
          args: AddFoodScreenRouteArgs(
            key: key,
            foodMenu: foodMenu,
          ),
          initialChildren: children,
        );

  static const String name = 'AddFoodScreenRoute';

  static const _i16.PageInfo<AddFoodScreenRouteArgs> page =
      _i16.PageInfo<AddFoodScreenRouteArgs>(name);
}

class AddFoodScreenRouteArgs {
  const AddFoodScreenRouteArgs({
    this.key,
    this.foodMenu,
  });

  final _i17.Key? key;

  final _i18.FoodMenu? foodMenu;

  @override
  String toString() {
    return 'AddFoodScreenRouteArgs{key: $key, foodMenu: $foodMenu}';
  }
}

/// generated route for
/// [_i2.AdminHomepage]
class AdminHomepageRoute extends _i16.PageRouteInfo<void> {
  const AdminHomepageRoute({List<_i16.PageRouteInfo>? children})
      : super(
          AdminHomepageRoute.name,
          initialChildren: children,
        );

  static const String name = 'AdminHomepageRoute';

  static const _i16.PageInfo<void> page = _i16.PageInfo<void>(name);
}

/// generated route for
/// [_i3.DisableHistoryScreen]
class DisableHistoryScreenRoute
    extends _i16.PageRouteInfo<DisableHistoryScreenRouteArgs> {
  DisableHistoryScreenRoute({
    _i17.Key? key,
    required int id,
    List<_i16.PageRouteInfo>? children,
  }) : super(
          DisableHistoryScreenRoute.name,
          args: DisableHistoryScreenRouteArgs(
            key: key,
            id: id,
          ),
          initialChildren: children,
        );

  static const String name = 'DisableHistoryScreenRoute';

  static const _i16.PageInfo<DisableHistoryScreenRouteArgs> page =
      _i16.PageInfo<DisableHistoryScreenRouteArgs>(name);
}

class DisableHistoryScreenRouteArgs {
  const DisableHistoryScreenRouteArgs({
    this.key,
    required this.id,
  });

  final _i17.Key? key;

  final int id;

  @override
  String toString() {
    return 'DisableHistoryScreenRouteArgs{key: $key, id: $id}';
  }
}

/// generated route for
/// [_i4.FeedbackInspectScreen]
class FeedbackInspectScreenRoute
    extends _i16.PageRouteInfo<FeedbackInspectScreenRouteArgs> {
  FeedbackInspectScreenRoute({
    _i17.Key? key,
    required int foodId,
    List<_i16.PageRouteInfo>? children,
  }) : super(
          FeedbackInspectScreenRoute.name,
          args: FeedbackInspectScreenRouteArgs(
            key: key,
            foodId: foodId,
          ),
          initialChildren: children,
        );

  static const String name = 'FeedbackInspectScreenRoute';

  static const _i16.PageInfo<FeedbackInspectScreenRouteArgs> page =
      _i16.PageInfo<FeedbackInspectScreenRouteArgs>(name);
}

class FeedbackInspectScreenRouteArgs {
  const FeedbackInspectScreenRouteArgs({
    this.key,
    required this.foodId,
  });

  final _i17.Key? key;

  final int foodId;

  @override
  String toString() {
    return 'FeedbackInspectScreenRouteArgs{key: $key, foodId: $foodId}';
  }
}

/// generated route for
/// [_i5.FoodManagementScreen]
class FoodManagementScreenRoute extends _i16.PageRouteInfo<void> {
  const FoodManagementScreenRoute({List<_i16.PageRouteInfo>? children})
      : super(
          FoodManagementScreenRoute.name,
          initialChildren: children,
        );

  static const String name = 'FoodManagementScreenRoute';

  static const _i16.PageInfo<void> page = _i16.PageInfo<void>(name);
}

/// generated route for
/// [_i6.Homepage]
class HomepageRoute extends _i16.PageRouteInfo<void> {
  const HomepageRoute({List<_i16.PageRouteInfo>? children})
      : super(
          HomepageRoute.name,
          initialChildren: children,
        );

  static const String name = 'HomepageRoute';

  static const _i16.PageInfo<void> page = _i16.PageInfo<void>(name);
}

/// generated route for
/// [_i7.LandingPageScreen]
class LandingPageScreenRoute extends _i16.PageRouteInfo<void> {
  const LandingPageScreenRoute({List<_i16.PageRouteInfo>? children})
      : super(
          LandingPageScreenRoute.name,
          initialChildren: children,
        );

  static const String name = 'LandingPageScreenRoute';

  static const _i16.PageInfo<void> page = _i16.PageInfo<void>(name);
}

/// generated route for
/// [_i8.LoginScreen]
class LoginScreenRoute extends _i16.PageRouteInfo<void> {
  const LoginScreenRoute({List<_i16.PageRouteInfo>? children})
      : super(
          LoginScreenRoute.name,
          initialChildren: children,
        );

  static const String name = 'LoginScreenRoute';

  static const _i16.PageInfo<void> page = _i16.PageInfo<void>(name);
}

/// generated route for
/// [_i9.OnlineOrderScreen]
class OnlineOrderScreenRoute extends _i16.PageRouteInfo<void> {
  const OnlineOrderScreenRoute({List<_i16.PageRouteInfo>? children})
      : super(
          OnlineOrderScreenRoute.name,
          initialChildren: children,
        );

  static const String name = 'OnlineOrderScreenRoute';

  static const _i16.PageInfo<void> page = _i16.PageInfo<void>(name);
}

/// generated route for
/// [_i10.OnsiteOrderScreen]
class OnsiteOrderScreenRoute extends _i16.PageRouteInfo<void> {
  const OnsiteOrderScreenRoute({List<_i16.PageRouteInfo>? children})
      : super(
          OnsiteOrderScreenRoute.name,
          initialChildren: children,
        );

  static const String name = 'OnsiteOrderScreenRoute';

  static const _i16.PageInfo<void> page = _i16.PageInfo<void>(name);
}

/// generated route for
/// [_i11.StaffDetailsScreen]
class StaffDetailsScreenRoute
    extends _i16.PageRouteInfo<StaffDetailsScreenRouteArgs> {
  StaffDetailsScreenRoute({
    _i17.Key? key,
    required int id,
    List<_i16.PageRouteInfo>? children,
  }) : super(
          StaffDetailsScreenRoute.name,
          args: StaffDetailsScreenRouteArgs(
            key: key,
            id: id,
          ),
          initialChildren: children,
        );

  static const String name = 'StaffDetailsScreenRoute';

  static const _i16.PageInfo<StaffDetailsScreenRouteArgs> page =
      _i16.PageInfo<StaffDetailsScreenRouteArgs>(name);
}

class StaffDetailsScreenRouteArgs {
  const StaffDetailsScreenRouteArgs({
    this.key,
    required this.id,
  });

  final _i17.Key? key;

  final int id;

  @override
  String toString() {
    return 'StaffDetailsScreenRouteArgs{key: $key, id: $id}';
  }
}

/// generated route for
/// [_i12.StaffHomepage]
class StaffHomepageRoute extends _i16.PageRouteInfo<void> {
  const StaffHomepageRoute({List<_i16.PageRouteInfo>? children})
      : super(
          StaffHomepageRoute.name,
          initialChildren: children,
        );

  static const String name = 'StaffHomepageRoute';

  static const _i16.PageInfo<void> page = _i16.PageInfo<void>(name);
}

/// generated route for
/// [_i13.StaffManagementScreen]
class StaffManagementScreenRoute extends _i16.PageRouteInfo<void> {
  const StaffManagementScreenRoute({List<_i16.PageRouteInfo>? children})
      : super(
          StaffManagementScreenRoute.name,
          initialChildren: children,
        );

  static const String name = 'StaffManagementScreenRoute';

  static const _i16.PageInfo<void> page = _i16.PageInfo<void>(name);
}

/// generated route for
/// [_i14.UserDetailsScreen]
class UserDetailsScreenRoute
    extends _i16.PageRouteInfo<UserDetailsScreenRouteArgs> {
  UserDetailsScreenRoute({
    _i17.Key? key,
    required int id,
    List<_i16.PageRouteInfo>? children,
  }) : super(
          UserDetailsScreenRoute.name,
          args: UserDetailsScreenRouteArgs(
            key: key,
            id: id,
          ),
          initialChildren: children,
        );

  static const String name = 'UserDetailsScreenRoute';

  static const _i16.PageInfo<UserDetailsScreenRouteArgs> page =
      _i16.PageInfo<UserDetailsScreenRouteArgs>(name);
}

class UserDetailsScreenRouteArgs {
  const UserDetailsScreenRouteArgs({
    this.key,
    required this.id,
  });

  final _i17.Key? key;

  final int id;

  @override
  String toString() {
    return 'UserDetailsScreenRouteArgs{key: $key, id: $id}';
  }
}

/// generated route for
/// [_i15.UserManagementScreen]
class UserManagementScreenRoute extends _i16.PageRouteInfo<void> {
  const UserManagementScreenRoute({List<_i16.PageRouteInfo>? children})
      : super(
          UserManagementScreenRoute.name,
          initialChildren: children,
        );

  static const String name = 'UserManagementScreenRoute';

  static const _i16.PageInfo<void> page = _i16.PageInfo<void>(name);
}
