// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouterGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:auto_route/auto_route.dart' as _i21;
import 'package:flutter/material.dart' as _i22;
import 'package:fyp/features/admin-dashboard/admin_homepage.dart' as _i3;
import 'package:fyp/features/feedback/feedback_inspect_screen.dart' as _i6;
import 'package:fyp/features/food-mgmt/add_food_screen.dart' as _i1;
import 'package:fyp/features/food-mgmt/food_mgmt_screen.dart' as _i7;
import 'package:fyp/features/homepage/homepage.dart' as _i8;
import 'package:fyp/features/homepage/order_foods_screen.dart' as _i14;
import 'package:fyp/features/homepage/selected_food_to_order_screen.dart'
    as _i15;
import 'package:fyp/features/landing-screen/landing_screen.dart' as _i9;
import 'package:fyp/features/login/login.dart' as _i10;
import 'package:fyp/features/order-history/current-order/current_order_screen.dart'
    as _i4;
import 'package:fyp/features/order-history/order_history_screen.dart' as _i13;
import 'package:fyp/features/order-mgmt/online-order/online_order_screen.dart'
    as _i11;
import 'package:fyp/features/order-mgmt/onsite-order/onsite_order_screen.dart'
    as _i12;
import 'package:fyp/features/people-mgmt/disable_history_screen.dart' as _i5;
import 'package:fyp/features/people-mgmt/staff-mgmt/add-staff/add_staff_screen.dart'
    as _i2;
import 'package:fyp/features/people-mgmt/staff-mgmt/staff-inspect/staff_details.dart'
    as _i16;
import 'package:fyp/features/people-mgmt/staff-mgmt/staff_management_screen.dart'
    as _i18;
import 'package:fyp/features/people-mgmt/user-mgmt/user-inspect/user_details.dart'
    as _i19;
import 'package:fyp/features/people-mgmt/user-mgmt/user_management_screen.dart'
    as _i20;
import 'package:fyp/features/staff/staff_homepage.dart' as _i17;
import 'package:fyp/model/foodmgmt/food_menu.dart' as _i23;

abstract class $AppRouter extends _i21.RootStackRouter {
  $AppRouter({super.navigatorKey});

  @override
  final Map<String, _i21.PageFactory> pagesMap = {
    AddFoodScreenRoute.name: (routeData) {
      final args = routeData.argsAs<AddFoodScreenRouteArgs>(
          orElse: () => const AddFoodScreenRouteArgs());
      return _i21.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i1.AddFoodScreen(
          key: args.key,
          foodMenu: args.foodMenu,
        ),
      );
    },
    AddStaffscreenRoute.name: (routeData) {
      final args = routeData.argsAs<AddStaffscreenRouteArgs>(
          orElse: () => const AddStaffscreenRouteArgs());
      return _i21.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i2.AddStaffscreen(
          key: args.key,
          foodMenu: args.foodMenu,
        ),
      );
    },
    AdminHomepageRoute.name: (routeData) {
      return _i21.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i3.AdminHomepage(),
      );
    },
    CurrentOrderScreenRoute.name: (routeData) {
      return _i21.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i4.CurrentOrderScreen(),
      );
    },
    DisableHistoryScreenRoute.name: (routeData) {
      final args = routeData.argsAs<DisableHistoryScreenRouteArgs>();
      return _i21.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i5.DisableHistoryScreen(
          key: args.key,
          id: args.id,
        ),
      );
    },
    FeedbackInspectScreenRoute.name: (routeData) {
      final args = routeData.argsAs<FeedbackInspectScreenRouteArgs>();
      return _i21.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i6.FeedbackInspectScreen(
          key: args.key,
          foodId: args.foodId,
        ),
      );
    },
    FoodManagementScreenRoute.name: (routeData) {
      return _i21.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i7.FoodManagementScreen(),
      );
    },
    HomepageRoute.name: (routeData) {
      return _i21.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i8.Homepage(),
      );
    },
    LandingPageScreenRoute.name: (routeData) {
      return _i21.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i9.LandingPageScreen(),
      );
    },
    LoginScreenRoute.name: (routeData) {
      return _i21.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i10.LoginScreen(),
      );
    },
    OnlineOrderScreenRoute.name: (routeData) {
      return _i21.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i11.OnlineOrderScreen(),
      );
    },
    OnsiteOrderScreenRoute.name: (routeData) {
      return _i21.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i12.OnsiteOrderScreen(),
      );
    },
    OrderHistoryScreenRoute.name: (routeData) {
      return _i21.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i13.OrderHistoryScreen(),
      );
    },
    OrderedFoodScreenRoute.name: (routeData) {
      return _i21.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i14.OrderedFoodScreen(),
      );
    },
    SelectedFoodToOrderScreenRoute.name: (routeData) {
      final args = routeData.argsAs<SelectedFoodToOrderScreenRouteArgs>();
      return _i21.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i15.SelectedFoodToOrderScreen(
          key: args.key,
          foodMenu: args.foodMenu,
          callback: args.callback,
        ),
      );
    },
    StaffDetailsScreenRoute.name: (routeData) {
      final args = routeData.argsAs<StaffDetailsScreenRouteArgs>();
      return _i21.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i16.StaffDetailsScreen(
          key: args.key,
          id: args.id,
        ),
      );
    },
    StaffHomepageRoute.name: (routeData) {
      return _i21.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i17.StaffHomepage(),
      );
    },
    StaffManagementScreenRoute.name: (routeData) {
      return _i21.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i18.StaffManagementScreen(),
      );
    },
    UserDetailsScreenRoute.name: (routeData) {
      final args = routeData.argsAs<UserDetailsScreenRouteArgs>();
      return _i21.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i19.UserDetailsScreen(
          key: args.key,
          id: args.id,
        ),
      );
    },
    UserManagementScreenRoute.name: (routeData) {
      return _i21.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i20.UserManagementScreen(),
      );
    },
  };
}

/// generated route for
/// [_i1.AddFoodScreen]
class AddFoodScreenRoute extends _i21.PageRouteInfo<AddFoodScreenRouteArgs> {
  AddFoodScreenRoute({
    _i22.Key? key,
    _i23.FoodMenu? foodMenu,
    List<_i21.PageRouteInfo>? children,
  }) : super(
          AddFoodScreenRoute.name,
          args: AddFoodScreenRouteArgs(
            key: key,
            foodMenu: foodMenu,
          ),
          initialChildren: children,
        );

  static const String name = 'AddFoodScreenRoute';

  static const _i21.PageInfo<AddFoodScreenRouteArgs> page =
      _i21.PageInfo<AddFoodScreenRouteArgs>(name);
}

class AddFoodScreenRouteArgs {
  const AddFoodScreenRouteArgs({
    this.key,
    this.foodMenu,
  });

  final _i22.Key? key;

  final _i23.FoodMenu? foodMenu;

  @override
  String toString() {
    return 'AddFoodScreenRouteArgs{key: $key, foodMenu: $foodMenu}';
  }
}

/// generated route for
/// [_i2.AddStaffscreen]
class AddStaffscreenRoute extends _i21.PageRouteInfo<AddStaffscreenRouteArgs> {
  AddStaffscreenRoute({
    _i22.Key? key,
    _i23.FoodMenu? foodMenu,
    List<_i21.PageRouteInfo>? children,
  }) : super(
          AddStaffscreenRoute.name,
          args: AddStaffscreenRouteArgs(
            key: key,
            foodMenu: foodMenu,
          ),
          initialChildren: children,
        );

  static const String name = 'AddStaffscreenRoute';

  static const _i21.PageInfo<AddStaffscreenRouteArgs> page =
      _i21.PageInfo<AddStaffscreenRouteArgs>(name);
}

class AddStaffscreenRouteArgs {
  const AddStaffscreenRouteArgs({
    this.key,
    this.foodMenu,
  });

  final _i22.Key? key;

  final _i23.FoodMenu? foodMenu;

  @override
  String toString() {
    return 'AddStaffscreenRouteArgs{key: $key, foodMenu: $foodMenu}';
  }
}

/// generated route for
/// [_i3.AdminHomepage]
class AdminHomepageRoute extends _i21.PageRouteInfo<void> {
  const AdminHomepageRoute({List<_i21.PageRouteInfo>? children})
      : super(
          AdminHomepageRoute.name,
          initialChildren: children,
        );

  static const String name = 'AdminHomepageRoute';

  static const _i21.PageInfo<void> page = _i21.PageInfo<void>(name);
}

/// generated route for
/// [_i4.CurrentOrderScreen]
class CurrentOrderScreenRoute extends _i21.PageRouteInfo<void> {
  const CurrentOrderScreenRoute({List<_i21.PageRouteInfo>? children})
      : super(
          CurrentOrderScreenRoute.name,
          initialChildren: children,
        );

  static const String name = 'CurrentOrderScreenRoute';

  static const _i21.PageInfo<void> page = _i21.PageInfo<void>(name);
}

/// generated route for
/// [_i5.DisableHistoryScreen]
class DisableHistoryScreenRoute
    extends _i21.PageRouteInfo<DisableHistoryScreenRouteArgs> {
  DisableHistoryScreenRoute({
    _i22.Key? key,
    required int id,
    List<_i21.PageRouteInfo>? children,
  }) : super(
          DisableHistoryScreenRoute.name,
          args: DisableHistoryScreenRouteArgs(
            key: key,
            id: id,
          ),
          initialChildren: children,
        );

  static const String name = 'DisableHistoryScreenRoute';

  static const _i21.PageInfo<DisableHistoryScreenRouteArgs> page =
      _i21.PageInfo<DisableHistoryScreenRouteArgs>(name);
}

class DisableHistoryScreenRouteArgs {
  const DisableHistoryScreenRouteArgs({
    this.key,
    required this.id,
  });

  final _i22.Key? key;

  final int id;

  @override
  String toString() {
    return 'DisableHistoryScreenRouteArgs{key: $key, id: $id}';
  }
}

/// generated route for
/// [_i6.FeedbackInspectScreen]
class FeedbackInspectScreenRoute
    extends _i21.PageRouteInfo<FeedbackInspectScreenRouteArgs> {
  FeedbackInspectScreenRoute({
    _i22.Key? key,
    required int foodId,
    List<_i21.PageRouteInfo>? children,
  }) : super(
          FeedbackInspectScreenRoute.name,
          args: FeedbackInspectScreenRouteArgs(
            key: key,
            foodId: foodId,
          ),
          initialChildren: children,
        );

  static const String name = 'FeedbackInspectScreenRoute';

  static const _i21.PageInfo<FeedbackInspectScreenRouteArgs> page =
      _i21.PageInfo<FeedbackInspectScreenRouteArgs>(name);
}

class FeedbackInspectScreenRouteArgs {
  const FeedbackInspectScreenRouteArgs({
    this.key,
    required this.foodId,
  });

  final _i22.Key? key;

  final int foodId;

  @override
  String toString() {
    return 'FeedbackInspectScreenRouteArgs{key: $key, foodId: $foodId}';
  }
}

/// generated route for
/// [_i7.FoodManagementScreen]
class FoodManagementScreenRoute extends _i21.PageRouteInfo<void> {
  const FoodManagementScreenRoute({List<_i21.PageRouteInfo>? children})
      : super(
          FoodManagementScreenRoute.name,
          initialChildren: children,
        );

  static const String name = 'FoodManagementScreenRoute';

  static const _i21.PageInfo<void> page = _i21.PageInfo<void>(name);
}

/// generated route for
/// [_i8.Homepage]
class HomepageRoute extends _i21.PageRouteInfo<void> {
  const HomepageRoute({List<_i21.PageRouteInfo>? children})
      : super(
          HomepageRoute.name,
          initialChildren: children,
        );

  static const String name = 'HomepageRoute';

  static const _i21.PageInfo<void> page = _i21.PageInfo<void>(name);
}

/// generated route for
/// [_i9.LandingPageScreen]
class LandingPageScreenRoute extends _i21.PageRouteInfo<void> {
  const LandingPageScreenRoute({List<_i21.PageRouteInfo>? children})
      : super(
          LandingPageScreenRoute.name,
          initialChildren: children,
        );

  static const String name = 'LandingPageScreenRoute';

  static const _i21.PageInfo<void> page = _i21.PageInfo<void>(name);
}

/// generated route for
/// [_i10.LoginScreen]
class LoginScreenRoute extends _i21.PageRouteInfo<void> {
  const LoginScreenRoute({List<_i21.PageRouteInfo>? children})
      : super(
          LoginScreenRoute.name,
          initialChildren: children,
        );

  static const String name = 'LoginScreenRoute';

  static const _i21.PageInfo<void> page = _i21.PageInfo<void>(name);
}

/// generated route for
/// [_i11.OnlineOrderScreen]
class OnlineOrderScreenRoute extends _i21.PageRouteInfo<void> {
  const OnlineOrderScreenRoute({List<_i21.PageRouteInfo>? children})
      : super(
          OnlineOrderScreenRoute.name,
          initialChildren: children,
        );

  static const String name = 'OnlineOrderScreenRoute';

  static const _i21.PageInfo<void> page = _i21.PageInfo<void>(name);
}

/// generated route for
/// [_i12.OnsiteOrderScreen]
class OnsiteOrderScreenRoute extends _i21.PageRouteInfo<void> {
  const OnsiteOrderScreenRoute({List<_i21.PageRouteInfo>? children})
      : super(
          OnsiteOrderScreenRoute.name,
          initialChildren: children,
        );

  static const String name = 'OnsiteOrderScreenRoute';

  static const _i21.PageInfo<void> page = _i21.PageInfo<void>(name);
}

/// generated route for
/// [_i13.OrderHistoryScreen]
class OrderHistoryScreenRoute extends _i21.PageRouteInfo<void> {
  const OrderHistoryScreenRoute({List<_i21.PageRouteInfo>? children})
      : super(
          OrderHistoryScreenRoute.name,
          initialChildren: children,
        );

  static const String name = 'OrderHistoryScreenRoute';

  static const _i21.PageInfo<void> page = _i21.PageInfo<void>(name);
}

/// generated route for
/// [_i14.OrderedFoodScreen]
class OrderedFoodScreenRoute extends _i21.PageRouteInfo<void> {
  const OrderedFoodScreenRoute({List<_i21.PageRouteInfo>? children})
      : super(
          OrderedFoodScreenRoute.name,
          initialChildren: children,
        );

  static const String name = 'OrderedFoodScreenRoute';

  static const _i21.PageInfo<void> page = _i21.PageInfo<void>(name);
}

/// generated route for
/// [_i15.SelectedFoodToOrderScreen]
class SelectedFoodToOrderScreenRoute
    extends _i21.PageRouteInfo<SelectedFoodToOrderScreenRouteArgs> {
  SelectedFoodToOrderScreenRoute({
    _i22.Key? key,
    required _i23.FoodMenu foodMenu,
    required dynamic Function(
      int,
      _i23.FoodMenu,
    ) callback,
    List<_i21.PageRouteInfo>? children,
  }) : super(
          SelectedFoodToOrderScreenRoute.name,
          args: SelectedFoodToOrderScreenRouteArgs(
            key: key,
            foodMenu: foodMenu,
            callback: callback,
          ),
          initialChildren: children,
        );

  static const String name = 'SelectedFoodToOrderScreenRoute';

  static const _i21.PageInfo<SelectedFoodToOrderScreenRouteArgs> page =
      _i21.PageInfo<SelectedFoodToOrderScreenRouteArgs>(name);
}

class SelectedFoodToOrderScreenRouteArgs {
  const SelectedFoodToOrderScreenRouteArgs({
    this.key,
    required this.foodMenu,
    required this.callback,
  });

  final _i22.Key? key;

  final _i23.FoodMenu foodMenu;

  final dynamic Function(
    int,
    _i23.FoodMenu,
  ) callback;

  @override
  String toString() {
    return 'SelectedFoodToOrderScreenRouteArgs{key: $key, foodMenu: $foodMenu, callback: $callback}';
  }
}

/// generated route for
/// [_i16.StaffDetailsScreen]
class StaffDetailsScreenRoute
    extends _i21.PageRouteInfo<StaffDetailsScreenRouteArgs> {
  StaffDetailsScreenRoute({
    _i22.Key? key,
    required int id,
    List<_i21.PageRouteInfo>? children,
  }) : super(
          StaffDetailsScreenRoute.name,
          args: StaffDetailsScreenRouteArgs(
            key: key,
            id: id,
          ),
          initialChildren: children,
        );

  static const String name = 'StaffDetailsScreenRoute';

  static const _i21.PageInfo<StaffDetailsScreenRouteArgs> page =
      _i21.PageInfo<StaffDetailsScreenRouteArgs>(name);
}

class StaffDetailsScreenRouteArgs {
  const StaffDetailsScreenRouteArgs({
    this.key,
    required this.id,
  });

  final _i22.Key? key;

  final int id;

  @override
  String toString() {
    return 'StaffDetailsScreenRouteArgs{key: $key, id: $id}';
  }
}

/// generated route for
/// [_i17.StaffHomepage]
class StaffHomepageRoute extends _i21.PageRouteInfo<void> {
  const StaffHomepageRoute({List<_i21.PageRouteInfo>? children})
      : super(
          StaffHomepageRoute.name,
          initialChildren: children,
        );

  static const String name = 'StaffHomepageRoute';

  static const _i21.PageInfo<void> page = _i21.PageInfo<void>(name);
}

/// generated route for
/// [_i18.StaffManagementScreen]
class StaffManagementScreenRoute extends _i21.PageRouteInfo<void> {
  const StaffManagementScreenRoute({List<_i21.PageRouteInfo>? children})
      : super(
          StaffManagementScreenRoute.name,
          initialChildren: children,
        );

  static const String name = 'StaffManagementScreenRoute';

  static const _i21.PageInfo<void> page = _i21.PageInfo<void>(name);
}

/// generated route for
/// [_i19.UserDetailsScreen]
class UserDetailsScreenRoute
    extends _i21.PageRouteInfo<UserDetailsScreenRouteArgs> {
  UserDetailsScreenRoute({
    _i22.Key? key,
    required int id,
    List<_i21.PageRouteInfo>? children,
  }) : super(
          UserDetailsScreenRoute.name,
          args: UserDetailsScreenRouteArgs(
            key: key,
            id: id,
          ),
          initialChildren: children,
        );

  static const String name = 'UserDetailsScreenRoute';

  static const _i21.PageInfo<UserDetailsScreenRouteArgs> page =
      _i21.PageInfo<UserDetailsScreenRouteArgs>(name);
}

class UserDetailsScreenRouteArgs {
  const UserDetailsScreenRouteArgs({
    this.key,
    required this.id,
  });

  final _i22.Key? key;

  final int id;

  @override
  String toString() {
    return 'UserDetailsScreenRouteArgs{key: $key, id: $id}';
  }
}

/// generated route for
/// [_i20.UserManagementScreen]
class UserManagementScreenRoute extends _i21.PageRouteInfo<void> {
  const UserManagementScreenRoute({List<_i21.PageRouteInfo>? children})
      : super(
          UserManagementScreenRoute.name,
          initialChildren: children,
        );

  static const String name = 'UserManagementScreenRoute';

  static const _i21.PageInfo<void> page = _i21.PageInfo<void>(name);
}
