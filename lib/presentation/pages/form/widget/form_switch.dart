import 'package:flutter/material.dart';
import 'package:flutter_clean_architecture/presentation/core/extension/color_extension.dart';
import 'package:flutter_clean_architecture/presentation/pages/form/model/form_item.dart';

class FormSwitch extends StatefulWidget {
  final FormItem item;
  const FormSwitch({super.key, required this.item});

  @override
  State<FormSwitch> createState() => _FormSwitchState();
}

class _FormSwitchState extends State<FormSwitch> {

  @override
  void initState() {
    getValue();
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
              height: 56,
              color: Theme.of(context).hintColor.toMaterialColor().shade50,
              padding: const EdgeInsets.all(16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Expanded(
                    child: Text(
                      getValue() ? widget.item.content.first['label']! : widget.item.content.last['label']!,
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
              const SizedBox(height: 16.0),
            ],
          )
              : const SizedBox(height: 16.0)
        ),
      ],
    );
  }

}