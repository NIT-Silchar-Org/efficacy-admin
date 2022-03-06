import 'dart:io';
import 'package:efficacy_admin/themes/appcolor.dart';
import 'package:efficacy_admin/utils/build_extended_fab.dart';
import 'package:efficacy_admin/widgets/tag_input.dart';
import 'package:image_picker/image_picker.dart';
import 'package:efficacy_admin/utils/build_fab.dart';
import 'package:efficacy_admin/widgets/date_picker.dart';
import 'package:efficacy_admin/widgets/detail_screen.dart';
import 'package:flutter/material.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';
import 'package:google_fonts/google_fonts.dart';
import '/widgets/form_widget.dart';

class AddEvent extends StatefulWidget {
  const AddEvent({Key? key}) : super(key: key);

  @override
  _AddEventState createState() => _AddEventState();
}

class _AddEventState extends State<AddEvent> {
  bool imgSelected = false;
  BorderRadiusGeometry sheetRadius = const BorderRadius.only(
    topLeft: Radius.circular(24.0),
    topRight: Radius.circular(24.0),
  );

  ScrollController sc = ScrollController();

  File? imageFile;
  bool isFAB = false;

  @override
  void initState() {
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

  @override
  void dispose() {
    super.dispose();
    sc.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: isFAB ? buildFab() : buildExtendedFab(context),
      resizeToAvoidBottomInset: false,
      body: SlidingUpPanel(
        minHeight: MediaQuery.of(context).size.height - 250,
        maxHeight: MediaQuery.of(context).size.height,
        panelBuilder: (sc) => Padding(
          padding: const EdgeInsets.fromLTRB(22, 0, 22, 0),
          child: ListView(
            controller: sc,
            shrinkWrap: true,
            children: [
              Container(
                margin: const EdgeInsets.only(top: 0, bottom: 30),
                child: Divider(
                  color: const Color(0xff180000).withOpacity(0.17),
                  height: 10,
                  thickness: 2,
                  indent: 100,
                  endIndent: 100,
                ),
              ),
              FormWidget(text: 'Event Title', icons: Icons.title),
              const SizedBox(
                height: 15,
              ),
              FormWidget(
                  text: 'Short Description', icons: Icons.segment_rounded),
              const SizedBox(
                height: 15,
              ),
              FormWidget(
                text: 'Long Description',
                icons: Icons.segment_rounded,
                line: 8,
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
              const DateTimeForm(),
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
              const DateTimeForm(),
              const SizedBox(
                height: 20,
              ),
              FormWidget(
                  text: 'Google Form URL',
                  icons: Icons.calendar_today_outlined),
              const SizedBox(
                height: 10,
              ),
              FormWidget(
                  text: 'Facebook Form URL',
                  icons: Icons.calendar_today_outlined),
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
              const TagInput(),
              const SizedBox(
                height: 65,
              ),
            ],
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
                  onTap: () {},
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
}
