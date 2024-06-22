import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_clean_architecture/presentation/pages/form/model/form_item.dart';
import 'package:flutter_clean_architecture/presentation/pages/form/service/form_controller.dart';
import 'package:flutter_clean_architecture/presentation/pages/form/widget/form_error_message.dart';
import 'package:flutter_clean_architecture/presentation/pages/form/widget/form_value.dart';
import 'package:intl/intl.dart';

import '../../../core/utils/platform_utils.dart';
import 'form_label.dart';
import 'form_unknown.dart';

class FormDatePicker extends StatefulWidget {
  final FormItem item;
  final FormController? controller;
  const FormDatePicker({super.key, required this.item, this.controller});

  @override
  State<FormDatePicker> createState() => _FormDatePickerState();
}

class _FormDatePickerState extends State<FormDatePicker> {

  @override
  void initState() {
    getValue();
    setController();
    super.initState();
  }

  DateTime getValue() {
    if(widget.item.value != null && widget.item.value != "") {
      try {
        return DateTime.parse(widget.item.value);
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
                      final DateTime? picked = await showDatePicker(
                          context: context,
                          initialDate: getValue(),
                          firstDate: DateTime(2000),
                          lastDate: DateTime(2025),
                      );
                      if(picked != null) {
                        String formattedDate = DateFormat('yyyy-MM-dd').format(picked);
                        setValue(formattedDate);
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
                        "Select Date",
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
                                  mode: CupertinoDatePickerMode.date,
                                  initialDateTime: getValue(),
                                  onDateTimeChanged: (DateTime newDate) {
                                    String formattedDate = DateFormat('yyyy-MM-dd').format(newDate);
                                    setValue(formattedDate);
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
                            "Select Date",
                            style: TextStyle(
                              color: Theme.of(context).colorScheme.inverseSurface,
                              fontWeight: FontWeight.normal,
                              fontSize: 16,
                            )
                        ),
                      )
                    : ElevatedButton(
                        onPressed: widget.item.disabled ? null : () async {
                          final DateTime? picked = await showDatePicker(
                              context: context,
                              initialDate: getValue(),
                              firstDate: DateTime(2000),
                              lastDate: DateTime(2025)
                          );
                          if(picked != null) {
                            String formattedDate = DateFormat('yyyy-MM-dd').format(picked);
                            setValue(formattedDate);
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
                            "Select Date",
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