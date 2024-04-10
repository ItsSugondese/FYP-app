// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouterGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:auto_route/auto_route.dart' as _i28;
import 'package:flutter/material.dart' as _i29;
import 'package:fyp/features/admin-dashboard/admin_homepage.dart' as _i3;
import 'package:fyp/features/feedback/feedback_inspect_screen.dart' as _i8;
import 'package:fyp/features/feedback/feedback_provide_screen.dart' as _i9;
import 'package:fyp/features/food-mgmt/add_food_screen.dart' as _i1;
import 'package:fyp/features/food-mgmt/food_mgmt_screen.dart' as _i10;
import 'package:fyp/features/homepage/homepage.dart' as _i11;
import 'package:fyp/features/homepage/order_foods_screen.dart' as _i19;
import 'package:fyp/features/homepage/selected_food_to_order_screen.dart'
    as _i20;
import 'package:fyp/features/landing-screen/landing_screen.dart' as _i12;
import 'package:fyp/features/login/login.dart' as _i13;
import 'package:fyp/features/notification/notification_screen.dart' as _i14;
import 'package:fyp/features/order-history/current-order/current_online_order_screen.dart'
    as _i4;
import 'package:fyp/features/order-history/current-order/current_onsite_order_screen.dart'
    as _i5;
import 'package:fyp/features/order-history/current-order/current_order_screen.dart'
    as _i6;
import 'package:fyp/features/order-history/order_history_management_screen.dart'
    as _i17;
import 'package:fyp/features/order-history/order_history_screen.dart' as _i18;
import 'package:fyp/features/order-mgmt/online-order/online_order_screen.dart'
    as _i15;
import 'package:fyp/features/order-mgmt/onsite-order/onsite_order_screen.dart'
    as _i16;
import 'package:fyp/features/people-mgmt/disable_history_screen.dart' as _i7;
import 'package:fyp/features/people-mgmt/staff-mgmt/add-staff/add_staff_screen.dart'
    as _i2;
import 'package:fyp/features/people-mgmt/staff-mgmt/staff-inspect/staff_details.dart'
    as _i21;
import 'package:fyp/features/people-mgmt/staff-mgmt/staff_management_screen.dart'
    as _i23;
import 'package:fyp/features/people-mgmt/user-mgmt/user-inspect/user_details.dart'
    as _i24;
import 'package:fyp/features/people-mgmt/user-mgmt/user_management_screen.dart'
    as _i26;
import 'package:fyp/features/staff/staff_homepage.dart' as _i22;
import 'package:fyp/features/user-payment/user_payment_management.dart' as _i27;
import 'package:fyp/layout/user_layout.dart' as _i25;
import 'package:fyp/model/foodmgmt/food_menu.dart' as _i30;

abstract class $AppRouter extends _i28.RootStackRouter {
  $AppRouter({super.navigatorKey});

  @override
  final Map<String, _i28.PageFactory> pagesMap = {
    AddFoodScreenRoute.name: (routeData) {
      final args = routeData.argsAs<AddFoodScreenRouteArgs>(
          orElse: () => const AddFoodScreenRouteArgs());
      return _i28.AutoRoutePage<dynamic>(
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
      return _i28.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i2.AddStaffscreen(
          key: args.key,
          foodMenu: args.foodMenu,
        ),
      );
    },
    AdminHomepageRoute.name: (routeData) {
      return _i28.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i3.AdminHomepage(),
      );
    },
    CurrentOnlineOrderScreenRoute.name: (routeData) {
      return _i28.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i4.CurrentOnlineOrderScreen(),
      );
    },
    CurrentOnsiteOrderScreenRoute.name: (routeData) {
      return _i28.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i5.CurrentOnsiteOrderScreen(),
      );
    },
    CurrentOrderScreenRoute.name: (routeData) {
      return _i28.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i6.CurrentOrderScreen(),
      );
    },
    DisableHistoryScreenRoute.name: (routeData) {
      final args = routeData.argsAs<DisableHistoryScreenRouteArgs>();
      return _i28.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i7.DisableHistoryScreen(
          key: args.key,
          id: args.id,
        ),
      );
    },
    FeedbackInspectScreenRoute.name: (routeData) {
      final args = routeData.argsAs<FeedbackInspectScreenRouteArgs>();
      return _i28.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i8.FeedbackInspectScreen(
          key: args.key,
          foodId: args.foodId,
          header: args.header,
        ),
      );
    },
    FeedbackProvideScreenRoute.name: (routeData) {
      return _i28.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i9.FeedbackProvideScreen(),
      );
    },
    FoodManagementScreenRoute.name: (routeData) {
      return _i28.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i10.FoodManagementScreen(),
      );
    },
    HomepageRoute.name: (routeData) {
      return _i28.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i11.Homepage(),
      );
    },
    LandingPageScreenRoute.name: (routeData) {
      return _i28.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i12.LandingPageScreen(),
      );
    },
    LoginScreenRoute.name: (routeData) {
      return _i28.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i13.LoginScreen(),
      );
    },
    NotificationScreenRoute.name: (routeData) {
      return _i28.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i14.NotificationScreen(),
      );
    },
    OnlineOrderScreenRoute.name: (routeData) {
      return _i28.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i15.OnlineOrderScreen(),
      );
    },
    OnsiteOrderScreenRoute.name: (routeData) {
      return _i28.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i16.OnsiteOrderScreen(),
      );
    },
    OrderHistoryManagementScreenRoute.name: (routeData) {
      return _i28.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i17.OrderHistoryManagementScreen(),
      );
    },
    OrderHistoryScreenRoute.name: (routeData) {
      return _i28.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i18.OrderHistoryScreen(),
      );
    },
    OrderedFoodScreenRoute.name: (routeData) {
      return _i28.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i19.OrderedFoodScreen(),
      );
    },
    SelectedFoodToOrderScreenRoute.name: (routeData) {
      final args = routeData.argsAs<SelectedFoodToOrderScreenRouteArgs>();
      return _i28.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i20.SelectedFoodToOrderScreen(
          key: args.key,
          foodMenu: args.foodMenu,
          callback: args.callback,
        ),
      );
    },
    StaffDetailsScreenRoute.name: (routeData) {
      final args = routeData.argsAs<StaffDetailsScreenRouteArgs>();
      return _i28.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i21.StaffDetailsScreen(
          key: args.key,
          id: args.id,
        ),
      );
    },
    StaffHomepageRoute.name: (routeData) {
      return _i28.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i22.StaffHomepage(),
      );
    },
    StaffManagementScreenRoute.name: (routeData) {
      return _i28.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i23.StaffManagementScreen(),
      );
    },
    UserDetailsScreenRoute.name: (routeData) {
      final args = routeData.argsAs<UserDetailsScreenRouteArgs>();
      return _i28.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i24.UserDetailsScreen(
          key: args.key,
          id: args.id,
        ),
      );
    },
    UserLayoutRoute.name: (routeData) {
      return _i28.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i25.UserLayout(),
      );
    },
    UserManagementScreenRoute.name: (routeData) {
      return _i28.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i26.UserManagementScreen(),
      );
    },
    UserPaymentManagementScreenRoute.name: (routeData) {
      return _i28.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i27.UserPaymentManagementScreen(),
      );
    },
  };
}

/// generated route for
/// [_i1.AddFoodScreen]
class AddFoodScreenRoute extends _i28.PageRouteInfo<AddFoodScreenRouteArgs> {
  AddFoodScreenRoute({
    _i29.Key? key,
    _i30.FoodMenu? foodMenu,
    List<_i28.PageRouteInfo>? children,
  }) : super(
          AddFoodScreenRoute.name,
          args: AddFoodScreenRouteArgs(
            key: key,
            foodMenu: foodMenu,
          ),
          initialChildren: children,
        );

  static const String name = 'AddFoodScreenRoute';

  static const _i28.PageInfo<AddFoodScreenRouteArgs> page =
      _i28.PageInfo<AddFoodScreenRouteArgs>(name);
}

class AddFoodScreenRouteArgs {
  const AddFoodScreenRouteArgs({
    this.key,
    this.foodMenu,
  });

  final _i29.Key? key;

  final _i30.FoodMenu? foodMenu;

  @override
  String toString() {
    return 'AddFoodScreenRouteArgs{key: $key, foodMenu: $foodMenu}';
  }
}

/// generated route for
/// [_i2.AddStaffscreen]
class AddStaffscreenRoute extends _i28.PageRouteInfo<AddStaffscreenRouteArgs> {
  AddStaffscreenRoute({
    _i29.Key? key,
    _i30.FoodMenu? foodMenu,
    List<_i28.PageRouteInfo>? children,
  }) : super(
          AddStaffscreenRoute.name,
          args: AddStaffscreenRouteArgs(
            key: key,
            foodMenu: foodMenu,
          ),
          initialChildren: children,
        );

  static const String name = 'AddStaffscreenRoute';

  static const _i28.PageInfo<AddStaffscreenRouteArgs> page =
      _i28.PageInfo<AddStaffscreenRouteArgs>(name);
}

class AddStaffscreenRouteArgs {
  const AddStaffscreenRouteArgs({
    this.key,
    this.foodMenu,
  });

  final _i29.Key? key;

  final _i30.FoodMenu? foodMenu;

  @override
  String toString() {
    return 'AddStaffscreenRouteArgs{key: $key, foodMenu: $foodMenu}';
  }
}

/// generated route for
/// [_i3.AdminHomepage]
class AdminHomepageRoute extends _i28.PageRouteInfo<void> {
  const AdminHomepageRoute({List<_i28.PageRouteInfo>? children})
      : super(
          AdminHomepageRoute.name,
          initialChildren: children,
        );

  static const String name = 'AdminHomepageRoute';

  static const _i28.PageInfo<void> page = _i28.PageInfo<void>(name);
}

/// generated route for
/// [_i4.CurrentOnlineOrderScreen]
class CurrentOnlineOrderScreenRoute extends _i28.PageRouteInfo<void> {
  const CurrentOnlineOrderScreenRoute({List<_i28.PageRouteInfo>? children})
      : super(
          CurrentOnlineOrderScreenRoute.name,
          initialChildren: children,
        );

  static const String name = 'CurrentOnlineOrderScreenRoute';

  static const _i28.PageInfo<void> page = _i28.PageInfo<void>(name);
}

/// generated route for
/// [_i5.CurrentOnsiteOrderScreen]
class CurrentOnsiteOrderScreenRoute extends _i28.PageRouteInfo<void> {
  const CurrentOnsiteOrderScreenRoute({List<_i28.PageRouteInfo>? children})
      : super(
          CurrentOnsiteOrderScreenRoute.name,
          initialChildren: children,
        );

  static const String name = 'CurrentOnsiteOrderScreenRoute';

  static const _i28.PageInfo<void> page = _i28.PageInfo<void>(name);
}

/// generated route for
/// [_i6.CurrentOrderScreen]
class CurrentOrderScreenRoute extends _i28.PageRouteInfo<void> {
  const CurrentOrderScreenRoute({List<_i28.PageRouteInfo>? children})
      : super(
          CurrentOrderScreenRoute.name,
          initialChildren: children,
        );

  static const String name = 'CurrentOrderScreenRoute';

  static const _i28.PageInfo<void> page = _i28.PageInfo<void>(name);
}

/// generated route for
/// [_i7.DisableHistoryScreen]
class DisableHistoryScreenRoute
    extends _i28.PageRouteInfo<DisableHistoryScreenRouteArgs> {
  DisableHistoryScreenRoute({
    _i29.Key? key,
    required int id,
    List<_i28.PageRouteInfo>? children,
  }) : super(
          DisableHistoryScreenRoute.name,
          args: DisableHistoryScreenRouteArgs(
            key: key,
            id: id,
          ),
          initialChildren: children,
        );

  static const String name = 'DisableHistoryScreenRoute';

  static const _i28.PageInfo<DisableHistoryScreenRouteArgs> page =
      _i28.PageInfo<DisableHistoryScreenRouteArgs>(name);
}

class DisableHistoryScreenRouteArgs {
  const DisableHistoryScreenRouteArgs({
    this.key,
    required this.id,
  });

  final _i29.Key? key;

  final int id;

  @override
  String toString() {
    return 'DisableHistoryScreenRouteArgs{key: $key, id: $id}';
  }
}

/// generated route for
/// [_i8.FeedbackInspectScreen]
class FeedbackInspectScreenRoute
    extends _i28.PageRouteInfo<FeedbackInspectScreenRouteArgs> {
  FeedbackInspectScreenRoute({
    _i29.Key? key,
    required int foodId,
    required String header,
    List<_i28.PageRouteInfo>? children,
  }) : super(
          FeedbackInspectScreenRoute.name,
          args: FeedbackInspectScreenRouteArgs(
            key: key,
            foodId: foodId,
            header: header,
          ),
          initialChildren: children,
        );

  static const String name = 'FeedbackInspectScreenRoute';

  static const _i28.PageInfo<FeedbackInspectScreenRouteArgs> page =
      _i28.PageInfo<FeedbackInspectScreenRouteArgs>(name);
}

class FeedbackInspectScreenRouteArgs {
  const FeedbackInspectScreenRouteArgs({
    this.key,
    required this.foodId,
    required this.header,
  });

  final _i29.Key? key;

  final int foodId;

  final String header;

  @override
  String toString() {
    return 'FeedbackInspectScreenRouteArgs{key: $key, foodId: $foodId, header: $header}';
  }
}

/// generated route for
/// [_i9.FeedbackProvideScreen]
class FeedbackProvideScreenRoute extends _i28.PageRouteInfo<void> {
  const FeedbackProvideScreenRoute({List<_i28.PageRouteInfo>? children})
      : super(
          FeedbackProvideScreenRoute.name,
          initialChildren: children,
        );

  static const String name = 'FeedbackProvideScreenRoute';

  static const _i28.PageInfo<void> page = _i28.PageInfo<void>(name);
}

/// generated route for
/// [_i10.FoodManagementScreen]
class FoodManagementScreenRoute extends _i28.PageRouteInfo<void> {
  const FoodManagementScreenRoute({List<_i28.PageRouteInfo>? children})
      : super(
          FoodManagementScreenRoute.name,
          initialChildren: children,
        );

  static const String name = 'FoodManagementScreenRoute';

  static const _i28.PageInfo<void> page = _i28.PageInfo<void>(name);
}

/// generated route for
/// [_i11.Homepage]
class HomepageRoute extends _i28.PageRouteInfo<void> {
  const HomepageRoute({List<_i28.PageRouteInfo>? children})
      : super(
          HomepageRoute.name,
          initialChildren: children,
        );

  static const String name = 'HomepageRoute';

  static const _i28.PageInfo<void> page = _i28.PageInfo<void>(name);
}

/// generated route for
/// [_i12.LandingPageScreen]
class LandingPageScreenRoute extends _i28.PageRouteInfo<void> {
  const LandingPageScreenRoute({List<_i28.PageRouteInfo>? children})
      : super(
          LandingPageScreenRoute.name,
          initialChildren: children,
        );

  static const String name = 'LandingPageScreenRoute';

  static const _i28.PageInfo<void> page = _i28.PageInfo<void>(name);
}

/// generated route for
/// [_i13.LoginScreen]
class LoginScreenRoute extends _i28.PageRouteInfo<void> {
  const LoginScreenRoute({List<_i28.PageRouteInfo>? children})
      : super(
          LoginScreenRoute.name,
          initialChildren: children,
        );

  static const String name = 'LoginScreenRoute';

  static const _i28.PageInfo<void> page = _i28.PageInfo<void>(name);
}

/// generated route for
/// [_i14.NotificationScreen]
class NotificationScreenRoute extends _i28.PageRouteInfo<void> {
  const NotificationScreenRoute({List<_i28.PageRouteInfo>? children})
      : super(
          NotificationScreenRoute.name,
          initialChildren: children,
        );

  static const String name = 'NotificationScreenRoute';

  static const _i28.PageInfo<void> page = _i28.PageInfo<void>(name);
}

/// generated route for
/// [_i15.OnlineOrderScreen]
class OnlineOrderScreenRoute extends _i28.PageRouteInfo<void> {
  const OnlineOrderScreenRoute({List<_i28.PageRouteInfo>? children})
      : super(
          OnlineOrderScreenRoute.name,
          initialChildren: children,
        );

  static const String name = 'OnlineOrderScreenRoute';

  static const _i28.PageInfo<void> page = _i28.PageInfo<void>(name);
}

/// generated route for
/// [_i16.OnsiteOrderScreen]
class OnsiteOrderScreenRoute extends _i28.PageRouteInfo<void> {
  const OnsiteOrderScreenRoute({List<_i28.PageRouteInfo>? children})
      : super(
          OnsiteOrderScreenRoute.name,
          initialChildren: children,
        );

  static const String name = 'OnsiteOrderScreenRoute';

  static const _i28.PageInfo<void> page = _i28.PageInfo<void>(name);
}

/// generated route for
/// [_i17.OrderHistoryManagementScreen]
class OrderHistoryManagementScreenRoute extends _i28.PageRouteInfo<void> {
  const OrderHistoryManagementScreenRoute({List<_i28.PageRouteInfo>? children})
      : super(
          OrderHistoryManagementScreenRoute.name,
          initialChildren: children,
        );

  static const String name = 'OrderHistoryManagementScreenRoute';

  static const _i28.PageInfo<void> page = _i28.PageInfo<void>(name);
}

/// generated route for
/// [_i18.OrderHistoryScreen]
class OrderHistoryScreenRoute extends _i28.PageRouteInfo<void> {
  const OrderHistoryScreenRoute({List<_i28.PageRouteInfo>? children})
      : super(
          OrderHistoryScreenRoute.name,
          initialChildren: children,
        );

  static const String name = 'OrderHistoryScreenRoute';

  static const _i28.PageInfo<void> page = _i28.PageInfo<void>(name);
}

/// generated route for
/// [_i19.OrderedFoodScreen]
class OrderedFoodScreenRoute extends _i28.PageRouteInfo<void> {
  const OrderedFoodScreenRoute({List<_i28.PageRouteInfo>? children})
      : super(
          OrderedFoodScreenRoute.name,
          initialChildren: children,
        );

  static const String name = 'OrderedFoodScreenRoute';

  static const _i28.PageInfo<void> page = _i28.PageInfo<void>(name);
}

/// generated route for
/// [_i20.SelectedFoodToOrderScreen]
class SelectedFoodToOrderScreenRoute
    extends _i28.PageRouteInfo<SelectedFoodToOrderScreenRouteArgs> {
  SelectedFoodToOrderScreenRoute({
    _i29.Key? key,
    required _i30.FoodMenu foodMenu,
    required dynamic Function(
      int,
      _i30.FoodMenu,
    ) callback,
    List<_i28.PageRouteInfo>? children,
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

  static const _i28.PageInfo<SelectedFoodToOrderScreenRouteArgs> page =
      _i28.PageInfo<SelectedFoodToOrderScreenRouteArgs>(name);
}

class SelectedFoodToOrderScreenRouteArgs {
  const SelectedFoodToOrderScreenRouteArgs({
    this.key,
    required this.foodMenu,
    required this.callback,
  });

  final _i29.Key? key;

  final _i30.FoodMenu foodMenu;

  final dynamic Function(
    int,
    _i30.FoodMenu,
  ) callback;

  @override
  String toString() {
    return 'SelectedFoodToOrderScreenRouteArgs{key: $key, foodMenu: $foodMenu, callback: $callback}';
  }
}

/// generated route for
/// [_i21.StaffDetailsScreen]
class StaffDetailsScreenRoute
    extends _i28.PageRouteInfo<StaffDetailsScreenRouteArgs> {
  StaffDetailsScreenRoute({
    _i29.Key? key,
    required int id,
    List<_i28.PageRouteInfo>? children,
  }) : super(
          StaffDetailsScreenRoute.name,
          args: StaffDetailsScreenRouteArgs(
            key: key,
            id: id,
          ),
          initialChildren: children,
        );

  static const String name = 'StaffDetailsScreenRoute';

  static const _i28.PageInfo<StaffDetailsScreenRouteArgs> page =
      _i28.PageInfo<StaffDetailsScreenRouteArgs>(name);
}

class StaffDetailsScreenRouteArgs {
  const StaffDetailsScreenRouteArgs({
    this.key,
    required this.id,
  });

  final _i29.Key? key;

  final int id;

  @override
  String toString() {
    return 'StaffDetailsScreenRouteArgs{key: $key, id: $id}';
  }
}

/// generated route for
/// [_i22.StaffHomepage]
class StaffHomepageRoute extends _i28.PageRouteInfo<void> {
  const StaffHomepageRoute({List<_i28.PageRouteInfo>? children})
      : super(
          StaffHomepageRoute.name,
          initialChildren: children,
        );

  static const String name = 'StaffHomepageRoute';

  static const _i28.PageInfo<void> page = _i28.PageInfo<void>(name);
}

/// generated route for
/// [_i23.StaffManagementScreen]
class StaffManagementScreenRoute extends _i28.PageRouteInfo<void> {
  const StaffManagementScreenRoute({List<_i28.PageRouteInfo>? children})
      : super(
          StaffManagementScreenRoute.name,
          initialChildren: children,
        );

  static const String name = 'StaffManagementScreenRoute';

  static const _i28.PageInfo<void> page = _i28.PageInfo<void>(name);
}

/// generated route for
/// [_i24.UserDetailsScreen]
class UserDetailsScreenRoute
    extends _i28.PageRouteInfo<UserDetailsScreenRouteArgs> {
  UserDetailsScreenRoute({
    _i29.Key? key,
    required int id,
    List<_i28.PageRouteInfo>? children,
  }) : super(
          UserDetailsScreenRoute.name,
          args: UserDetailsScreenRouteArgs(
            key: key,
            id: id,
          ),
          initialChildren: children,
        );

  static const String name = 'UserDetailsScreenRoute';

  static const _i28.PageInfo<UserDetailsScreenRouteArgs> page =
      _i28.PageInfo<UserDetailsScreenRouteArgs>(name);
}

class UserDetailsScreenRouteArgs {
  const UserDetailsScreenRouteArgs({
    this.key,
    required this.id,
  });

  final _i29.Key? key;

  final int id;

  @override
  String toString() {
    return 'UserDetailsScreenRouteArgs{key: $key, id: $id}';
  }
}

/// generated route for
/// [_i25.UserLayout]
class UserLayoutRoute extends _i28.PageRouteInfo<void> {
  const UserLayoutRoute({List<_i28.PageRouteInfo>? children})
      : super(
          UserLayoutRoute.name,
          initialChildren: children,
        );

  static const String name = 'UserLayoutRoute';

  static const _i28.PageInfo<void> page = _i28.PageInfo<void>(name);
}

/// generated route for
/// [_i26.UserManagementScreen]
class UserManagementScreenRoute extends _i28.PageRouteInfo<void> {
  const UserManagementScreenRoute({List<_i28.PageRouteInfo>? children})
      : super(
          UserManagementScreenRoute.name,
          initialChildren: children,
        );

  static const String name = 'UserManagementScreenRoute';

  static const _i28.PageInfo<void> page = _i28.PageInfo<void>(name);
}

/// generated route for
/// [_i27.UserPaymentManagementScreen]
class UserPaymentManagementScreenRoute extends _i28.PageRouteInfo<void> {
  const UserPaymentManagementScreenRoute({List<_i28.PageRouteInfo>? children})
      : super(
          UserPaymentManagementScreenRoute.name,
          initialChildren: children,
        );

  static const String name = 'UserPaymentManagementScreenRoute';

  static const _i28.PageInfo<void> page = _i28.PageInfo<void>(name);
}
