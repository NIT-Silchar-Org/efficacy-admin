// ignore_for_file: file_names
import 'package:flutter/material.dart';

class ActionButton extends StatelessWidget {
  ActionButton({required this.color, required this.onPressed});
  final Color color;
  final Function()? onPressed;

  @override
  Widget build(BuildContext context) {
    return Container(
      
      height: 50,
      width: 50,
      child: Material(
        borderRadius: BorderRadius.circular(10),
        elevation: 10,
        color: color,
        child: MaterialButton(
          padding: EdgeInsets.only(right: 2),
          onPressed: onPressed,
          child: const Icon(
            Icons.add,
            color: Colors.white,
            size: 32,
          ),
        ),
      ),
    );
  }
}
