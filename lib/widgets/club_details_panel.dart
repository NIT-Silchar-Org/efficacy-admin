import 'package:efficacy_admin/utils/divider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_lorem/flutter_lorem.dart';

const kPrimaryColor = Color(0xff05354C);
const kTextColor = Color(0xff49454F);

class ClubPanelWidget extends StatelessWidget {
  final ScrollController scrollController;

  const ClubPanelWidget({
    Key? key,
    required this.scrollController,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    String clubLogoUrl =
        'https://res.cloudinary.com/devncode/image/upload/v1575267757/production_devncode/community/1575267756355.jpg';
    String clubName = 'GDSC NITS';
    String clubDesc = lorem(words: 15, paragraphs: 1);
    String clubEmailID = 'xyz@gmail.com';
    String clubFacebookUrl = 'xyz_club/facebook.com';
    String clubInstagramUrl = 'xyz_club/instagram.com';
    String clubLinkedInUrl = 'xyz_club/linkedin.com';
    String clubLeadName = 'John Doe';
    String clubContact = '7890123455';

    final size = MediaQuery.of(context).size;
    return ListView(
      controller: scrollController,
      padding: EdgeInsets.zero,
      children: <Widget>[
        const PanelDivider(), 
        CircleAvatar(
          radius: 25,
          child: Image.network(
            clubLogoUrl,
            fit: BoxFit.contain,
          ),
        ),
        const SizedBox(height: 20),
        Text(
          clubName,
          textAlign: TextAlign.center,
          style: Theme.of(context).textTheme.headline1?.copyWith(
                color: kPrimaryColor,
                fontSize: 18,
              ),
        ),
        const SizedBox(height: 40),
        Text(
          'Description',
          style: Theme.of(context).textTheme.headline1?.copyWith(
                color: kPrimaryColor,
                fontSize: 18,
              ),
        ),
        const SizedBox(height: 10),
        Text(
          clubDesc,
          style: Theme.of(context).textTheme.bodyText2?.copyWith(
                color: kTextColor,
                fontSize: 12,
              ),
        ),
        const SizedBox(height: 20),
        Text(
          'Email Id',
          style: Theme.of(context).textTheme.headline1?.copyWith(
                color: kPrimaryColor,
                fontSize: 18,
              ),
        ),
        const SizedBox(height: 10),
        Text(
          clubEmailID,
          style: Theme.of(context).textTheme.bodyText2?.copyWith(
                color: kTextColor,
                fontSize: 12,
              ),
        ),
        const SizedBox(height: 20),
        Text(
          'Facebook link',
          style: Theme.of(context).textTheme.headline1?.copyWith(
                color: kPrimaryColor,
                fontSize: 18,
              ),
        ),
        const SizedBox(height: 10),
        Text(
          clubFacebookUrl,
          style: Theme.of(context).textTheme.bodyText2?.copyWith(
                color: kTextColor,
                fontSize: 12,
              ),
        ),
        const SizedBox(height: 20),
        Text(
          'Instagram link',
          style: Theme.of(context).textTheme.headline1?.copyWith(
                color: kPrimaryColor,
                fontSize: 18,
              ),
        ),
        const SizedBox(height: 10),
        Text(
          clubInstagramUrl,
          style: Theme.of(context).textTheme.bodyText2?.copyWith(
                color: kTextColor,
                fontSize: 12,
              ),
        ),
        const SizedBox(height: 20),
        Text(
          'LinkedIn link',
          style: Theme.of(context).textTheme.headline1?.copyWith(
                color: kPrimaryColor,
                fontSize: 18,
              ),
        ),
        const SizedBox(height: 10),
        Text(
          clubLinkedInUrl,
          style: Theme.of(context).textTheme.bodyText2?.copyWith(
                color: kTextColor,
                fontSize: 12,
              ),
        ),
        const SizedBox(height: 20),
        Text(
          'Club Lead Name',
          style: Theme.of(context).textTheme.headline1?.copyWith(
                color: kPrimaryColor,
                fontSize: 18,
              ),
        ),
        const SizedBox(height: 10),
        Text(
          clubLeadName,
          style: Theme.of(context).textTheme.bodyText2?.copyWith(
                color: kTextColor,
                fontSize: 12,
              ),
        ),
        const SizedBox(height: 20),
        Text(
          'Contact',
          style: Theme.of(context).textTheme.headline1?.copyWith(
                color: kPrimaryColor,
                fontSize: 18,
              ),
        ),
        const SizedBox(height: 10),
        Text(
          clubContact,
          style: Theme.of(context).textTheme.bodyText2?.copyWith(
                color: kTextColor,
                fontSize: 12,
              ),
        ),
        SizedBox(
          height: 100,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'For any Queries Contact : ',
                style: Theme.of(context).textTheme.bodyText2?.copyWith(
                      color: Colors.grey,
                      fontSize: 12,
                      fontStyle: FontStyle.italic,
                    ),
              ),
              Text(
                clubEmailID,
                style: Theme.of(context).textTheme.bodyText2?.copyWith(
                      color: kPrimaryColor,
                      fontSize: 12,
                      fontStyle: FontStyle.italic,
                      decoration: TextDecoration.underline,
                    ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 20),
      ],
    );
  }
}
