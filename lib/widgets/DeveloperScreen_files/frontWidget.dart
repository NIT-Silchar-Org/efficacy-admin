import 'package:cmApp/models/developers.dart';
import 'package:flutter/material.dart';

class FrontWidget extends StatelessWidget {
  DeveloiperProfile developer;
  Size deviceSize;

  FrontWidget({@required this.developer, @required this.deviceSize});
  @override
  Widget build(BuildContext context) {
    return Container(
      height: deviceSize.height * 0.6,
      width: deviceSize.width * 09,
      color: Colors.blue,
      child: Column(
        children: [
          Container(
            margin: EdgeInsets.all(5),
            color: Colors.blue,
            height: deviceSize.height * 0.5,
            width: deviceSize.width * 0.9,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: FadeInImage(
                placeholder: AssetImage(
                    'assets/images/Pngtree_black default avatar_5407174.png'),
                image: NetworkImage(developer.imageUrl),
                fit: BoxFit.cover,
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.only(top: 20),
            child: Center(
              child: Text(
                developer.name,
                style: Theme.of(context).textTheme.headline6.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
