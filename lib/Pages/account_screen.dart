import 'package:flutter/material.dart';
import 'package:efficacy_admin/Pages/edit_account_screen.dart';

class Account extends StatefulWidget {
  @override
  _AccountState createState() => _AccountState();
}

class _AccountState extends State<Account> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          SizedBox(height: 50),
          Row(
            mainAxisSize: MainAxisSize.max,
            children: [
              SizedBox(width: 40),
              Container(
                child: Icon(
                  Icons.account_circle_rounded,
                  color: Colors.white,
                  size: 45.0,
                ),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.black,
                ),
              ),
              SizedBox(width: 10),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("John Doe", style: TextStyle(color: Color.fromRGBO(5, 53, 76, 0.68))),
                  SizedBox(height: 5),
                  GestureDetector(
                    onTap: () {Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => EditAccount(),
                      ),
                    );
},
                    child: Text(
                      "Edit Account Details",
                      style: TextStyle(color: Colors.blue),
                    ),
                  )
                ],
              ),
            ],
          ),
          SizedBox(height: 30),
          Container(height: 1.5, color: Colors.grey, width: MediaQuery.of(context).size.width),
          SizedBox(height: 15),
          Row(
            children: [
              SizedBox(width: 40),
              Icon(
                Icons.people_outline,
                color: Colors.black,
                size: 25.0,
              ),
              SizedBox(width: 10),
              Text("Club Details", style: TextStyle(color: Color.fromRGBO(5, 53, 76, 1))),
            ],
          ),
          SizedBox(height: 10),
          Row(
            children: [
              SizedBox(width: 40),
              Icon(
                Icons.error_outline,
                color: Colors.black,
                size: 25.0,
              ),
              SizedBox(width: 10),
              Text("About Us", style: TextStyle(color: Color.fromRGBO(5, 53, 76, 1))),
            ],
          ),
          SizedBox(height: 10),
          Row(
            children: [
              SizedBox(width: 40),
              Icon(
                Icons.logout,
                color: Colors.black,
                size: 25.0,
              ),
              SizedBox(width: 10),
              Text("Log out", style: TextStyle(color: Color.fromRGBO(5, 53, 76, 1))),
            ],
          )
        ],
      ),
    );
  }
}

