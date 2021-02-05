import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:provider/provider.dart';

import '../providers/adminDetails_provider.dart';

class ProfileScreen extends StatefulWidget {
  static const routeName = '/profile_screen';
  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  String name;
  String clubName;
  String branch;
  String emailId;
  String fbId;
  String liId;

  final nameController = TextEditingController();
  final fbIdController = TextEditingController();
  final liIdController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final adminProfile =
        Provider.of<AdminProvider>(context, listen: false).adminData;

    name = adminProfile.name ?? 'Enter Your Name';
    clubName = adminProfile.clubName ?? '';
    branch = adminProfile.branch ?? 'Enter Your Branch';
    emailId = adminProfile.email ?? 'Enter Enail Id';
    fbId =
        adminProfile.fb == 'null' ? 'Enter fb profile link' : adminProfile.fb;
    liId = adminProfile.linkedin == 'null'
        ? 'Enter Linkedin Profile'
        : adminProfile.linkedin;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Profile',
          style: Theme.of(context).textTheme.headline6.copyWith(
                color: Colors.white,
                fontSize: 27,
              ),
        ),
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Consumer<AdminProvider>(
          builder: (context, adminDetails, _) => Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              //Name
              Container(
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    //Icon
                    Padding(
                      padding: const EdgeInsets.only(
                          left: 21, right: 0, bottom: 11, top: 21),
                      child: Icon(
                        Icons.person_rounded,
                        size: 31,
                      ),
                    ),
                    //texts
                    Padding(
                      padding:
                          const EdgeInsets.only(left: 21, bottom: 11, top: 21),
                      child: Container(
                        alignment: Alignment.centerLeft,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Name",
                              style: GoogleFonts.roboto(
                                textStyle: TextStyle(
                                  color: Colors.blue[500],
                                  letterSpacing: 0.5,
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            Text(
                              name,
                              style: GoogleFonts.roboto(
                                  textStyle: TextStyle(
                                      color: Colors.blue[900],
                                      letterSpacing: 0.5,
                                      fontSize: 16,
                                      fontWeight: FontWeight.w900)),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Spacer(),
                    //button
                    FlatButton(
                      onPressed: () {
                        showModalBottomSheet<void>(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.vertical(
                              top: Radius.circular(25.0),
                            ),
                          ),
                          context: context,
                          isScrollControlled: true,
                          builder: (context) => SingleChildScrollView(
                            child: Container(
                              padding: EdgeInsets.only(
                                  bottom:
                                      MediaQuery.of(context).viewInsets.bottom),
                              child: Padding(
                                padding: const EdgeInsets.all(11),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    //Enter Your Name
                                    Container(
                                      alignment: Alignment.bottomLeft,
                                      child: Padding(
                                          padding: const EdgeInsets.only(
                                              left: 11,
                                              top: 5,
                                              right: 11,
                                              bottom: 11),
                                          child: Text(
                                            "Enter Your Name",
                                            style: GoogleFonts.roboto(
                                              textStyle: TextStyle(
                                                  color: Colors.blue[900],
                                                  letterSpacing: 0.5,
                                                  fontSize: 21,
                                                  fontWeight: FontWeight.w900),
                                            ),
                                          )),
                                    ),
                                    //Input Field
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          left: 21,
                                          top: 0,
                                          right: 21,
                                          bottom: 5),
                                      child: TextFormField(
                                        decoration: InputDecoration(
                                          filled: true,
                                          fillColor: Colors.cyan[50],
                                          enabledBorder: UnderlineInputBorder(
                                            borderSide: BorderSide(
                                              width: 5.0,
                                              color: Colors.blue[400],
                                            ),
                                            borderRadius: BorderRadius.only(
                                                topRight: Radius.circular(11),
                                                bottomLeft: Radius.zero,
                                                bottomRight: Radius.zero,
                                                topLeft: Radius.circular(11)),
                                          ),
                                          focusedBorder: UnderlineInputBorder(
                                            borderSide: BorderSide(
                                              width: 5.0,
                                              color: Colors.blue[900],
                                            ),
                                            borderRadius: BorderRadius.only(
                                                topRight: Radius.circular(11),
                                                bottomLeft: Radius.zero,
                                                bottomRight: Radius.zero,
                                                topLeft: Radius.circular(11)),
                                          ),
                                        ),
                                        keyboardType: TextInputType.text,
                                        onFieldSubmitted:
                                            Navigator.of(context).pop,
                                        style: GoogleFonts.montserrat(
                                          textStyle: TextStyle(
                                            color: Colors.blue[900],
                                            letterSpacing: 0.5,
                                            fontSize: 18,
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                        autofocus: true,
                                        controller: nameController,
                                      ),
                                    ),
                                    //Cancel & Submit Button
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: [
                                        //Cancel
                                        FlatButton(
                                          onPressed: () {
                                            Navigator.pop(context);
                                          },
                                          child: Text(
                                            "Cancel",
                                            style: GoogleFonts.roboto(
                                              textStyle: TextStyle(
                                                  color: Colors.blue[900],
                                                  letterSpacing: 0.5,
                                                  fontSize: 15,
                                                  fontWeight: FontWeight.w900),
                                            ),
                                          ),
                                        ),
                                        //Submit
                                        FlatButton(
                                          onPressed: () {
                                            setState(() {
                                              if (nameController.text != "") {
                                                name = nameController.text;
                                                Navigator.pop(context);
                                              } else {
                                                Navigator.pop(context);
                                              }
                                            });
                                          },
                                          child: Text(
                                            "Submit",
                                            style: GoogleFonts.roboto(
                                              textStyle: TextStyle(
                                                  color: Colors.blue[900],
                                                  letterSpacing: 0.5,
                                                  fontSize: 15,
                                                  fontWeight: FontWeight.w900),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        );
                      },
                      child: Padding(
                        padding: const EdgeInsets.only(
                          top: 21,
                          right: 0,
                        ),
                        child: Icon(Icons.edit),
                      ),
                    ),
                  ],
                ),
              ),
              //Club
              Container(
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    //icon
                    Padding(
                      padding: const EdgeInsets.only(
                          left: 21, right: 0, bottom: 11, top: 21),
                      child: Icon(
                        Icons.people_alt_rounded,
                        size: 31,
                      ),
                    ),
                    //texts
                    Padding(
                      padding:
                          const EdgeInsets.only(left: 21, bottom: 11, top: 21),
                      child: Container(
                        alignment: Alignment.centerLeft,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Club",
                              style: GoogleFonts.roboto(
                                textStyle: TextStyle(
                                  color: Colors.blue[500],
                                  letterSpacing: 0.5,
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            Text(
                              clubName,
                              style: GoogleFonts.roboto(
                                  textStyle: TextStyle(
                                      color: Colors.blue[900],
                                      letterSpacing: 0.5,
                                      fontSize: 16,
                                      fontWeight: FontWeight.w900)),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              //Branch
              Container(
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    //icons
                    Padding(
                      padding:
                          const EdgeInsets.only(left: 21, bottom: 11, top: 21),
                      child: Icon(
                        Icons.stream,
                        size: 31,
                      ),
                    ),
                    //texts
                    Padding(
                      padding:
                          const EdgeInsets.only(left: 21, bottom: 11, top: 21),
                      child: Container(
                        alignment: Alignment.centerLeft,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Branch",
                              style: GoogleFonts.roboto(
                                textStyle: TextStyle(
                                  color: Colors.blue[500],
                                  letterSpacing: 0.5,
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            Text(
                              branch,
                              style: GoogleFonts.roboto(
                                  textStyle: TextStyle(
                                      color: Colors.blue[900],
                                      letterSpacing: 0.5,
                                      fontSize: 16,
                                      fontWeight: FontWeight.w900)),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              // email
              Container(
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    //icon
                    Padding(
                      padding: const EdgeInsets.only(
                          left: 21, right: 0, bottom: 11, top: 21),
                      child: Icon(
                        Icons.email,
                        size: 31,
                      ),
                    ),
                    //texts
                    Padding(
                      padding:
                          const EdgeInsets.only(left: 21, bottom: 11, top: 21),
                      child: Container(
                        alignment: Alignment.centerLeft,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "e-Mail",
                              style: GoogleFonts.roboto(
                                textStyle: TextStyle(
                                  color: Colors.blue[500],
                                  letterSpacing: 0.5,
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            Text(
                              emailId,
                              style: GoogleFonts.roboto(
                                  textStyle: TextStyle(
                                      color: Colors.blue[900],
                                      letterSpacing: 0.5,
                                      fontSize: 16,
                                      fontWeight: FontWeight.w900)),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              //Facebook
              Container(
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    //icon
                    Padding(
                      padding: const EdgeInsets.only(
                          left: 21, right: 0, bottom: 11, top: 21),
                      child: Icon(
                        MdiIcons.facebook,
                        size: 31,
                      ),
                    ),
                    //texts
                    Padding(
                      padding:
                          const EdgeInsets.only(left: 21, bottom: 11, top: 21),
                      child: Container(
                        alignment: Alignment.centerLeft,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Facebook",
                              style: GoogleFonts.roboto(
                                textStyle: TextStyle(
                                  color: Colors.blue[500],
                                  letterSpacing: 0.5,
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            Text(
                              fbId,
                              style: GoogleFonts.roboto(
                                  textStyle: TextStyle(
                                      color: Colors.blue[900],
                                      letterSpacing: 0.5,
                                      fontSize: 16,
                                      fontWeight: FontWeight.w900)),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Spacer(),
                    FlatButton(
                      onPressed: () {
                        showModalBottomSheet<void>(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.vertical(
                                  top: Radius.circular(25.0))),
                          context: context,
                          isScrollControlled: true,
                          builder: (context) => SingleChildScrollView(
                            child: Container(
                              padding: EdgeInsets.only(
                                  bottom:
                                      MediaQuery.of(context).viewInsets.bottom),
                              child: Padding(
                                padding: const EdgeInsets.all(11),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    //Enter Your Facebook ID
                                    Container(
                                      alignment: Alignment.bottomLeft,
                                      child: Padding(
                                          padding: const EdgeInsets.only(
                                              left: 11,
                                              top: 5,
                                              right: 11,
                                              bottom: 11),
                                          child: Text(
                                            "Enter Your Facebook ID",
                                            style: GoogleFonts.roboto(
                                              textStyle: TextStyle(
                                                  color: Colors.blue[900],
                                                  letterSpacing: 0.5,
                                                  fontSize: 21,
                                                  fontWeight: FontWeight.w900),
                                            ),
                                          )),
                                    ),
                                    //Input Field
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          left: 21,
                                          top: 0,
                                          right: 21,
                                          bottom: 5),
                                      child: TextFormField(
                                        decoration: InputDecoration(
                                          filled: true,
                                          fillColor: Colors.cyan[50],
                                          enabledBorder: UnderlineInputBorder(
                                            borderSide: BorderSide(
                                              width: 5.0,
                                              color: Colors.blue[400],
                                            ),
                                            borderRadius: BorderRadius.only(
                                                topRight: Radius.circular(11),
                                                bottomLeft: Radius.zero,
                                                bottomRight: Radius.zero,
                                                topLeft: Radius.circular(11)),
                                          ),
                                          focusedBorder: UnderlineInputBorder(
                                            borderSide: BorderSide(
                                              width: 5.0,
                                              color: Colors.blue[900],
                                            ),
                                            borderRadius: BorderRadius.only(
                                                topRight: Radius.circular(11),
                                                bottomLeft: Radius.zero,
                                                bottomRight: Radius.zero,
                                                topLeft: Radius.circular(11)),
                                          ),
                                        ),
                                        keyboardType: TextInputType.text,
                                        onFieldSubmitted:
                                            Navigator.of(context).pop,
                                        style: GoogleFonts.montserrat(
                                          textStyle: TextStyle(
                                            color: Colors.blue[900],
                                            letterSpacing: 0.5,
                                            fontSize: 18,
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                        autofocus: true,
                                        controller: fbIdController,
                                      ),
                                    ),
                                    //Cancel & Submit Button
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: [
                                        //Cancel
                                        FlatButton(
                                          onPressed: () {
                                            Navigator.pop(context);
                                          },
                                          child: Text(
                                            "Cancel",
                                            style: GoogleFonts.roboto(
                                              textStyle: TextStyle(
                                                  color: Colors.blue[900],
                                                  letterSpacing: 0.5,
                                                  fontSize: 15,
                                                  fontWeight: FontWeight.w900),
                                            ),
                                          ),
                                        ),
                                        //Submit
                                        FlatButton(
                                          onPressed: () {
                                            setState(() {
                                              if (fbIdController != "") {
                                                fbId = fbIdController.text;
                                                Navigator.pop(context);
                                              } else {
                                                Navigator.pop(context);
                                              }
                                            });
                                          },
                                          child: Text(
                                            "Submit",
                                            style: GoogleFonts.roboto(
                                              textStyle: TextStyle(
                                                  color: Colors.blue[900],
                                                  letterSpacing: 0.5,
                                                  fontSize: 15,
                                                  fontWeight: FontWeight.w900),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        );
                      },
                      child: Padding(
                        padding: const EdgeInsets.only(
                          top: 21,
                          right: 0,
                        ),
                        child: Icon(Icons.edit),
                      ),
                    ),
                  ],
                ),
              ),
              //LinkedIn
              Container(
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    //icon
                    Padding(
                      padding: const EdgeInsets.only(
                          left: 21, right: 0, bottom: 11, top: 21),
                      child: Icon(
                        MdiIcons.linkedin,
                        size: 31,
                      ),
                    ),
                    //texts
                    Padding(
                      padding:
                          const EdgeInsets.only(left: 21, bottom: 11, top: 21),
                      child: Container(
                        alignment: Alignment.centerLeft,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "LinkedIn",
                              style: GoogleFonts.roboto(
                                textStyle: TextStyle(
                                  color: Colors.blue[500],
                                  letterSpacing: 0.5,
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            Text(
                              liId,
                              style: GoogleFonts.roboto(
                                  textStyle: TextStyle(
                                      color: Colors.blue[900],
                                      letterSpacing: 0.1,
                                      fontSize: 16,
                                      fontWeight: FontWeight.w900)),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Spacer(),
                    FlatButton(
                      onPressed: () {
                        showModalBottomSheet<void>(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.vertical(
                                  top: Radius.circular(25.0))),
                          context: context,
                          isScrollControlled: true,
                          builder: (context) => SingleChildScrollView(
                            child: Container(
                              padding: EdgeInsets.only(
                                  bottom:
                                      MediaQuery.of(context).viewInsets.bottom),
                              child: Padding(
                                padding: const EdgeInsets.all(11),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    //Enter Your LinkedIn ID
                                    Container(
                                      alignment: Alignment.bottomLeft,
                                      child: Padding(
                                          padding: const EdgeInsets.only(
                                              left: 11,
                                              top: 5,
                                              right: 11,
                                              bottom: 11),
                                          child: Text(
                                            "Enter Your LinkedIn ID",
                                            style: GoogleFonts.roboto(
                                              textStyle: TextStyle(
                                                  color: Colors.blue[900],
                                                  letterSpacing: 0.5,
                                                  fontSize: 21,
                                                  fontWeight: FontWeight.w900),
                                            ),
                                          )),
                                    ),
                                    //Input Field
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          left: 21,
                                          top: 0,
                                          right: 21,
                                          bottom: 5),
                                      child: TextFormField(
                                        decoration: InputDecoration(
                                          filled: true,
                                          fillColor: Colors.cyan[50],
                                          enabledBorder: UnderlineInputBorder(
                                            borderSide: BorderSide(
                                              width: 5.0,
                                              color: Colors.blue[400],
                                            ),
                                            borderRadius: BorderRadius.only(
                                                topRight: Radius.circular(11),
                                                bottomLeft: Radius.zero,
                                                bottomRight: Radius.zero,
                                                topLeft: Radius.circular(11)),
                                          ),
                                          focusedBorder: UnderlineInputBorder(
                                            borderSide: BorderSide(
                                              width: 5.0,
                                              color: Colors.blue[900],
                                            ),
                                            borderRadius: BorderRadius.only(
                                                topRight: Radius.circular(11),
                                                bottomLeft: Radius.zero,
                                                bottomRight: Radius.zero,
                                                topLeft: Radius.circular(11)),
                                          ),
                                        ),
                                        keyboardType: TextInputType.text,
                                        onFieldSubmitted:
                                            Navigator.of(context).pop,
                                        style: GoogleFonts.montserrat(
                                          textStyle: TextStyle(
                                            color: Colors.blue[900],
                                            letterSpacing: 0.5,
                                            fontSize: 18,
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                        autofocus: true,
                                        controller: liIdController,
                                      ),
                                    ),
                                    //Cancel & Submit Button
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: [
                                        //Cancel
                                        FlatButton(
                                          onPressed: () {
                                            Navigator.pop(context);
                                          },
                                          child: Text(
                                            "Cancel",
                                            style: GoogleFonts.roboto(
                                              textStyle: TextStyle(
                                                  color: Colors.blue[900],
                                                  letterSpacing: 0.5,
                                                  fontSize: 15,
                                                  fontWeight: FontWeight.w900),
                                            ),
                                          ),
                                        ),
                                        //Submit
                                        FlatButton(
                                          onPressed: () {
                                            setState(() {
                                              if (liIdController != "") {
                                                liId = liIdController.text;
                                                Navigator.pop(context);
                                              } else {
                                                Navigator.pop(context);
                                              }
                                            });
                                          },
                                          child: Text(
                                            "Submit",
                                            style: GoogleFonts.roboto(
                                              textStyle: TextStyle(
                                                  color: Colors.blue[900],
                                                  letterSpacing: 0.5,
                                                  fontSize: 15,
                                                  fontWeight: FontWeight.w900),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        );
                      },
                      child: Padding(
                        padding: const EdgeInsets.only(
                          top: 21,
                          right: 0,
                        ),
                        child: Icon(Icons.edit),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
