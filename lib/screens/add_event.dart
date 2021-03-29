import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AddEvent extends StatefulWidget {
  @override
  _AddEventState createState() => _AddEventState();
}

class _AddEventState extends State<AddEvent> {
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Form(
          key: _formKey,
          child: Column(
            children: <Widget>[
              Stack(
                children: <Widget>[
                  Container(
                    alignment: Alignment.center,
                    child: Image.asset("assets/bg_bottom_layer.png"),
                  ),
                  Container(
                    alignment: Alignment.center,
                    child: Image.asset("assets/bg_top_layer.png"),
                  ),
                  Positioned(
                    right: 21.0,
                    bottom: 31.0,
                    left: 21.0,
                    child: Card(
                      elevation: 0,
                      color: Colors.transparent,
                      child: Column(
                        children: [
                          Text(
                            "Add Event",
                            style: GoogleFonts.openSans(
                                color: Colors.white,
                                letterSpacing: .5,
                                fontSize: 41,
                                fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    ),
                  )
                ],
              ),
              //Title
              Container(
                alignment: Alignment.bottomLeft,
                child: Padding(
                    padding: const EdgeInsets.only(
                        left: 21, top: 21, right: 21, bottom: 11),
                    child: Text(
                      "Title",
                      style: GoogleFonts.roboto(
                        textStyle: TextStyle(
                            color: Colors.blue[900],
                            letterSpacing: 0.5,
                            fontSize: 21,
                            fontWeight: FontWeight.w900),
                      ),
                    )),
              ),
              Padding(
                padding: const EdgeInsets.only(
                    left: 21, top: 0, right: 21, bottom: 21),
                child: TextFormField(
                  validator: (value) {
                    if (value.isEmpty) {
                      return 'Please Enter Title';
                    }
                    return null;
                  },
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
                  style: GoogleFonts.montserrat(
                    textStyle: TextStyle(
                      color: Colors.blue[900],
                      letterSpacing: 0.5,
                      fontSize: 18,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ),
              //Description
              Container(
                alignment: Alignment.bottomLeft,
                child: Padding(
                    padding: const EdgeInsets.only(
                        left: 21, top: 11, right: 21, bottom: 11),
                    child: Text(
                      "Description",
                      style: GoogleFonts.roboto(
                        textStyle: TextStyle(
                            color: Colors.blue[900],
                            letterSpacing: 0.5,
                            fontSize: 21,
                            fontWeight: FontWeight.w900),
                      ),
                    )),
              ),
              Padding(
                padding: const EdgeInsets.only(
                    left: 21, top: 0, right: 21, bottom: 21),
                child: TextFormField(
                  validator: (value) {
                    if (value.isEmpty) {
                      return 'Please Enter Description';
                    }
                    return null;
                  },
                  maxLines: 5,
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
                  style: GoogleFonts.montserrat(
                    textStyle: TextStyle(
                      color: Colors.blue[900],
                      letterSpacing: 0.5,
                      fontSize: 18,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ),
              //Venue
              Container(
                alignment: Alignment.bottomLeft,
                child: Padding(
                    padding: const EdgeInsets.only(
                        left: 21, top: 11, right: 21, bottom: 11),
                    child: Text(
                      "Venue",
                      style: GoogleFonts.roboto(
                        textStyle: TextStyle(
                            color: Colors.blue[900],
                            letterSpacing: 0.5,
                            fontSize: 21,
                            fontWeight: FontWeight.w900),
                      ),
                    )),
              ),
              Padding(
                padding: const EdgeInsets.only(
                    left: 21, top: 0, right: 21, bottom: 21),
                child: TextFormField(
                  validator: (value) {
                    if (value.isEmpty) {
                      return 'Please Enter Venue';
                    }
                    return null;
                  },
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
                  style: GoogleFonts.montserrat(
                    textStyle: TextStyle(
                      color: Colors.blue[900],
                      letterSpacing: 0.5,
                      fontSize: 18,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ),
              //Date
              Container(
                alignment: Alignment.bottomLeft,
                child: Padding(
                    padding: const EdgeInsets.only(
                        left: 21, top: 11, right: 21, bottom: 11),
                    child: Text(
                      "Date",
                      style: GoogleFonts.roboto(
                        textStyle: TextStyle(
                            color: Colors.blue[900],
                            letterSpacing: 0.5,
                            fontSize: 21,
                            fontWeight: FontWeight.w900),
                      ),
                    )),
              ),
              Padding(
                padding: const EdgeInsets.only(
                    left: 21, top: 0, right: 21, bottom: 21),
                child: TextFormField(
                  validator: (value) {
                    if (value.isEmpty) {
                      return 'Please Enter Date';
                    }
                    return null;
                  },
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
                  style: GoogleFonts.montserrat(
                    textStyle: TextStyle(
                      color: Colors.blue[900],
                      letterSpacing: 0.5,
                      fontSize: 18,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ),
              //Time
              Container(
                alignment: Alignment.bottomLeft,
                child: Padding(
                    padding: const EdgeInsets.only(
                        left: 21, top: 11, right: 21, bottom: 11),
                    child: Text(
                      "Time",
                      style: GoogleFonts.roboto(
                        textStyle: TextStyle(
                            color: Colors.blue[900],
                            letterSpacing: 0.5,
                            fontSize: 21,
                            fontWeight: FontWeight.w900),
                      ),
                    )),
              ),
              Padding(
                padding: const EdgeInsets.only(
                    left: 21, top: 0, right: 21, bottom: 21),
                child: TextFormField(
                  validator: (value) {
                    if (value.isEmpty) {
                      return 'Please Enter Time';
                    }
                    return null;
                  },
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
                  style: GoogleFonts.montserrat(
                    textStyle: TextStyle(
                      color: Colors.blue[900],
                      letterSpacing: 0.5,
                      fontSize: 18,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ),
              //Add Button
              RaisedButton(
                onPressed: () {
                  if (_formKey.currentState.validate()) {
                    return true;
                  }
                },
                child: Padding(
                  padding: const EdgeInsets.all(11),
                  child: Text(
                    "Add",
                    style: GoogleFonts.openSans(
                      textStyle: TextStyle(
                          color: Colors.white,
                          letterSpacing: .5,
                          fontSize: 25,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
                color: Colors.blue[900],
                textColor: Colors.white,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(51)),
              ),
              SizedBox(
                height: 21,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
