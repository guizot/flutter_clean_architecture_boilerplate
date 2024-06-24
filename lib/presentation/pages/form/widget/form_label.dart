import 'package:flutter/material.dart';
import '../model/form_item.dart';

class FormLabel extends StatefulWidget {
  final FormItem item;
  const FormLabel({super.key, required this.item});

  @override
  State<FormLabel> createState() => _FormLabelState();
}

class _FormLabelState extends State<FormLabel> {

  @override
  Widget build(BuildContext context) {
    return widget.item.label != "" ? Column(
      crossAxisAlignment: CrossAxisAlignment.start,
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
                text: widget.item.disabled ? "" : widget.item.required ? " *" : " (Optional)",
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: widget.item.disabled ? 14 : widget.item.required ? 18 : 14,
                    color: widget.item.disabled ? Colors.grey : widget.item.required ? Colors.red : Colors.grey
                ),
              )
            ],
          ),
        ),
        const SizedBox(height: 8),
      ],
    ) : Container();
  }

}