//import 'package:cmApp/providers/dropDownItem_provider.dart';
import 'package:flutter/material.dart';

//import 'package:provider/provider.dart';

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
    //_dropDownValue = _itemList[0];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return FormField<String>(
      builder: (FormFieldState<String> state) {
        return InputDecorator(
          decoration: InputDecoration(
            labelStyle: Theme.of(context).textTheme.subtitle1,
            errorStyle: TextStyle(color: Colors.redAccent, fontSize: 16.0),
            hintText: 'Please select ${widget.itemType}',
            //  border: OutlineInputBorder(borderRadius: BorderRadius.circular(5.0)),
          ),
          isEmpty: _dropDownValue == null,
          child: DropdownButtonHideUnderline(
            child: DropdownButton<String>(
              value: _dropDownValue,
              isDense: true,
              onChanged: (String selectedValue) {
                setState(() {
                  _dropDownValue = selectedValue;
                  widget.adminCredentials[widget.itemType] = selectedValue;
                  state.didChange(selectedValue);
                });
              },
              items: _itemList.map((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
            ),
          ),
        );
      },
    );
  }
}
