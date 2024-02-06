import 'package:auto_route/auto_route.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:fyp/constants/designing/colors.dart';
import 'package:fyp/constants/designing/dimension.dart';
import 'package:fyp/features/landing-screen/landing-screen-service/landing_screen_constants.dart';
import 'package:fyp/features/login/login-service/login-service.dart';
import 'package:fyp/routes/routes_import.gr.dart';

@RoutePage()
class LoginScreen extends StatefulWidget {
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final loginService = LoginService();
  final TextEditingController _emailFieldController = TextEditingController();
  final TextEditingController _passwordFieldController =
      TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(),
        // drawer: MyDrawer(),
        backgroundColor: Colors.white,
        body: Container(
          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          width: Dimension.getScreenWidth(context),
          height: Dimension.getScreenHeight(context),
          child: Stack(
            children: [
              Align(
                alignment: Alignment.center,
                child: Container(
                  width: double.infinity,
                  height: Dimension.getScreenHeight(context) * 0.53,
                  child: Column(
                    children: [
                      const Column(
                        children: [
                          Text("Login",
                              style: TextStyle(letterSpacing: 4, fontSize: 30)),
                          SizedBox(
                            height: 10,
                          ),
                          Text("Add your details to login",
                              style: TextStyle(
                                  fontSize: 15, color: Color(0xFF989898))),
                        ],
                      ),
                      const Spacer(),
                      Container(
                        child: Form(
                          key: _formKey, // Add this key

                          autovalidateMode: AutovalidateMode.onUserInteraction,

                          child: Column(
                            children: [
                              TextFormField(
                                controller: _emailFieldController,
                                decoration: const InputDecoration(
                                  contentPadding: EdgeInsets.symmetric(
                                      horizontal: 30, vertical: 20),
                                  filled: true,
                                  fillColor: Color(0xFFEEEEEE),
                                  labelText: 'Your email',
                                  labelStyle: TextStyle(
                                    color: Color(
                                        0xFF989898), // Set the label text color
                                    fontSize: 16.0, // Set the label text size
                                    fontWeight: FontWeight
                                        .normal, // Set the label text weight
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(30.0)),
                                  ),
                                  enabledBorder: OutlineInputBorder(
                                    borderSide: BorderSide.none,
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(30.0)),
                                  ),
                                ),
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'This field is required';
                                  }
                                  return null;
                                },
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                              TextFormField(
                                controller: _passwordFieldController,
                                decoration: const InputDecoration(
                                  contentPadding: EdgeInsets.symmetric(
                                      horizontal: 30, vertical: 20),
                                  filled: true,
                                  fillColor: Color(0xFFEEEEEE),
                                  labelText: 'password',
                                  labelStyle: TextStyle(
                                    color: Color(
                                        0xFF989898), // Set the label text color
                                    fontSize: 16.0, // Set the label text size
                                    fontWeight: FontWeight
                                        .normal, // Set the label text weight
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(30.0)),
                                  ),
                                  enabledBorder: OutlineInputBorder(
                                    borderSide: BorderSide.none,
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(30.0)),
                                  ),
                                ),
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'This field is required';
                                  }
                                  return null;
                                },
                              ),

                              // This formatter allows only numeric values with up to 2 decimal places
                            ],
                          ),
                        ),
                      ),
                      const Spacer(),
                      Column(
                        children: [
                          Container(
                            width: double.infinity,
                            child: ElevatedButton(
                              style: ButtonStyle(
                                  padding: MaterialStateProperty.all(
                                    EdgeInsets.symmetric(vertical: 15),
                                  ),
                                  shape: MaterialStateProperty.all(
                                      const StadiumBorder()),
                                  backgroundColor: MaterialStateProperty.all(
                                      CustomColors.defaultRedColor),
                                  elevation: MaterialStateProperty.all(0)),
                              onPressed: () {},
                              child: const Text(
                                "Login",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize:
                                        LandingScreenConstants.buttonFontSize,
                                    fontWeight: FontWeight.normal),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          RichText(
                            text: TextSpan(
                              text: "Forgot password? ",
                              style: TextStyle(
                                  fontSize: 15, color: Color(0xFF989898)),
                              children: <TextSpan>[
                                TextSpan(
                                  recognizer: TapGestureRecognizer()
                                    ..onTap = () {},
                                  text: 'Click Here',
                                  style: TextStyle(
                                    color: Colors.blue,
                                  ),
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              Align(
                  alignment: Alignment.bottomCenter,
                  child: RichText(
                    text: TextSpan(
                      text: "Not a staff? ",
                      style: TextStyle(fontSize: 15, color: Color(0xFF989898)),
                      children: <TextSpan>[
                        TextSpan(
                          recognizer: TapGestureRecognizer()
                            ..onTap = () {
                              AutoRouter.of(context)
                                  .push(const LandingPageScreenRoute());
                            },
                          text: 'Homepage',
                          style: TextStyle(
                            color: CustomColors.defaultRedColor,
                          ),
                        ),
                      ],
                    ),
                  ))
            ],
          ),
        ));
  }
}

// class _LoginScreenState extends State<LoginScreen> {
//   final loginService = LoginService();
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.brown[100],
//       body: Column(
//         children: <Widget>[
//           Expanded(
//             child: Container(
//               height: 100,
//               width: 100,
//               child: Image.asset(
//                 'assets/images/tuteelogo.png',
//                 fit: BoxFit.contain,
//               ),
//             ),
//           ),
//           Expanded(
//             child: Column(
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: <Widget>[
//                 Row(
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   children: <Widget>[
//                     Text(
//                       'Don\'t have an account?',
//                       style: TextStyle(color: Colors.brown, fontSize: 20),
//                     ),
//                     Text(
//                       ' SIGN UP',
//                       style: TextStyle(
//                           color: Colors.brown,
//                           fontSize: 20,
//                           fontWeight: FontWeight.bold),
//                     )
//                   ],
//                 ),
//                 Expanded(
//                   child: Padding(
//                     padding: EdgeInsets.only(left: 40, right: 40, top: 20),
//                     child: ClipRRect(
//                       borderRadius: BorderRadius.circular(20),
//                       child: Container(
//                         color: Colors.brown[50],
//                         child: Row(
//                           children: <Widget>[
//                             Padding(
//                               padding: EdgeInsets.all(20),
//                               child: Icon(
//                                 Icons.accessibility,
//                                 color: Colors.brown,
//                               ),
//                             ),
//                             Text(
//                               ' E M A I L',
//                               style:
//                                   TextStyle(color: Colors.brown, fontSize: 20),
//                             )
//                           ],
//                         ),
//                       ),
//                     ),
//                   ),
//                 ),
//                 Expanded(
//                   child: Padding(
//                     padding: EdgeInsets.only(
//                         left: 40, right: 40, top: 10, bottom: 10),
//                     child: ClipRRect(
//                       borderRadius: BorderRadius.circular(20),
//                       child: Container(
//                         color: Colors.brown[50],
//                         child: Row(
//                           children: <Widget>[
//                             Padding(
//                               padding: EdgeInsets.all(20),
//                               child: Icon(
//                                 Icons.lock,
//                                 color: Colors.brown,
//                               ),
//                             ),
//                             Text(' P A S S W O R D',
//                                 style: TextStyle(
//                                     color: Colors.brown, fontSize: 20))
//                           ],
//                         ),
//                       ),
//                     ),
//                   ),
//                 ),
//                 Padding(
//                   padding: EdgeInsets.only(top: 10),
//                   child: Text(
//                     'Forgot Password?',
//                     style: TextStyle(color: Colors.brown, fontSize: 20),
//                   ),
//                 ),
//                 Expanded(
//                   child: Padding(
//                     padding: EdgeInsets.only(
//                         left: 40, right: 40, top: 30, bottom: 20),
//                     child: ClipRRect(
//                       borderRadius: BorderRadius.circular(20),
//                       child: Container(
//                         color: Colors.brown,
//                         child: Center(
//                           child: Text('S I G N  I N',
//                               style: TextStyle(
//                                   color: Colors.white,
//                                   fontSize: 20,
//                                   fontWeight: FontWeight.bold)),
//                         ),
//                       ),
//                     ),
//                   ),
//                 ),
//                 Padding(
//                   padding: EdgeInsets.only(left: 15, right: 15, bottom: 20),
//                   child: Row(
//                     children: <Widget>[
//                       Expanded(
//                         child: Padding(
//                           padding: EdgeInsets.only(left: 10, right: 5),
//                           child: SignInButton(
//                             Buttons.AppleDark,
//                             text: "Sign in",
//                             onPressed: () {},
//                           ),
//                         ),
//                       ),
//                       Expanded(
//                         child: Padding(
//                           padding: EdgeInsets.only(left: 5, right: 5),
//                           child: SignInButton(
//                             Buttons.Google,
//                             text: "Sign in",
//                             onPressed: () {
//                               loginService.signIn(context);
//                             },
//                           ),
//                         ),
//                       ),
//                       Expanded(
//                         child: Padding(
//                           padding: EdgeInsets.only(left: 5, right: 10),
//                           child: SignInButton(
//                             Buttons.Facebook,
//                             text: "Sign in",
//                             onPressed: () {},
//                           ),
//                         ),
//                       ),
//                     ],
//                   ),
//                 )
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
