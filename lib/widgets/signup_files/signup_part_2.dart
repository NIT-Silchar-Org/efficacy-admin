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
    @required TextEditingController nameController,
  })  : _adminCredentials = adminCredentials,
        _nameController=nameController,
        super(key: key);

  final Map<String, String> _adminCredentials;
  final Size deviceSize;
  final TextEditingController _nameController;

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
            keyboardType: TextInputType.name,
            validator: (value) {
              if (value.isEmpty) {
                return 'This Field cant be empty';
              }
              return null;
            },
            style: Theme.of(context).textTheme.headline6,
            controller: _nameController,
            onSaved: (String value) => _adminCredentials['name'] = value,
            textInputAction: TextInputAction.done,
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
