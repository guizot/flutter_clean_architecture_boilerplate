import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_clean_architecture/presentation/core/utils/platform_utils.dart';
import 'package:flutter_clean_architecture/presentation/pages/form/model/form_item.dart';
import 'package:intl/intl.dart';
import '../service/form_controller.dart';
import 'form_error_message.dart';
import 'form_label.dart';
import 'form_unknown.dart';
import 'form_value.dart';

class FormTimePicker extends StatefulWidget {
  final FormItem item;
  final FormController? controller;
  const FormTimePicker({super.key, required this.item, this.controller});

  @override
  State<FormTimePicker> createState() => _FormTimePickerState();
}

class _FormTimePickerState extends State<FormTimePicker> {

  @override
  void initState() {
    if(PlatformUtils.isWeb) {
      getValueAndroid();
    } else if (PlatformUtils.isMobile) {
      Platform.isIOS ? getValueIos() : getValueAndroid();
    }
    setController();
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
        widget.item.value = "No Data";
        return TimeOfDay.now();
      }
    } else {
      widget.item.value = "No Data";
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
        widget.item.value = "No Data";
        return DateTime.now();
      }
    } else {
      widget.item.value = "No Data";
      return DateTime.now();
    }
  }

  void setValue(String value) {
    setState(() {
      widget.item.value = value;
      widget.item.error = false;
    });
    setController();
  }

  void clearValue() {
    setState(() {
      widget.item.value = "No Data";
      widget.item.error = false;
    });
    setController();
  }

  void setController() {
    widget.controller?.item = widget.item;
  }

  @override
  Widget build(BuildContext context) {
    try {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          FormLabel(item: widget.item),
          FormValue(
            item: widget.item,
            value: widget.item.value,
            onClear: clearValue
          ),
          FormErrorMessage(item: widget.item),
          (
              PlatformUtils.isWeb
                  ? ElevatedButton(
                      onPressed: widget.item.disabled ? null : () async {
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
                        elevation: const WidgetStatePropertyAll(0.0),
                        shape: WidgetStatePropertyAll(
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
                  : (
                  Platform.isIOS
                      ? ElevatedButton(
                          onPressed: widget.item.disabled ? null : () async {
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
                            elevation: const WidgetStatePropertyAll(0.0),
                            shape: WidgetStatePropertyAll(
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
                          onPressed: widget.item.disabled ? null : () async {
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
                            elevation: const WidgetStatePropertyAll(0.0),
                            shape: WidgetStatePropertyAll(
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
              )
          ),
          const SizedBox(height: 16.0),
        ],
      );
    } catch (e) {
      return FormUnknown(
          label: widget.item.label,
          message: e.toString()
      );
    }
  }

}