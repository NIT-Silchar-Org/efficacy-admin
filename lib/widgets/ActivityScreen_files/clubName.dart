import 'package:cmApp/providers/clubDetails_provider.dart';
import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

///[ClubName] widget contains the club name and tab buttons

class ClubName extends StatelessWidget {
  const ClubName({
    Key key,
    @required this.deviceSize,
    @required this.clubName,
  }) : super(key: key);

  final Size deviceSize;
  final String clubName;

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
            clubName,
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
