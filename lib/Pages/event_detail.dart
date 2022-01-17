import 'package:efficacy_admin/themes/appcolor.dart';
import 'package:efficacy_admin/themes/theme.dart';
import 'package:flutter/material.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';
import 'package:google_fonts/google_fonts.dart';
import '/widgets/organizers.dart';
import '/utils/calender_widget.dart';
import '/utils/like_widget.dart';
import '/utils/facebook_widget.dart';
import '/utils/share_widget.dart';
import '/utils/gform_widget.dart';

class EventDetail extends StatefulWidget {
  static const id = '/EventDetail';
  const EventDetail({Key? key}) : super(key: key);

  @override
  _EventDetailState createState() => _EventDetailState();
}

class _EventDetailState extends State<EventDetail> {
  final String description =
      "Flutter is Google’s mobile UI framework for crafting high-quality native interfaces on iOS and Android in record time. Flutter works with existing code, is used by developers and organizations around the world, and is free and open source.";
  BorderRadiusGeometry sheetRadius = const BorderRadius.only(
    topLeft: Radius.circular(24.0),
    topRight: Radius.circular(24.0),
  );
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SlidingUpPanel(
        panel: Center(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(35, 0, 35, 0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    margin: const EdgeInsets.only(top: 8, bottom: 20),
                    child: Divider(
                      color: const Color(0xff180000).withOpacity(0.17),
                      height: 20,
                      thickness: 2,
                      indent: 100,
                      endIndent: 100,
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: const [Like(), Calender(), Share()],
                  ),
                  Container(
                    margin: const EdgeInsets.only(top: 22),
                    child: Text(
                      "Design Challenge",
                      style: GoogleFonts.poppins(
                          textStyle: Theme.of(context)
                              .textTheme
                              .headline1!
                              .copyWith(
                                  fontSize: 24,
                                  color: lightTheme.primaryColor)),
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.only(top: 12),
                    child: Text(
                      description,
                      style: GoogleFonts.poppins(
                        textStyle:
                            Theme.of(context).textTheme.bodyText2!.copyWith(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w400,
                                  color: AppColorLight.onSurfaceVariant,
                                ),
                      ),
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.only(top: 29),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: const [Gform(), Facebook()],
                    ),
                  ),
                  const SizedBox(height: 22),
                  const Organizers(),
                  Container(
                    margin: const EdgeInsets.only(top: 12, bottom: 20),
                    child: Text(
                      "published on 12 March,2021",
                      style: GoogleFonts.poppins(
                        textStyle: TextStyle(
                            color: const Color(0xff191C1D).withOpacity(0.7),
                            fontSize: 8.0,
                            fontWeight: FontWeight.w300,
                            letterSpacing: 0.5,
                            fontStyle: FontStyle.italic),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
        collapsed: null,
        minHeight: MediaQuery.of(context).size.height - 250,
        maxHeight: MediaQuery.of(context).size.height - 250,
        defaultPanelState: PanelState.OPEN,
        body: SafeArea(
          child: Column(
            children: [
              Container(
                height: 250,
                decoration: const BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage('assets/androidStudyJam.png'),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ],
          ),
        ),
        borderRadius: sheetRadius,
      ),
    );
  }
}
