import 'package:flutter/material.dart';
import 'package:flutter_clean_architecture/presentation/core/extension/color_extension.dart';
import 'package:flutter_clean_architecture/presentation/pages/form/model/form_item.dart';
import 'package:flutter_clean_architecture/presentation/pages/form/service/form_validation.dart';

class FormValue extends StatefulWidget {
  final FormItem item;
  final String value;
  final VoidCallback onClear;
  const FormValue({super.key, required this.item, required this.value, required this.onClear});

  @override
  State<FormValue> createState() => _FormValueState();
}

class _FormValueState extends State<FormValue> {

  @override
  Widget build(BuildContext context) {
    return Container(
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
              child: Row(
                children: [
                  Expanded(
                    child: Text(
                        widget.value,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Theme.of(context).colorScheme.inverseSurface,
                          fontWeight: FontWeight.normal,
                          fontSize: 16,
                        )
                    ),
                  ),
                  (
                    !FormValidation().checkFormItem(widget.item) && !widget.item.disabled
                      ? GestureDetector(
                          onTap: widget.onClear,
                          child: const Icon(Icons.close_rounded),
                        )
                      : Container()
                  )
                ],
              ),
            )
        )
    );
  }

}