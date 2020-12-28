import 'package:flutter/material.dart';

class CustomDrawerHeader extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      //margin:EdgeInsets.only(bottom:10),
      width: double.infinity,
      height: 200,
      color: Colors.grey[200],
      padding: EdgeInsets.only(
        top: 20,
      ),
      child: ListTile(
        leading: CircleAvatar(
          child: Text(
            'A',
            style: TextStyle(fontSize: 25),
          ),
          backgroundColor: Colors.white,
          radius: 50,
        ),
        title: Text(
          'Guest',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        subtitle: Text('NITS CLUB'),
      ),
    );
  }
}
