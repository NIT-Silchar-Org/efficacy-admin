import 'package:cmApp/providers/adminDetails_provider.dart';
import 'package:cmApp/utilities/loadingSpinner.dart';
import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

///[ClubName] widget contains the club name and hamburger icon

class ClubName extends StatelessWidget {
  const ClubName({
    Key key,
    @required this.deviceSize,
    @required this.scaffoldKey,
    // @required this.clubName,
  }) : super(key: key);

  final Size deviceSize;
  final GlobalKey<ScaffoldState> scaffoldKey;
  static bool _loadedClubId =
      false; //so that we load club id and name only once.
  //final String clubName;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Consumer<AdminProvider>(
          builder: (context, adminProvider, _) => _loadedClubId
              ? Container(
                  padding: EdgeInsets.only(top: deviceSize.height*0.12,right:5,left: 5),
                  //render clubName directly if clubId is loaded
                  height: deviceSize.height,
                  width: double.infinity,
                  color: Theme.of(context).backgroundColor,
                  alignment: Alignment.topCenter,
                  child: FittedBox(
                    child: Text(
                      adminProvider.clubName,
                      style: Theme.of(context).textTheme.headline6.copyWith(
                          color: Colors.white,
                          fontSize: 80,
                          fontWeight: FontWeight.w700,
                          fontFamily: 'OpenSans'),
                    ),
                  ),
                )
              : StreamBuilder(
                  stream: adminProvider.getAdminProfile,
                  builder: (context, dataSnapshot) {
                    if (dataSnapshot.connectionState ==
                        ConnectionState.waiting) {
                      return Container(
                         padding: EdgeInsets.only(top: deviceSize.height*0.12,right:5,left: 5),
                        height: deviceSize.height,
                        width: double.infinity,
                        color: Theme.of(context).backgroundColor,
                        alignment: Alignment.topCenter,
                        child: LoadingSpinner(),
                      );
                    } else if (dataSnapshot.error != null) {
                      return Center(
                        child: Text('Oops something went wrong'),
                      );
                    } else {
                      _loadedClubId = true;
                      return Container(
                         padding: EdgeInsets.only(top: deviceSize.height*0.12,right:5,left: 5),
                        height: deviceSize.height,
                        width: double.infinity,
                        color: Theme.of(context).backgroundColor,
                        alignment: Alignment.topCenter,
                        child: FittedBox(
                          child: Text(
                            dataSnapshot.data.clubName.toString(),
                            style: Theme.of(context).textTheme.headline6.copyWith(
                                color: Colors.white,
                                fontSize: 80,
                                fontWeight: FontWeight.w700,
                                fontFamily: 'OpenSans'),
                          ),
                        ),
                      );
                    }
                  },
                ),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 8,top: 24),
          child: IconButton(
            icon: Icon(Icons.menu),
            onPressed: () => scaffoldKey.currentState
                .openDrawer(), //custom hamburger icon , to open and close side drawer
            iconSize: 40,
            color: Colors.white,
          ),
        ),
      ],
    );
  }
}
