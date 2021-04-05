import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cmApp/models/developers.dart';
import 'package:cmApp/providers/developerDetails_provider.dart';
import 'package:cmApp/utilities/loadingSpinner.dart';
import 'package:cmApp/widgets/AboutScreen_files/abouDevelopersTab.dart';
import 'package:cmApp/widgets/AboutScreen_files/aboutDesignerTab.dart';
import 'package:cmApp/widgets/AboutScreen_files/aboutMentorsTab.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tab_indicator_styler/tab_indicator_styler.dart';

class AboutScreen extends StatelessWidget {
  static const routeName = '/aboutDevelopers_screen';

  @override
  Widget build(BuildContext context) {
    Size deviceSize = MediaQuery.of(context).size;
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Theme.of(context).backgroundColor,
          title: Text(
            'About Us',
            style: Theme.of(context).textTheme.headline6.copyWith(
                  color: Colors.white,
                  fontSize: 27,
                ),
          ),
          bottom: PreferredSize(
            preferredSize: Size.fromHeight(50),
            child: TabBar(
              indicatorColor: Colors.green,
              labelColor: Colors.black,
              indicator: RectangularIndicator(
                color: Colors.white,
                topLeftRadius: 30,
                bottomLeftRadius: 30,
                topRightRadius: 30,
                bottomRightRadius: 30,
                verticalPadding: 8,
                horizontalPadding: 8,
              ),
              labelStyle:
                  Theme.of(context).textTheme.subtitle1.copyWith(fontSize: 16),
              tabs: [
                Tab(
                  text: 'Developers',
                ),
                Tab(
                  text: 'Designers',
                ),
                Tab(
                  text: 'Mentors',
                ),
              ],
            ),
          ),
        ),
        body: TabBarView(
          children: [
            AboutdevelopersTab(),
            AboutDesignersTab(),
            AboutMentorsTab(),
          ],
        ),
      ),
    );
  }
}
