import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:fyp/config/network/api/GoogleSignInApi.dart';
import 'package:fyp/constants/designing/colors.dart';
import 'package:fyp/constants/designing/dimension.dart';
import 'package:fyp/constants/designing/image_path.dart';
import 'package:fyp/constants/designing/screen_name.dart';
import 'package:fyp/helper/svg/svg_path_helper.dart';
import 'package:fyp/model/people/user.dart';
import 'package:fyp/routes/routes_import.gr.dart';
import 'package:fyp/services/user/user_profile_service.dart';
import 'package:fyp/utils/appbar/custom_appbar_profile.dart';

class UserProfile extends StatefulWidget {
  const UserProfile({super.key});

  @override
  State<UserProfile> createState() => _UserProfileState();
}

class _UserProfileState extends State<UserProfile> {
  late final UserProfileService userProfileService;
  late Future<User> userFuture;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    userProfileService = UserProfileService(context);
    fetchUserProfile();
  }

  fetchUserProfile() {
    userFuture = userProfileService.getSingleUser();
  }

  Future<void> refresh() async {
    setState(() {
      fetchUserProfile();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppbarProfile(),
      body: RefreshIndicator(
        onRefresh: refresh,
        child: SingleChildScrollView(
          physics: const AlwaysScrollableScrollPhysics(),
          child: Container(
            height: Dimension.getScreenHeight(context) -
                (MediaQuery.of(context).padding.top +
                    kToolbarHeight +
                    kBottomNavigationBarHeight),
            padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 8),
            child: Column(
              children: [
                FutureBuilder<User>(
                    future: userFuture,
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return Container(
                          height: 250,
                          child: const Center(
                            child: CircularProgressIndicator(),
                          ),
                        );
                      } else if (snapshot.hasData) {
                        User user = snapshot.data!;

                        return Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Container(
                              alignment: Alignment.center,
                              child: CircleAvatar(
                                radius: 100,
                                backgroundImage: !user.isExternal
                                    ? NetworkImage(user.profilePath!)
                                    : AssetImage(
                                        ImagePath.getImagePath(
                                            ScreenName.landing, "anon.jpg"),
                                      ) as ImageProvider<Object>,
                              ),
                            ),
                            Text(
                              user.fullName,
                              style: TextStyle(fontSize: 20),
                            ),
                            Text(
                              user.email,
                              style: TextStyle(
                                  color: Color.fromARGB(255, 186, 185, 185),
                                  fontSize: 18),
                            ),
                          ],
                        );
                      } else {
                        return Column(
                          children: [
                            ElevatedButton(
                                child: const Text("Remove data"),
                                onPressed: () => {GoogleSignInApi.logout()}),
                            ElevatedButton(
                                child: const Text("Login"),
                                onPressed: () => {
                                      AutoRouter.of(context)
                                          .push(const LoginScreenRoute())
                                    }),
                            Text("${snapshot.error}")
                          ],
                        );
                      }
                    }),
                const SizedBox(
                  height: 30,
                ),
                SvgPathHelper.buildLink(
                  height: 30,
                  width: 30,
                  svgCode: '''
                    <svg
                      xmlns="http://www.w3.org/2000/svg"
                      viewBox="0 0 24 24"
                      fill="none"
                      stroke="currentColor"
                      stroke-width="2"
                      stroke-linecap="round"
                      stroke-linejoin="round"
                      class="h-4 w-4"
                    >
                      <path d="M21 8a2 2 0 0 0-1-1.73l-7-4a2 2 0 0 0-2 0l-7 4A2 2 0 0 0 3 8v8a2 2 0 0 0 1 1.73l7 4a2 2 0 0 0 2 0l7-4A2 2 0 0 0 21 16Z"></path>
                      <path d="m3.3 7 8.7 5 8.7-5"></path>
                      <path d="M12 22V12"></path>
                    </svg>
                  ''',
                  label: 'Order History',
                  onTap: () {
                    AutoRouter.of(context)
                        .push(const OrderHistoryScreenRoute());
                  },
                ),
                SvgPathHelper.buildLink(
                  height: 30,
                  width: 30,
                  svgCode: '''
                    <svg
                      xmlns="http://www.w3.org/2000/svg"
                      width="24"
                      height="24"
                      viewBox="0 0 24 24"
                      fill="none"
                      stroke="currentColor"
                      stroke-width="2"
                      stroke-linecap="round"
                      stroke-linejoin="round"
                      class="h-4 w-4"
                    >
                      <path d="M21 15a2 2 0 0 1-2 2H7l-4 4V5a2 2 0 0 1 2-2h14a2 2 0 0 1 2 2z"></path>
                    </svg>
                  ''',
                  label: 'Feedback',
                  onTap: () {
                    AutoRouter.of(context)
                        .push(const FeedbackProvideScreenRoute());
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
