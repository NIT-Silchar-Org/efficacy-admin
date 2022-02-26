import 'package:efficacy_admin/themes/appcolor.dart';
import 'package:flutter/material.dart';

class DateTimePicker extends StatefulWidget {
  const DateTimePicker({Key? key}) : super(key: key);

  @override
  _DateTimePickerState createState() => _DateTimePickerState();
}

class _DateTimePickerState extends State<DateTimePicker> {
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      decoration: InputDecoration(
        suffixIcon:
            Icon(Icons.calendar_today_outlined, color: AppColorLight.primary),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: AppColorLight.outline, width: 2.0),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide:
              BorderSide(color: Theme.of(context).primaryColor, width: 2.0),
        ),
        labelText: 'DD/MM/YYYY-HH:mm:ss',
        labelStyle: TextStyle(color: AppColorLight.outline),
      ),
    );
  }
}
