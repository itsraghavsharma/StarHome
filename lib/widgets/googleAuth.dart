import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'dart:developer';

class FirebaseService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn();

  Future<String?> signInwithGoogle() async {
    try {
      log('Google Sign In Requested');
      final GoogleSignInAccount? googleSignInAccount =
      await _googleSignIn.signIn();
      log('Google Account Selected');
      final GoogleSignInAuthentication googleSignInAuthentication =
      await googleSignInAccount!.authentication;

      final AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleSignInAuthentication.accessToken,
        idToken: googleSignInAuthentication.idToken,
      );
      log('Signed In...');
      final UserCredential authResult =
      await _auth.signInWithCredential(credential);

      final User user = authResult.user!;
      if (authResult.additionalUserInfo!.isNewUser) {
        if (user != null) {
          //You can her set data user in Fire store
          //Ex: Go to RegisterPage()
          return "New User";

        }
      }
      return "Old User";

    } on FirebaseAuthException catch (e) {
      log(e.message.toString());
      throw e;
    }
  }

  Future<void> signOutFromGoogle() async{
    await _googleSignIn.signOut();
    await _auth.signOut();
    log('Google Logged Off!');
  }
}