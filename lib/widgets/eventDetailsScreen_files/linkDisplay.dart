import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

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

class LinkDisplay extends StatelessWidget {
  LinkDisplay(this.link, this.icon, this.isBottomDivider, this.isTopDivider);

  String link;
  IconData icon;
  bool isBottomDivider = true;
  bool isTopDivider = true;
  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Padding(
        padding: EdgeInsets.only(top: 20, left: 15, right: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            isTopDivider
                ? Divider(
                    color: Colors.grey[600],
                    indent: 25,
                    endIndent: 25,
                  )
                : SizedBox(),
            SizedBox(
              height: 10,
            ),
            InkWell(
              onTap: () {
                _launchSocial(link, "");
              },
              child: ListTile(
                leading: Icon(
                  icon,
                  size: 50,
                ),
                title: Text(
                  link,
                  style: Theme.of(context)
                      .textTheme
                      .subtitle1
                      .copyWith(color: Colors.blue),
                ),
              ),
            ),
            isBottomDivider
                ? Divider(
                    color: Colors.grey[600],
                    indent: 25,
                    endIndent: 25,
                  )
                : SizedBox(),
            SizedBox(
              height: 40,
            ),
          ],
        ),
      ),
    );
  }
}
