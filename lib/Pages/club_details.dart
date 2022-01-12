import 'package:efficacy_admin/widgets/club_details_panel.dart';
import 'package:flutter/material.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

class ClubDetailsPage extends StatefulWidget {
  const ClubDetailsPage({Key? key}) : super(key: key);

  @override
  _ClubDetailsPageState createState() => _ClubDetailsPageState();
}

class _ClubDetailsPageState extends State<ClubDetailsPage> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return SizedBox(
      height: size.height,
      width: size.width,
      child: SafeArea(
        child: Scaffold(
          body: SlidingUpPanel(
            padding: const EdgeInsets.symmetric(horizontal: 35),
            collapsed: null,
            maxHeight: size.height,
            minHeight: size.height * 0.75,
            body: Column(
              children: [
                SizedBox(
                  child: Image.asset(
                    'assets/mainPhoto.png',
                    fit: BoxFit.cover,
                  ),
                ),
              ],
            ),
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(24.0),
              topRight: Radius.circular(24.0),
            ),
            panelBuilder: (scrollController) => ClubPanelWidget(
              scrollController: scrollController,
            ),
          ),
        ),
      ),
    );
  }
}