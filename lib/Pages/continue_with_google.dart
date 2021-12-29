import 'package:efficacy_admin/themes/appcolor.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:flutter/material.dart';

class Googlelogin extends StatefulWidget {
  const Googlelogin({Key? key}) : super(key: key);

  @override
  _GoogleloginState createState() => _GoogleloginState();
}

class _GoogleloginState extends State<Googlelogin> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Center(
        child: Column(
          children: [
            Container(
              margin:
                  const EdgeInsets.only(left: 0, top: 96, right: 0, bottom: 0),
              height: 250,
              width: 250,
              decoration: const BoxDecoration(
                color: Color(0xFFC4C4C4),
                shape: BoxShape.circle,
              ),
            ),
            const SizedBox(
              height: 41,
            ),
            const Text(
              "Hey! Welcome",
              style: TextStyle(
                fontWeight: FontWeight.w700,
                color: Color(0xff000000),
                fontSize: 24,
              ),
            ),
            const SizedBox(
              height: 16,
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(17, 0, 17, 0),
              child: Text(
                "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Suscipit sed augue quam amet, sed gravida.",
                style: TextStyle(
                  fontWeight: FontWeight.w400,
                  color: const Color(0xff000000).withOpacity(0.64),
                  fontSize: 16,
                ),
                textAlign: TextAlign.center,
              ),
            ),
            const SizedBox(
              height: 63,
            ),
            Container(
              margin: const EdgeInsets.fromLTRB(48, 0, 48, 0),
              child: SizedBox(
                height: 44,
                child: ElevatedButton(
                  style: ButtonStyle(
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                    ),
                    backgroundColor: MaterialStateProperty.all<Color>(
                        AppColorDark.onPrimary),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const [
                      FaIcon(FontAwesomeIcons.google,
                          size: 16, color: Color(0xFFFFFFFF)),
                      SizedBox(
                        width: 10,
                      ),
                      Text(
                        "Continue with Google",
                        style: TextStyle(
                          fontWeight: FontWeight.w500,
                          color: Color(0xFFFFFFFF),
                          fontSize: 16,
                        ),
                      )
                    ],
                  ),
                  onPressed: () {},
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
