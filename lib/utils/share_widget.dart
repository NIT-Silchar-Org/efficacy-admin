import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';

class Share extends StatelessWidget {
  Share({Key? key, this.date_of_post}) : super(key: key);
  DateTime? date_of_post;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Icon(
          FontAwesomeIcons.clock,
          size: 20,
          color: Color(0xff05354C),
        ),
        Text(
          DateFormat(DateFormat.ABBR_MONTH_DAY)
              .format(date_of_post!)
              .toString()+", "+DateFormat(DateFormat.HOUR_MINUTE)
              .format(date_of_post!)
              .toString(),
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
