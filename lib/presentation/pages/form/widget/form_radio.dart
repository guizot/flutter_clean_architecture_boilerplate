import 'package:flutter/material.dart';
import 'package:flutter_clean_architecture/presentation/core/extension/color_extension.dart';
import 'package:flutter_clean_architecture/presentation/pages/form/model/form_item.dart';

class FormRadio extends StatefulWidget {
  final FormItem item;
  const FormRadio({super.key, required this.item});

  @override
  State<FormRadio> createState() => _FormRadioState();
}

class _FormRadioState extends State<FormRadio> {

  @override
  void initState() {
    initValue();
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
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        RichText(
          text: TextSpan(
            children: [
              TextSpan(
                text: widget.item.label,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                  color: Theme.of(context).textTheme.bodyLarge?.color
                ),
              ),
              TextSpan(
                text: widget.item.required ? " *" : " (Optional)",
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: widget.item.required ? 18 : 14,
                    color: widget.item.required ? Colors.red : Colors.grey
                ),
              )
            ],
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
                        textAlign: TextAlign.start,
                        style: const TextStyle(
                          color: Colors.red,
                          fontWeight: FontWeight.normal,
                          fontSize: 12,
                        )
                    ),
                    const SizedBox(height: 8.0),
                  ],
                )
              : const SizedBox(height: 12.0)
        ),
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
  }

}