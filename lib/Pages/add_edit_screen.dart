import 'package:efficacy_admin/themes/appcolor.dart';
import 'package:efficacy_admin/themes/theme.dart';
import 'package:flutter/material.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import '/widgets/tags.dart';

class AddEvent extends StatefulWidget {
  const AddEvent({Key? key}) : super(key: key);

  @override
  _AddEventState createState() => _AddEventState();
}

class _AddEventState extends State<AddEvent> {
  final String description =
      "Flutter is Google’s mobile UI framework for crafting high-quality native interfaces on iOS and Android in record time. Flutter works with existing code, is used by developers and organizations around the world, and is free and open source.";
  BorderRadiusGeometry sheetRadius = const BorderRadius.only(
    topLeft: Radius.circular(24.0),
    topRight: Radius.circular(24.0),
  );
  FocusNode myFocusNode = FocusNode();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SlidingUpPanel(
        panel: Center(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(22, 0, 22, 0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    margin: const EdgeInsets.only(top: 8, bottom: 30),
                    child: Divider(
                      color: const Color(0xff180000).withOpacity(0.17),
                      height: 20,
                      thickness: 2,
                      indent: 100,
                      endIndent: 100,
                    ),
                  ),
                  TextFormField(
                    focusNode: myFocusNode,
                    decoration: InputDecoration(
                      prefixIcon: Icon(
                        Icons.title,
                        color: AppColorLight.outline,
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                            color: AppColorLight.outline, width: 2.0),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                            color: Theme.of(context).primaryColor, width: 2.0),
                      ),
                      labelText: 'Event Title',
                      labelStyle: TextStyle(
                          color: myFocusNode.hasFocus
                              ? Theme.of(context).primaryColor
                              : AppColorLight.outline),
                    ),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  TextFormField(
                    focusNode: myFocusNode,
                    decoration: InputDecoration(
                      prefixIcon: Icon(Icons.segment_rounded,
                          color: AppColorLight.outline),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                            color: AppColorLight.outline, width: 2.0),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                            color: Theme.of(context).primaryColor, width: 2.0),
                      ),
                      labelText: 'Short Description',
                      labelStyle: TextStyle(
                          color: myFocusNode.hasFocus
                              ? Theme.of(context).primaryColor
                              : AppColorLight.outline),
                    ),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  TextFormField(
                    focusNode: myFocusNode,
                    maxLines: 8,
                    decoration: InputDecoration(
                      prefixIcon: Icon(Icons.segment_rounded,
                          color: AppColorLight.outline),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                            color: AppColorLight.outline, width: 2.0),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                            color: Theme.of(context).primaryColor, width: 2.0),
                      ),
                      labelText: 'Long Description',
                      labelStyle: TextStyle(
                          color: myFocusNode.hasFocus
                              ? Theme.of(context).primaryColor
                              : AppColorLight.outline),
                    ),
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
                  TextFormField(
                    focusNode: myFocusNode,
                    decoration: InputDecoration(
                      suffixIcon: Icon(Icons.calendar_today_outlined,
                          color: AppColorLight.primary),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                            color: AppColorLight.outline, width: 2.0),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                            color: Theme.of(context).primaryColor, width: 2.0),
                      ),
                      labelText: 'DD/MM/YYYY-HH:mm:ss',
                      labelStyle: TextStyle(
                          color: myFocusNode.hasFocus
                              ? Theme.of(context).primaryColor
                              : AppColorLight.outline),
                    ),
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
                  TextFormField(
                    focusNode: myFocusNode,
                    decoration: InputDecoration(
                      suffixIcon: Icon(Icons.calendar_today_outlined,
                          color: AppColorLight.primary),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                            color: AppColorLight.outline, width: 2.0),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                            color: Theme.of(context).primaryColor, width: 2.0),
                      ),
                      labelText: 'DD/MM/YYYY-HH:mm:ss',
                      labelStyle: TextStyle(
                          color: myFocusNode.hasFocus
                              ? Theme.of(context).primaryColor
                              : AppColorLight.outline),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  TextFormField(
                    focusNode: myFocusNode,
                    decoration: InputDecoration(
                      prefixIcon: Icon(Icons.calendar_today_outlined,
                          color: AppColorLight.outline),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                            color: AppColorLight.outline, width: 2.0),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                            color: Theme.of(context).primaryColor, width: 2.0),
                      ),
                      labelText: 'Google Form URL',
                      labelStyle: TextStyle(
                          color: myFocusNode.hasFocus
                              ? Theme.of(context).primaryColor
                              : AppColorLight.outline),
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  TextFormField(
                    focusNode: myFocusNode,
                    decoration: InputDecoration(
                      prefixIcon: Icon(Icons.calendar_today_outlined,
                          color: AppColorLight.outline),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                            color: AppColorLight.outline, width: 2.0),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                            color: Theme.of(context).primaryColor, width: 2.0),
                      ),
                      labelText: 'Facebook Form URL',
                      labelStyle: TextStyle(
                          color: myFocusNode.hasFocus
                              ? Theme.of(context).primaryColor
                              : AppColorLight.outline),
                    ),
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
                    height: 10,
                  ),
                  const NameTag()
                ],
              ),
            ),
          ),
        ),
        collapsed: null,
        minHeight: MediaQuery.of(context).size.height - 250,
        maxHeight: MediaQuery.of(context).size.height - 250,
        defaultPanelState: PanelState.OPEN,
        body: SafeArea(
          child: Column(
            children: [
              Container(
                height: 250,
                decoration: const BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage('assets/androidStudyJam.png'),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ],
          ),
        ),
        borderRadius: sheetRadius,
      ),
    );
  }
}
