import 'package:cmApp/models/events.dart';
import 'package:cmApp/providers/event_provider.dart';
import 'package:cmApp/utilities/loadingSpinner.dart';
import 'package:cmApp/widgets/SideDrawer/sideDrawer.dart';
import 'package:flutter/material.dart';

import 'package:provider/provider.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

import '../widgets/ActivityScreen_files/activityCard.dart';
import '../widgets/ActivityScreen_files/clubName.dart';
import '../widgets/ActivityScreen_files/tabButton.dart';
import './addEvent_screen.dart';

class ClubActivityScreen extends StatefulWidget {
  static const routeName = '/club-activity-screen';

  @override
  _ClubActivityScreenState createState() => _ClubActivityScreenState();
}

class _ClubActivityScreenState extends State<ClubActivityScreen> {
  bool isUpcomingEventsButtonClicked = true;

  bool isOngoingEventButtonClicked = false;

  bool isCompletedButtonClicked = false;

  int countOngoingData = 0;

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    //----------------------------------------------------
    final MediaQueryData mediaQuery = MediaQuery.of(context);
    final Size deviceSize = mediaQuery.size;
    return Scaffold(
      key: _scaffoldKey,
      //appBar: appBar,
      drawer: SideDrawer(deviceSize), //side drawer

      //sliding bottom pannel
      body: SlidingUpPanel(
        //backdropEnabled: true,
        minHeight: deviceSize.height * 0.64,
        maxHeight: deviceSize.height * 0.64,
        boxShadow: <BoxShadow>[
          BoxShadow(
            color: Colors.indigo[800],
            blurRadius: 2.0,
            spreadRadius: 2.0,
            offset: Offset(1, -3),
          ) // shadow direction: bottom right)
        ],
        isDraggable: false,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(24),
          topRight: Radius.circular(24),
        ),
        panelBuilder: (ScrollController sc) => Consumer<EventProvider>(
          builder: (context, eventProvider, _) => StreamBuilder(
            stream: (isCompletedButtonClicked)
                ? eventProvider.getCompletedEvents
                : (isOngoingEventButtonClicked
                    ? eventProvider.getOngoingEvents
                    : eventProvider.getupComingEvents),
            builder: (context, dataSnapshot) {
              if (dataSnapshot.connectionState == ConnectionState.waiting ||
                  eventProvider.clubId == null) {
                //additional condition to avoid unnecessary bugs while loading events
                print('loading');
                return LoadingSpinner();
              } else if (dataSnapshot.error != null) {
                // print(dataSnapshot.data[1]);
                print(dataSnapshot.error);
                return Center(
                  child: Text('Oops! Something went wrong'),
                );
              } else if (dataSnapshot.hasData) {
                if (dataSnapshot.data.length == 0)
                  return Image.asset('assets/images/Events Empty Data Set.png');
                return ListView.builder(
                  //controller: sc,
                  itemBuilder: (context, index) {
                    if (isOngoingEventButtonClicked) {
                      countOngoingData++;
                      if ((dataSnapshot.data[index] as Events).endTime.isAfter(
                          DateTime
                              .now())) //condition to filter only ongoing events.
                      {
                        return ActivityCard(
                          eventData: dataSnapshot.data[index] as Events,
                          isOngoing: true,
                          isCompleted: false,
                          isUpcoming: false,
                        );
                      } else 
                        return SizedBox(
                          height: 0,
                        );
                    }

                    return ActivityCard(
                      eventData: dataSnapshot.data[index] as Events,
                      isCompleted: isCompletedButtonClicked,
                      isUpcoming: isUpcomingEventsButtonClicked,
                      isOngoing: false,
                    );
                  },
                  itemCount: dataSnapshot.data.length as int,
                );
              } else {
                return Text('NOTHING TO VIEW');
              }
            },
          ),
        ),
        body: Stack(
          children: [
            ClubName(
              deviceSize: deviceSize,
              scaffoldKey: _scaffoldKey,
            ),

            //Tab Bar
            Positioned(
              top: deviceSize.height * 0.305,
              child: Container(
                padding: const EdgeInsets.only(top: 1.5, bottom: 1.5),
                color: Theme.of(context).backgroundColor,
                width: deviceSize.width,
                height: deviceSize.height * 0.055,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    //this condition will check which button is clicked

                    //for upcomin events------------------------
                    (isUpcomingEventsButtonClicked)
                        ? TabButton(
                            label: 'Upcoming',
                            isClicked: isUpcomingEventsButtonClicked,
                          )
                        : InkWell(
                            borderRadius: BorderRadius.circular(45),
                            onTap: () {
                              setState(() {
                                isUpcomingEventsButtonClicked = true;
                                isCompletedButtonClicked = false;
                                isOngoingEventButtonClicked = false;
                              });
                              print(isUpcomingEventsButtonClicked);
                              print('upcoming events');
                            },
                            child: TabButton(
                              label: 'Upcoming',
                              isClicked: isUpcomingEventsButtonClicked,
                            ),
                          ),

                    //for ongoing events------------------------
                    (isOngoingEventButtonClicked)
                        ? TabButton(
                            label: 'Ongoing',
                            isClicked: isOngoingEventButtonClicked,
                          )
                        : InkWell(
                            borderRadius: BorderRadius.circular(45),
                            onTap: () {
                              setState(() {
                                isOngoingEventButtonClicked = true;
                                isUpcomingEventsButtonClicked = false;
                                isCompletedButtonClicked = false;
                                countOngoingData = 0;
                              });
                              print(isOngoingEventButtonClicked);
                              print('Ongoing');
                            },
                            child: TabButton(
                              label: 'Ongoing',
                              isClicked: isOngoingEventButtonClicked,
                            ),
                          ),

                    // for ongoing events------------------------------------

                    (isCompletedButtonClicked)
                        ? TabButton(
                            isClicked: !isUpcomingEventsButtonClicked,
                            label: 'Completed',
                          )
                        : InkWell(
                            onTap: () {
                              setState(() {
                                isCompletedButtonClicked = true;
                                isUpcomingEventsButtonClicked = false;
                                isOngoingEventButtonClicked = false;
                              });
                              print(isCompletedButtonClicked);
                              print('completed');
                            },
                            borderRadius: BorderRadius.circular(45),
                            child: TabButton(
                              isClicked: isCompletedButtonClicked,
                              label: 'Completed',
                            ),
                          )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),

      //---------------Add Event Button-----------------------
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.blue[900],
        onPressed: () {
          Navigator.of(context).pushNamed(AddEventScreen.routeName);
        },
        child: const Icon(
          Icons.add,
          size: 52,
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
    );
  }
}
