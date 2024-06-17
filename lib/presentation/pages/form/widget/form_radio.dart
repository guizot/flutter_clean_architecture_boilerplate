import 'package:flutter/material.dart';
import 'package:flutter_clean_architecture/presentation/core/extension/color_extension.dart';
import 'package:flutter_clean_architecture/presentation/pages/form/model/form_item.dart';

import '../service/form_controller.dart';
import 'form_error_message.dart';
import 'form_label.dart';
import 'form_unknown.dart';

class FormRadio extends StatefulWidget {
  final FormItem item;
  final FormController? controller;
  const FormRadio({super.key, required this.item, this.controller});

  @override
  State<FormRadio> createState() => _FormRadioState();
}

class _FormRadioState extends State<FormRadio> {

  @override
  void initState() {
    initValue();
    setController();
    super.initState();
  }

  void initValue() {
    if(widget.item.value == null || widget.item.value == "") {
      widget.item.value = "No Data";
    }
  }

  void setValue(String value) {
    setState(() {
      widget.item.value = value;
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
          FormErrorMessage(item: widget.item),
          Column(
              children: widget.item.content.map((item) => (
                  Column(
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(16),
                          border: Border.all(
                            color: Colors.grey,
                            width: 1.0,
                          ),
                        ),
                        child: RadioListTile<String>(
                          title: Text(item['label']!),
                          value: item['value']!,
                          groupValue: widget.item.value,
                          onChanged: (value) => setValue(value.toString()),
                        ),
                      ),
                      const SizedBox(height: 8.0),
                    ],
                  )
              )).toList()
          ),
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