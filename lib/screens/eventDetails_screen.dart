import 'package:cmApp/providers/event_provider.dart';
import 'package:cmApp/utilities/loadingSpinner.dart';
import 'package:cmApp/widgets/eventDetailsScreen_files/dateTime.dart';
import 'package:cmApp/widgets/eventDetailsScreen_files/eventDescription.dart';
import 'package:cmApp/widgets/eventDetailsScreen_files/venue.dart';
import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

class EventDetailsScreen extends StatelessWidget {
  static const routeName = '/eventDetails_screen';

  Future<void> _reloadEvent(BuildContext context, String id) async {
    await Provider.of<EventProvider>(context, listen: false)
        .singleEventProvider(id);
  }

  @override
  Widget build(BuildContext context) {
    final String id = ModalRoute.of(context).settings.arguments.toString();

    return Scaffold(
      body: FutureBuilder(
        future: _reloadEvent(context, id),
        builder: (context, dataSnapshot) {
          if (dataSnapshot.connectionState == ConnectionState.waiting ||
              id == null)
            return LoadingSpinner();
          else if (dataSnapshot.hasError) {
            print(dataSnapshot.error);
            return Text('Oops!Something went wrong');
          } else {
            return RefreshIndicator(
              onRefresh: () => _reloadEvent(context, id),
              child: Consumer<EventProvider>(
                builder: (context, event, fixChild) {
                  return CustomScrollView(
                    slivers: <Widget>[
                      //Defining appbar
                      SliverAppBar(
                        expandedHeight: 250,
                        // floating: true,
                        pinned: true,
                        flexibleSpace: FlexibleSpaceBar(
                          centerTitle: true,
                          titlePadding: EdgeInsets.all(5),
                          title: Text(
                            event.singleEvent.title,
                            style:
                                Theme.of(context).textTheme.headline6.copyWith(
                                      color: Colors.white,
                                      fontSize: 30,
                                      // fontFamily: 'Roboto',
                                      fontWeight: FontWeight.normal,
                                    ),
                          ),
                          background: Image.network(
                                event.singleEvent.imageUrl,
                                width: double.infinity,
                                fit: BoxFit.cover,
                              ) ??
                              Container(
                                color: Theme.of(context).backgroundColor,
                              ),
                        ),
                      ),
                      EventDescription(event.singleEvent.about),
                      EventDate(event.singleEvent.startTime),
                      Venue(event.singleEvent.venue),
                      //add duration and ends at
                    ],
                  );
                },
              ),
            );
          }
        },
      ),
      //EventDescription(),

      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.blue[900],
        onPressed: () {
          //Navigator.of(context).pushNamed(AddEventScreen.routeName);
        },
        child: const Icon(
          Icons.edit,
          size: 32,
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
    );
  }
}
