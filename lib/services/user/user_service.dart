import 'package:auto_route/auto_route.dart';
import 'package:fyp/routes/routes_import.gr.dart';
import 'package:fyp/services/storage/store_service.dart';

class UserService{
  static void dashboardManagement(StackRouter router) async{
    List<String> roles = (await Store.getRoles()) as List<String>;
    if(roles.contains("ADMIN".toUpperCase())){
      router.pushAndPopUntil(const AdminHomepageRoute(),predicate: (route ) =>  true);
    }else if(roles.contains("STAFF".toUpperCase())){
      router.pushAndPopUntil(const StaffHomepageRoute(), predicate: (route ) =>  true );
    }else if(roles.contains("USER".toUpperCase())){
      router.pushAndPopUntil(const HomepageRoute(), predicate: (route ) =>  true);
    }else{
      router.pushAndPopUntil(const LoginScreenRoute(), predicate: (route ) =>  true);
    }
  }
}