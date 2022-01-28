import 'package:efficacy_admin/themes/appcolor.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

Widget buildExtendedFab(BuildContext context) => AnimatedContainer(
      duration: Duration(milliseconds: 200),
      curve: Curves.linear,
      width: 150,
      height: 50,
      child: FloatingActionButton.extended(
        onPressed: () {},
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        backgroundColor: AppColorLight.primary,
        icon: const Icon(
          Icons.upload_outlined,
          size: 30,
        ),
        label: Center(
          child: Text(
            "Upload",
            // style: TextStyle(fontSize: 15, color: Colors.white),
            style: GoogleFonts.poppins(
                textStyle: Theme.of(context)
                    .textTheme
                    .bodyText1!
                    .copyWith(color: Colors.white)),
          ),
        ),
      ),
    );
