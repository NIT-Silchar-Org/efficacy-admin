import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Like extends StatelessWidget {
  const Like({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Icon(
          Icons.thumb_up_alt_outlined,
          size: 20,
          color: Color(0xff05354C),
        ),
        Text(
          '1.2k',
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
