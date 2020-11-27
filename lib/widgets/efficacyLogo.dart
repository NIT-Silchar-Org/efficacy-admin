//put this widget anywhere to get a desirable efficacy logo

import 'package:flutter/material.dart';

class EfficacyLogo extends StatelessWidget {
  EfficacyLogo({
    @required this.deviceSize,
  });
  Size deviceSize;

  @override
  Widget build(BuildContext context) {
    return Container(
        height: deviceSize.height * 0.3,
        width: double.infinity,
        alignment: Alignment.center,
        padding: const EdgeInsets.only(top: 50.0),
        child: Image.asset(
          'assets/images/efficacy_Logo.png',
          alignment: Alignment.center,
          fit: BoxFit.contain,
        ),
    );
  }
}
