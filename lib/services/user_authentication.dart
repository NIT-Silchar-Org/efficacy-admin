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

  Future signInWithGoogle() async {
    try {
      final googleUser = await googleSignIn.signIn();
      if (googleUser == null) return;
      _user = googleUser;

      final googleAuth = await googleUser.authentication;

      credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );
      notifyListeners();
    } catch (e) {
      print(e.toString());
    }
  }

  Future signInWithFirebase() async {
    try {
      await _firebaseAuth.signInWithCredential(credential);
      notifyListeners();
    } on FirebaseAuthException catch (e) {
      print(e.toString());
    }
  }

  Future logOut() async {
    try {
      await _firebaseAuth.signOut();
      await googleSignIn.disconnect();
      notifyListeners();
    } catch (e) {
      print(e.toString());
    }
  }
}
