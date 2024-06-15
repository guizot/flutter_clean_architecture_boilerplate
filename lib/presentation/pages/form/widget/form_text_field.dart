import 'package:flutter/material.dart';
import 'package:flutter_clean_architecture/presentation/core/extension/color_extension.dart';
import 'package:flutter_clean_architecture/presentation/pages/form/model/form_item.dart';

import 'form_error_message.dart';
import 'form_label.dart';
import 'form_unknown.dart';

class FormTextField extends StatefulWidget {
  final FormItem item;
  const FormTextField({super.key, required this.item});

  @override
  State<FormTextField> createState() => _FormTextFieldState();
}

class _FormTextFieldState extends State<FormTextField> {

  @override
  void initState() {
    getValue();
    super.initState();
  }

  String getValue() {
    if(widget.item.value is String) {
      return widget.item.value;
    } else {
      return "";
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
    try {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          FormLabel(item: widget.item),
          Container(
            width: double.infinity,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: widget.item.error ? Colors.red : Colors.grey),
            ),
            child: TextFormField(
              initialValue: widget.item.value,
              keyboardType: TextInputType.multiline,
              maxLines: null,
              minLines: 1,
              decoration: InputDecoration(
                contentPadding: const EdgeInsets.all(16), // Padding inside the TextFormField
                border: InputBorder.none, // Remove the default underline
                hintText: "Enter text here...",
                hintStyle: TextStyle(
                  color: Theme.of(context).hintColor.toMaterialColor().shade100
                ),
                fillColor: Theme.of(context).hintColor.toMaterialColor().shade50,
                filled: true, // Fill the background color
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(16),
                  borderSide: const BorderSide(
                    color: Colors.transparent,
                  ),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(16),
                  borderSide: const BorderSide(
                    color: Colors.transparent,
                  ),
                ),
              ),
              onChanged: (value) {
                setValue(value);
              },
            ),
          ),
          FormErrorMessage(item: widget.item),
          const SizedBox(height: 8.0),
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