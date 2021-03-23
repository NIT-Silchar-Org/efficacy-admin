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

class ClubActivityScreen extends StatelessWidget {
  static const routeName = '/club-activity-screen';

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
        minHeight: deviceSize.height * 0.6,
        maxHeight: deviceSize.height * 0.6,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(24),
          topRight: Radius.circular(24),
        ),
        panelBuilder: (ScrollController sc) => Consumer<EventProvider>(
          builder: (context, eventProvider, _) => StreamBuilder(
            stream: eventProvider.getCompletedEvents,
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
                print(dataSnapshot.data.length);
                return ListView.builder(
                  //controller: sc,
                  itemBuilder: (context, index) =>
                      ActivityCard(dataSnapshot.data[index] as Events),
                  itemCount: dataSnapshot.data.length as int,
                );
              } else {
                return Text('NOTHING TO VIEW');
              }
            },
          ),
        ),
        body: ClubName(
          deviceSize: deviceSize,
          scaffoldKey: _scaffoldKey,
        ),
      ),

      //---------------tabButtons-----------------------
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

//TAB BAR CODE

class TabBar extends StatefulWidget {
  ///THIS [TabBar] will keep floating over the sliding pannel

  const TabBar({
    Key key,
  }) : super(key: key);

  @override
  _TabBarState createState() => _TabBarState();
}

class _TabBarState extends State<TabBar> {
  bool isUpcomingEventsButtonClicked = true;
  bool isOngoingEventButtonClicked = false;
  bool isCompletedButtonClicked = false;

  @override
  Widget build(BuildContext context) {
    return Row(
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
    );
  }
}

class EventSheet extends StatefulWidget {
  ///This [EventSheet] contains Tab Buttons and event sheet (displayed at the bottom of the page)
  ///which will be rendered on the home screen ie:- club activity screen
  const EventSheet({
    Key key,
    @required this.deviceSize,
    @required this.appBar,
    @required this.mediaQuery,
  }) : super(key: key);

  final Size deviceSize;
  final PreferredSizeWidget appBar;
  final MediaQueryData mediaQuery;

  @override
  _EventSheetState createState() => _EventSheetState();
}

class _EventSheetState extends State<EventSheet> {
  bool isUpcomingEventsButtonClicked = true;
  bool isOngoingEventButtonClicked = false;
  bool isCompletedButtonClicked = false;

  Future<void> _refreshEventList(BuildContext ctx) async {
    await Provider.of<EventProvider>(ctx, listen: false).reLoadClubId;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.only(top: 1.5, bottom: 1.5),
          color: Theme.of(context).backgroundColor,
          width: widget.deviceSize.width,
          height: widget.deviceSize.height * 0.055,
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
        //-----------------------Activity Cards----------------------------
        Container(
          height: widget.deviceSize.height * 0.70 -
              widget.appBar.preferredSize.height -
              widget.mediaQuery.padding.top,
          width: widget.deviceSize.width,
          color: Theme.of(context).backgroundColor,
          child: Card(
            //margin: const EdgeInsets.only(top: 2.5),
            color: Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(35),
                topRight: Radius.circular(35),
              ),
            ),
            child: (isUpcomingEventsButtonClicked)
                //upcoming events
                ? Consumer<EventProvider>(
                    builder: (context, eventProvider, _) => StreamBuilder(
                        stream: eventProvider.getupComingEvents,
                        builder: (context, dataSnapshot) {
                          if (dataSnapshot.connectionState ==
                                  ConnectionState.waiting ||
                              eventProvider.clubId == null) {
                            //additional condition to avoid unnecessary bugs while loading events
                            print('clubId:${eventProvider.clubId}');
                            return LoadingSpinner();
                          } else if (dataSnapshot.error != null) {
                            // print(dataSnapshot.data[1]);
                            print(dataSnapshot.error);
                            return Center(
                              child: Text('Oops! Something went wrong'),
                            );
                          } else if (dataSnapshot.hasData) {
                            print(dataSnapshot.data.length);
                            return RefreshIndicator(
                              onRefresh: () => _refreshEventList(context),
                              child: ListView.builder(
                                itemBuilder: (context, index) => ActivityCard(
                                    dataSnapshot.data[index] as Events),
                                itemCount: dataSnapshot.data.length as int,
                              ),
                            );
                          } else {
                            return Text('NOTHING TO VIEW');
                          }
                        }),
                  )

                // Ongoing Events
                : (isOngoingEventButtonClicked)
                    ? Consumer<EventProvider>(
                        builder: (context, eventProvider, _) => StreamBuilder(
                          stream: eventProvider.getOngoingEvents,
                          builder: (context, dataSnapshot) {
                            if (dataSnapshot.connectionState ==
                                    ConnectionState.waiting ||
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
                              print(dataSnapshot.data.length);
                              return RefreshIndicator(
                                onRefresh: () => _refreshEventList(context),
                                child: ListView.builder(
                                  itemBuilder: (context, index) {
                                    if ((dataSnapshot.data[index] as Events)
                                        .endTime
                                        .isAfter(DateTime
                                            .now())) //condition to filter only ongoing events.
                                      return ActivityCard(
                                          dataSnapshot.data[index] as Events);
                                    else
                                      return SizedBox(
                                        height: 0,
                                      );
                                  },
                                  itemCount: dataSnapshot.data.length as int,
                                ),
                              );
                            } else {
                              return Text('NOTHING TO VIEW');
                            }
                          },
                        ),
                      )
                    :
                    //completed events
                    Consumer<EventProvider>(
                        builder: (context, eventProvider, _) => StreamBuilder(
                          stream: eventProvider.getCompletedEvents,
                          builder: (context, dataSnapshot) {
                            if (dataSnapshot.connectionState ==
                                    ConnectionState.waiting ||
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
                              print(dataSnapshot.data.length);
                              return RefreshIndicator(
                                onRefresh: () => _refreshEventList(context),
                                child: ListView.builder(
                                  itemBuilder: (context, index) => ActivityCard(
                                      dataSnapshot.data[index] as Events),
                                  itemCount: dataSnapshot.data.length as int,
                                ),
                              );
                            } else {
                              return Text('NOTHING TO VIEW');
                            }
                          },
                        ),
                      ),
          ),
        ),
      ],
    );
  }
}
