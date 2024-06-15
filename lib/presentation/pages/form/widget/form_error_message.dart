import 'package:flutter/material.dart';
import '../model/form_item.dart';

class FormErrorMessage extends StatefulWidget {
  final FormItem item;
  const FormErrorMessage({super.key, required this.item});

  @override
  State<FormErrorMessage> createState() => _FormErrorMessageState();
}

class _FormErrorMessageState extends State<FormErrorMessage> {

  @override
  Widget build(BuildContext context) {
    return (
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
        : const SizedBox(height: 8.0)
    );
  }

}