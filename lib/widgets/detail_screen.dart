import 'package:efficacy_admin/themes/appcolor.dart';
import 'package:flutter/material.dart';

class Fullscreen extends StatelessWidget {
  const Fullscreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back_ios_new_rounded,
            color: Colors.white,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      backgroundColor: Colors.black,
      body: Center(
        child: Container(
          height: 300,
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/androidStudyJam.png'),
              fit: BoxFit.cover,
            ),
          ),
        ),
      ),
    );
  }
}
