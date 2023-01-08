import 'package:flutter/material.dart';

class AboutUsCard extends StatelessWidget {
  final String name;
  final String imgUrl;
  final String subTitle;
  const AboutUsCard({Key? key,
    required this.name,
    required this.imgUrl,
    required this.subTitle
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
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
          style:
              const TextStyle(fontWeight: FontWeight.bold, color: Color(0xFF05354C)),
        ),
        subtitle: Text(
          subTitle,
          style: const TextStyle(color: Color(0xFF49454F)),
        ),
      ),
    );
  }
}
