import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:efficacy_admin/Pages/account_screen.dart';
import 'package:efficacy_admin/Pages/add_edit_screen.dart';
import 'package:efficacy_admin/constant/constant.dart';
import 'package:efficacy_admin/services/service.dart';
import 'package:flutter/material.dart';
import 'package:efficacy_admin/themes/appcolor.dart';
import 'package:efficacy_admin/widgets/event_detatils.dart';
import 'package:buttons_tabbar/buttons_tabbar.dart';
import '/Pages/event_detail.dart';
//import 'package:efficacy_admin/utils/custom_fab.dart';
import 'dart:convert';

class HomePage extends StatefulWidget {
  static const id = '/HomePage';

  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final NetworkEngine engine = NetworkEngine();
  bool isInit = true, isloading = false;
  @override
  void initState() {
    //getevents();
    super.initState();
  }

  getevents() async {
    if (isInit) {
      setState(() {
        isloading = true;
      });
      print('starting');
      final response =
          await engine.post(data:{}, endPoint:allevent).then((value) {
              print(value);
        setState(() {
          isloading = false;
        });
      });
      print('///////');
      print(response);
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
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
                    builder: (context) => Account(),
                  ),
                );
              },
              iconSize: 30,
            ),
            const SizedBox(width: 10),
          ],
        ),
        body: isloading
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : Column(
                children: [
                  DefaultTabController(
                    length: 3,
                    child: Column(
                      children: <Widget>[
                        ButtonsTabBar(
                          contentPadding: const EdgeInsets.symmetric(
                              horizontal: 50, vertical: 0),
                          backgroundColor: AppColorLight.primary,
                          unselectedBackgroundColor: Colors.white,
                          labelStyle: const TextStyle(
                              color: Colors.white, fontWeight: FontWeight.bold),
                          unselectedLabelStyle: TextStyle(
                              color: AppColorLight.primary,
                              fontWeight: FontWeight.bold),
                          borderWidth: 1,
                          unselectedBorderColor: AppColorLight.primary,
                          radius: 100,
                          tabs: const [
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
                  const SizedBox(height: 10),
                  SizedBox(
                    height: MediaQuery.of(context).size.height / 1.245,
                    child: ListView.builder(
                      shrinkWrap: true,
                        physics:BouncingScrollPhysics(),
                      itemCount: 5,
                      itemBuilder: (context, int index) {
                        return GestureDetector(
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 10, vertical: 7),
                            child: EventCard(
                              data: 'hello',
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
                            showmodalsheet(context);
                          },
                        );
                      },
                    ),
                  ),
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
    );
  }

  showmodalsheet(BuildContext context) {
    return showModalBottomSheet(
      context: context,
      builder: (BuildContext context) => Container(
        color: const Color(0xff757575),
        child: Container(
          height: (MediaQuery.of(context).size.height) / 5,
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20.0),
              topRight: Radius.circular(20.0),
            ),
          ),
          child: Column(
            children: [
              const SizedBox(
                height: 20.0,
                width: 100.0,
                child: Divider(
                  color: Colors.black87,
                  thickness: 2,
                ),
              ),
              ListTile(
                leading: Icon(
                  Icons.delete,
                  color: AppColorLight.primary,
                ),
                title: Text(
                  'Delete',
                  style: TextStyle(
                    color: AppColorLight.primary,
                  ),
                ),
              ),
              GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const AddEvent(),
                    ),
                  );
                },
                child: ListTile(
                  leading: Icon(
                    Icons.edit,
                    color: AppColorLight.primary,
                  ),
                  title: Text(
                    'Edit',
                    style: TextStyle(
                      color: AppColorLight.primary,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
