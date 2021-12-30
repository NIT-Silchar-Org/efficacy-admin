import 'package:flutter/material.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';
import 'package:google_fonts/google_fonts.dart';

class EventDetail extends StatefulWidget {
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
                    children: [
                      Column(
                        children: [
                          const Icon(
                            Icons.thumb_up_alt_outlined,
                            size: 20,
                            color: Color(0xff05354C),
                          ),
                          Text(
                            '1.2k',
                            style: GoogleFonts.poppins(
                              textStyle: TextStyle(
                                color: const Color(0xff49454F).withOpacity(0.7),
                                fontSize: 12.0,
                                fontWeight: FontWeight.w500,
                                letterSpacing: 0.5,
                              ),
                            ),
                          )
                        ],
                      ),
                      Column(
                        children: [
                          const Icon(
                            Icons.calendar_today_outlined,
                            size: 20,
                            color: Color(0xff05354C),
                          ),
                          Text(
                            '20 Nov',
                            style: GoogleFonts.poppins(
                              textStyle: TextStyle(
                                color: const Color(0xff49454F).withOpacity(0.7),
                                fontSize: 12.0,
                                fontWeight: FontWeight.w500,
                                letterSpacing: 0.5,
                              ),
                            ),
                          )
                        ],
                      ),
                      Column(
                        children: [
                          const Icon(
                            Icons.share_outlined,
                            size: 20,
                            color: Color(0xff05354C),
                          ),
                          Text(
                            'Share',
                            style: GoogleFonts.poppins(
                              textStyle: TextStyle(
                                color: const Color(0xff49454F).withOpacity(0.7),
                                fontSize: 12.0,
                                fontWeight: FontWeight.w500,
                                letterSpacing: 0.5,
                              ),
                            ),
                          )
                        ],
                      )
                    ],
                  ),
                  Container(
                    margin: const EdgeInsets.only(top: 22),
                    child: Text(
                      "Design Challenge",
                      style: GoogleFonts.poppins(
                        textStyle: const TextStyle(
                          color: Color(0xff05354C),
                          fontSize: 24.0,
                          fontWeight: FontWeight.w700,
                          letterSpacing: 0.5,
                        ),
                      ),
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.only(top: 20),
                    child: Text(
                      description,
                      style: GoogleFonts.poppins(
                        textStyle: const TextStyle(
                          color: Color(0xff49454F),
                          fontSize: 16.0,
                          fontWeight: FontWeight.w400,
                          letterSpacing: 0.5,
                        ),
                      ),
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.only(top: 29),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Card(
                          shadowColor: const Color(0xffD8F6FF).withOpacity(0.5),
                          elevation: 1,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: SizedBox(
                            width: 125,
                            height: 28,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                Container(
                                  width: 22,
                                  height: 22,
                                  decoration: const BoxDecoration(
                                    image: DecorationImage(
                                      image:
                                          AssetImage('assets/google_logo.png'),
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                                Text(
                                  "Google Form",
                                  style: GoogleFonts.poppins(
                                    textStyle: const TextStyle(
                                      color: Color(0xFFFECC07),
                                      fontSize: 12.0,
                                      fontWeight: FontWeight.w500,
                                      letterSpacing: 0.5,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        Card(
                          shadowColor: const Color(0xffD8F6FF).withOpacity(0.5),
                          elevation: 1,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: SizedBox(
                            width: 125,
                            height: 28,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                const Icon(
                                  Icons.facebook,
                                  size: 22,
                                  color: Color(0xff1877F2),
                                ),
                                Text(
                                  "Facebook",
                                  style: GoogleFonts.poppins(
                                    textStyle: const TextStyle(
                                      color: Color(0xff213f8d),
                                      fontSize: 12.0,
                                      fontWeight: FontWeight.w500,
                                      letterSpacing: 0.5,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                  const SizedBox(height: 22),
                  Text(
                    "Added by",
                    style: GoogleFonts.poppins(
                      textStyle: const TextStyle(
                        color: Color(0xff05354C),
                        fontSize: 18.0,
                        fontWeight: FontWeight.w500,
                        letterSpacing: 0.5,
                      ),
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.only(top: 12),
                    child: Row(
                      children: [
                        const Icon(
                          Icons.person,
                          size: 32,
                        ),
                        Container(
                          margin: const EdgeInsets.only(left: 12),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Random Name",
                                style: GoogleFonts.poppins(
                                  textStyle: TextStyle(
                                    color: const Color(0xff191C1D)
                                        .withOpacity(0.7),
                                    fontSize: 12.0,
                                    fontWeight: FontWeight.w400,
                                    letterSpacing: 0.5,
                                  ),
                                ),
                              ),
                              Text(
                                "Moderator",
                                style: GoogleFonts.poppins(
                                  textStyle: TextStyle(
                                    color: const Color(0xff191C1D)
                                        .withOpacity(0.5),
                                    fontSize: 8.0,
                                    fontWeight: FontWeight.w400,
                                    letterSpacing: 0.5,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.only(top: 20),
                    child: Row(
                      children: [
                        Container(
                          width: 36,
                          height: 36,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8),
                              color: const Color(0xFFFFF0B6)),
                          child: const Center(
                            child: Icon(
                              Icons.call_outlined,
                              size: 14,
                              color: Color(0xffFECC07),
                            ),
                          ),
                        ),
                        Container(
                          margin: const EdgeInsets.only(left: 12),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "9876543210",
                                style: GoogleFonts.poppins(
                                  textStyle: TextStyle(
                                    color: const Color(0xff191C1D)
                                        .withOpacity(0.7),
                                    fontSize: 12.0,
                                    fontWeight: FontWeight.w400,
                                    letterSpacing: 0.5,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
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
