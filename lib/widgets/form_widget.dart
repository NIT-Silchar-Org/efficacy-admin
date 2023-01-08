import 'package:flutter/material.dart';
import 'package:efficacy_admin/themes/appcolor.dart';

class FormWidget extends StatelessWidget {
  final ValueChanged<String> onValueChanged;
  String text;
  IconData icons;
  int? line;
  String? initialValue;
  FormWidget(
      {Key? key,
      required this.text,
      required this.icons,
      this.line,
      this.initialValue,
      required this.onValueChanged})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      maxLines: line ?? 1,
      initialValue: initialValue ?? '',
      decoration: InputDecoration(
        prefixIcon: Icon(
          icons,
          color: AppColorLight.outline,
        ),
        border: OutlineInputBorder(
          borderSide: BorderSide(color: AppColorLight.outline, width: 2.0),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide:
              BorderSide(color: Theme.of(context).primaryColor, width: 2.0),
        ),
        // errorBorder: OutlineInputBorder(
        //   borderSide: BorderSide(color: AppColorLight.error, width: 2.0),
        // ),
        labelText: text,
        labelStyle: TextStyle(color: AppColorLight.outline),
      ),
      validator: (val) {
        if (val!.isEmpty) {
          return 'Required';
        } else {
          return null;
        }
      },
      onSaved: (e) {
        onValueChanged(e!);
      },
    );
  }
}
