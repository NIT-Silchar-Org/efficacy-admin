import 'dart:convert';

import 'package:efficacy_admin/pages/add_event.dart';
import 'package:efficacy_admin/utils/loading_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:efficacy_admin/Pages/account_screen.dart';
import 'package:efficacy_admin/models/user_model.dart';
import 'package:efficacy_admin/provider/event_provider.dart';
import 'package:efficacy_admin/services/user_authentication.dart';
import 'package:efficacy_admin/widgets/completed_events.dart';
import 'package:efficacy_admin/widgets/ongoing_events.dart';
import 'package:efficacy_admin/widgets/upcoming_events.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:efficacy_admin/themes/appcolor.dart';
import 'package:buttons_tabbar/buttons_tabbar.dart';
import 'package:provider/provider.dart';
import '/Pages/event_detail.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomePage extends StatefulWidget {
  static const id = '/HomePage';

  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late final SharedPreferences prefs;
  List data = [];
  bool isloading = false;
  late final UserModel user;
  @override
  void initState() {
    getdata();
    super.initState();
  }

  getdata() async {
    setState(() {
      isloading = true;
    });
    prefs = await SharedPreferences.getInstance();
    final userid = prefs.getString('Googleid');
    print(userid);
    await FirebaseFirestore.instance
        .collection('admin')
        .doc(userid)
        .get()
        .then((snapshot) {
      user = UserModel.fromJson(snapshot.data()!);
    });
    print(user.clubId);
    final middata = await Provider.of<EventProvider>(context, listen: false)
        .fetchEvents(["94Pkmpbj0qzBCkiSQ6Yr"]);
    data = json.decode(middata);
    setState(() {
      isloading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: DefaultTabController(
        length: 3,
        child: Scaffold(
          appBar: AppBar(
            centerTitle: true,
            iconTheme: const IconThemeData(color: Color(0xff05354c)),
            title: Text(
              "Efficacy",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 24,
                color: AppColorLight.primary,
              ),
            ),
            backgroundColor: Colors.white,
            elevation: 0,
            actions: [
              IconButton(
                icon: const Icon(Icons.account_circle_outlined),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => Account(user: user),
                    ),
                  );
                },
                iconSize: 30,
              ),
              const SizedBox(width: 10),
            ],
            bottom: ButtonsTabBar(
              contentPadding:
                  const EdgeInsets.symmetric(horizontal: 50, vertical: 0),
              backgroundColor: AppColorLight.primary,
              unselectedBackgroundColor: Colors.white,
              labelStyle: const TextStyle(
                  color: Colors.white, fontWeight: FontWeight.bold),
              unselectedLabelStyle: TextStyle(
                  color: AppColorLight.primary, fontWeight: FontWeight.bold),
              borderWidth: 1,
              unselectedBorderColor: AppColorLight.primary,
              radius: 100,
              tabs: const [
                Tab(text: "Upcoming"),
                Tab(text: "Ongoing"),
                Tab(text: "Completed"),
              ],
            ),
          ),
          body: isloading
              ? const LoadingScreen()
              : TabBarView(
                  children: [
                    Upcoming(id: user.clubId!, data: data),
                    Ongoing(id: user.clubId!, data: data),
                    Completed(id: user.clubId!, data: data)
                  ],
                ),
          floatingActionButton: FloatingActionButton(
            backgroundColor: AppColorLight.primary,
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const AddEvent(),
                ),
              );
            },
            child: const Icon(
              Icons.add,
              size: 52,
            ),
          ),
          floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
        ),
      ),
    );
  }
}
