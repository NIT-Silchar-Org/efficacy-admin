import 'package:flutter/material.dart';

class EventDescription extends StatelessWidget {
  String description;

  EventDescription(this.description);

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Container(
        padding: EdgeInsets.only(top: 8, left: 10, right: 5),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 10,
            ),
            Text(
              'Description',
              style: Theme.of(context).textTheme.headline6.copyWith(
                    color: Colors.grey,
                    fontSize: 35,
                  ),
            ),
            SizedBox(
              height: 8,
            ),
            Text(
              description,
              style: Theme.of(context)
                  .textTheme
                  .headline6
                  .copyWith(color: Colors.black),
              softWrap: true,
            ),
            Divider(
              color: Colors.grey,
              indent: 25,
              endIndent: 25,
            ),
          ],
        ),
      ),
    );
  }
}
