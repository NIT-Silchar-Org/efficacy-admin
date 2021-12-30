import 'package:flutter/material.dart';
import 'package:efficacy_admin/themes/appcolor.dart';
import 'package:efficacy_admin/widgets/event_detatils.dart';
import 'package:tab_indicator_styler/tab_indicator_styler.dart';

class ClubActivityScreen extends StatefulWidget {
  static const routeName = '/club-activity-screen';

  @override
  _ClubActivityScreenState createState() => _ClubActivityScreenState();
}

class _ClubActivityScreenState extends State<ClubActivityScreen> {
  @override
  Widget build(BuildContext context) {
    //----------------------------------------------------
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          iconTheme: IconThemeData(color: AppColorLight.onPrimaryContainer),
          title: Text(
            "Efficacy",
            style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 24,
                color: AppColorLight.onPrimaryContainer),
          ),
          backgroundColor: Colors.white,
          elevation: 0,
          actions: [Icon(Icons.account_circle)],
        ),
        body: Column(
          children: [
            DefaultTabController(
              length: 3,
              child: Material(
                child: TabBar(
                  indicatorPadding: EdgeInsets.all(5),
                  tabs: [
                    Tab(
                      text: "Upcoming",
                    ),
                    Tab(
                      text: "Ongoing",
                    ),
                    Tab(
                      text: "Completed",
                    ),
                  ],
                  labelColor: AppColorLight.onPrimaryContainer,
                  // add it here
                  indicator: RectangularIndicator(
                      bottomLeftRadius: 20,
                      topLeftRadius: 20,
                      topRightRadius: 20,
                      bottomRightRadius: 20,
                      color: AppColorLight.onPrimaryContainer,
                      paintingStyle: PaintingStyle.stroke),
                ),
              ),
            ),
            Container(
              height: MediaQuery.of(context).size.height / 1.229,
              child: ListView.builder(itemBuilder: (context, index) {
                return GestureDetector(
                  child: Container(child: EventCard()),
                  onLongPress: () {
                    showModalBottomSheet(
                        context: context,
                        builder: (BuildContext context) => Container(
                              color: Color(0xff757575),
                              child: Container(
                                height:
                                    (MediaQuery.of(context).size.height) / 3.8,
                                padding: EdgeInsets.all(20.0),
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(20.0),
                                    topRight: Radius.circular(20.0),
                                  ),
                                ),
                                child: Column(
                                  children: [
                                    SizedBox(
                                      height: 20.0,
                                      width: 100.0,
                                      child: Divider(
                                        color: Colors.black87,
                                        thickness: 2,
                                      ),
                                    ),
                                    ListTile(
                                      leading: Icon(Icons.delete),
                                      title: Text('Delete'),
                                    ),
                                    ListTile(
                                      leading: Icon(Icons.edit),
                                      title: Text('Edit'),
                                    ),
                                  ],
                                ),
                              ),
                            ));
                  },
                );
              }),
            ),
          ],
        ),
        floatingActionButton: FloatingActionButton(
          backgroundColor: AppColorLight.onPrimaryContainer,
          onPressed: () {},
          child: const Icon(
            Icons.add,
            size: 52,
          ),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      ),
    );
  }
}
