import 'package:cmApp/screens/eventDetails_screen.dart';
import 'package:flutter/material.dart';

import './activityCard_button.dart';

class ActivityCard extends StatelessWidget {
  

  void editButton() {}

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(left: 15, right: 15, top: 1.5, bottom: 0),
      padding: const EdgeInsets.all(10),
      height: 180,
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Card(
        elevation: 7,
        shadowColor: Colors.grey[400],
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(35),
        ),
        child: Row(
          children: [
            leadingWidget(context, 13.5),
            bodyWidget(context),
            trailingWidget(context),
          ],
        ),
      ),
    );
  }

  ///[trailingWidget] will at the last of the [ActivityCard],it contains the response of students.

  Container trailingWidget(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(right: 4),
      width: 76,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          IconButton(
            icon: Icon(
              Icons.remove_circle,
              size: 35,
              color: Theme.of(context).errorColor,
            ),
            onPressed: () {},
            padding: EdgeInsets.only(right: 25),
          ),
          Text(
            'Responded',
            style: TextStyle(fontSize: 12),
          ),
          const SizedBox(
            height: 2,
          ),
          Container(
            width: 50,
            child: Row(
              children: [
                Text(
                  '32/55',
                  style: TextStyle(fontSize: 15),
                ),
                const SizedBox(
                  width: 8,
                )
              ],
            ),
          ),
        ],
      ),
    );
  }

  ///[bodyWidget] makes the body of the [ActivityCard],it contains the title, description and buttons.
  Container bodyWidget(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(
        top: 15,
        left: 15,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          //Title Container
          Container(
            width: 200,
            child: Text('Meeting',
                style: Theme.of(context).textTheme.headline6.copyWith(
                      fontSize: 25,
                      color: Colors.black,
                    )),
          ),
          SizedBox(
            height: 10,
          ),
          //Description container
          Container(
            width: 180,
            height: 50,
            child: Text(
              'This is the description area. HSDHlafdhdklfhhfdljhdlhadlaldsldjldsj',
              softWrap: true,
            ),
          ),
          SizedBox(
            height: 10,
          ),
          //Button Container
          Container(
            //alignment: Alignment.centerLeft,
            width: 160,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ActivityCardButton(
                  buttonName: 'Details',
                  routeName: EventDetailsScreen.routeName,
                ),
                ActivityCardButton(
                  buttonName: 'Edit',
                  routeName: null,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  ///[leadingWidget] defines the widget on the leading position of the card.It contains the [CircleAvatar] and Due Date.The size argument defines the size of the dates written.
  Container leadingWidget(BuildContext context, double size) {
    return Container(
      margin: const EdgeInsets.only(left: 5, top: 5),
      child: Column(
        children: [
          //_________CircleAvatar________//
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: CircleAvatar(
              backgroundColor: Colors.deepPurple[900],
              radius: 20,
              child: Text(
                'M',
                style: Theme.of(context).textTheme.headline6.copyWith(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
              ),
            ),
          ),
          //________Date and Due Date__________//
          Container(
            margin: EdgeInsets.only(left: 15),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Due Date',
                  style: TextStyle(color: Colors.purpleAccent, fontSize: size),
                ),
                Text(
                  '12 Aug',
                  style: TextStyle(color: Colors.lightGreen, fontSize: size),
                ),
                Text(
                  '12 PM',
                  style: TextStyle(color: Colors.lightGreen, fontSize: size),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
