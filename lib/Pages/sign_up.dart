import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:efficacy_admin/models/club_model.dart';
import 'package:efficacy_admin/models/user_model.dart';
import 'package:efficacy_admin/services/user_authentication.dart';
import 'package:efficacy_admin/themes/appcolor.dart';
import 'package:efficacy_admin/utils/loading_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SignupPage extends StatefulWidget {
  static const id = '/SignUp';

  const SignupPage({Key? key}) : super(key: key);

  @override
  _SignupPageState createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  String _value = "GDSC, NITS", countryCode = "";
  final _formKey = GlobalKey<FormState>();
  bool isLoading = false;
  late final TextEditingController phonecontroller;
  late final TextEditingController passcodecontroller;
  final clubref = FirebaseFirestore.instance.collection('clubs');
  final passcoderef = FirebaseFirestore.instance.collection('Passcodes');
  List<ClubModel> clubs = [];
  Map<String, dynamic> passcode = {};
  @override
  void initState() {
    getclubs();
    getpasscodes();
    phonecontroller = TextEditingController();
    passcodecontroller = TextEditingController();
    super.initState();
  }

  getclubs() async {
    setState(() {
      isLoading = true;
    });
    await clubref.get().then(
      (snapshots) {
        for (var snapshot in snapshots.docs) {
          ClubModel data = ClubModel.fromJson(snapshot.data());
          clubs.add(data);
        }
      },
    );
    setState(() {
      isLoading = false;
    });
  }

  getpasscodes() async {
    setState(() {
      isLoading = true;
    });
    await passcoderef.get().then(
      (snapshots) {
        for (var snapshot in snapshots.docs) {
          passcode[snapshot.data()['name']] = snapshot.data()['passcode'];
        }
      },
    );
    setState(() {
      isLoading = false;
    });
  }

  @override
  void dispose() {
    phonecontroller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final googleUser = Provider.of<GoogleSignInProvider>(context).user;
    return isLoading
        ? const LoadingScreen()
        : Scaffold(
            //resizeToAvoidBottomInset: false,
            body: Form(
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Container(
                      margin: const EdgeInsets.only(
                          left: 0, top: 72, right: 0, bottom: 43),
                      height: 150,
                      width: 150,
                      decoration: const BoxDecoration(
                        color: Color(0xFFC4C4C4),
                        shape: BoxShape.circle,
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.fromLTRB(59, 0, 59, 0),
                      child: Form(
                        key: _formKey,
                        child: Column(
                          children: [
                            TextFormField(
                              readOnly: true,
                              decoration: InputDecoration(
                                isDense: true,
                                contentPadding: const EdgeInsets.symmetric(
                                  horizontal: 0,
                                  vertical: 5,
                                ),
                                hintText:
                                    googleUser?.email ?? 'efficacy@gmail.com',
                                hintStyle: Theme.of(context)
                                    .textTheme
                                    .bodyText1!
                                    .copyWith(
                                        fontSize: 20,
                                        color: AppColorLight.outline),
                                focusedBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(
                                    color: AppColorDark.outline,
                                    width: 2.0,
                                  ),
                                ),
                                enabledBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(
                                    color: AppColorLight.outline,
                                    width: 2.0,
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(height: 27),
                            TextFormField(
                              decoration: InputDecoration(
                                isDense: true,
                                contentPadding: const EdgeInsets.symmetric(
                                  horizontal: 0,
                                  vertical: 5,
                                ),
                                hintText: googleUser?.displayName ?? 'Name',
                                hintStyle: Theme.of(context)
                                    .textTheme
                                    .bodyText1!
                                    .copyWith(
                                        fontSize: 20,
                                        color: AppColorLight.outline),
                                focusedBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(
                                      color: Theme.of(context).primaryColor,
                                      width: 2.0),
                                ),
                                enabledBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(
                                    color: AppColorLight.outline,
                                    width: 2.0,
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(height: 27),
                            IntlPhoneField(
                              controller: phonecontroller,
                              initialCountryCode: 'IN',
                              showCountryFlag: false,
                              onChanged: (number) {
                                countryCode = number.countryCode;
                              },
                              decoration: InputDecoration(
                                isDense: true,
                                contentPadding: const EdgeInsets.symmetric(
                                  horizontal: 0,
                                  vertical: 5,
                                ),
                                hintText: 'Phone number',
                                hintStyle: Theme.of(context)
                                    .textTheme
                                    .bodyText1!
                                    .copyWith(
                                        fontSize: 20,
                                        color: AppColorLight.outline),
                                focusedBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(
                                    color: Theme.of(context).primaryColor,
                                    width: 2.0,
                                  ),
                                ),
                                enabledBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(
                                    color: AppColorLight.outline,
                                    width: 2.0,
                                  ),
                                ),
                              ),
                              autovalidateMode:
                                  AutovalidateMode.onUserInteraction,
                            ),
                            const SizedBox(height: 2),
                            builddropdown(),
                            const SizedBox(height: 27),
                            TextFormField(
                              controller: passcodecontroller,
                              validator: (value) {
                                if (passcodecontroller.text ==
                                    passcode[_value]) {
                                  return null;
                                } else {
                                  return 'Passcode is wrong';
                                }
                              },
                              decoration: InputDecoration(
                                isDense: true,
                                contentPadding: const EdgeInsets.symmetric(
                                  horizontal: 0,
                                  vertical: 5,
                                ),
                                hintText: 'Enter passcode of your club',
                                hintStyle: Theme.of(context)
                                    .textTheme
                                    .bodyText1!
                                    .copyWith(
                                        fontSize: 20,
                                        color: AppColorLight.outline),
                                focusedBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(
                                      color: Theme.of(context).primaryColor,
                                      width: 2.0),
                                ),
                                enabledBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(
                                    color: AppColorLight.outline,
                                    width: 2.0,
                                  ),
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 55),
                    Container(
                      margin: const EdgeInsets.fromLTRB(48, 0, 48, 0),
                      child: SizedBox(
                        height: 44,
                        child: ElevatedButton(
                          style: ButtonStyle(
                            shape: MaterialStateProperty.all<
                                RoundedRectangleBorder>(
                              RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8.0),
                              ),
                            ),
                            backgroundColor: MaterialStateProperty.all<Color>(
                                Theme.of(context).primaryColor),
                          ),
                          child: Text(
                            "Sign Up",
                            style: Theme.of(context)
                                .textTheme
                                .bodyText2!
                                .copyWith(color: AppColorLight.onPrimary),
                          ),
                          onPressed: () async {
                            if (_formKey.currentState?.validate() == true) {
                              setState(() => isLoading = !isLoading);
                              var status =
                                  await Provider.of<GoogleSignInProvider>(
                                          context,
                                          listen: false)
                                      .signInWithFirebase();
                              String clubId = "", clublogo = "";
                              for (var model in clubs) {
                                if (model.clubName == _value) {
                                  clubId = model.clubId;
                                  clublogo = model.clubLogoUrl;
                                  break;
                                }
                              }
                              final data = UserModel(
                                      name: googleUser!.displayName,
                                      userPhotoUrl: googleUser.photoUrl,
                                      phoneNumber:
                                          '$countryCode${phonecontroller.text}',
                                      clubId: clubId,
                                      clubPhotoUrl: clublogo,
                                      clubName: _value,
                                      email: googleUser.email,
                                      userId: googleUser.id,
                                      position: 'Moderator')
                                  .toJson();
                              FirebaseFirestore.instance
                                  .collection('admin')
                                  .doc(googleUser.id)
                                  .set(data);
                              if (status == "Signed Up") {
                                Navigator.of(context).pushNamedAndRemoveUntil(
                                    '/', (Route<dynamic> route) => false);
                              }
                            }
                          },
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
          );
  }

  Widget builddropdown() {
    return DropdownButtonFormField(
      decoration: InputDecoration(
        isDense: true, // this will remove the default content padding
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 0,
          vertical: 5,
        ),
        focusedBorder: UnderlineInputBorder(
          borderSide: BorderSide(
            color: Theme.of(context).primaryColor,
            width: 2.0,
          ),
        ),
        enabledBorder: UnderlineInputBorder(
          borderSide: BorderSide(
            color: AppColorLight.outline,
            width: 2.0,
          ),
        ),
      ),
      value: _value,
      items: clubs.map((e) {
        return DropdownMenuItem(
          child: Text(
            e.clubName,
            style: TextStyle(
              fontSize: 20.0,
              color: AppColorLight.outline,
              fontWeight: FontWeight.w500,
            ),
          ),
          value: e.clubName,
        );
      }).toList(),
      onChanged: (value) {
        setState(() {
          _value = value!.toString();
          print(_value);
        });
      },
    );
  }
}
