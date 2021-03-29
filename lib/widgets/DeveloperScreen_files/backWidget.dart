import 'package:cmApp/models/developers.dart';
import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

class BackWidget extends StatelessWidget {
  Size deviceSize;
  DeveloiperProfile developer;

  BackWidget({
    @required this.deviceSize,
    @required this.developer,
  });

  void _launchSocial(String url, String fallbackUrl) async {
    // Don't use canLaunch because of fbProtocolUrl (fb://)
    try {
      bool launched =
          await launch(url, forceSafariVC: false, forceWebView: false);
      if (!launched) {
        await launch(fallbackUrl, forceSafariVC: false, forceWebView: false);
      }
    } catch (e) {
      await launch(fallbackUrl, forceSafariVC: false, forceWebView: false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: deviceSize.height * 0.6,
      width: deviceSize.width * 09,
      color: Colors.blue,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          SizedBox(
            height: 10,
          ),
          Container(
            margin: EdgeInsets.all(10),
            alignment: Alignment.topLeft,
            child: Text(
              developer.work,
              style: Theme.of(context).textTheme.bodyText1.copyWith(
                  //color: Colors.deepPurple,
                  fontWeight: FontWeight.bold,
                  fontSize: 18),
            ),
          ),
          Container(
            margin: EdgeInsets.all(10),
            alignment: Alignment.topLeft,
            child: Text(
              developer.about,
              style: Theme.of(context).textTheme.bodyText1.copyWith(
                    //color: Colors.deepPurple,
                    fontSize: 18,
                    fontWeight: FontWeight.w300,
                  ),
            ),
          ),
          ListTile(
            leading: Text(
              'Branch :',
              style: Theme.of(context).textTheme.bodyText1.copyWith(
                    //color: Colors.deepPurple,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
            ),
            title: Text(developer.branch),
          ),
          Container(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                IconButton(
                  icon: Icon(MdiIcons.facebook),
                  onPressed: () {
                    _launchSocial(developer.fb, developer.fbFallback);
                  },
                  iconSize: 50,
                ),
                IconButton(
                  icon: Icon(MdiIcons.linkedin),
                  onPressed: () {
                    _launchSocial(developer.linkedin,"");
                  },
                  iconSize: 50,
                ),
                IconButton(
                  icon: Icon(MdiIcons.github),
                  onPressed: () {
                    _launchSocial(developer.github,"");
                  },
                  iconSize: 50,
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
