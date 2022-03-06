import 'package:efficacy_admin/themes/appcolor.dart';
import 'package:flutter/material.dart';
import 'package:date_time_picker/date_time_picker.dart';

class DateTimeForm extends StatefulWidget {
  const DateTimeForm({Key? key}) : super(key: key);

  @override
  _DateTimeFormState createState() => _DateTimeFormState();
}

class _DateTimeFormState extends State<DateTimeForm> {
  @override
  Widget build(BuildContext context) {
    // return TextFormField(
    //   decoration: InputDecoration(
    //     suffixIcon:
    //         Icon(Icons.calendar_today_outlined, color: AppColorLight.primary),
    //     enabledBorder: OutlineInputBorder(
    //       borderSide: BorderSide(color: AppColorLight.outline, width: 2.0),
    //     ),
    //     focusedBorder: OutlineInputBorder(
    //       borderSide:
    //           BorderSide(color: Theme.of(context).primaryColor, width: 2.0),
    //     ),
    //     labelText: 'DD/MM/YYYY-HH:mm:ss',
    //     labelStyle: TextStyle(color: AppColorLight.outline),
    //   ),
    // );
    return DateTimePicker(
      type: DateTimePickerType.dateTimeSeparate,
      use24HourFormat: false,
      dateMask: 'd MMM, yyyy',
      initialValue: DateTime.now().toString(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
      icon: Icon(Icons.calendar_today_outlined, color: AppColorLight.primary),
      dateLabelText: 'Date',
      timeLabelText: "Time",
      style: TextStyle(color: AppColorLight.outline),
      onChanged: (val) => print(val),
      validator: (val) {
        print(val);
        return null;
      },
      onSaved: (val) => print(val),
    );
  }
}
