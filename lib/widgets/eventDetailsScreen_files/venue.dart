import 'package:flutter/material.dart';

class Venue extends StatelessWidget {
  String venue;

  Venue(this.venue);
  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Column(
        children: [
          ListTile(
            leading: Icon(
              Icons.location_on,
              color: Colors.grey[800],
              size: 35,
            ),
            title: Text(
              venue,
              style: Theme.of(context).textTheme.headline6.copyWith(
                    color: Colors.black,
                    fontSize: 22,
                  ),
            ),
          ),
          SizedBox(
            height: 70,
          ),
          // Divider(
          //   color: Colors.grey[600],
          //   indent: 25,
          //   endIndent: 25,
          // ),
          SizedBox(
            height: 100,
          ),
        ],
      ),
    );
  }
}
