import 'package:cmApp/providers/dropDownItem_provider.dart';
import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

class DropdownMenu extends StatefulWidget {
  final Size deviceSize;
  final Map<String, String> adminCredentials;
  final List<String> itemList;
  final String itemType;
  DropdownMenu(
      {@required this.deviceSize,
      @required this.adminCredentials,
      @required this.itemList,
      @required this.itemType});
  @override
  _DropdownMenuState createState() => _DropdownMenuState();
}

class _DropdownMenuState extends State<DropdownMenu> {
  String _dropDownValue;
  List<String> _itemList;
  @override
  void initState() {
    _itemList = widget.itemList;
    _dropDownValue = _itemList[0];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(
            color: (_dropDownValue == _itemList[0])
                ? Colors.grey
                : Colors.deepPurpleAccent,
          ),
        ),
      ),
      width: widget.deviceSize.width * 0.85,
      child: ButtonTheme(
        alignedDropdown: true,
        child: DropdownButtonFormField<String>(
          isExpanded: true,
          value: _dropDownValue,
          icon: Icon(
            Icons.arrow_drop_down,
            color: Theme.of(context).textTheme.button.color,
          ),
          iconSize: 35,
          elevation: 6,
          style: Theme.of(context).textTheme.subtitle1,
          decoration: InputDecoration(border: InputBorder.none),
          items: _itemList.map((club) {
            return DropdownMenuItem<String>(
              value: club,
              child: Text(club),
            );
          }).toList(),
          onChanged: (String selectedValue) {
            setState(() {
              _dropDownValue = selectedValue;
              widget.adminCredentials[widget.itemType] = _dropDownValue;
            });
          },
        ),
      ),
    );
  }
}
