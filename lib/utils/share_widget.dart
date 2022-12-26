import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Share extends StatelessWidget {
  const Share({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Icon(
          Icons.share_outlined,
          size: 20,
          color: Color(0xff05354C),
        ),
        Text(
          'Share',
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
