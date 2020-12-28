import 'package:flutter/material.dart';

///[ClubName] widget contains the club name and tab buttons

class ClubName extends StatelessWidget {
  const ClubName({
    Key key,
    @required this.deviceSize,
  }) : super(key: key);

  final Size deviceSize;


  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          height: deviceSize.height * 0.25,
          width: double.infinity,
          color: Theme.of(context).backgroundColor,
          alignment: Alignment.center,
          child: Text(
            'Eco Club',
            style: Theme.of(context).textTheme.headline6.copyWith(
                  color: Colors.white,
                  fontSize: 80,
                  fontWeight: FontWeight.bold,
                ),
          ),
        ),
      ],
    );
  }
}
