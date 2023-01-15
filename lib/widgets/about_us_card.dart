import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

class AboutUsCard extends StatelessWidget {
  final String name;
  final String imgUrl;
  final String subTitle;
  final String fbUrl;
  final String instaUrl;
  const AboutUsCard({
    Key? key,
    required this.name,
    required this.imgUrl,
    required this.subTitle,
    required this.fbUrl,
    required this.instaUrl,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => connectBottomSheet(context),
      child: Card(
        elevation: 0,
        child: ListTile(
          leading: CircleAvatar(
            radius: 20,
            child: Image.asset(
              imgUrl,
              width: 96,
              height: 96,
            ),
          ),
          title: Text(
            name,
            style: const TextStyle(
                fontWeight: FontWeight.bold, color: Color(0xFF05354C)),
          ),
          subtitle: Text(
            subTitle,
            style: const TextStyle(color: Color(0xFF49454F)),
          ),
        ),
      ),
    );
  }

  Future<dynamic> connectBottomSheet(BuildContext context) {
    return showModalBottomSheet(
      backgroundColor: Colors.transparent,
      context: context,
      builder: (context) => Container(
        height: 200,
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20),
          ),
        ),
        child: Column(
          children: [
            Container(
              margin: const EdgeInsets.only(top: 15),
              width: 75,
              height: 3,
              decoration: BoxDecoration(
                color: const Color(0xFF05354c),
                borderRadius: BorderRadius.circular(20),
              ),
            ),
            const SizedBox(height: 20),
            const Text(
              'Connect',
              style: TextStyle(
                fontSize: 22,
                color: Color(0xFF05354c),
                fontWeight: FontWeight.bold,
              ),
            ),
            Container(
              margin: const EdgeInsets.only(top: 5),
              width: double.infinity,
              height: 2,
              decoration: BoxDecoration(
                color: Colors.grey[300],
                borderRadius: BorderRadius.circular(20),
              ),
            ),
            const SizedBox(height: 30),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                InkWell(
                  onTap: () {
                    launchUrl(
                      Uri.parse(instaUrl),
                      mode: LaunchMode.externalApplication,
                    );
                  },
                  child: const Icon(
                    FontAwesomeIcons.linkedinIn,
                    color: Color(0xFF05354c),
                    size: 42,
                  ),
                ),
                InkWell(
                  onTap: () {
                    launchUrl(
                      Uri.parse(fbUrl),
                      mode: LaunchMode.externalApplication,
                    );
                  },
                  child: const Icon(
                    FontAwesomeIcons.facebook,
                    color: Color(0xFF05354c),
                    size: 50,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
