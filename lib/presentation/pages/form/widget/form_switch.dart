import 'package:flutter/material.dart';
import 'package:flutter_clean_architecture/presentation/core/extension/color_extension.dart';
import 'package:flutter_clean_architecture/presentation/pages/form/model/form_item.dart';

import '../service/form_controller.dart';
import 'form_error_message.dart';
import 'form_label.dart';
import 'form_unknown.dart';

class FormSwitch extends StatefulWidget {
  final FormItem item;
  final FormController? controller;
  const FormSwitch({super.key, required this.item, this.controller});

  @override
  State<FormSwitch> createState() => _FormSwitchState();
}

class _FormSwitchState extends State<FormSwitch> {

  @override
  void initState() {
    getValue();
    setController();
    super.initState();
  }

  bool getValue() {
    if(widget.item.value is bool) {
      return widget.item.value;
    } else {
      return false;
    }
  }

  void setValue(bool value) {
    setState(() {
      widget.item.value = value;
      widget.item.error = false;
    });
    setController();
  }

  dynamic getContentValue(String key) {
    Map<String, dynamic>? foundItem = widget.item.content.firstWhere((item) => item['label'] == key);
    return foundItem['value'];
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
                height: 56,
                color: Theme.of(context).hintColor.toMaterialColor().shade50,
                padding: const EdgeInsets.all(16),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Expanded(
                      child: Text(
                        getValue() ? getContentValue('positive') : getContentValue('negative'),
                        textAlign: TextAlign.start,
                        style: TextStyle(
                          color: Theme.of(context).colorScheme.inverseSurface,
                          fontWeight: FontWeight.normal,
                          fontSize: 16,
                        ),
                      ),
                    ),
                    Switch(
                      value: getValue(),
                      onChanged: (value) {
                        setValue(value);
                      },
                    ),
                  ],
                ),
              ),
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