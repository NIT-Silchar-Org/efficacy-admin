import 'package:efficacy_admin/themes/appcolor.dart';
import 'package:efficacy_admin/themes/theme.dart';
import 'package:efficacy_admin/utils/divider.dart';
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
  final Map<String, dynamic>? detail;
  const EventDetail({Key? key, this.detail}) : super(key: key);

  @override
  _EventDetailState createState() => _EventDetailState();
}

class _EventDetailState extends State<EventDetail> {
  BorderRadiusGeometry sheetRadius = const BorderRadius.only(
    topLeft: Radius.circular(24.0),
    topRight: Radius.circular(24.0),
  );
  @override
  Widget build(BuildContext context) {
    final String description = widget.detail!['longDescription'];
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SlidingUpPanel(
        minHeight: MediaQuery.of(context).size.height - 250,
        maxHeight: MediaQuery.of(context).size.height,
        panelBuilder: (sc) => Padding(
          padding: const EdgeInsets.fromLTRB(35, 0, 35, 0),
          child: ListView(
            // crossAxisAlignment: CrossAxisAlignment.start,
            controller: sc,
            shrinkWrap: true,
            children: [
              const PanelDivider(),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Like(likes: widget.detail!['likeCount']),
                  Calender(
                    date_of_post:
                        DateTime.tryParse(widget.detail!['startTime']),
                  ),
                  Share(
                      date_of_post: DateTime.tryParse(
                    widget.detail!['startTime'],
                  ))
                ],
              ),
              Container(
                margin: const EdgeInsets.only(top: 22),
                child: Text(
                  widget.detail!['name'],
                  style: GoogleFonts.poppins(
                    textStyle: Theme.of(context).textTheme.headline1!.copyWith(
                          fontSize: 24,
                          color: lightTheme.primaryColor,
                        ),
                  ),
                ),
              ),
              Container(
                margin: const EdgeInsets.only(top: 12),
                child: Text(
                  description,
                  style: GoogleFonts.poppins(
                    textStyle: Theme.of(context).textTheme.bodyText2!.copyWith(
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
                  children: [
                    Gform(form_url: widget.detail!['googleFormURL']),
                    Facebook(
                      fburl: widget.detail!['fbPostURL'],
                    )
                  ],
                ),
              ),
              const SizedBox(height: 22),
              Organizers(contact: widget.detail!['contacts']),
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
        body: SafeArea(
          child: Stack(
            children: [
              Container(
                height: 250,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: NetworkImage(widget.detail!['posterURL']),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              Positioned(
                left: 10,
                top: 10,
                child: IconButton(
                  onPressed: () => Navigator.of(context).pop(),
                  icon: const Icon(
                    Icons.arrow_back,
                    color: Colors.white,
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
