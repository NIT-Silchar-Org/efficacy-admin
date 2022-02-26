import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

class GoogleSignInProvider extends ChangeNotifier {
  final googleSignIn = GoogleSignIn();
  final FirebaseAuth _firebaseAuth;
  GoogleSignInAccount? _user;
  var credential;

  GoogleSignInProvider(this._firebaseAuth);

  Stream<User?> get authStateChanges => _firebaseAuth.idTokenChanges();

  GoogleSignInAccount? get user => _user;

  Future<String> signInWithGoogle() async {
    try {
      final googleUser = await googleSignIn.signIn();
      if (googleUser == null) return "Google Sign Failed";
      _user = googleUser;

      final googleAuth = await googleUser.authentication;

      credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );
      notifyListeners();
      return "Google Credential Acquired";
    } catch (e) {
      return e.toString();
    }
  }

  Future<String> signInWithFirebase() async {
    try {
      await _firebaseAuth.signInWithCredential(credential);
        print('signed Up');
      notifyListeners();
      return "Signed Up";
    } on FirebaseAuthException catch (e) {
      return e.toString();
    }
  }

  Future logOut() async {
    try {
      await _firebaseAuth.signOut().then((value) async {
        await googleSignIn.signOut();
      }).then((value) {
        _user = null;
        notifyListeners();
      });
    } catch (e) {
      print(e.toString());
    }
  }
}
