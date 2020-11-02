import 'package:flutter/material.dart';

class SignupButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(5),
      width: 170,
      height: 55,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(205),
        boxShadow: [
          const BoxShadow(
            blurRadius: 10,
            color: Colors.black,
            offset: Offset(6, 4),
          ),
        ],
        color: Theme.of(context).buttonColor,
      ),
      child: Text(
        'SignUp',
        style: Theme.of(context).textTheme.headline6.copyWith(
              color: Colors.white,
              //fontWeight: FontWeight.bold,
              fontSize: 30
            ),
      ),
    );
  }
}