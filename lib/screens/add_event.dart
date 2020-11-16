import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AddEvent extends StatefulWidget {
  @override
  _AddEventState createState() => _AddEventState();
}

class _AddEventState extends State<AddEvent> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Form(
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
                  // Container(
                  //   alignment: Alignment.center,
                  //   child: Text(
                  //     "Add Event",
                  //     style: GoogleFonts.openSans(
                  //         color: Colors.white,
                  //         letterSpacing: .5,
                  //         fontSize: 41,
                  //         fontWeight: FontWeight.bold),
                  //   ),
                  // )
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
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
