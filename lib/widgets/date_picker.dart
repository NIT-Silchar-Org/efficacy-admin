import 'package:efficacy_admin/themes/appcolor.dart';
import 'package:flutter/material.dart';
import 'package:date_time_picker/date_time_picker.dart';

class DateTimeForm extends StatefulWidget {
  final ValueChanged<String> onValueChanged;
  String? initialDate;
  DateTimeForm({Key? key, required this.onValueChanged, this.initialDate})
      : super(key: key);

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
      initialValue: widget.initialDate ?? DateTime.now().toString(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
      icon: Icon(Icons.calendar_today_outlined, color: AppColorLight.primary),
      dateLabelText: 'Date',
      timeLabelText: "Time",
      style: TextStyle(color: AppColorLight.outline),
      validator: (val) {
        if (val!.isEmpty) {
          return 'Required';
        }
        return null;
      },
      onSaved: (val) => widget.onValueChanged(val!),
    );
  }
}
