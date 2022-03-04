import 'package:flutter/material.dart';

class EditAccount extends StatefulWidget {
  static const id = "/personalInfo";

  EditAccount({Key? key}) : super(key: key);
  @override
  _EditAccountState createState() => _EditAccountState();
}

class _EditAccountState extends State<EditAccount> {
  List<String> degree = ['B.Tech', 'B.Sc', 'B.Com', 'B.A'];
  String dropdownvalue = 'B.tech';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
              elevation: 0,
        backgroundColor: Colors.transparent,
        leading: IconButton(
          onPressed: () => Navigator.of(context).pop(),
          icon:const Icon(Icons.arrow_back),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(25, 0, 25, 5),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 40),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  Text(
                    'Account Details',
                    style: TextStyle(
                        color: Color.fromRGBO(5, 53, 76, 1),
                        fontSize: 24,
                        fontWeight: FontWeight.bold),
                  ),
                ],
              ),
              const SizedBox(height: 35),
              const Text(
                'Name',
                style: TextStyle(
                  color: Color.fromRGBO(5, 53, 76, 1),
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 10),
              TextFormField(
                enabled: false,
                initialValue: 'John Doe',
                decoration: InputDecoration(
                  fillColor: Colors.grey[400],
                  filled: true,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: const BorderSide(color: Colors.transparent),
                  ),
                ),
              ),
              const SizedBox(height: 15),
              const Text(
                'Phone no.',
                style: const TextStyle(
                  color: Color.fromRGBO(5, 53, 76, 1),
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 10),
              TextFormField(
                enabled: false,
                initialValue: '1234567899',
                decoration: InputDecoration(
                  fillColor: Colors.grey[400],
                  filled: true,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: const BorderSide(color: Colors.transparent),
                  ),
                ),
              ),
              const SizedBox(height: 15),
              const Text(
                'Scholar id',
                style: const TextStyle(
                  color: const Color.fromRGBO(5, 53, 76, 1),
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 10),
              TextFormField(
                initialValue: '2013057',
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: const BorderSide(
                      color: Color.fromRGBO(5, 53, 76, 1),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 15),
              const Text(
                'Branch',
                style: const TextStyle(
                  color: Color.fromRGBO(5, 53, 76, 1),
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 10),
              TextFormField(
                initialValue: 'EE',
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide:
                        const BorderSide(color: Color.fromRGBO(5, 53, 76, 1)),
                  ),
                ),
              ),
              const SizedBox(height: 15),
              const Text(
                'Degree',
                style: const TextStyle(
                  color: const Color.fromRGBO(5, 53, 76, 1),
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 10),
              Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(
                      color: const Color.fromRGBO(5, 53, 76, 1),
                    ),
                  ),
                  child: DropdownButtonHideUnderline(
                    child: DropdownButton<String>(
                      hint: Padding(
                        child: Text(dropdownvalue),
                        padding: const EdgeInsets.fromLTRB(10, 0, 0, 0),
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
              const SizedBox(height: 15),
              const Text(
                'Club',
                style: const TextStyle(
                  color: Color.fromRGBO(5, 53, 76, 1),
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 10),
              TextFormField(
                enabled: false,
                initialValue: 'GDSC',
                decoration: InputDecoration(
                  fillColor: Colors.grey[400],
                  filled: true,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: const BorderSide(color: Colors.transparent),
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
