import 'package:flutter/material.dart';
import 'package:efficacy_admin/themes/appcolor.dart';

class FormWidget extends StatelessWidget {
    TextEditingController controller;
  String text;
  IconData icons;
  int? line;
  FormWidget({Key? key, required this.text, required this.icons, this.line,required this.controller})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      maxLines: line ?? 1,
      controller: controller,
      decoration: InputDecoration(
        prefixIcon: Icon(
          icons,
          color: AppColorLight.outline,
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: AppColorLight.outline, width: 2.0),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide:
              BorderSide(color: Theme.of(context).primaryColor, width: 2.0),
        ),
        labelText: text,
        labelStyle: TextStyle(color: AppColorLight.outline),
      ),
    );
  }
}
