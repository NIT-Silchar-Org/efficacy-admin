import 'package:efficacy_admin/utils/loading_screen.dart';
import 'package:efficacy_admin/pages/add_event.dart';
import 'package:efficacy_admin/Pages/event_detail.dart';
import 'package:efficacy_admin/provider/event_provider.dart';
import 'package:efficacy_admin/themes/appcolor.dart';
import 'package:efficacy_admin/widgets/event_detatils.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Ongoing extends StatefulWidget {
  final String id;
  final List data;
  const Ongoing({Key? key, required this.id, required this.data}) : super(key: key);

  @override
  _OngoingState createState() => _OngoingState();
}

class _OngoingState extends State<Ongoing> {
  List data = [];
  bool isloading = false;
  @override
  void initState() {
    getdata();
    super.initState();
  }

  getdata() async {
    setState(() {
      isloading = true;
    });
    data = widget.data;
    setState(() {
      isloading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return isloading? const LoadingScreen(): Column(
      children: [
        const SizedBox(height: 10),
        SizedBox(
          height: MediaQuery.of(context).size.height / 1.299,
          child: ListView.builder(
            itemCount: data.length,
            itemBuilder: (context, index) {
              return Visibility(
                visible: DateTime.now().compareTo(DateTime.parse(data[index]['endTime'])) < 0 
                && DateTime.now().compareTo(DateTime.parse(data[index]['startTime'])) >= 0,
                child: GestureDetector(
                  child: Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 10, vertical: 7),
                    child: EventCard(
                      detail: data[index],
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => EventDetail(
                              detail: data[index],
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                  onLongPress: () {
                    showModalBottomSheet(
                      context: context,
                      builder: (BuildContext context) => Container(
                        color: const Color(0xff757575),
                        child: Container(
                          height: (MediaQuery.of(context).size.height) / 4.4,
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
                  },
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
