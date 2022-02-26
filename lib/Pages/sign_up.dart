import 'package:efficacy_admin/models/user_model.dart';
import 'package:efficacy_admin/services/user_authentication.dart';
import 'package:efficacy_admin/themes/appcolor.dart';
import 'package:efficacy_admin/utils/loading_screen.dart';
import 'package:flutter/material.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:provider/provider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class SignupPage extends StatefulWidget {
  static const id = '/SignUp';

  const SignupPage({Key? key}) : super(key: key);

  @override
  _SignupPageState createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  String _value = 'GDSC', number = '';
  final _formKey = GlobalKey<FormState>();
  bool isLoading = false;
  final ref = FirebaseFirestore.instance.collection('clubs');
  List<String> clubs = [];
  late final TextEditingController phonecontroller;
  @override
  void initState() {
    fetchclubs();
    phonecontroller = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    phonecontroller.dispose();
    super.dispose();
  }

  void fetchclubs() async {
    await ref.get().then(
      (QuerySnapshot snapshot) {
        for (var element in snapshot.docs) {
          //print(element['name'].toString());
          clubs.add(element['name'].toString());
        }
      },
    );
    print(clubs);
  }

  @override
  Widget build(BuildContext context) {
    final googleUser = Provider.of<GoogleSignInProvider>(context).user;
    return isLoading
        ? const LoadingScreen()
        : Scaffold(
            resizeToAvoidBottomInset: false,
            body: Form(
              key: _formKey,
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
                    margin: const EdgeInsets.fromLTRB(20, 0, 20, 0),
                    child: Column(
                      children: [
                        TextFormField(
                          readOnly: true,
                          decoration: InputDecoration(
                            isDense:
                                true, // this will remove the default content padding
                            contentPadding: const EdgeInsets.symmetric(
                              horizontal: 0,
                              vertical: 5,
                            ),
                            hintText: googleUser?.email ?? 'efficacy@gmail.com',
                            hintStyle: Theme.of(context)
                                .textTheme
                                .bodyText1!
                                .copyWith(
                                    fontSize: 20, color: AppColorLight.outline),
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
                          readOnly: true,
                          decoration: InputDecoration(
                            isDense:
                                true, // this will remove the default content padding
                            contentPadding: const EdgeInsets.symmetric(
                              horizontal: 0,
                              vertical: 5,
                            ),
                            hintText: googleUser?.displayName ?? 'Name',
                            hintStyle: Theme.of(context)
                                .textTheme
                                .bodyText1!
                                .copyWith(
                                    fontSize: 20, color: AppColorLight.outline),
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
                          initialCountryCode: 'IN',
                          // showCountryFlag: false,
                          onSaved: (phone) {
                            number = phone!.completeNumber;
                            print(phone.completeNumber);
                          },
                          decoration: InputDecoration(
                            isDense:
                                true, // this will remove the default content padding
                            contentPadding: const EdgeInsets.symmetric(
                              horizontal: 0,
                              vertical: 5,
                            ),
                            hintText: 'Phone number',
                            hintStyle: Theme.of(context)
                                .textTheme
                                .bodyText1!
                                .copyWith(
                                    fontSize: 20, color: AppColorLight.outline),
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
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                        ),
                        const SizedBox(height: 27),
                        builddropdown(),
                      ],
                    ),
                  ),
                  const SizedBox(height: 55),
                  Container(
                    margin: const EdgeInsets.fromLTRB(20, 0, 20, 0),
                    child: SizedBox(
                      height: 44,
                      child: ElevatedButton(
                        style: ButtonStyle(
                          shape:
                              MaterialStateProperty.all<RoundedRectangleBorder>(
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
                          if (_formKey.currentState!.validate()) {
                            _formKey.currentState!.save();
                            setState(() => isLoading = !isLoading);
                            var status =
                                await Provider.of<GoogleSignInProvider>(context,
                                        listen: false)
                                    .signInWithFirebase();
                            if (status == "Signed Up") {
                              final user = UserModel(
                                name: googleUser?.displayName,
                                email: googleUser?.email,
                                userId: googleUser?.id,
                                clubName: _value,
                                phoneNumber: number,
                              ).toJson();
                              await FirebaseFirestore.instance
                                  .collection('admin')
                                  .doc()
                                  .set(user);
                              //setState(() => isLoading = !isLoading);
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
          );
  }

  builddropdown() {
    return InputDecorator(
      decoration: const InputDecoration(border: OutlineInputBorder()),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          value: _value,
          items: clubs.map((element) {
            return DropdownMenuItem<String>(
              child: Text(
                element,
                style: TextStyle(
                  fontSize: 20.0,
                  color: AppColorLight.outline,
                  fontWeight: FontWeight.w500,
                ),
              ),
              value: element,
            );
          }).toList(),
          /*items: [
            DropdownMenuItem(
              child: Text(
                'GDSC',
                style: TextStyle(
                  fontSize: 20.0,
                  color: AppColorLight.outline,
                  fontWeight: FontWeight.w500,
                ),
              ),
              value: 'GDSC',
            ),
            DropdownMenuItem(
              child: Text(
                'Efficacy',
                style: TextStyle(
                  fontSize: 20.0,
                  color: AppColorLight.outline,
                  fontWeight: FontWeight.w500,
                ),
              ),
              value: 'Efficacy',
            ),
          ],*/
          onChanged: (value) {
            setState(() {
              _value = value!;
            });
          },
        ),
      ),
    );
  }
}
