import 'package:auto_route/auto_route.dart';
import 'package:fyp/routes/routes_import.gr.dart';
import 'package:fyp/services/storage/store_service.dart';
import 'package:fyp/services/user/user_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthGuard extends AutoRouteGuard{

  late List<String> allowedRoles;

  AuthGuard({required this.allowedRoles});

  @override
  void onNavigation(NavigationResolver resolver, StackRouter router) async{
    if(await _matchRole()){
      resolver.next(true);
    }else{
      resolver.next(false);
      UserService.dashboardManagement(router);
    }
  }

  Future<bool> _matchRole() async{
    bool matched = false;
    List<String> roles = (await Store.getRoles()) as List<String>;
    for(int i=0; i<allowedRoles.length; i++){
      for(int j=0; j<roles.length; j++){
        if(roles[i] == allowedRoles[j]){
          matched = true;
          break;
        }
      }
      if(matched) {
        break;
      }
    }
    return matched;
  }
}