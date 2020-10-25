import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';


class login extends StatefulWidget
{
  @override
  _loginState createState() => _loginState();
}

class _loginState extends State<login> {
  @override

  String email;
  String password;

  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          TextField(decoration: InputDecoration(labelText: "Email"),
            onChanged: (value){
              setState(() {
                email=value;
              });
            },
          ),
          TextField(decoration: InputDecoration(labelText: "Password"),
              onChanged: (value){
                setState(() {
                  password=value;
                });
              },
              obscureText: true),
          FlatButton(
            child: Text("Login"),
            onPressed: (){
              FirebaseAuth.instance.signInWithEmailAndPassword(email: email, password: password).
              then((FirebaseUser){
                Navigator.pushNamed(context, '/homepage');
              })
                  .catchError((e)
              {
                print(e);
              }
              );
            },
          )
        ],
      ),
    );

  }
}