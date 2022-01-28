import 'package:efficacy_admin/themes/appcolor.dart';
import 'package:flutter/material.dart';

Widget buildFab() => AnimatedContainer(
      duration: Duration(milliseconds: 200),
      curve: Curves.linear,
      width: 50,
      height: 50,
      child: FloatingActionButton.extended(
        onPressed: () {},
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        backgroundColor: AppColorLight.primary,
        icon: const Padding(
          padding: EdgeInsets.only(left: 10.0),
          child: Icon(Icons.upload_outlined),
        ),
        label: SizedBox(),
      ),
    );
