// ignore: file_names
import 'package:google_sign_in/google_sign_in.dart';

class GoogleSignInApi {
  static const GOOGLE_CLIENT_DEV_KEY =
      '746907184110-vm60s3kv0ofk1soqg2l5qptm60t82it0.apps.googleusercontent.com'; // This is a fake key. Please use a correct key.
  // static final GoogleSignIn _googleSignIn = new GoogleSignIn(
  //   clientId: GOOGLE_CLIENT_DEV_KEY,
  //   scopes: [
  //     'https://www.googleapis.com/auth/userinfo.email',
  //     'openid',
  //     'https://www.googleapis.com/auth/userinfo.profile',
  //   ],
  // );

  static GoogleSignIn _googleSignIn = GoogleSignIn(
    clientId: GOOGLE_CLIENT_DEV_KEY,
    scopes: [
      'email',
    ],
  );
  static Future<GoogleSignInAccount?> login() => _googleSignIn.signIn();
  static Future<GoogleSignInAccount?> logout() => _googleSignIn.signOut();
}
