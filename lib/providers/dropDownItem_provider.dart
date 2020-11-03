import 'package:flutter/foundation.dart';

import 'package:flutter/widgets.dart';


class DropdownItems with ChangeNotifier{
  List<String>_clubList=['Select Club','DSC','CES','MES'];

  List<String> get clubList{
    return [..._clubList];
  }

   List<String>_branchList=['Select Branch','CE','CSE','ECE','EE','E&I','ME',];

  List<String> get branchList{
    return [..._branchList];
  }
}