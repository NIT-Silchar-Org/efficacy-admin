import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:efficacy_admin/models/user_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class EditAccount extends StatefulWidget {
  static const id = "/personalInfo";
  final UserModel? user;
  const EditAccount({Key? key, this.user}) : super(key: key);
  @override
  _EditAccountState createState() => _EditAccountState();
}

class _EditAccountState extends State<EditAccount> {
  final GlobalKey<FormState> _formkey = GlobalKey<FormState>();
  late final TextEditingController scolarIdcontroller, branchcontroller;
  List<String> degree = ['B.Tech', 'B.Sc', 'B.Com', 'B.A'];
  String dropdownvalue = 'B.tech';
  @override
  void initState() {
    scolarIdcontroller = TextEditingController(text:widget.user!.scholarId??'');
    branchcontroller = TextEditingController(text:widget.user!.branch??'');
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    scolarIdcontroller.dispose();
    branchcontroller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
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
                    initialValue: widget.user!.name,
                    decoration: InputDecoration(
                      fillColor: Colors.grey[400],
                      filled: true,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: const BorderSide(color: Colors.transparent),
                      ),
                    ),
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
                    initialValue: widget.user!.phoneNumber,
                    decoration: InputDecoration(
                      fillColor: Colors.grey[400],
                      filled: true,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: const BorderSide(color: Colors.transparent),
                      ),
                    ),
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
                    //initialValue: widget.user!.scholarId ?? '',
                    decoration: InputDecoration(
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
                  child: TextFormField(
                    controller: branchcontroller,
                    //initialValue: widget.user!.branch ?? '',
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: const BorderSide(
                          color: Color.fromRGBO(5, 53, 76, 1),
                        ),
                      ),
                    ),
                    validator: (val) {
                      if (val!.isEmpty) {
                        return 'branch must not be null';
                      }
                      return null;
                    },
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
                          setState(() {
                            dropdownvalue = val!;
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
                    initialValue: widget.user!.clubName,
                    decoration: InputDecoration(
                      fillColor: Colors.grey[400],
                      filled: true,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: const BorderSide(color: Colors.transparent),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 15),
                Container(
                    width:MediaQuery.of(context).size.width-50,
                    decoration:BoxDecoration(color:Colors.blue,borderRadius:BorderRadius.circular(12)),
                  margin: const EdgeInsets.fromLTRB(25, 0, 25, 0),
                  child: TextButton(
                    onPressed: () async {
                      if (_formkey.currentState!.validate()) {
                        final data = UserModel(
                          scholarId: scolarIdcontroller.text,
                          branch: branchcontroller.text,
                          phoneNumber:widget.user!.phoneNumber,
                            email:widget.user!.email,
                            userId:widget.user!.userId,
                            name:widget.user!.name,
                            clubId:widget.user!.clubId,
                            clubName:widget.user!.clubName,
                            clubPhotoUrl:widget.user!.clubPhotoUrl,
                        ).toJson();
                        await FirebaseFirestore.instance
                            .collection('admin')
                            .doc(FirebaseAuth.instance.currentUser!.uid)
                            .update(data);
                        Navigator.of(context).pop();
                        Navigator.of(context).pop();
                      }
                    },
                    child: const Text('Submit',style:TextStyle(color:Colors.white)),
                  ),
                ),
                const SizedBox(height:10),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
