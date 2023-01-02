import 'package:efficacy_admin/Pages/about_us.dart';
import 'package:efficacy_admin/Pages/club_details.dart';
import 'package:efficacy_admin/Pages/home_page.dart';
import 'package:efficacy_admin/models/user_model.dart';
import 'package:efficacy_admin/services/user_authentication.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:efficacy_admin/Pages/edit_account_screen.dart';
import 'package:provider/provider.dart';

class Account extends StatefulWidget {
  static const id = '/Account';
  final UserModel? user;
  const Account({Key? key, this.user}) : super(key: key);
  @override
  _AccountState createState() => _AccountState();
}

class _AccountState extends State<Account> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          const SizedBox(height: 50),
          Row(
            mainAxisSize: MainAxisSize.max,
            children: [
              const SizedBox(width: 40),
              Container(
                child: (widget.user?.userPhotoUrl != null)
                    ? Container(
                      height: 45,
                      width: 45,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(30),
                        child: Image.network(
                            widget.user!.userPhotoUrl!,
                          ),
                      ),
                    )
                    : Icon(
                        Icons.account_circle_rounded,
                        color: Colors.white,
                        size: 45.0,
                      ),
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.black,
                ),
              ),
              const SizedBox(width: 10),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.user!.name!,
                    style: const TextStyle(
                      color: Color.fromRGBO(5, 53, 76, 0.68),
                    ),
                  ),
                  const SizedBox(height: 5),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              EditAccount(userId: widget.user!.userId),
                        ),
                      );
                    },
                    child: const Text(
                      "Edit Account Details",
                      style: TextStyle(color: Colors.blue),
                    ),
                  )
                ],
              ),
            ],
          ),
          const SizedBox(height: 30),
          Container(
              height: 1.5,
              color: Colors.grey,
              width: MediaQuery.of(context).size.width),
          const SizedBox(height: 15),
          Row(
            children: [
              const SizedBox(width: 40),
              const Icon(
                Icons.people_outline,
                color: Colors.black,
                size: 25.0,
              ),
              const SizedBox(width: 10),
              GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const ClubDetailsPage(),
                    ),
                  );
                },
                child: const Text(
                  "Club Details",
                  style: TextStyle(
                    color: Color.fromRGBO(5, 53, 76, 1),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          Row(
            children: [
              const SizedBox(width: 40),
              const Icon(
                Icons.error_outline,
                color: Colors.black,
                size: 25.0,
              ),
              const SizedBox(width: 10),
              GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const AboutUsPage(),
                    ),
                  );
                },
                child: const Text(
                  "About Us",
                  style: TextStyle(
                    color: Color.fromRGBO(5, 53, 76, 1),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          Row(
            children: [
              const SizedBox(width: 40),
              const Icon(
                Icons.logout,
                color: Colors.black,
                size: 25.0,
              ),
              const SizedBox(width: 10),
              GestureDetector(
                onTap: () {
                  Provider.of<GoogleSignInProvider>(context, listen: false)
                      .logOut();
                  Navigator.of(context).pushNamedAndRemoveUntil(
                      '/', (Route<dynamic> route) => false);
                },
                child: const Text(
                  "Log out",
                  style: TextStyle(
                    color: Color.fromRGBO(5, 53, 76, 1),
                  ),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
