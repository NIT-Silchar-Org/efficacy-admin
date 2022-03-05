import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Like extends StatefulWidget {
  const Like({Key? key}) : super(key: key);
 @override
  _LikeState createState() => _LikeState();
}

class _LikeState extends State<Like> {

  bool ispressed=false;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        IconButton(
        onPressed: (){setState((){ispressed=!ispressed;});},
        icon: Icon(
          Icons.thumb_up_alt,
          size: 24,
          color:ispressed?Colors.blue: Color(0xff05354C),
        ),
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
