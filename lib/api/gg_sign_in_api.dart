

import 'package:google_sign_in/google_sign_in.dart';

class GoogleSignInAPI {
      // Initialize Google Sign-In
  static final _googleSignIn = GoogleSignIn.instance;
  
  static Future<GoogleSignInAccount?>login() => _googleSignIn.signIn();


}