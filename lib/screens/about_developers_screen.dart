import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cmApp/models/developers.dart';
import 'package:cmApp/providers/developerDetails_provider.dart';
import 'package:cmApp/utilities/loadingSpinner.dart';
import 'package:cmApp/widgets/DeveloperScreen_files/backWidget.dart';
import 'package:cmApp/widgets/DeveloperScreen_files/frontWidget.dart';
import 'package:flip_card/flip_card.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AboutDevelopersScreen extends StatelessWidget {
  static const routeName = '/aboutDevelopers_screen';

  @override
  Widget build(BuildContext context) {
    Size deviceSize = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).backgroundColor,
        title: Text(
          'About Developers',
          style: Theme.of(context).textTheme.headline6.copyWith(
                color: Colors.white,
                fontSize: 27,
              ),
        ),
      ),
      body: Consumer<DeveloperDetailProvider>(
        builder: (ctx, developer, _) => StreamBuilder(
          stream: developer.getDeveloperProfile,
          builder: (ctx, developerSnapshot) {
            if (developerSnapshot.connectionState == ConnectionState.waiting)
              return LoadingSpinner();
            else if (developerSnapshot.error != null) {
              // print(dataSnapshot.data[1]);
              print(developerSnapshot.error);
              return Center(
                child: Text('Oops! Something went wrong'),
              );
            } else {
              return ListView.builder(
                itemBuilder: (ctx, index) => Container(
                  margin: EdgeInsets.all(10),
                  height: deviceSize.height * 0.6,
                  width: deviceSize.width * 09,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(20),
                    child: FlipCard(
                      direction: FlipDirection.HORIZONTAL, // default
                      front: FrontWidget(
                        developer:
                            developerSnapshot.data[index] as DeveloiperProfile,
                        deviceSize: deviceSize,
                      ),
                      back: BackWidget(
                        developer:
                            developerSnapshot.data[index] as DeveloiperProfile,
                        deviceSize: deviceSize,
                      ),
                    ),
                  ),
                ),
                itemCount: developerSnapshot.data.length,
              );
            }
          },
        ),
      ),
    );
  }
}
