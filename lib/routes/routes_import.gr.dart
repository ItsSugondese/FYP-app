// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouterGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:auto_route/auto_route.dart' as _i10;
import 'package:flutter/material.dart' as _i11;
import 'package:fyp/features/admin-dashboard/admin_homepage.dart' as _i2;
import 'package:fyp/features/food-mgmt/add_food_screen.dart' as _i1;
import 'package:fyp/features/food-mgmt/food_mgmt_screen.dart' as _i3;
import 'package:fyp/features/homepage/homepage.dart' as _i4;
import 'package:fyp/features/login/login.dart' as _i5;
import 'package:fyp/features/order-mgmt/online-order/online_order_screen.dart'
    as _i6;
import 'package:fyp/features/order-mgmt/onsite-order/onsite_order_screen.dart'
    as _i7;
import 'package:fyp/features/people-mgmt/user-mgmt/user_management_screen.dart'
    as _i9;
import 'package:fyp/features/staff/staff_homepage.dart' as _i8;
import 'package:fyp/model/foodmgmt/food_menu.dart' as _i12;

abstract class $AppRouter extends _i10.RootStackRouter {
  $AppRouter({super.navigatorKey});

  @override
  final Map<String, _i10.PageFactory> pagesMap = {
    AddFoodScreenRoute.name: (routeData) {
      final args = routeData.argsAs<AddFoodScreenRouteArgs>(
          orElse: () => const AddFoodScreenRouteArgs());
      return _i10.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i1.AddFoodScreen(
          key: args.key,
          foodMenu: args.foodMenu,
        ),
      );
    },
    AdminHomepageRoute.name: (routeData) {
      return _i10.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i2.AdminHomepage(),
      );
    },
    FoodManagementScreenRoute.name: (routeData) {
      return _i10.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i3.FoodManagementScreen(),
      );
    },
    HomepageRoute.name: (routeData) {
      return _i10.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i4.Homepage(),
      );
    },
    LoginScreenRoute.name: (routeData) {
      return _i10.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i5.LoginScreen(),
      );
    },
    OnlineOrderScreenRoute.name: (routeData) {
      return _i10.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i6.OnlineOrderScreen(),
      );
    },
    OnsiteOrderScreenRoute.name: (routeData) {
      return _i10.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i7.OnsiteOrderScreen(),
      );
    },
    StaffHomepageRoute.name: (routeData) {
      return _i10.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i8.StaffHomepage(),
      );
    },
    UserManagementScreenRoute.name: (routeData) {
      return _i10.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i9.UserManagementScreen(),
      );
    },
  };
}

/// generated route for
/// [_i1.AddFoodScreen]
class AddFoodScreenRoute extends _i10.PageRouteInfo<AddFoodScreenRouteArgs> {
  AddFoodScreenRoute({
    _i11.Key? key,
    _i12.FoodMenu? foodMenu,
    List<_i10.PageRouteInfo>? children,
  }) : super(
          AddFoodScreenRoute.name,
          args: AddFoodScreenRouteArgs(
            key: key,
            foodMenu: foodMenu,
          ),
          initialChildren: children,
        );

  static const String name = 'AddFoodScreenRoute';

  static const _i10.PageInfo<AddFoodScreenRouteArgs> page =
      _i10.PageInfo<AddFoodScreenRouteArgs>(name);
}

class AddFoodScreenRouteArgs {
  const AddFoodScreenRouteArgs({
    this.key,
    this.foodMenu,
  });

  final _i11.Key? key;

  final _i12.FoodMenu? foodMenu;

  @override
  String toString() {
    return 'AddFoodScreenRouteArgs{key: $key, foodMenu: $foodMenu}';
  }
}

/// generated route for
/// [_i2.AdminHomepage]
class AdminHomepageRoute extends _i10.PageRouteInfo<void> {
  const AdminHomepageRoute({List<_i10.PageRouteInfo>? children})
      : super(
          AdminHomepageRoute.name,
          initialChildren: children,
        );

  static const String name = 'AdminHomepageRoute';

  static const _i10.PageInfo<void> page = _i10.PageInfo<void>(name);
}

/// generated route for
/// [_i3.FoodManagementScreen]
class FoodManagementScreenRoute extends _i10.PageRouteInfo<void> {
  const FoodManagementScreenRoute({List<_i10.PageRouteInfo>? children})
      : super(
          FoodManagementScreenRoute.name,
          initialChildren: children,
        );

  static const String name = 'FoodManagementScreenRoute';

  static const _i10.PageInfo<void> page = _i10.PageInfo<void>(name);
}

/// generated route for
/// [_i4.Homepage]
class HomepageRoute extends _i10.PageRouteInfo<void> {
  const HomepageRoute({List<_i10.PageRouteInfo>? children})
      : super(
          HomepageRoute.name,
          initialChildren: children,
        );

  static const String name = 'HomepageRoute';

  static const _i10.PageInfo<void> page = _i10.PageInfo<void>(name);
}

/// generated route for
/// [_i5.LoginScreen]
class LoginScreenRoute extends _i10.PageRouteInfo<void> {
  const LoginScreenRoute({List<_i10.PageRouteInfo>? children})
      : super(
          LoginScreenRoute.name,
          initialChildren: children,
        );

  static const String name = 'LoginScreenRoute';

  static const _i10.PageInfo<void> page = _i10.PageInfo<void>(name);
}

/// generated route for
/// [_i6.OnlineOrderScreen]
class OnlineOrderScreenRoute extends _i10.PageRouteInfo<void> {
  const OnlineOrderScreenRoute({List<_i10.PageRouteInfo>? children})
      : super(
          OnlineOrderScreenRoute.name,
          initialChildren: children,
        );

  static const String name = 'OnlineOrderScreenRoute';

  static const _i10.PageInfo<void> page = _i10.PageInfo<void>(name);
}

/// generated route for
/// [_i7.OnsiteOrderScreen]
class OnsiteOrderScreenRoute extends _i10.PageRouteInfo<void> {
  const OnsiteOrderScreenRoute({List<_i10.PageRouteInfo>? children})
      : super(
          OnsiteOrderScreenRoute.name,
          initialChildren: children,
        );

  static const String name = 'OnsiteOrderScreenRoute';

  static const _i10.PageInfo<void> page = _i10.PageInfo<void>(name);
}

/// generated route for
/// [_i8.StaffHomepage]
class StaffHomepageRoute extends _i10.PageRouteInfo<void> {
  const StaffHomepageRoute({List<_i10.PageRouteInfo>? children})
      : super(
          StaffHomepageRoute.name,
          initialChildren: children,
        );

  static const String name = 'StaffHomepageRoute';

  static const _i10.PageInfo<void> page = _i10.PageInfo<void>(name);
}

/// generated route for
/// [_i9.UserManagementScreen]
class UserManagementScreenRoute extends _i10.PageRouteInfo<void> {
  const UserManagementScreenRoute({List<_i10.PageRouteInfo>? children})
      : super(
          UserManagementScreenRoute.name,
          initialChildren: children,
        );

  static const String name = 'UserManagementScreenRoute';

  static const _i10.PageInfo<void> page = _i10.PageInfo<void>(name);
}
