import 'package:flutter/material.dart';

class TabButton extends StatelessWidget {
  String label;
  bool isClicked;
  // final bool isClicked;

  TabButton({
    @required this.label,
    @required this.isClicked,
  });
  @override
  Widget build(BuildContext context) {
    return Container(
      padding:
          const EdgeInsets.only(top: 3.5, bottom: 3.5, left: 15, right: 15),
      margin: EdgeInsets.only(bottom: 5),
      //width: 100,
      alignment: Alignment.center,
      decoration: isClicked
          ? BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(45),
              boxShadow: [
                BoxShadow(
                  color: Colors.indigo[800],
                  blurRadius: 2.0,
                  spreadRadius: 2.0,
                  offset: Offset(1, 3.5), // shadow direction: bottom right
                ),
              ],
            )
          : null,
      child: Center(
        child: Text(
          label,
          style: Theme.of(context).textTheme.headline6.copyWith(
                fontSize: 15,
                color: Colors.black,
              ),
        ),
      ),
    );
  }
}
