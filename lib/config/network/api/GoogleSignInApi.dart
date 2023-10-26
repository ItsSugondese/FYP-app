import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';


class GoogleSignInApi{

  static final _googleSignIn = GoogleSignIn(clientId: "746907184110-vm60s3kv0ofk1soqg2l5qptm60t82it0.apps.googleusercontent.com");

  static Future<GoogleSignInAccount?> login() => _googleSignIn.signIn();
  static Future<GoogleSignInAccount?> logout() => _googleSignIn.signOut();
}