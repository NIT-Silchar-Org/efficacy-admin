import 'package:efficacy_admin/themes/appcolor.dart';
import 'package:flutter/material.dart';

Widget buildExtendedFab() => AnimatedContainer(
      duration: Duration(milliseconds: 200),
      curve: Curves.linear,
      width: 150,
      height: 50,
      child: FloatingActionButton.extended(
        onPressed: () {},
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        backgroundColor: AppColorLight.primary,
        icon: Icon(Icons.upload_outlined),
        label: const Center(
          child: Text(
            "Upload",
            style: TextStyle(fontSize: 15, color: Colors.white),
          ),
        ),
      ),
    );
