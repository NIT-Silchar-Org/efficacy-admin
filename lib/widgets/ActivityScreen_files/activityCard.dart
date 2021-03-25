import 'package:cmApp/models/events.dart';
import 'package:cmApp/providers/event_provider.dart';
import 'package:cmApp/screens/eventDetails_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';

import './activityCard_button.dart';

class ActivityCard extends StatelessWidget {
  Events eventData;

  ActivityCard(
      {@required this.eventData,
      this.isCompleted,
      this.isOngoing,
      this.isUpcoming});

  bool isOngoing = false;
  bool isUpcoming = false;
  bool isCompleted = false;
  //can be called as Event Card

  void editButton() {}

  @override
  Widget build(BuildContext context) {
    Size deviceSize = MediaQuery.of(context).size;
    return Container(
      margin: const EdgeInsets.only(left: 15, right: 15, top: 1.5, bottom: 0),
      padding: const EdgeInsets.only(
        //bottom: 0,
        // top: 10,
        left: 10,
        right: 10,
      ),
      //height: 180,
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
      ),
      child: Card(
        elevation: 7,
        shadowColor: Colors.grey[400],
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(35),
        ),
        child: Column(
          children: [
            Row(
              children: [
                leadingWidget(context, 10.5),
                bodyWidget(context, deviceSize),
                // trailingWidget(context),
              ],
            ),
            SizedBox(
              height: 10,
            ),
          ],
        ),
      ),
    );
  }

  ///[trailingWidget] will at the last of the [ActivityCard],it contains the response of students.

  Container trailingWidget(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(right: 4, top: 5),
      width: 76,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        mainAxisAlignment: MainAxisAlignment.start,
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
  Container bodyWidget(BuildContext context, Size deviceSize) {
    final event = Provider.of<EventProvider>(context);

    return Container(
      // height: 139,
      margin: EdgeInsets.only(
        top: 5,
        left: 15,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: 50,
          ),
          //Title Container
          Container(
            // height: 20,
            width: 209,
            child: Text(eventData.title,
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
            width: 205,
            height: 50,
            child: Text(
              eventData.about.length > 70
                  ? eventData.about
                      .replaceRange(70, eventData.about.length, '...')
                  : eventData.about,
              softWrap: true,
            ),
          ),
          SizedBox(
            height: 18,
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
                  routeArgs: eventData.eventId,
                ),

                //Edit button, different code as passing route was difficult

                InkWell(
                  onTap: () {
                    // Navigator.of(context).pushNamed(routeName,arguments:routeArgs );
                  },
                  borderRadius: BorderRadius.circular(20),
                  child: Container(
                    alignment: Alignment.center,
                    width: 70,
                    padding: EdgeInsets.only(
                        right: 4, left: 4, top: 2.5, bottom: 2.5),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(color: Colors.black),
                    ),
                    child: Text(
                      'Edit',
                      style: Theme.of(context).textTheme.headline6.copyWith(
                            fontSize: 15,
                            color: Colors.black,
                          ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  ///[leadingWidget] defines the widget on the leading position of the card.It contains the [CircleAvatar] and Due Date.The size argument defines the size of the dates written.
  Widget leadingWidget(BuildContext context, double size) {
    print('The upcoming is $isUpcoming');
    print('The comp is $isCompleted');
    print('The ongoing is $isOngoing');
    final event = Provider.of<EventProvider>(context);
    // return Container(
    // margin: const EdgeInsets.only(left: 5, top: 5),
    // child:
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        //_________CircleAvatar________//
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: CircleAvatar(
            backgroundColor: Colors.deepPurple[900],
            radius: 20,
            child: Text(
              eventData.title.trim()[0].toUpperCase(),
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
                (isUpcoming)
                    ? 'Starts On'
                    : (isOngoing ? 'Ends On' : 'Ended On'),
                style: TextStyle(color: Colors.purpleAccent, fontSize: size),
              ),
              SizedBox(
                height: 7,
              ),
              Text(
                (isUpcoming)
                    ? DateFormat.MMMd().format(eventData.startTime)
                    : DateFormat.MMMd().format(eventData.endTime),
                style: TextStyle(color: Colors.lightGreen, fontSize: size),
              ),
              SizedBox(
                height: 3,
              ),
              Text(
                DateFormat.jm().format(eventData.startTime),
                style: TextStyle(color: Colors.lightGreen, fontSize: size),
              ),
            ],
          ),
        ),
      ],
    );
    //);
  }
}
