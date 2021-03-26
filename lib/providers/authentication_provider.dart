import 'dart:async';
import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';

import 'package:flutter/widgets.dart';

import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:firebase_auth/firebase_auth.dart';

class AuthenticationProvider with ChangeNotifier {
  UserCredential _authResult;

  Future<void> signUp(
      String email, String password, Map<String, String> _userData) async {
    try {
      _authResult = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password);
      FirebaseFirestore.instance
          .collection('admins')
          .doc(_authResult.user.uid)
          .set(_userData);
    } on PlatformException catch (error) {
      throw error;
    }
    //notifyListeners();
  }

  Future<void> login(String email, String password) async {
    try {
      _authResult = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);
    } on PlatformException catch (error) {
      throw error;
    }
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
    FirebaseAuth.instance.signOut();
  }
}
