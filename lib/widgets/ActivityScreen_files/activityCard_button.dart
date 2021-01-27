import 'package:cmApp/providers/event_provider.dart';
import 'package:flutter/material.dart';

import 'package:provider/provider.dart';


class ActivityCardButton extends StatelessWidget {
  String buttonName;
  String routeName;
  String routeArgs;

  ActivityCardButton({
    @required this.buttonName,
    @required this.routeName,
    @required this.routeArgs,
  });
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.of(context).pushNamed(routeName,arguments:routeArgs );
       // print(Provider.of<EventProvider>(context,listen: false).getEventByClubId);
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
