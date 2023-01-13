import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

class Calender extends StatelessWidget {
  Calender({Key? key, this.date_of_post}) : super(key: key);
  DateTime? date_of_post;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Icon(
          Icons.calendar_today_outlined,
          size: 20,
          color: Color(0xff05354C),
        ),
        Text(
          DateFormat(DateFormat.ABBR_MONTH_DAY)
              .format(date_of_post!)
              .toString(),
          // "$date_of_post",
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
