import 'package:flutter/material.dart';

class ProfilePic extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
                    radius: 80,
                    backgroundColor: Colors.black,
                    child: Text(
                      'Image Preview',
                      style: TextStyle(
                        color: Colors.white,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  );
  }
}