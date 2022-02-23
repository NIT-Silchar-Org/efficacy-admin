import 'package:flutter/material.dart';
import 'package:expandable_text/expandable_text.dart';

class EventCard extends StatefulWidget {
    final data;
  const EventCard({
    Key? key,
    required this.onPressed,
    required this.data
  }) : super(key: key);

  final Function onPressed;
  @override
  _EventCardState createState() => _EventCardState();
}

class _EventCardState extends State<EventCard> {
  final text =
      "What is Lorem Ipsum?Lorem Ipsum is simply dummy text of the printing and typesetting industry.Lorem Ipsum has been the industry standard dummy text ever since the 1500s,when an unknown printer took a galleyof type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leapinto electronic typesetting, remaining essentially unchanged.It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum";
  @override
  Widget build(BuildContext context) {
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
                decoration: const BoxDecoration(
                  color: Colors.grey,
                  borderRadius: BorderRadius.only(
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
                  const Padding(
                    padding: EdgeInsets.fromLTRB(0, 0, 0, 8),
                    child: Text(
                      'Design Challenge',
                      style: TextStyle(
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
                      children: const [
                        Icon(Icons.calendar_today,size:16),
                        Padding(
                          padding: EdgeInsets.fromLTRB(8, 0, 0, 0),
                          child: Text('11:00 AM, Nov 27 - 12:00 PM, Nov 28',style:TextStyle(fontSize:13)),
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
