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
    return Column(
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
      ],
    );
  }

}