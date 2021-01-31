import 'dart:async';
import 'dart:convert';

import 'package:flutter/cupertino.dart';

import 'package:flutter/widgets.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

//import 'package:firebase_auth/firebase_auth.dart' as auth;

import '../models/http_exception.dart';

class AuthenticationProvider with ChangeNotifier {
  String _token;
  DateTime _expiryDate;
  String _userId;
  Timer _authTimer;

  Future<void> _authenticate(
      String email, String password, String urlSegment) async {
    print(email);
    print(password);
    String url =
        'https://identitytoolkit.googleapis.com/v1/accounts:$urlSegment?key=AIzaSyDlLNUNt9MJy2HE6_6FPj-N5BVbwy5Asz8';
    try {
      final response = await http.post(
        url,
        body: json.encode(
          {
            'email': email,
            'password': password,
            'returnSecureToken': true,
          },
        ),
      );

      print(response.body);
      final dynamic responseData = json.decode(response.body);
      if (responseData['error'] != null) {
        throw HttpException(
          responseData['error']['message'].toString(),
        );
      }
      _token = responseData['idToken'].toString();
      _userId = responseData['localId'].toString();
      _expiryDate = DateTime.now().add(
        Duration(
          seconds: int.parse(
            responseData['expiresIn'].toString(),
          ),
        ),
      );

      autoLogout();
      notifyListeners();
      final prefs = await SharedPreferences.getInstance();
      final userData = json.encode(
        {
          'token': _token,
          'userId': _userId,
          'expiryDate': _expiryDate.toIso8601String(),
        },
      );
      prefs.setString('userData', userData);
    } catch (error) {
      rethrow;
    }
  }

  Future<void> signUp(String email, String password) async {
    return _authenticate(email, password, 'signUp');
  }

  Future<void> login(String email, String password) async {
    return _authenticate(email, password, 'signInWithPassword');
    // try {
    //   auth.UserCredential user = await auth.FirebaseAuth.instance
    //       .signInWithEmailAndPassword(email: email, password: password);
    //   await user.user.getIdToken().then((String value) => _token = value);
    //   _userId = user.user.uid;

    //   notifyListeners();
    // } catch (error) {
    //   rethrow;
    // }
  }

  Future<bool> tryAutoLogin() async {
    final prefs = await SharedPreferences.getInstance();
    if (!prefs.containsKey('userData')) {
      return false;
    }
    final extractedUserData =
        json.decode(prefs.getString('userData')) as Map<String, Object>;
    final expiryDate = DateTime.parse(
      extractedUserData['expiryDate'].toString(),
    );

    if (expiryDate.isBefore(
      DateTime.now(),
    )) {
      return false;
    }
    _token = extractedUserData['token'].toString();
    _userId = extractedUserData['userId'].toString();
    _expiryDate = expiryDate;
    notifyListeners();
    autoLogout();
    return true;
  }

  final adminRef = FirebaseFirestore.instance.collection('admins');
  Map<String, dynamic> _adminDetails;

  Future<void> getAdminDetails() async {
    await adminRef.get().then<void>((QuerySnapshot adminSnapshot) {
      _adminDetails =
          adminSnapshot.docs.firstWhere((QueryDocumentSnapshot admins) {
        return admins.data()['uid'].toString() == _userId;
      }).data();
      // print(_adminDetails);
      // clubId = admin.data()['clubId'].toString();
    });
  }

  Map<String, dynamic> get adminDetails {
    return _adminDetails;
  }

  String get token {
    if (_expiryDate != null &&
        _expiryDate.isAfter(DateTime.now()) &&
        _token != null) {
      return _token;
    }
    return null;
  }

  String get userId {                                                           
    return _userId;
  }

  bool get isAuthenticated {
    return token != null;
  }

  Future<void> logout() async {
    _token = null;
    _expiryDate = null;
    _userId = null;
    if (_authTimer != null) {
      _authTimer.cancel();
    }
    // Navigator.of(ctx).pushReplacementNamed('/');

    final prefs = await SharedPreferences.getInstance();
    //prefs.remove('userData');  //used if we have multiple things stored that must survive logout, except 'userData'
    prefs.clear();
    notifyListeners();
  }

  void autoLogout() {
    if (_authTimer != null) {
      _authTimer.cancel();
    }
    final _timeToExpiry = _expiryDate
        .difference(
          DateTime.now(),
        )
        .inSeconds;
    _authTimer = Timer(
      Duration(seconds: _timeToExpiry),
      logout,
    ); //timer takes a function which it will execute after a certain duration as mentioned
    print('auto log out');
  }

//to store admin data to firestore

  Future<void> userSetup(Map<String, dynamic> adminCredentials) async {
    CollectionReference adminData =
        FirebaseFirestore.instance.collection('admins');

    print(adminData);

    final Map<String, String> _adminMap = {
      'adminName': adminCredentials['name'].toString(),
      'clubName': adminCredentials['club'].toString(),
      'uid': adminCredentials['uid'].toString(),
      'clubId': adminCredentials['clubId'].toString(),
      'email':adminCredentials['email'].toString(),
      'branch':adminCredentials['branch'].toString(),
      'fb':adminCredentials['fb'].toString(),
      'linkedin':adminCredentials['linkedin'].toString(),
    };
    adminData.doc(userId).set(_adminMap);
  }
}
