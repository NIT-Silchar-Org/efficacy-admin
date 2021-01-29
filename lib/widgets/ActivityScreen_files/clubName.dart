import 'package:cmApp/providers/clubDetails_provider.dart';
import 'package:cmApp/utilities/loadingSpinner.dart';
import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

///[ClubName] widget contains the club name and tab buttons

class ClubName extends StatelessWidget {
  const ClubName({
    Key key,
    @required this.deviceSize,
    // @required this.clubName,
  }) : super(key: key);

  final Size deviceSize;
  //final String clubName;

  Future<void> _loadClubName(BuildContext ctx) async {
    await Provider.of<ClubDetailsProvider>(ctx, listen: false)
        .fetchAndSetClubDetails(); 
  } //to load club details

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        FutureBuilder(
          future: _loadClubName(context),
          builder: (context, dataSnapshot) {
            if (dataSnapshot.connectionState == ConnectionState.waiting) {
              return Container(
                height: deviceSize.height * 0.25,
                width: double.infinity,
                color: Theme.of(context).backgroundColor,
                alignment: Alignment.center,
                child: LoadingSpinner(),
              );
            } else if (dataSnapshot.error != null) {
              return Center(
                child: Text('Oops something went wrong'),
              );
            } else {
              // final String previousClubName=null;
              return Consumer<ClubDetailsProvider>(
                builder: (context, clubDetails, _) => Container(
                  height: deviceSize.height * 0.25,
                  width: double.infinity,
                  color: Theme.of(context).backgroundColor,
                  alignment: Alignment.center,
                  child: clubDetails.clubName == null
                      ? LoadingSpinner()
                      : Text(
                          clubDetails.clubName,
                          style: Theme.of(context).textTheme.headline6.copyWith(
                                color: Colors.white,
                                fontSize: 80,
                                fontWeight: FontWeight.w700,
                                fontFamily: 'OpenSans'
                              ),
                        ),
                ),
              );
            }
          },
        ),
      ],
    );
  }
}
