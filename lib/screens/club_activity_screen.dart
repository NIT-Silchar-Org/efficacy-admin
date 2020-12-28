//import 'package:cmApp/screens/add_event_screen.dart';
import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

import '../providers/authentication_provider.dart';
import '../widgets/ActivityScreen_files/activityCard.dart';
import '../widgets/ActivityScreen_files/clubName.dart';
import '../widgets/ActivityScreen_files/tabButton.dart';
import '../widgets/SideDrawer/customDrawerHeader.dart';
import '../widgets/SideDrawer/drawerItem.dart';
import './addEvent_screen.dart';

class ClubActivityScreen extends StatefulWidget {
  static const routeName = '/club-activity-screen';

  @override
  _ClubActivityScreenState createState() => _ClubActivityScreenState();
}

class _ClubActivityScreenState extends State<ClubActivityScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey();
  bool isTaskButtonClicked = true;
  bool isResponseButtonClicked = false;
  @override
  Widget build(BuildContext context) {
    //defining AppBar--------------------------------------
    PreferredSizeWidget appBar = AppBar(
      backgroundColor: Theme.of(context).backgroundColor,
      leading: IconButton(
        icon: Icon(Icons.menu),
        onPressed: () => _scaffoldKey.currentState.openDrawer(),
        iconSize: 40,
      ),
    );
    //----------------------------------------------------
    final MediaQueryData mediaQuery = MediaQuery.of(context);
    final Size deviceSize = mediaQuery.size;
    return SafeArea(
      child: Scaffold(
        key: _scaffoldKey,
        appBar: appBar,
        drawer: Container(
          width: deviceSize.width * 0.9,
          child: Drawer(
            child: ListView(
              children: [
                CustomDrawerHeader(), //Drawer Head

                //--Drawer Items--

                DrawerItem(
                  icon: Icons.home,
                  itemName: 'Home',
                ), //Home

                DrawerItem(
                  icon: Icons.add,
                  itemName: 'Add Event',
                  routeName: AddEventScreen.routeName,
                ), //Add Event

                DrawerItem(
                  icon: Icons.settings,
                  itemName: 'Settings',
                ), //Settings

//-----------------------Logout-----------------------//
                ListTile(
                  leading: Icon(
                    Icons.power_settings_new_rounded,
                    size: 25,
                  ),
                  title: Text(
                    'Logout',
                    style: TextStyle(fontSize: 18),
                  ),
                  onTap: () {
                    Navigator.pop(context);
                    Navigator.of(context).pushReplacementNamed('/');
                    Provider.of<AuthenticationProvider>(context, listen: false)
                        .logout();
                  },
                ),
                //----------------------/Logout--------------------//
              ],
            ),
          ),
        ),
        body: Column(
          children: [
            ClubName(deviceSize: deviceSize), //contains club name
            //---------------tabButtons-----------------------
            Container(
              padding: const EdgeInsets.only(top: 3, bottom: 3),
              color: Theme.of(context).backgroundColor,
              width: deviceSize.width,
              height: deviceSize.height * 0.05,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  //this condition will check wether the tab button is already clicked or not
                  (isTaskButtonClicked)
                      ? TabButton(
                          label: 'Tasks',
                          isClicked: isTaskButtonClicked,
                        )
                      : InkWell(
                          borderRadius: BorderRadius.circular(45),
                          onTap: () {
                            setState(() {
                              isTaskButtonClicked = !isTaskButtonClicked;
                              isResponseButtonClicked =
                                  !isResponseButtonClicked;
                            });
                            print(isTaskButtonClicked);
                            print('tasks');
                          },
                          child: TabButton(
                            label: 'Tasks',
                            isClicked: isTaskButtonClicked,
                          ),
                        ),
                  (isResponseButtonClicked)
                      ? TabButton(
                          isClicked: !isTaskButtonClicked,
                          label: 'Responses',
                        )
                      : InkWell(
                          onTap: () {
                            setState(() {
                              isResponseButtonClicked =
                                  !isResponseButtonClicked;
                              isTaskButtonClicked = !isTaskButtonClicked;
                            });
                            print(isResponseButtonClicked);
                            print('Responses');
                          },
                          borderRadius: BorderRadius.circular(45),
                          child: TabButton(
                            isClicked: isResponseButtonClicked,
                            label: 'Responses',
                          ),
                        )
                ],
              ),
            ),
            //-----------------------Activity Cards----------------------------
            Container(
              height: deviceSize.height * 0.70 -
                  appBar.preferredSize.height -
                  mediaQuery.padding.top,
              width: deviceSize.width,
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
                child: (isTaskButtonClicked)
                    ? ListView.builder(
                        itemBuilder: (context, index) => ActivityCard(),
                        itemCount: 10,
                      )
                    : Center(
                        child: Text('Response Page'),
                      ),
              ),
            ),
          ],
        ),
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
      ),
    );
  }
}
