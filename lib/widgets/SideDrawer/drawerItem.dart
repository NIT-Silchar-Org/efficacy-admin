import 'package:flutter/material.dart';

class DrawerItem extends StatelessWidget {
  IconData icon;
  String itemName;
  String routeName;

  DrawerItem({
    @required this.icon,
    @required this.itemName,
    this.routeName,
  });
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 60,
      child: ListTile(
        leading: Icon(
          icon,
          size: 25,
        ),
        title: Text(
          itemName,
          style: TextStyle(fontSize: 18),
        ),
        onTap: () {
          Navigator.pop(context);
          if (routeName !=null) {
            Navigator.of(context).pushNamed(routeName);
          }
        },
      ),
    );
  }
}
