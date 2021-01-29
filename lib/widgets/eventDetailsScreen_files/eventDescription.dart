import 'package:flutter/material.dart';

class EventDescription extends StatelessWidget {
  String description;

  EventDescription(this.description);

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Padding(
        padding: EdgeInsets.only(top: 30, left: 15, right: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 10,
            ),
            Text(
              'About',
              style: Theme.of(context).textTheme.headline6.copyWith(
                    color: Colors.black,
                    fontSize: 35,
                   // fontFamily: 'CenturyGothic',
                    fontWeight: FontWeight.w600,
                  ),
            ),
            SizedBox(
              height: 30,
            ),
            Text(
              description.replaceAll('/n', '\n'),
              style: Theme.of(context).textTheme.headline6.copyWith(
                    color: Colors.black,
                   //fontFamily: 'CenturyGothic',
                    fontWeight: FontWeight.w500,
                  ),
              softWrap: true,
            ),
            SizedBox(
              height: 70,
            ),
            Divider(
              color: Colors.grey[600],
              indent: 25,
              endIndent: 25,
            ),
            SizedBox(
              height: 40,
            ),
          ],
        ),
      ),
    );
  }
}
