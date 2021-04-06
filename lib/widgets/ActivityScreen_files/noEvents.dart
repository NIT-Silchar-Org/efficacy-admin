import 'package:flutter/material.dart';

class NoEvents extends StatelessWidget {
  String message;
  NoEvents(this.message);
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Container(
          height: 15,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(24),
              topRight: Radius.circular(24),
            ),
          ),
        ),

        Image.asset(
          'assets/images/noEvents.gif',
          height: 350,
        ),
        //SizedBox(height: 2),
        Text(message),
      ],
    );
  }
}
