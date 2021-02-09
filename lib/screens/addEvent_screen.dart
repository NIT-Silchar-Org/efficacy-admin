import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:date_format/date_format.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart';
import 'package:firebase_storage/firebase_storage.dart';

class AddEventScreen extends StatefulWidget {
  static const routeName = '/add_event_screen';
  @override
  _AddEventScreenState createState() => _AddEventScreenState();
}

class _AddEventScreenState extends State<AddEventScreen> {

  String _setTime, _setDate;
  File _image;

  String _hour, _minute, _time;

  String dateTime;

  DateTime selectedDate = DateTime.now();

  TimeOfDay selectedTime = TimeOfDay(hour: 00, minute: 00);

  TextEditingController _dateController = TextEditingController();
  TextEditingController _timeController = TextEditingController();

  TextEditingController _des, _title, _venue, _fbPostLink,
      _googleFormLink;


  Future<Null> _selectDate(BuildContext context) async {
    final DateTime picked = await showDatePicker(
        context: context,
        initialDate: selectedDate,
        initialDatePickerMode: DatePickerMode.day,
        firstDate: DateTime(2015),
        lastDate: DateTime(2101));
    if (picked != null)
      setState(() {
        selectedDate = picked;
        _dateController.text = DateFormat.yMd().format(selectedDate);
      });
  }

  Future<Null> _selectTime(BuildContext context) async {
    final TimeOfDay picked = await showTimePicker(
      context: context,
      initialTime: selectedTime,
    );
    if (picked != null)
      setState(() {
        selectedTime = picked;
        _hour = selectedTime.hour.toString();
        _minute = selectedTime.minute.toString();
        _time = _hour + ' : ' + _minute;
        _timeController.text = _time;
        _timeController.text = formatDate(
            DateTime(2019, 08, 1, selectedTime.hour, selectedTime.minute),
            [hh, ':', nn, " ", am]).toString();
      });
  }

  @override
  void initState() {
    super.initState();
    _des = TextEditingController();
    _title = TextEditingController();
    _venue = TextEditingController();
    _fbPostLink = TextEditingController();
    _googleFormLink = TextEditingController();

    _dateController.text = DateFormat.yMd().format(DateTime.now());

    _timeController.text = formatDate(
        DateTime(2019, 08, 1, DateTime
            .now()
            .hour, DateTime
            .now()
            .minute),
        [hh, ':', nn, " ", am]).toString();
  }

  Future<void> getImage() async {
    var image = await ImagePicker.pickImage(source: ImageSource.gallery);
    setState(() {
      _image = image;
    });
    print("size = " + _image.lengthSync().toString());
  }

  Future uploadPic(BuildContext context) async{
    String fileName=basename(_image.path);
    Reference firebaseStorageRef=FirebaseStorage.instance.ref().child(fileName);
    UploadTask uploadTask=firebaseStorageRef.putFile(_image);
    TaskSnapshot taskSnapshot=await uploadTask;
    setState(() {
      print("poster uploaded");
      Scaffold.of(context).showSnackBar(SnackBar(content:Text('poster uploaded')));
    });
  }

  String description, date, time, venue, image, title, fbPostLink,
      googleFormLink;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Add Event',
          style: Theme
              .of(context)
              .textTheme
              .headline6
              .copyWith(
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
                      style: Theme
                          .of(context)
                          .textTheme
                          .headline6
                          .copyWith(
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
                      style: Theme
                          .of(context)
                          .textTheme
                          .headline6
                          .copyWith(
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
                  keyboardType:TextInputType.multiline,
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
                      style: Theme
                          .of(context)
                          .textTheme
                          .headline6
                          .copyWith(
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
                      "Date",
                      style: Theme
                          .of(context)
                          .textTheme
                          .headline6
                          .copyWith(
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
                  onTap: () {
                    _selectDate(context);
                  },
                  controller: _dateController,
                  onSaved: (String val) {
                    _setDate = val;
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
                      style: Theme
                          .of(context)
                          .textTheme
                          .headline6
                          .copyWith(
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
                  onTap: () {
                    _selectTime(context);
                    title:
                    Text(_timeController.toString());
                  },
                  controller: _timeController,
                  onSaved: (String val) {
                    _setTime = val;
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

              Container(
                  alignment: Alignment.bottomLeft,
                  child: Padding(
                    padding: const EdgeInsets.only(
                        left: 21, top: 11, right: 21, bottom: 11),
                    child: Text(
                      "Fb Post Link",
                      style: Theme
                          .of(context)
                          .textTheme
                          .headline6
                          .copyWith(
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
                      style: Theme
                          .of(context)
                          .textTheme
                          .headline6
                          .copyWith(
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
                      style: Theme
                          .of(context)
                          .textTheme
                          .headline6
                          .copyWith(
                        color: Colors.blue[900],
                        fontSize: 20,
                        // fontFamily: 'Roboto',
                        fontWeight: FontWeight.normal,
                      ),
                    )),
              ),
              //Add poster
              InkWell(
                onTap: getImage,
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
                        child: _image == null
                            ? Text(
                          'Select Poster',
                          style: GoogleFonts.openSans(
                            fontWeight: FontWeight.bold,
                            color: Colors.blue[900],
                            letterSpacing: 0.5,
                            fontSize: 21,
                          ),
                        )
                            : Image.file(_image),
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
                          style: Theme
                              .of(context)
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
                      width: 10,
                      height: 21,
                    ),
                    RaisedButton(
                      onPressed: () {
                        addEvent();
                        uploadPic(context);
                        Navigator.of(context).pop();
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          "Add",
                          style: Theme
                              .of(context)
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
   addEvent () async
  {
    Map <String, dynamic> data = {
      "title": _title.text,
      "about": _des.text,
      "venue": _venue.text,
      "fb Post Link": _fbPostLink.text,
      "Google Form Link": _googleFormLink.text,
      "Date": _dateController.text,
      "Time": _timeController.text
    };
    Firestore.instance.collection("events").add(data);
  }
}
