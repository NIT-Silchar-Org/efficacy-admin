import 'package:flutter/material.dart';

class ActivityCardButton extends StatelessWidget {
  String buttonName;
  String routeName;

  ActivityCardButton({
    @required this.buttonName,
    @required this.routeName,
  });
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.of(context).pushNamed(routeName);
      },
      borderRadius: BorderRadius.circular(20),
      child: Container(
        alignment: Alignment.center,
        width: 70,
        padding: EdgeInsets.only(right: 4, left: 4, top: 2.5, bottom: 2.5),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: Colors.black),
        ),
        child: Text(
          buttonName,
          style: Theme.of(context).textTheme.headline6.copyWith(
                fontSize: 15,
                color: Colors.black,
              ),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}
