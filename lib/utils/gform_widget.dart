import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart';

class Gform extends StatelessWidget {
  Gform({Key? key, this.form_url}) : super(key: key);
  String? form_url;

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
        _launchurl(form_url!);
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
              Container(
                width: 22,
                height: 22,
                decoration: const BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage('assets/google_logo.png'),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              Text(
                "Google Form",
                style: GoogleFonts.poppins(
                  textStyle: const TextStyle(
                    color: Color(0xFFFECC07),
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
