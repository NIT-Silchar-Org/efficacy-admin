import 'package:flutter/material.dart';

class DropdownMenu extends StatefulWidget {
  final Size deviceSize;
  DropdownMenu({
    @required this.deviceSize,
  });
  @override
  _DropdownMenuState createState() => _DropdownMenuState();
}

class _DropdownMenuState extends State<DropdownMenu> {
  String _dropDownValue;
  List<String> _clubList;
  @override
  void initState() {
    _clubList = [
      'Select Club',
      'DSC',
      'CES',
      'CSS',
    ];
    _dropDownValue = _clubList[0];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return 
    Container(
        width:widget.deviceSize.width*0.85 ,
        child:
        ButtonTheme(
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
        decoration:InputDecoration(border:InputBorder.none),
        items: _clubList.map((club) {
          return DropdownMenuItem<String>(
            value: club,
            child: Text(club),
          );
        }).toList(),
        onChanged: (String selectedValue) {
          setState(() {
            _dropDownValue = selectedValue;
          });
        },
      ),
    ),
    );
  }
}
