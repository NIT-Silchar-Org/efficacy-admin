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
  editScreen({this.event});
  final Events event;
  static const routeName = '/edit_screen';
  @override
  editScreenState createState() => editScreenState();
}

class editScreenState extends State<editScreen> {
  TextEditingController _controller2;
  TextEditingController _controller1;
  File image;
  String filename;
  String url;
  String id;

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
    _des = TextEditingController(text: widget.event.about);
    _title = TextEditingController(text: widget.event.title);
    _venue = TextEditingController(text: widget.event.venue);
    _fbPostLink = TextEditingController(text: widget.event.fbPostLink);
    _googleFormLink = TextEditingController(text: widget.event.googleFormLink);
    _controller2 = TextEditingController(text: widget.event.startTime.toString());
    _controller1 = TextEditingController(text: widget.event.endTime.toString());
    id = widget.event.eventId;
    filename= widget.event.imageUrl;
    String lsHour = widget.event.startTime.hour.toString().padLeft(2, '0');
    String lsMinute = widget.event.startTime.minute.toString().padLeft(2, '0');
    _getValue();
  }



  Future<void> _getValue() async {
    await Future.delayed(const Duration(seconds: 3), () {
      setState(() {
        _controller2.text = widget.event.startTime.toString();
        _controller1.text = widget.event.endTime.toString();
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
      } else if(filename!=null){
        image = null;
      }
    });
  }

  String description, date, time, venue, title, fbPostLink, googleFormLink;
  bool _isEventUploading = false;

  _showImage(context) {
    if (filename == null && image == null) {
      return Text("Add Poster");
    } else if (image != null) {
      print('showing image from local file');

      return Stack(
        alignment: AlignmentDirectional.bottomCenter,
        children: <Widget>[
          Image.file(
            image,
            fit: BoxFit.cover,
            height: 250,
          ),
          FlatButton(
            padding: EdgeInsets.all(16),
            color: Colors.black54,
            child: Text(
              'Change Poster',
              style: TextStyle(color: Colors.blue, fontSize: 15, fontWeight: FontWeight.w400),
            ),
            onPressed: () => _getImage(),
          )
        ],
      );
    } else if (filename != null) {
      print('showing image from url');

      return Stack(
        alignment: AlignmentDirectional.bottomCenter,
        children: <Widget>[
          Image.network(
            filename,
            width: MediaQuery.of(context).size.width,
            fit: BoxFit.cover,
            height: 250,
          ),
          FlatButton(
            padding: EdgeInsets.all(16),
            color: Colors.black54,
            child: Text(
              'Change Poster',
              style: TextStyle(color: Colors.white, fontSize: 15, fontWeight: FontWeight.w400),
            ),
            onPressed: () => _getImage(),
          )
        ],
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    print(id);
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

                    child: Column(
                        children: <Widget>[
                          _showImage(context),

                    ],)
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
                              editEvent(context).then((_) {
                                // TODO add snack bar to show if the event has been added or not
                                _isEventUploading = false;

                                Navigator.of(context).pop();
                              });
                            },
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                "Done",
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

  Future editEvent(BuildContext context) async {
    if (image != null) {
      Reference ref = FirebaseStorage.instance.ref().child(filename);
      UploadTask uploadTask = ref.putFile(image);
      var downUrl = await (await uploadTask).ref.getDownloadURL();
      url = downUrl.toString();
      print("Download URL: $url");
    } else if(filename!=null)
      url = filename;
    else
      url=null;
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
    await Provider.of<EventProvider>(context, listen: false)
        .editEvent(events, id);
  }
}
