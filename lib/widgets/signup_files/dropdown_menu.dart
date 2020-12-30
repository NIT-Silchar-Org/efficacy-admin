import 'package:cmApp/providers/dropDownItem_provider.dart';


import 'package:flutter/material.dart';


import 'package:provider/provider.dart';

/// Provides a [DropdownMenu]  of given type and values

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
    widget.adminCredentials[widget.itemType] = null;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 11, top: 11),
      child: FormField<String>(
        builder: (FormFieldState<String> state) {
          return InputDecorator(
            decoration: InputDecoration(
              labelStyle: Theme.of(context).textTheme.subtitle1,
              errorStyle: const TextStyle(color: Colors.redAccent, fontSize: 16.0),
              hintText: 'Please select your ${widget.itemType}',
              //  border: OutlineInputBorder(borderRadius: BorderRadius.circular(5.0)),
            ),
            isEmpty: _dropDownValue == null,
            child: DropdownButtonHideUnderline(
              child: DropdownButton<String>(
                value: _dropDownValue,
                isDense: true,
                onChanged: (String selectedValue) {
                  FocusManager.instance.primaryFocus.unfocus();
                  setState(() {
                    _dropDownValue = selectedValue;
                    FocusManager.instance.primaryFocus.unfocus();
                    widget.adminCredentials[widget.itemType] = selectedValue;

                    //to store clubids only for club dropdown menu
                    if (widget.itemType == 'club')
                      widget.adminCredentials['clubId'] =
                          Provider.of<DropdownItems>(context, listen: false)
                              .getClubId(selectedValue);
                    state.didChange(selectedValue);
                  });
                },
                items: _itemList.map((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(
                      value,
                      style: Theme.of(context).textTheme.subtitle1,
                    ),
                  );
                }).toList(),
              ),
            ),
          );
        },
      ),
    );
  }
}
