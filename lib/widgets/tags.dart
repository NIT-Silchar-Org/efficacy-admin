import 'package:efficacy_admin/themes/appcolor.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_tags/flutter_tags.dart';

class NameTag extends StatefulWidget {
  const NameTag({Key? key}) : super(key: key);

  @override
  _NameTagState createState() => _NameTagState();
}

class _NameTagState extends State<NameTag> {
  late List<String> _items;
  double _fontSize = 14;

  @override
  void initState() {
    super.initState();
    _items = ['Soumya', 'Apoorv', 'Biju'];
    // _items.add(str);
  }

  @override
  Widget build(BuildContext context) {
    return Tags(
      itemCount: _items.length, // required
      itemBuilder: (int index) {
        final item = _items[index];

        return ItemTags(
          // Each ItemTags must contain a Key. Keys allow Flutter to
          // uniquely identify widgets.
          key: Key(index.toString()),
          index: index, // required
          title: item,
          textStyle: Theme.of(context).textTheme.bodyText2,
          combine: ItemTagsCombine.withTextAfter,
          image: ItemTagsImage(image: const AssetImage("assets/1.png")),
          icon: ItemTagsIcon(
            icon: Icons.add,
          ),
          activeColor: Colors.white,
          textActiveColor: AppColorLight.outline,
          border: Border(
            bottom: BorderSide(color: AppColorLight.outline, width: 2),
            left: BorderSide(color: AppColorLight.outline, width: 2),
            right: BorderSide(color: AppColorLight.outline, width: 2),
            top: BorderSide(color: AppColorLight.outline, width: 2),
          ),
          borderRadius: BorderRadius.all(Radius.circular(10)),
          removeButton: ItemTagsRemoveButton(
            backgroundColor: Colors.transparent,
            color: AppColorLight.outline,
            onRemoved: () {
              // Remove the item from the data source.
              setState(() {
                // required
                _items.removeAt(index);
              });
              //required
              return true;
            },
          ), // OR null,
        );
      },
    );
  }
}
