import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_clean_architecture/presentation/core/extension/color_extension.dart';
import 'package:flutter_clean_architecture/presentation/pages/form/model/form_item.dart';
import 'package:intl/intl.dart';

class FormDatePicker extends StatefulWidget {
  final FormItem item;
  const FormDatePicker({super.key, required this.item});

  @override
  State<FormDatePicker> createState() => _FormDatePickerState();
}

class _FormDatePickerState extends State<FormDatePicker> {

  @override
  void initState() {
    getValue();
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
              border: Border.all(color: widget.item.error ? Colors.red : Colors.grey),
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
        (
          widget.item.error
            ? Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                const SizedBox(height: 4.0),
                Text(
                    "${widget.item.label} can not be empty",
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      color: Colors.red,
                      fontWeight: FontWeight.normal,
                      fontSize: 12,
                    )
                ),
                const SizedBox(height: 4.0),
              ],
          )
            : const SizedBox(height: 8.0)
        ),
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
              onPressed: () async {
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
        ),
        const SizedBox(height: 16.0),
      ],
    );
  }

}