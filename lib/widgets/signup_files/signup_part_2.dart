import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:cmApp/providers/dropDownItem_provider.dart';
import './dropdown_menu.dart';


///********************Sign up page 2 *****************///

class SignupPart2 extends StatelessWidget {
  const SignupPart2({
    Key key,
    @required Map<String, String> adminCredentials,
    @required this.deviceSize,
  })  : _adminCredentials = adminCredentials,
        super(key: key);

  final Map<String, String> _adminCredentials;
  final Size deviceSize;

  @override
  Widget build(BuildContext context) {
    return Consumer<DropdownItems>(
      builder: (ctx, dropdownItem, child) => Column(
        children: [
          /******************Name Field****************************/
          TextFormField(
            decoration: InputDecoration(
              labelText: 'Name',
              labelStyle: Theme.of(context).textTheme.subtitle1,
            ),
            keyboardType: TextInputType.emailAddress,
            validator: (value) {
              if (value.isEmpty) {
                return 'This Field cant be empty';
              }
              return '';
            },
            style: Theme.of(context).textTheme.headline6,
            onSaved: (String value) => _adminCredentials['name'] = value,
          ),
         // SizedBox(height: 15,),
          DropdownMenu(
            deviceSize: deviceSize,
            adminCredentials: _adminCredentials,
            itemList: dropdownItem.clubList,
            itemType: 'club',
          ),
          DropdownMenu(
            deviceSize: deviceSize,
            adminCredentials: _adminCredentials,
            itemList: dropdownItem.branchList,
            itemType: 'branch',
          ),
          SizedBox(
            height: 25,
          ),
        ],
      ),
    );
  }
}