import 'dart:io';
import 'dart:typed_data';

import 'package:auto_route/annotations.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:fyp/config/network/api/GoogleSignInApi.dart';
import 'package:fyp/features/users/homepage/homepage-service/homepage_service.dart';
import 'package:fyp/model/foodmgmt/Food_menu_item_with_image.dart';
import 'package:fyp/model/foodmgmt/food_menu.dart';

import '../../../routes/routes_import.gr.dart';

@RoutePage()
class Homepage extends StatefulWidget {
  const Homepage({Key? key}) : super(key: key);

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  HomepageService homepageService = HomepageService();

  @override
  void initState() {
    // TODO: implement initState
  }
  @override
  Widget build(BuildContext context) {
    return Container(
      child: FutureBuilder<List<FoodMenuItemWithImage>>(
    future: homepageService.getFoodMenusWithImages(),
        builder: (context, snapshot){
          if(snapshot.hasData){
            return Center(
              child: ListView.builder(
                  shrinkWrap: true,
                  itemCount: snapshot.data?.length,
                  itemBuilder: (BuildContext context, int index){
                    FoodMenuItemWithImage menuWithImage = snapshot.data![index];
                    return Column(
                      children: [
                        Card(
                          child: SizedBox(
                            width: 300,
                            height: 100,
                            child: Row(
                              children: [
                                menuWithImage.image != null ?
                                Image.memory(
                                  menuWithImage.image ?? Uint8List(0),
                                  width: 100,
                                  height: 100,
                                  fit: BoxFit.cover,
                                ) : Image.asset(
                                  'assets/images/tuteelogo.png', // The path to the asset within your app
                                  width: 100,
                                  height: 100,
                                  fit: BoxFit.cover,
                                ),
                                Column(
                                  children: [
                                    Text(menuWithImage.foodMenu.name),
                                    Text("Rs. ${menuWithImage.foodMenu.cost}"),
                                  ],
                                )

                              ],
                            ),
                          ),
                        )
                      ],
                    );
                  }
              ),
            );
          }else if(snapshot.hasError){
            return Column(
              children: [
                ElevatedButton(
                child: Text("Fuck me"),
                onPressed: () => {
                  GoogleSignInApi.logout()
                }
                ),
                ElevatedButton(
                    child: Text("Login"),
                    onPressed: () => {
                    AutoRouter.of(context).push(const LoginScreenRoute())
                    }
                ),

          Text("${snapshot.error}")
              ],
            );
          }else{
            return CircularProgressIndicator();
          }
        }
    ),
    );
  }
}
