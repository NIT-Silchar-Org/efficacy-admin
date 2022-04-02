import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:efficacy_admin/provider/contact_provider.dart';
import 'package:efficacy_admin/services/firebase_upload.dart';
import 'package:efficacy_admin/themes/appcolor.dart';
import 'package:efficacy_admin/widgets/tag_input.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:image_picker/image_picker.dart';
import 'package:efficacy_admin/utils/build_fab.dart';
import 'package:efficacy_admin/widgets/date_picker.dart';
import 'package:efficacy_admin/widgets/detail_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';
import 'package:google_fonts/google_fonts.dart';
import '../utils/divider.dart';
import '../utils/loading_screen.dart';
import '/widgets/form_widget.dart';

class AddEvent extends StatefulWidget {
  const AddEvent({Key? key}) : super(key: key);

  @override
  _AddEventState createState() => _AddEventState();
}

class _AddEventState extends State<AddEvent> {
  final formkey = GlobalKey<FormState>();
  bool imgSelected = false;
  BorderRadiusGeometry sheetRadius = const BorderRadius.only(
    topLeft: Radius.circular(24.0),
    topRight: Radius.circular(24.0),
  );

  ScrollController sc = ScrollController();

  File? imageFile;
  bool isFAB = false;
  bool isLoading = false;

  String title = '';
  String shortDesc = '';
  String longDesc = '';
  String startTime = '';
  String endTime = '';
  String googleUrl = '';
  String fbUrl = '';
  List<String> contacts = [];

  dynamic ref;
  String clubId = '';

  @override
  void initState() {
    final userId = FirebaseAuth.instance.currentUser!.uid;
    ref = FirebaseFirestore.instance.collection('admin').doc('/$userId');
    // getModerator();
    super.initState();
    sc.addListener(() {
      if (sc.offset > 50) {
        setState(() {
          isFAB = true;
        });
      } else {
        setState(() {
          isFAB = false;
        });
      }
    });
  }

  getModerator() async {
    setState(() {
      isLoading = true;
    });
    await ref.get().then(
      (snapshots) {
        setState(() {
          clubId = snapshots.data()['clubId'].toString();
        });
        print(clubId);
      },
    );
    final data = await Provider.of<ContactProvider>(context, listen: false)
        .fetchContact(clubId + '/');

    setState(() {
      isLoading = false;
    });
  }

  @override
  void dispose() {
    super.dispose();
    sc.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return isLoading
        ? const LoadingScreen()
        : Scaffold(
            floatingActionButton:
                isFAB ? buildFab() : buildExtendedFab(context),
            resizeToAvoidBottomInset: false,
            body: SlidingUpPanel(
              minHeight: MediaQuery.of(context).size.height - 250,
              maxHeight: MediaQuery.of(context).size.height,
              panelBuilder: (sc) => Padding(
                padding: const EdgeInsets.fromLTRB(22, 0, 22, 0),
                child: Form(
                  key: formkey,
                  child: ListView(
                    controller: sc,
                    shrinkWrap: true,
                    children: [
                      const PanelDivider(),
                      FormWidget(
                        text: 'Event Title',
                        icons: Icons.title,
                        onValueChanged: (e) {
                          setState(() {
                            title = e;
                          });
                        },
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      FormWidget(
                        text: 'Short Description',
                        icons: Icons.segment_rounded,
                        onValueChanged: (e) {
                          setState(() {
                            shortDesc = e;
                          });
                        },
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      FormWidget(
                        text: 'Long Description',
                        icons: Icons.segment_rounded,
                        line: 8,
                        onValueChanged: (e) {
                          setState(() {
                            longDesc = e;
                          });
                        },
                      ),
                      const SizedBox(
                        height: 16,
                      ),
                      Text(
                        "Start Date & Time",
                        style: GoogleFonts.poppins(
                          textStyle: Theme.of(context)
                              .textTheme
                              .bodyText1!
                              .copyWith(color: AppColorLight.primary),
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      DateTimeForm(
                        onValueChanged: (value) => {
                          setState(() {
                            startTime = value;
                          })
                        },
                      ),
                      const SizedBox(
                        height: 12,
                      ),
                      Text(
                        "End Date & Time",
                        style: GoogleFonts.poppins(
                          textStyle: Theme.of(context)
                              .textTheme
                              .bodyText1!
                              .copyWith(color: AppColorLight.primary),
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      DateTimeForm(
                        onValueChanged: (value) => {
                          setState(() {
                            endTime = value;
                          })
                        },
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      FormWidget(
                        text: 'Google Form URL',
                        icons: Icons.calendar_today_outlined,
                        onValueChanged: (e) {
                          setState(() {
                            googleUrl = e;
                          });
                        },
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      FormWidget(
                        text: 'Facebook Form URL',
                        icons: Icons.calendar_today_outlined,
                        onValueChanged: (e) {
                          setState(() {
                            fbUrl = e;
                          });
                        },
                      ),
                      const SizedBox(
                        height: 25,
                      ),
                      Text(
                        "Add Contacts",
                        style: GoogleFonts.poppins(
                          textStyle: Theme.of(context)
                              .textTheme
                              .bodyText1!
                              .copyWith(color: AppColorLight.primary),
                        ),
                      ),
                      const SizedBox(
                        height: 12,
                      ),
                      TagInput(
                        onValueChanged: (value) => {
                          setState(
                            () => {
                              value.forEach((element) {
                                contacts.add(element);
                              })
                            },
                          )
                        },
                      ),
                      const SizedBox(
                        height: 65,
                      ),
                    ],
                  ),
                ),
              ),
              body: SafeArea(
                child: Stack(
                  children: [
                    GestureDetector(
                      onTap: () async {
                        if (imageFile != null) {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => Fullscreen(
                                imageFile: imageFile!,
                              ),
                            ),
                          ).then((value) => setState(() {
                                imageFile = value;
                              }));
                        }
                      },
                      child: SizedBox(
                        height: 250,
                        child: imageFile != null
                            ? Image.file(
                                imageFile!,
                                fit: BoxFit.cover,
                              )
                            : Image.asset(
                                'assets/placeholder.png',
                                fit: BoxFit.cover,
                              ),
                      ),
                    ),
                    Positioned(
                      left: 20.0,
                      top: 25.0,
                      child: GestureDetector(
                        onTap: () {
                          Navigator.pop(context);
                        },
                        child: Container(
                          width: 40,
                          height: 40,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: const Color(0xffDFE5E7).withOpacity(0.2),
                          ),
                          child: const Icon(
                            Icons.arrow_back_ios_new_rounded,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                    Positioned(
                      width: MediaQuery.of(context).size.width,
                      top: 120.0,
                      child: imageFile == null
                          ? GestureDetector(
                              onTap: () {
                                _getFromGallery();
                              },
                              child: Center(
                                child: Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(20),
                                    color: AppColorLight.primary,
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 12, vertical: 10),
                                    child: Text(
                                      "Change poster",
                                      style: GoogleFonts.poppins(
                                        textStyle: Theme.of(context)
                                            .textTheme
                                            .bodyText2!
                                            .copyWith(color: Colors.white),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            )
                          : const SizedBox(),
                    ),
                  ],
                ),
              ),
              borderRadius: sheetRadius,
            ),
          );
  }

  _getFromGallery() async {
    XFile? pickedFile = (await ImagePicker().pickImage(
      source: ImageSource.gallery,
    ));
    if (pickedFile != null) {
      setState(() {
        imageFile = File(pickedFile.path);
      });
    }
  }

  Widget buildExtendedFab(BuildContext context) => AnimatedContainer(
        duration: Duration(milliseconds: 200),
        curve: Curves.linear,
        width: 150,
        height: 50,
        child: FloatingActionButton.extended(
          onPressed: () async {
            final isValid = formkey.currentState!.validate();
            if (!isValid) {
              formkey.currentState!.save();
              if (imageFile == null) return;
              final fileName = File(imageFile!.path);
              final destination = 'images/$fileName';

              isLoading = true;
              var task = FirebaseUpload.uploadFile(destination, imageFile!);
              if (task == null) {
                isLoading = false;
                return;
              }

              final snapshot = await task.whenComplete(() {});
              final urlDownload = await snapshot.ref.getDownloadURL();
              isLoading = false;
              print('Download-Link: $urlDownload');
            }
          },
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
          backgroundColor: AppColorLight.primary,
          icon: const Icon(
            Icons.upload_outlined,
            size: 30,
          ),
          label: Center(
            child: Text(
              "Upload",
              // style: TextStyle(fontSize: 15, color: Colors.white),
              style: GoogleFonts.poppins(
                  textStyle: Theme.of(context)
                      .textTheme
                      .bodyText1!
                      .copyWith(color: Colors.white)),
            ),
          ),
        ),
      );
}
