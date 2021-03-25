import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cmApp/models/events.dart';
import 'package:cmApp/providers/event_provider.dart';
import 'package:cmApp/utilities/loadingSpinner.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:date_time_picker/date_time_picker.dart';
import 'package:provider/provider.dart';

class editScreen extends StatefulWidget {
  editScreen({this.id,this.index,this.title,this.about,this.venue,this.googleFormLink,this.fbPostLink,
    this.end,this.start,this.image});
  final String id;
  final index;
  final String title;
  final String about;
  final String venue;
  final String googleFormLink;
  final String fbPostLink;
  final DateTime end;
  final DateTime start;
  final String image;
  static const routeName = '/edit_screen';
  @override
  editScreenState createState() => editScreenState();
}

Future<void> _reloadEvent(BuildContext context, String id) async {
  await Provider.of<EventProvider>(context, listen: false)
      .singleEventProvider(id);
}

class editScreenState extends State<editScreen> {

  TextEditingController _controller2;
  TextEditingController _controller1;
  File image;
  String filename;
  String url;


  TextEditingController _des, _title, _venue, _fbPostLink, _googleFormLink;
  String _valueChanged2 = '';
  String _valueToValidate2 = '';
  String _valueSaved2 = '';
  String _valueChanged1 = '';
  String _valueToValidate1 = '';
  String _valueSaved1 = '';

  DocumentReference ref;
  String id;


  @override
  void initState() {
    super.initState();
    _des = TextEditingController(text: widget.about);
    _title = TextEditingController(text: widget.title);
    _venue = TextEditingController(text: widget.venue);
    _fbPostLink = TextEditingController(text: widget.fbPostLink);
    _googleFormLink = TextEditingController(text: widget.googleFormLink);
    _controller2 = TextEditingController(text: widget.start.toString());
    _controller1 = TextEditingController(text: widget.end.toString());
    ref=widget.id as DocumentReference;
    id=widget.id;
    String lsHour = widget.start.hour.toString().padLeft(2, '0');
    String lsMinute = widget.start.minute.toString().padLeft(2, '0');
    _getValue();
  }

  Future<void> _getValue() async {
    await Future.delayed(const Duration(seconds: 3), () {
      setState(() {
        _controller2.text = widget.start.toString();
        _controller1.text = widget.end.toString();
      });
    });
  }


  Future _getImage() async {
    var SelectedImage =
    await ImagePicker.pickImage(source: ImageSource.gallery);
    setState(() {
      if (SelectedImage != null) {
        image = SelectedImage;
        filename = basename(image.path);
      } else {
        image = null;
      }
    });
  }

  String description, date, time, venue, title, fbPostLink, googleFormLink;
  bool _isEventUploading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      appBar: AppBar(
        title: Text(
          'Edit Event',
          style: Theme.of(context).textTheme.headline6.copyWith(
            color: Colors.white,
            fontSize: 27,
          ),
        ),
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Form(
          child: Column(
            children: <Widget>[
              Container(
                alignment: Alignment.bottomLeft,
                child: Padding(
                    padding: const EdgeInsets.only(
                        left: 21, top: 11, right: 0, bottom: 11),
                    child: Text(
                      "Title",
                      style: Theme.of(context).textTheme.headline6.copyWith(
                        color: Colors.blue[900],
                        fontSize: 20,
                        // fontFamily: 'Roboto',
                        fontWeight: FontWeight.normal,
                      ),
                    )),
              ),
              Padding(
                padding: const EdgeInsets.only(
                    left: 21, top: 0, right: 11, bottom: 11),
                child: TextFormField(
                  controller: _title,
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: Colors.cyan[50],
                    enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(
                        width: 5.0,
                        color: Colors.blue[500],
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
                  style: GoogleFonts.roboto(
                    textStyle: TextStyle(
                      color: Colors.blue[900],
                      letterSpacing: 0.5,
                      fontSize: 16,
                      fontWeight: FontWeight.w900,
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
                      style: Theme.of(context).textTheme.headline6.copyWith(
                        color: Colors.blue[900],
                        fontSize: 20,
                        // fontFamily: 'Roboto',
                        fontWeight: FontWeight.normal,
                      ),
                    )),
              ),
              Padding(
                padding: const EdgeInsets.only(
                    left: 21, top: 0, right: 21, bottom: 21),
                child: TextFormField(
                  controller: _des,
                  keyboardType: TextInputType.multiline,
                  maxLines: null,
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
                      style: Theme.of(context).textTheme.headline6.copyWith(
                        color: Colors.blue[900],
                        fontSize: 20,
                        // fontFamily: 'Roboto',
                        fontWeight: FontWeight.normal,
                      ),
                    ),
                  )),

              Padding(
                padding: const EdgeInsets.only(
                    left: 21, top: 0, right: 21, bottom: 21),
                child: TextFormField(
                  controller: _venue,
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
                      "Start Date     Start Time",
                      style: Theme.of(context).textTheme.headline6.copyWith(
                        color: Colors.blue[900],
                        fontSize: 20,
                        // fontFamily: 'Roboto',
                        fontWeight: FontWeight.normal,
                      ),
                    ),
                  )),
              Padding(
                padding: const EdgeInsets.only(
                    left: 21, top: 0, right: 21, bottom: 21),
                child: DateTimePicker(
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
                  style: GoogleFonts.montserrat(
                    textStyle: TextStyle(
                      color: Colors.blue[900],
                      letterSpacing: 0.5,
                      fontSize: 18,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  type: DateTimePickerType.dateTime,
                  dateMask: 'd MMMM, yyyy   -   hh:mm a',
                  controller: _controller2,
                  //initialValue: _initialValue,
                  firstDate: DateTime(2000),
                  lastDate: DateTime(2100),
                  //icon: Icon(Icons.event),
                  use24HourFormat: false,
                  onChanged: (val) => setState(() => _valueChanged2 = val),
                  validator: (val) {
                    setState(() => _valueToValidate2 = val);
                    return null;
                  },
                  onSaved: (val) => setState(() => _valueSaved2 = val),
                ),
              ),

              Container(
                  alignment: Alignment.bottomLeft,
                  child: Padding(
                    padding: const EdgeInsets.only(
                        left: 21, top: 11, right: 21, bottom: 11),
                    child: Text(
                      "End Date    End Time",
                      style: Theme.of(context).textTheme.headline6.copyWith(
                        color: Colors.blue[900],
                        fontSize: 20,
                        // fontFamily: 'Roboto',
                        fontWeight: FontWeight.normal,
                      ),
                    ),
                  )),
              Padding(
                padding: const EdgeInsets.only(
                    left: 21, top: 0, right: 21, bottom: 21),
                child: DateTimePicker(
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
                  style: GoogleFonts.montserrat(
                    textStyle: TextStyle(
                      color: Colors.blue[900],
                      letterSpacing: 0.5,
                      fontSize: 18,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  type: DateTimePickerType.dateTime,
                  dateMask: 'd MMMM, yyyy   -   hh:mm a',
                  controller: _controller1,
                  firstDate: DateTime(2000),
                  lastDate: DateTime(2100),
                  //icon: Icon(Icons.event),
                  use24HourFormat: false,
                  onChanged: (val) => setState(() => _valueChanged1 = val),
                  validator: (val) {
                    setState(() => _valueToValidate1 = val);
                    return null;
                  },
                  onSaved: (val) => setState(() => _valueSaved1 = val),
                ),
              ),

              Container(
                  alignment: Alignment.bottomLeft,
                  child: Padding(
                    padding: const EdgeInsets.only(
                        left: 21, top: 11, right: 21, bottom: 11),
                    child: Text(
                      "Fb Post Link",
                      style: Theme.of(context).textTheme.headline6.copyWith(
                        color: Colors.blue[900],
                        fontSize: 20,
                        // fontFamily: 'Roboto',
                        fontWeight: FontWeight.normal,
                      ),
                    ),
                  )),

              Padding(
                padding: const EdgeInsets.only(
                    left: 21, top: 0, right: 21, bottom: 21),
                child: TextFormField(
                  controller: _fbPostLink,
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

              Container(
                  alignment: Alignment.bottomLeft,
                  child: Padding(
                    padding: const EdgeInsets.only(
                        left: 21, top: 11, right: 21, bottom: 11),
                    child: Text(
                      "Google Form Link",
                      style: Theme.of(context).textTheme.headline6.copyWith(
                        color: Colors.blue[900],
                        fontSize: 20,
                        // fontFamily: 'Roboto',
                        fontWeight: FontWeight.normal,
                      ),
                    ),
                  )),

              Padding(
                padding: const EdgeInsets.only(
                    left: 21, top: 0, right: 21, bottom: 21),
                child: TextFormField(
                  controller: _googleFormLink,
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

              Container(
                alignment: Alignment.bottomLeft,
                child: Padding(
                    padding: const EdgeInsets.only(
                        left: 21, top: 11, right: 21, bottom: 11),
                    child: Text(
                      "Poster",
                      style: Theme.of(context).textTheme.headline6.copyWith(
                        color: Colors.blue[900],
                        fontSize: 20,
                        // fontFamily: 'Roboto',
                        fontWeight: FontWeight.normal,
                      ),
                    )),
              ),
              //Add poster
              InkWell(
                onTap: _getImage,
                child: Padding(
                  padding: const EdgeInsets.only(
                      top: 0, bottom: 11, left: 21, right: 21),
                  child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(11),
                        color: Colors.cyan[50],
                      ),
                      height: 200,
                      child: Center(
                        child: image == null
                            ? Text(
                          'Select Poster',
                          style: GoogleFonts.openSans(
                            fontWeight: FontWeight.bold,
                            color: Colors.blue[900],
                            letterSpacing: 0.5,
                            fontSize: 21,
                          ),
                        )
                            : Image.file(image),
                      )),
                ),
              ),

              Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    RaisedButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          "Cancel",
                          style: Theme.of(context).textTheme.headline6.copyWith(
                            color: Colors.white,
                            fontSize: 20,
                            // fontFamily: 'Roboto',
                            fontWeight: FontWeight.normal,
                          ),
                        ),
                      ),
                      color: Colors.blue[900],
                      textColor: Colors.white,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(51)),
                    ),
                    SizedBox(
                      width: 10,
                      height: 21,
                    ),
                    (_isEventUploading)
                        ? LoadingSpinner()
                        : RaisedButton(
                      onPressed: () {
                        setState(() {
                          _isEventUploading = true;
                        });
                        editEvent();
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          "Add",
                          style: Theme.of(context)
                              .textTheme
                              .headline6
                              .copyWith(
                            color: Colors.white,
                            fontSize: 20,
                            // fontFamily: 'Roboto',
                            fontWeight: FontWeight.normal,
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
              SizedBox(
                height: 20,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future editEvent() async {
    FirebaseFirestore _firestore = FirebaseFirestore.instance;
    await _firestore.runTransaction((transaction)async{
      DocumentReference postRef = _firestore.collection('events')
          .document(id);
      DocumentSnapshot snapshot = await transaction.get(postRef);
      await transaction.update(postRef,{
        'about': _des.text,
        'clubId': null,
        'endTime': DateTime.parse(_controller1.text),
        'startTime': DateTime.parse(_controller2.text),
        'imageUrl': url,
        'title': _title.text,
        'venue': _venue.text,
        'fbPostLink': _fbPostLink.text,
        'googleFormLink': _googleFormLink.text,

      });
    });
  }

}
