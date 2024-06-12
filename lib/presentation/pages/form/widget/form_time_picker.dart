import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_clean_architecture/presentation/core/extension/color_extension.dart';
import 'package:flutter_clean_architecture/presentation/pages/form/model/form_item.dart';
import 'package:intl/intl.dart';

class FormTimePicker extends StatefulWidget {
  final FormItem item;
  const FormTimePicker({super.key, required this.item});

  @override
  State<FormTimePicker> createState() => _FormTimePickerState();
}

class _FormTimePickerState extends State<FormTimePicker> {

  @override
  void initState() {
    Platform.isIOS ? getValueIos() : getValueAndroid();
    super.initState();
  }

  TimeOfDay getValueAndroid() {
    if(widget.item.value != null && widget.item.value != "") {
      try {
        List<String> parts = widget.item.value.split(':');
        int hour = int.parse(parts[0]);
        int minute = int.parse(parts[1]);
        return TimeOfDay(hour: hour, minute: minute);
      } catch (e) {
        setValue("No Time");
        return TimeOfDay.now();
      }
    } else {
      setValue("No Time");
      return TimeOfDay.now();
    }
  }

  DateTime getValueIos() {
    if(widget.item.value != null && widget.item.value != "") {
      try {
        List<String> parts = widget.item.value.split(':');
        int hour = int.parse(parts[0]);
        int minute = int.parse(parts[1]);
        return DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day, hour, minute);
      } catch (e) {
        widget.item.value = "No Time";
        return DateTime.now();
      }
    } else {
      widget.item.value = "No Time";
      return DateTime.now();
    }
  }

  void setValue(String value) {
    setState(() {
      widget.item.value = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(
          widget.item.label,
          style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 18
          ),
        ),
        const SizedBox(height: 8),
        Container(
            width: double.infinity,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: Colors.grey),
            ),
            child: ClipRRect(
                borderRadius: BorderRadius.circular(16.0),
                child: Container(
                  color: Theme.of(context).hintColor.toMaterialColor().shade50,
                  padding: const EdgeInsets.all(16),
                  child: Text(
                      widget.item.value,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Theme.of(context).colorScheme.inverseSurface,
                        fontWeight: FontWeight.normal,
                        fontSize: 16,
                      )
                  ),
                )
            )
        ),
        const SizedBox(height: 8.0),
        (
          Platform.isIOS
              ? ElevatedButton(
                onPressed: () async {
                  showModalBottomSheet(
                    context: context,
                    builder: (BuildContext builder) {
                      return SizedBox(
                        height: MediaQuery.of(context).size.height / 3,
                        child: CupertinoDatePicker(
                          mode: CupertinoDatePickerMode.time,
                          initialDateTime: getValueIos(),
                          onDateTimeChanged: (DateTime newTime) {
                            String formattedTime = DateFormat('HH:mm').format(newTime);
                            setValue(formattedTime);
                          },
                        ),
                      );
                    },
                  );
                },
                style: ButtonStyle(
                  elevation: const MaterialStatePropertyAll(0.0),
                  shape: MaterialStatePropertyAll(
                      RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16),
                          side: const BorderSide(
                            width: 1.0,
                            color: Colors.grey,
                          )
                      )
                  ),
                ),
                child: Text(
                    "Select Time",
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.inverseSurface,
                      fontWeight: FontWeight.normal,
                      fontSize: 16,
                    )
                ),
              )
              : ElevatedButton(
                onPressed: () async {
                  final TimeOfDay? picked = await showTimePicker(
                    context: context,
                    initialTime: getValueAndroid(),
                  );
                  if(picked != null) {
                    String formattedTime = '${picked.hour.toString().padLeft(2, '0')}:${picked.minute.toString().padLeft(2, '0')}';
                    setValue(formattedTime);
                  }
                },
                style: ButtonStyle(
                  elevation: const MaterialStatePropertyAll(0.0),
                  shape: MaterialStatePropertyAll(
                      RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16),
                          side: const BorderSide(
                            width: 1.0,
                            color: Colors.grey,
                          )
                      )
                  ),
                ),
                child: Text(
                    "Select Time",
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.inverseSurface,
                      fontWeight: FontWeight.normal,
                      fontSize: 16,
                    )
                ),
              )
        ),
        const SizedBox(height: 16.0),
      ],
    );
  }

}