import 'package:flutter/material.dart';

class ProfileFieldMaker extends StatelessWidget {
  final String fieldPreValue;
  final String fieldTitle;
  final IconData fieldIcon;
  final String description;
  final bool countryCode;

  ProfileFieldMaker({
    @required this.fieldTitle,
    @required this.fieldPreValue,
    @required this.fieldIcon,
    @required this.description,
    this.countryCode=false,
  });
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 15),
      height: 100,
      width: MediaQuery.of(context).size.width,
      child: Row(
        children: <Widget>[
          Container(
            padding: EdgeInsets.only(top: 10),
            alignment: Alignment.topCenter,
            height: 100,
            width: 30,
            child: Icon(
              fieldIcon,
              size: 30,
              color: Colors.blueGrey,
            ),
          ),
          SizedBox(
            width: 10,
          ),
          Container(
            padding: EdgeInsets.only(left: 10),
            width: 352,
            height: 200,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          fieldTitle,
                          style: TextStyle(
                            color: Colors.blueGrey,
                            fontSize: 16,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          countryCode ? '+91 $fieldPreValue' : fieldPreValue,
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 22,
                          ),
                        ),
                      ],
                    ),
                    IconButton(
                      icon: Icon(
                        Icons.edit,
                        size: 30,
                        color: Colors.blueGrey,
                      ),
                      onPressed: () {},
                    ),
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),
                Expanded(
                  child: Container(
                    child: Text(
                      description,
                      style: TextStyle(
                        color: Colors.blueGrey,
                        fontSize: 14,
                      ),
                      softWrap: true,
                    ),
                  ),
                ),
                SizedBox(
                  height: 7,
                ),
                const Divider(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
