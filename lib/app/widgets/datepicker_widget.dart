import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../helpers/kcolors.dart';

class DatePickerWidget extends StatelessWidget {

  late Icon icon;
  late String? hint;
  late TextEditingController controller;
  late String? Function(DateTime?)? func;
  DateTime? firstDate;
  DateTime? initialDate;
  DateTime? lastDate;
  DateFormat? format;
  bool time;

  DatePickerWidget({
    required this.icon,
    required this.hint,
    required this.controller,
    required this.func,
    this.firstDate,
    this.initialDate,
    this.lastDate,
    this.format,
    this.time = true
});


  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      child: DateTimeField(
        format: format??DateFormat("dd.MM.yyyy HH:mm"),
        decoration: InputDecoration(
            border: InputBorder.none,
            hintStyle: const TextStyle(fontSize: 18, color: Colors.black),
            hintText: hint,
            focusedBorder: OutlineInputBorder(
                borderSide:
                const BorderSide(color: Colors.transparent, width: 3),
                borderRadius: BorderRadius.circular(20)),
            enabledBorder: OutlineInputBorder(
                borderSide:
                const BorderSide(color: Colors.transparent, width: 1),
                borderRadius: BorderRadius.circular(20)),
            errorBorder: OutlineInputBorder(
                borderSide: const BorderSide(color: Colors.red, width: 1),
                borderRadius: BorderRadius.circular(20)),
            filled: true,
            fillColor: KColors.kLightGray,
            prefixIcon: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: IconTheme(
                data: const IconThemeData(color: KColors.kMiddleBlue),
                child: icon,
              ),
            )),
        controller: controller,
        validator: func,
        onShowPicker: (context, currentValue) async {
          final date = await showDatePicker(
              context: context,
              firstDate: firstDate??DateTime.now(),
              initialDate: initialDate??DateTime.now(),
              lastDate: lastDate??DateTime.now().add(Duration(days: 31))
          );
          if (date != null && time) {
            final time = await showTimePicker(
                context: context,
                initialTime: TimeOfDay.now(),
                builder: (context, childWidget) {
                  return MediaQuery(
                      data: MediaQuery.of(context)
                          .copyWith(alwaysUse24HourFormat: true),
                      child: childWidget!);
                });
            return DateTimeField.combine(date, time);
          } else {
            return date;
          }
        },
      ),
    );
  }
}
