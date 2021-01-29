import 'package:flutter/material.dart';

import 'package:intl/intl.dart';

class EventDate extends StatelessWidget {
  DateTime dateTime;

  EventDate(this.dateTime);

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Column(
        children: [
          ListTile(
            leading: Icon(
              Icons.calendar_today,
              color: Colors.grey[800],
              size: 35,
            ),
            title: Text(
              DateFormat.yMMMEd().format(dateTime),
              style: Theme.of(context).textTheme.headline6.copyWith(
                    color: Colors.black,
                    fontSize: 22,
                  ),
            ),
            subtitle: Text(
              DateFormat.jm().format(dateTime),
              style: Theme.of(context).textTheme.subtitle1.copyWith(
                  //color: Colors.black,
                  //fontSize: 22,
                  ),
            ),
          ),
          SizedBox(
            height: 15,
          ),
        ],
      ),
    );
  }
}
