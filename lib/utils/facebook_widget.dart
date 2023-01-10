import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart';

class Facebook extends StatelessWidget {
  Facebook({Key? key, this.fburl}) : super(key: key);
  String? fburl;

  Future<void> _launchurl(String url) async {
    final Uri uri = Uri(scheme: 'https', host: url);
    if (!await launchUrl(
      uri,
      mode: LaunchMode.externalApplication,
    )) {
      throw "Can not Launch";
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
       onTap: () {
        _launchurl(fburl!);
      },
      child: Card(
        shadowColor: const Color(0xffD8F6FF).withOpacity(0.5),
        elevation: 1,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        child: SizedBox(
          width: 125,
          height: 28,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              const Icon(
                Icons.facebook,
                size: 22,
                color: Color(0xff1877F2),
              ),
              Text(
                "Facebook",
                style: GoogleFonts.poppins(
                  textStyle: const TextStyle(
                    color: Color(0xff213f8d),
                    fontSize: 12.0,
                    fontWeight: FontWeight.w500,
                    letterSpacing: 0.5,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
