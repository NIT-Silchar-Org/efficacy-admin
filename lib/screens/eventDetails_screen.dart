import 'package:cmApp/models/events.dart';
import 'package:cmApp/providers/event_provider.dart';
import 'package:cmApp/utilities/loadingSpinner.dart';
import 'package:cmApp/widgets/eventDetailsScreen_files/dateTime.dart';
import 'package:cmApp/widgets/eventDetailsScreen_files/eventDescription.dart';
import 'package:cmApp/widgets/eventDetailsScreen_files/venue.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'edit_screen.dart';

enum SelectedOption {
  Delete,
}
Events eventCopy;

class EventDetailsScreen extends StatelessWidget {
  static const routeName = '/eventDetails_screen';

  Future<void> _reloadEvent(BuildContext context, String id) async {
    await Provider.of<EventProvider>(context, listen: false)
        .singleEventProvider(id);
  }

  //String _eventName = 'this event';

  @override
  Widget build(BuildContext context) {
    final Map<String, Object> routeArgs =
        ModalRoute.of(context).settings.arguments;
    final String id = routeArgs['id'].toString();
    final bool isCompleted = routeArgs['isCompleted'];
    //defining AlertDialog for confirm delete

    void _confirmDeleteDialog(String eventName) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text("Confirm Delete ?"),
            content: Text('Are you sure you want to delete "$eventName"'),
            actions: <Widget>[
              //dialog buttons
              FlatButton(
                child: Text(
                  "Cancel",
                  style: Theme.of(context)
                      .textTheme
                      .subtitle1
                      .copyWith(color: Colors.blue),
                ),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
              FlatButton(
                child: Text(
                  "Delete",
                  style: Theme.of(context)
                      .textTheme
                      .subtitle1
                      .copyWith(color: Colors.red),
                ),
                onPressed: () {
                  //TODO place a transparent loader to show that a file is deleting
                  Provider.of<EventProvider>(context, listen: false)
                      .deleteEvent(eventId: id, imageUrl: eventCopy.imageUrl)
                      .then(
                        Navigator.of(context).pop, //to close dialog box
                      )
                      .then(
                        Navigator.of(context).pop, //to close event page
                      );
                },
              ),
            ],
          );
        },
      );
    }

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
                  eventCopy = event.singleEvent;
                  return CustomScrollView(
                    slivers: <Widget>[
                      //Defining appbar
                      SliverAppBar(
                        expandedHeight: 250,
                        actions: [
                          PopupMenuButton(
                            onSelected: (SelectedOption selectedValue) {
                              if (selectedValue == SelectedOption.Delete) {
                                _confirmDeleteDialog(
                                  event.singleEvent.title,
                                );
                              }
                            },
                            icon: Icon(
                              Icons.more_vert,
                            ),
                            itemBuilder: (_) => [
                              PopupMenuItem(
                                height: 10,
                                child: Padding(
                                  padding:
                                      const EdgeInsets.only(bottom: 4, top: 4),
                                  child: Text(
                                    'Delete',
                                    style: TextStyle(fontSize: 15),
                                  ),
                                ),
                                value: SelectedOption.Delete,
                              ),
                            ],
                          ),
                        ],
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

      floatingActionButton: Visibility(
        visible:
            !isCompleted, //if event end date is before today then not visible
        child: FloatingActionButton(
          backgroundColor: Colors.blue[900],
          onPressed: () {
            Navigator.of(context).push(new MaterialPageRoute(
                builder: (BuildContext context) => new editScreen(
                      event: eventCopy,
                    )));
          },
          child: const Icon(
            Icons.edit,
            size: 32,
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
    );
  }
}
