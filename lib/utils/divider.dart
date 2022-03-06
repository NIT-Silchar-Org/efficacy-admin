import 'package:flutter/material.dart';

class PanelDivider extends StatelessWidget {
  const PanelDivider({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 0, bottom: 10),
      child: Divider(
        color: const Color(0xff180000).withOpacity(0.17),
        height: 20,
        thickness: 2,
        indent: 100,
        endIndent: 100,
      ),
    );
  }
}
