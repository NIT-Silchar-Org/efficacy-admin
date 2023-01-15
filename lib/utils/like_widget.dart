import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Like extends StatelessWidget {
  Like({Key? key, this.likes}) : super(key: key);
  int? likes;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Icon(
          Icons.thumb_up_outlined,
          size: 24,
          color: Color(0xff05354C),
        ),
        Text(
          "$likes",
          style: GoogleFonts.poppins(
            textStyle: TextStyle(
              color: const Color(0xff49454F).withOpacity(0.7),
              fontSize: 12.0,
              fontWeight: FontWeight.w500,
              letterSpacing: 0.5,
            ),
          ),
        )
      ],
    );
  }
}
