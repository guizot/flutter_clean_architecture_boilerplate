import 'package:flutter/material.dart';
import 'package:flutter_clean_architecture/presentation/core/extension/color_extension.dart';
import 'package:flutter_clean_architecture/presentation/pages/form/model/form_item.dart';
import 'package:flutter_clean_architecture/presentation/pages/form/widget/form_unknown.dart';

import 'form_error_message.dart';
import 'form_label.dart';

class FormSlider extends StatefulWidget {
  final FormItem item;
  const FormSlider({super.key, required this.item});

  @override
  State<FormSlider> createState() => _FormSliderState();
}

class _FormSliderState extends State<FormSlider> {

  @override
  void initState() {
    getValue();
    super.initState();
  }

  double getValue() {
    if(widget.item.content.isNotEmpty) {
      if(
          widget.item.value is double ||
          widget.item.value is int
      ) {
        if(
            widget.item.value < getContentValue('min') ||
            widget.item.value > getContentValue('max')
        ) {
          double minValue = getContentValue('min');
          widget.item.value = minValue;
          return minValue;
        } else {
          return widget.item.value.toDouble();
        }
      } else {
        double minValue = getContentValue('min');
        widget.item.value = minValue;
        return minValue;
      }
    } else {
      widget.item.value = 0.0;
      return 0.0;
    }
  }

  void setValue(int value) {
    setState(() {
      widget.item.value = value;
      widget.item.error = false;
    });
  }

  dynamic getContentValue(String key) {
    Map<String, dynamic>? foundItem = widget.item.content.firstWhere((item) => item['label'] == key);
    return foundItem['value'];
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
                        getValue().round().toString(),
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
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16),
              border: Border.all(
                color: Colors.grey, // Border color
                width: 1.0, // Border width
              ),
            ),
            child: Slider(
              value: getValue(),
              label: getValue().round().toString(),
              min: getContentValue('min'),
              max: getContentValue('max'),
              divisions: getContentValue('division'),
              onChanged: (double value) {
                setValue(value.round());
              },
            ),
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