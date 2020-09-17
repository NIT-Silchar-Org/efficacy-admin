import 'package:flutter/material.dart';

class Wrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Wrapper"),
        centerTitle: true,
      ),
      body: Center(
        child: Text("Sign In/Feed"),
      ),
    );
  }
}
