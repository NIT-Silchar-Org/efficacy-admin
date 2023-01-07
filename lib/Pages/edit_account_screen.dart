import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:efficacy_admin/models/user_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:efficacy_admin/utils/loading_screen.dart';

class EditAccount extends StatefulWidget {
  static const id = "/personalInfo";
  final String? userId;
  const EditAccount({Key? key, this.userId}) : super(key: key);
  @override
  _EditAccountState createState() => _EditAccountState();
}

class _EditAccountState extends State<EditAccount> {
  final GlobalKey<FormState> _formkey = GlobalKey<FormState>();
  late final TextEditingController scolarIdcontroller;
  List<String> degree = ['B.Tech', 'B.Sc', 'B.Com', 'B.A'];
  List<String> branch = ['EE', 'ECE', 'CSE', 'CE', 'ME', 'EIE'];
  late String degreevalue, branchvalue;
  late final UserModel user;
  bool isloading = false;
  @override
  void initState() {
    getdata();
    super.initState();
  }

  getdata() async {
    setState(() {
      isloading = true;
    });
    await FirebaseFirestore.instance
        .collection('admin')
        .doc(widget.userId!)
        .get()
        .then((snapshot) {
      user = UserModel.fromJson(snapshot.data()!);
    });
    branchvalue = user.branch ?? '';
    degreevalue = 'B.tech';
    scolarIdcontroller = TextEditingController(text: user.scholarId ?? '');
    setState(() {
      isloading = false;
    });
  }

  @override
  void dispose() {
    super.dispose();
    scolarIdcontroller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body:isloading?const LoadingScreen(): SingleChildScrollView(
          child: Form(
            key: _formkey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 40,
                  child: Align(
                    alignment: Alignment.topLeft,
                    child: Container(
                      margin: const EdgeInsets.fromLTRB(10, 10, 0, 0),
                      child: IconButton(
                        onPressed: () => Navigator.of(context).pop(),
                        icon: const Icon(
                          Icons.arrow_back,
                          color: Colors.black,
                        ),
                      ),
                    ),
                  ),
                ),
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
                const Padding(
                  padding: EdgeInsets.fromLTRB(25, 0, 25, 0),
                  child: Text(
                    'Name',
                    style: TextStyle(
                      color: Color.fromRGBO(5, 53, 76, 1),
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                Padding(
                  padding: const EdgeInsets.fromLTRB(25, 0, 25, 0),
                  child: TextFormField(
                    enabled: false,
                    initialValue: user.name,
                    decoration: InputDecoration(
                      filled: true,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: const BorderSide(color: Colors.transparent),
                      ),
                    ),
                    style: TextStyle(color: Colors.grey.withOpacity(0.8)),
                  ),
                ),
                const SizedBox(height: 15),
                const Padding(
                  padding: EdgeInsets.fromLTRB(25, 0, 25, 0),
                  child: Text(
                    'Phone no.',
                    style: TextStyle(
                      color: Color.fromRGBO(5, 53, 76, 1),
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                Padding(
                  padding: const EdgeInsets.fromLTRB(25, 0, 25, 0),
                  child: TextFormField(
                    enabled: false,
                    initialValue: user.phoneNumber,
                    decoration: InputDecoration(
                      filled: true,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: const BorderSide(color: Colors.transparent),
                      ),
                    ),
                    style: TextStyle(color: Colors.grey.withOpacity(0.8)),
                  ),
                ),
                const SizedBox(height: 15),
                const Padding(
                  padding: EdgeInsets.fromLTRB(25, 0, 25, 0),
                  child: Text(
                    'Scholar id',
                    style: TextStyle(
                      color: Color.fromRGBO(5, 53, 76, 1),
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                Padding(
                  padding: const EdgeInsets.fromLTRB(25, 0, 25, 0),
                  child: TextFormField(
                    controller: scolarIdcontroller,
                    //initialValue: user.scholarId ?? '',
                    decoration: InputDecoration(
                      hintText: 'Ex- 2013057',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: const BorderSide(
                          color: Color.fromRGBO(5, 53, 76, 1),
                        ),
                      ),
                    ),
                    validator: (val) {
                      if (val!.isEmpty) {
                        return 'scholarId must not be null';
                      }
                      return null;
                    },
                  ),
                ),
                const SizedBox(height: 15),
                const Padding(
                  padding: EdgeInsets.fromLTRB(25, 0, 25, 0),
                  child: Text(
                    'Branch',
                    style: TextStyle(
                      color: Color.fromRGBO(5, 53, 76, 1),
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                Padding(
                  padding: const EdgeInsets.fromLTRB(25, 0, 25, 0),
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(
                        color: const Color.fromRGBO(5, 53, 76, 1),
                      ),
                    ),
                    child: DropdownButtonHideUnderline(
                      child: DropdownButton<String>(
                        hint: Padding(
                          child: Text(branchvalue),
                          padding: const EdgeInsets.fromLTRB(10, 0, 0, 0),
                        ),
                        isExpanded: true,
                        items: branch.map(
                          (val) {
                            return DropdownMenuItem(
                              value: val,
                              child: Text(val),
                            );
                          },
                        ).toList(),
                        onChanged: (val) {
                          setState(() {
                            branchvalue = val!;
                          });
                        },
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 15),
                const Padding(
                  padding: EdgeInsets.fromLTRB(25, 0, 25, 0),
                  child: Text(
                    'Degree',
                    style: TextStyle(
                      color: Color.fromRGBO(5, 53, 76, 1),
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                Padding(
                  padding: const EdgeInsets.fromLTRB(25, 0, 25, 0),
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(
                        color: const Color.fromRGBO(5, 53, 76, 1),
                      ),
                    ),
                    child: DropdownButtonHideUnderline(
                      child: DropdownButton<String>(
                        hint: Padding(
                          child: Text(degreevalue),
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
                          setState(() {
                            degreevalue = val!;
                          });
                        },
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 15),
                const Padding(
                  padding: EdgeInsets.fromLTRB(25, 0, 25, 0),
                  child: Text(
                    'Club',
                    style: TextStyle(
                      color: Color.fromRGBO(5, 53, 76, 1),
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                Padding(
                  padding: const EdgeInsets.fromLTRB(25, 0, 25, 0),
                  child: TextFormField(
                    enabled: false,
                    initialValue: user.clubName,
                    decoration: InputDecoration(
                      filled: true,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: const BorderSide(color: Colors.transparent),
                      ),
                    ),
                    style: TextStyle(color: Colors.grey.withOpacity(0.8)),
                  ),
                ),
                const SizedBox(height: 15),
                Container(
                  width: MediaQuery.of(context).size.width - 50,
                  decoration: BoxDecoration(
                    color: const Color.fromRGBO(5, 53, 76, 1),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  margin: const EdgeInsets.fromLTRB(25, 0, 25, 0),
                  child: TextButton(
                    onPressed: () async {
                      if (_formkey.currentState!.validate()) {
                        final data = UserModel(
                          scholarId: scolarIdcontroller.text,
                          branch: branchvalue,
                          phoneNumber: user.phoneNumber,
                          email: user.email,
                          userId: user.userId,
                          name: user.name,
                          clubId: user.clubId,
                          clubName: user.clubName,
                          clubPhotoUrl: user.clubPhotoUrl,
                        ).toJson();
                        await FirebaseFirestore.instance
                            .collection('admin')
                            .doc(widget.userId)
                            .update(data);
                        Navigator.of(context).pop();
                        Navigator.of(context).pop();
                      }
                    },
                    child: const Text('Submit',
                        style: TextStyle(color: Colors.white)),
                  ),
                ),
                const SizedBox(height: 10),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

