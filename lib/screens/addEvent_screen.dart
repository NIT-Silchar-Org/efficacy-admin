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

class AddEventScreen extends StatefulWidget {
  static const routeName = '/add_event_screen';
  @override
  _AddEventScreenState createState() => _AddEventScreenState();
}

class _AddEventScreenState extends State<AddEventScreen> {
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

  @override
  void initState() {
    super.initState();
    _des = TextEditingController();
    _title = TextEditingController();
    _venue = TextEditingController();
    _fbPostLink = TextEditingController();
    _googleFormLink = TextEditingController();
    _controller2 = TextEditingController(text: DateTime.now().toString());
    _controller1 = TextEditingController(text: DateTime.now().toString());
    String lsHour = TimeOfDay.now().hour.toString().padLeft(2, '0');
    String lsMinute = TimeOfDay.now().minute.toString().padLeft(2, '0');
    _getValue();
  }

  Future<void> _getValue() async {
    await Future.delayed(const Duration(seconds: 3), () {
      setState(() {
        _controller2.text = DateTime.now().toString();
        _controller1.text = DateTime.now().toString();
      });
    });
  }

  Future _getImage() async {
    final ImagePicker _picker = ImagePicker();
    var SelectedImage = await _picker.getImage(source: ImageSource.gallery);
    setState(() {
      if (SelectedImage != null) {
        image = File(SelectedImage.path);
        filename = basename(image.path);
      } else {
        image = null;
      }
    });
  }

  String description, date, time, venue, title, fbPostLink, googleFormLink;
  bool _isEventUploading = false;
  final GlobalKey<FormState> _formKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Add Event',
          style: Theme.of(context).textTheme.headline6.copyWith(
                color: Colors.white,
                fontSize: 27,
              ),
        ),
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Form(
          key: _formKey,
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
                  validator: (value) {
                    if (value.isEmpty) return 'This field cant be empty';
                    return null;
                  },
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
                  validator: (value) {
                    if (value.isEmpty) return 'This field cant be empty';
                    return null;
                  },
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
                              if (!_formKey.currentState.validate()) return;
                              setState(() {
                                _isEventUploading = true;
                              });
                              addEvent(context).then((_) {
                                _isEventUploading = false;

                                Navigator.of(context).pop();

                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: Text('Event added successfully'),
                                    backgroundColor: Colors.green,
                                  ),
                                );
                              });
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

  addEvent(BuildContext context) async {
    if (image != null) {
      Reference ref = FirebaseStorage.instance.ref().child(filename);
      UploadTask uploadTask = ref.putFile(image);
      var downUrl = await (await uploadTask).ref.getDownloadURL();
      url = downUrl.toString();
      print("Download URL: $url");
    } else
      url = null;
    Events events = Events(
      about: _des.text,
      clubId: null,
      endTime: DateTime.parse(_controller1.text),
      startTime: DateTime.parse(_controller2.text),
      imageUrl: url,
      title: _title.text,
      venue: _venue.text,
      fbPostLink: _fbPostLink.text,
      googleFormLink: _googleFormLink.text,
    );
    await Provider.of<EventProvider>(context, listen: false).addEvent(events);
  }
}
