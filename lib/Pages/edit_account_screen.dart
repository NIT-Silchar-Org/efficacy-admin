import 'package:flutter/material.dart';

class EditAccount extends StatefulWidget {
  static const id = "/personalInfo";

  EditAccount({Key? key}) : super(key: key);
  @override
  _EditAccountState createState() => _EditAccountState();
}

class _EditAccountState extends State<EditAccount> {
  List<String> degree = [
    'B.Tech',
    'B.Sc',
    'B.Com',
    'B.A'
  ];
  String dropdownvalue = 'B.tech';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.fromLTRB(25, 0, 25, 5),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 40),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('Account Details', style: TextStyle(color: Color.fromRGBO(5, 53, 76, 1), fontSize: 24, fontWeight: FontWeight.bold)),
                ],
              ),
              SizedBox(height: 35),
              Text(
                'Name',
                style: TextStyle(
                  color: Color.fromRGBO(5, 53, 76, 1),
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 10),
              TextFormField(
                enabled: false,
                initialValue: 'John Doe',
                decoration: InputDecoration(
                  fillColor: Colors.grey[400],
                  filled: true,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide(color: Colors.transparent),
                  ),
                ),
              ),
              SizedBox(height: 15),
              Text(
                'Phone no.',
                style: TextStyle(
                  color: Color.fromRGBO(5, 53, 76, 1),
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 10),
              TextFormField(
                enabled: false,
                initialValue: '1234567899',
                decoration: InputDecoration(
                  fillColor: Colors.grey[400],
                  filled: true,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide(color: Colors.transparent),
                  ),
                ),
              ),
              SizedBox(height: 15),
              Text(
                'Scholar id',
                style: TextStyle(
                  color: Color.fromRGBO(5, 53, 76, 1),
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 10),
              TextFormField(
                initialValue: '2013057',
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide(
                      color: Color.fromRGBO(5, 53, 76, 1),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 15),
              Text(
                'Branch',
                style: TextStyle(
                  color: Color.fromRGBO(5, 53, 76, 1),
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 10),
              TextFormField(
                initialValue: 'EE',
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide(color: Color.fromRGBO(5, 53, 76, 1)),
                  ),
                ),
              ),
              SizedBox(height: 15),
              Text(
                'Degree',
                style: TextStyle(
                  color: Color.fromRGBO(5, 53, 76, 1),
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 10),
              Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(
                      color: Color.fromRGBO(5, 53, 76, 1),
                    ),
                  ),
                  child: DropdownButtonHideUnderline(
                    child: DropdownButton<String>(
                      hint: Padding(
                        child: Text(dropdownvalue),
                        padding: EdgeInsets.fromLTRB(10, 0, 0, 0),
                      ),
                      isExpanded: true,
                      items: degree.map(
                        (val) {
                          return DropdownMenuItem(
                            value: val,
                            child: Text(val),
                          );
                        },
                      ).toList(),
                      onChanged: (val) {
                        setState(
                          () {
                            dropdownvalue = val!;
                          },
                        );
                      },
                    ),
                  )),
              SizedBox(height: 15),
              Text(
                'Club',
                style: TextStyle(
                  color: Color.fromRGBO(5, 53, 76, 1),
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 10),
              TextFormField(
                enabled: false,
                initialValue: 'GDSC',
                decoration: InputDecoration(
                  fillColor: Colors.grey[400],
                  filled: true,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide(color: Colors.transparent),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

