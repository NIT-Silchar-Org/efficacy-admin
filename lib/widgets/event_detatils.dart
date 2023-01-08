import 'package:flutter/material.dart';
import 'package:expandable_text/expandable_text.dart';

class EventCard extends StatefulWidget {
  final Map<String, dynamic>? detail;
  const EventCard({
    Key? key,
    required this.onPressed,
    this.detail,
  }) : super(key: key);

  final Function onPressed;
  @override
  _EventCardState createState() => _EventCardState();
}

class _EventCardState extends State<EventCard> {
  Map<String, String> monthtostring = {
    "1": "Jan",
    "2": "Feb",
    "3": "Mar",
    "4": "Apr",
    "5": "May",
    "6": "Jun",
    "7": "Jul",
    "8": "Aug",
    "9": "Sep",
    "10": "Oct",
    "11": "Nov",
    "12": "Dec"
  };
  @override
  Widget build(BuildContext context) {
    final text = widget.detail!['longDescription'];
    final date = DateTime.parse(widget.detail!['startTime']),
        enddate = DateTime.parse(widget.detail!['endTime']);
    String month = date.month.toString(),
        day = date.day.toString(),
        endmonth = enddate.month.toString();
    final deviceSize = MediaQuery.of(context).size;
    return SizedBox(
      width: deviceSize.width * 0.85,
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        elevation: 20,
        child: Column(
          children: [
            GestureDetector(
              onTap: () {
                widget.onPressed();
              },
              child: Container(
                height: deviceSize.height / 4,
                decoration: BoxDecoration(
                  image: DecorationImage(
                      image: NetworkImage(widget.detail!['posterURL']),
                      fit: BoxFit.cover),
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(12),
                    topRight: Radius.circular(12),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.fromLTRB(0, 0, 0, 8),
                    child: Text(
                      widget.detail!['name'],
                      style: const TextStyle(
                        fontSize: 22,
                        color: Color.fromRGBO(5, 53, 76, 1),
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                  ExpandableText(
                    text,
                    expandText: 'Read more',
                    collapseText: 'Show less',
                    maxLines: 2,
                    expandOnTextTap: true,
                    collapseOnTextTap: true,
                    linkStyle: const TextStyle(
                      color: Color.fromRGBO(5, 53, 76, 1),
                      fontWeight: FontWeight.w700,
                    ),
                    style: const TextStyle(
                      height: 1.5,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(0, 8, 0, 0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        const Icon(Icons.calendar_today),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(8, 0, 0, 0),
                          child: Text(
                              '${date.hour < 13 ? "${date.hour}" : "${24 - date.hour}"}:${date.minute} ${date.hour > 12 && date.hour != 24 ? "PM" : "AM"}, ${monthtostring[month]} $day - ${enddate.hour < 13 ? "${enddate.hour}" : "${24 - enddate.hour}"}:${enddate.minute} ${enddate.hour > 12 && enddate.hour != 24 ? "PM" : "AM"}, ${monthtostring[endmonth]} ${enddate.day}'),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}


