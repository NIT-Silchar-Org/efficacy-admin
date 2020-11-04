import 'dart:convert';

import 'package:flutter/material.dart';

import 'package:http/http.dart' as http;

class SignupProvider with ChangeNotifier {
  String _token;
  DateTime _expiryDate;
  String _userId;

  Future<void> signUp(String email, String password) async {
    String url =
        'https://identitytoolkit.googleapis.com/v1/accounts:signUp?key=AIzaSyDlLNUNt9MJy2HE6_6FPj-N5BVbwy5Asz8';

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
  }
}
