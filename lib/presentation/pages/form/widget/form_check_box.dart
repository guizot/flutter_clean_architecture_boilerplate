import 'package:flutter/material.dart';
import 'package:flutter_clean_architecture/presentation/core/extension/color_extension.dart';
import 'package:flutter_clean_architecture/presentation/core/extension/list_extension.dart';
import 'package:flutter_clean_architecture/presentation/pages/form/model/form_item.dart';

import '../service/form_controller.dart';
import 'form_error_message.dart';
import 'form_label.dart';
import 'form_unknown.dart';

class FormCheckBox extends StatefulWidget {
  final FormItem item;
  final FormController? controller;
  const FormCheckBox({super.key, required this.item, this.controller});

  @override
  State<FormCheckBox> createState() => _FormCheckBoxState();
}

class _FormCheckBoxState extends State<FormCheckBox> {

  @override
  void initState() {
    getValue();
    setController();
    super.initState();
  }

  void getValue() {
    if(widget.item.value is List && widget.item.value.isNotEmpty) {
      for (var item in widget.item.content) {
        if (widget.item.value.contains(item['label'])) {
          setState(() {
            item['value'] = true;
          });
        }
      }
    } else {
      widget.item.value = "No Data";
    }
  }

  void setValue(Map<String,dynamic> item, bool? value) {
    setState(() {
      item['value'] = value;
      List<String> list = widget.item.content
          .where((item) => item['value'] == true)
          .map((item) => item['label'] as String)
          .toList();
      widget.item.value = list.isNotEmpty ? list : "No Data";
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
                        (widget.item.value is List) ? widget.item.value.join(', ') : widget.item.value,
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
              children: widget.item.content.mapIndexed((index, item) => (
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
                        child: CheckboxListTile(
                          title: Text(item['label']),
                          value: item['value'],
                          controlAffinity: ListTileControlAffinity.leading,
                          onChanged: (value) {
                            setValue(item, value);
                          },
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