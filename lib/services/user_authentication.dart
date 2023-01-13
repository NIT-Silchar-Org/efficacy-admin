import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:shared_preferences/shared_preferences.dart';

class GoogleSignInProvider extends ChangeNotifier {
  final googleSignIn = GoogleSignIn();
  final FirebaseAuth _firebaseAuth;
  GoogleSignInAccount? _user;
  dynamic credential;

  GoogleSignInProvider(this._firebaseAuth);

  Stream<User?> get authStateChanges => _firebaseAuth.idTokenChanges();

  GoogleSignInAccount? get user => _user;

  Future<String> signInWithGoogle() async {
    try {
      final googleUser = await googleSignIn.signIn();
      if (googleUser == null) return "Google Sign Failed";
      _user = googleUser;
      SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.setString('Googleid', googleUser.id);
      final googleAuth = await googleUser.authentication;

      credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );
      var ref=FirebaseFirestore.instance.collection('admin');
      var information=await ref.doc(googleUser.id).get();
      if(information.exists){
          await _firebaseAuth.signInWithCredential(credential);
      }
      notifyListeners();
      return "Google Credential Acquired";
    } on PlatformException catch (e) {
      print("The user is not signed in yet. Asking to sign in.");
    // this.sin_googleSignIn.signIn();
      return e.toString();
    }
  }

  Future<String> signInWithFirebase() async {
    try {
      await _firebaseAuth.signInWithCredential(credential);
      notifyListeners();
      return "Signed Up";
    } on FirebaseAuthException catch (e) {
      return e.toString();
    }
  }

  Future<void> logOut() async {
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
