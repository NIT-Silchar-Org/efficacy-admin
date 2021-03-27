import 'dart:async';

import 'package:flutter/cupertino.dart';

import 'package:flutter/widgets.dart';

import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:firebase_auth/firebase_auth.dart';

class AuthenticationProvider with ChangeNotifier {
  UserCredential _authResult;

  Future<void> signUp(
      String email, String password, Map<String, String> _userData) async {
      _authResult = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password);
      FirebaseFirestore.instance
          .collection('admins')
          .doc(_authResult.user.uid)
          .set(_userData);
   
    //notifyListeners();
  }

  Future<void> login(String email, String password) async {
      _authResult = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);
    
   // notifyListeners();
  }

  final adminRef = FirebaseFirestore.instance.collection('admins');
  Map<String, dynamic> _adminDetails;

  Map<String, dynamic> get adminDetails {
    return _adminDetails;
  }

  String get userId {
    return FirebaseAuth.instance.currentUser.uid;
  }

  Future<void> logout() async {
    await FirebaseAuth.instance.signOut();
  }
}
