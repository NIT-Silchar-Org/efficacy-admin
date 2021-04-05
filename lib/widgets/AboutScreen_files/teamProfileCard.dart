import 'package:cmApp/models/developers.dart';
import 'package:flutter/material.dart';

import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:url_launcher/url_launcher.dart';

void _launchSocial(String url, fallbackUrl) async {
  try {
    bool launched = await launch(
      url,
      forceSafariVC: false,
    );
  } catch (e) {
    await launch(fallbackUrl, forceSafariVC: false);
  }
}

class TeamProfileCard extends StatelessWidget {
  final DeveloiperProfile developer;
  final Size deviceSize;

  TeamProfileCard(this.developer, this.deviceSize);
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Row(
          children: [
            SizedBox(
              width: 40,
            ),
            Card(
              margin: EdgeInsets.all(10),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15)),
              elevation: 2.7,
              child: InkWell(
                borderRadius: BorderRadius.circular(15),
                onTap: () {
                  showMaterialModalBottomSheet(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(20),
                          topRight: Radius.circular(20)),
                    ),
                    context: context,
                    builder: (context) => SingleChildScrollView(
                      controller: ModalScrollController.of(context),
                      child: Container(
                        padding: EdgeInsets.only(top: 40, bottom: 40),
                        height: 208,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Connect',
                              style: Theme.of(context)
                                  .textTheme
                                  .headline6
                                  .copyWith(
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold,
                                  ),
                            ),
                            SizedBox(
                              height: 2,
                            ),
                            Divider(
                              indent: 45,
                              endIndent: 45,
                              thickness: 1,
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                GestureDetector(
                                  onTap: () {
                                    _launchSocial(
                                        developer.fb, developer.fbFallback);
                                    Navigator.of(context).pop();
                                  },
                                  child: Container(
                                    width: 90,
                                    child: Image.asset(
                                        "assets/images/facebook.png"),
                                  ),
                                ),
                                GestureDetector(
                                  onTap: () {
                                    _launchSocial(developer.linkedin, "");
                                    Navigator.of(context).pop();
                                  },
                                  child: Container(
                                    width: 62,
                                    child: Image.asset(
                                        "assets/images/linkedinpng.png"),
                                  ),
                                )
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
                child: Container(
                  width: deviceSize.width * 0.77,
                  height: 98,
                  // color: Colors.black,
                  margin:
                      EdgeInsets.only(top: 11, bottom: 9, left: 10, right: 10),
                  padding: EdgeInsets.only(left: 90, top: 20, bottom: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        developer.name,
                        style: Theme.of(context).textTheme.headline6.copyWith(
                              fontSize: 17,
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                            ),
                      ),
                      Text(
                        developer.designation,
                        style: TextStyle(
                          color: Colors.grey,
                        ),
                      ),
                      Text(
                        'NIT Silchar | ${developer.branch}',
                        style: TextStyle(
                          color: Colors.grey[400],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
        Positioned(
          top: 7.55,
          left: 10,
          child: CircleAvatar(
            radius: 61,
            backgroundImage: NetworkImage(developer.imageUrl),
            backgroundColor: Colors.grey[400],
          ),
        )
      ],
    );
  }
}
