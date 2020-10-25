import 'package:flutter/material.dart';

class IconBadge extends StatelessWidget {
  IconData icon;
  Widget child;
  Color color;

  IconBadge({
    @required this.icon,
    @required this.child,
    this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: <Widget>[
        child,
        Positioned(
          right: 104,
          bottom: 6,
          child: CircleAvatar(
            radius: 30,
            backgroundColor: (color == null) ? Colors.grey : color,
            child: IconButton(
              icon: Icon(icon),
              onPressed: (){},
              color: Colors.white,
            ),
          ),
        ),
      ],
    );
  }
}
