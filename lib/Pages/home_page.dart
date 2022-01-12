import 'package:flutter/material.dart';
import 'package:efficacy_admin/themes/appcolor.dart';
import 'package:efficacy_admin/widgets/event_detatils.dart';
import 'package:buttons_tabbar/buttons_tabbar.dart';
import '/Pages/event_detail.dart';

class ClubActivityScreen extends StatefulWidget {
  static const routeName = '/club-activity-screen';

  const ClubActivityScreen({Key? key}) : super(key: key);

  @override
  _ClubActivityScreenState createState() => _ClubActivityScreenState();
}

class _ClubActivityScreenState extends State<ClubActivityScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          iconTheme: IconThemeData(color: Color(0xff05354c)),
          title: Text(
            "Efficacy",
            style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 24,
                color: Color(0xff05354c)),
          ),
          backgroundColor: Colors.white,
          elevation: 0,
          actions: [
            Icon(
              Icons.account_circle,
              size: 30,
            ),
            SizedBox(
              width: 10,
            ),
          ],
        ),
        body: Column(
          children: [
            DefaultTabController(
              length: 3,
              child: Column(
                children: <Widget>[
                  ButtonsTabBar(
                    contentPadding:
                        EdgeInsets.symmetric(horizontal: 50, vertical: 0),
                    backgroundColor: Color(0xff05354c),
                    unselectedBackgroundColor: Colors.white,
                    labelStyle: TextStyle(
                        color: Colors.white, fontWeight: FontWeight.bold),
                    unselectedLabelStyle: TextStyle(
                        color: Color(0xff05354c), fontWeight: FontWeight.bold),
                    borderWidth: 1,
                    unselectedBorderColor: Color(0xff05354c),
                    radius: 100,
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
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Container(
              height: MediaQuery.of(context).size.height / 1.245,
              child: ListView.builder(itemBuilder: (context, index) {
                return GestureDetector(
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 10, vertical: 7),
                    child: EventCard(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const EventDetail(),
                          ),
                        );
                      },
                    ),
                  ),
                  onLongPress: () {
                    showModalBottomSheet(
                        context: context,
                        builder: (BuildContext context) => Container(
                              color: Color(0xff757575),
                              child: Container(
                                height:
                                    (MediaQuery.of(context).size.height) / 5,
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
          backgroundColor: Color(0xff05354c),
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
