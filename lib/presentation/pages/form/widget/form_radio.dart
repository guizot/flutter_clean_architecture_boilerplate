import 'package:flutter/material.dart';
import 'package:flutter_clean_architecture/presentation/pages/form/model/form_item.dart';
import '../service/form_controller.dart';
import 'form_error_message.dart';
import 'form_label.dart';
import 'form_unknown.dart';
import 'form_value.dart';

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
                          title: Text(item.label),
                          value: item.value,
                          groupValue: widget.item.value,
                          onChanged: widget.item.disabled ? null : (value) => setValue(value.toString()),
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