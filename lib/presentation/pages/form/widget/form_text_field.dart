import 'package:flutter/material.dart';
import 'package:flutter_clean_architecture/presentation/core/extension/color_extension.dart';
import 'package:flutter_clean_architecture/presentation/pages/form/model/form_item.dart';
import 'package:flutter_clean_architecture/presentation/pages/form/service/form_validation.dart';
import '../service/form_controller.dart';
import 'form_error_message.dart';
import 'form_label.dart';
import 'form_unknown.dart';

class FormTextField extends StatefulWidget {
  final FormItem item;
  final FormController? controller;
  const FormTextField({super.key, required this.item, this.controller});

  @override
  State<FormTextField> createState() => _FormTextFieldState();
}

class _FormTextFieldState extends State<FormTextField> {

  final key = GlobalKey<FormFieldState>();
  String? emailValidationText;

  @override
  void initState() {
    getValue();
    setController();
    super.initState();
  }

  String getValue() {
    if(widget.item.value is String) {
      return widget.item.value;
    } else {
      return "";
    }
  }

  void setValue(String value) {
    setState(() {
      widget.item.value = value;
      if(isEmail()) {
        if(!key.currentState!.isValid) {
          emailValidationText = "Enter a valid email address";
          widget.item.error = true;
        } else {
          emailValidationText = null;
          widget.item.error = false;
        }
      } else {
        emailValidationText = null;
        widget.item.error = false;
      }
    });
    setController();
  }

  dynamic getContentValue(String key) {
    Map<String, dynamic>? foundItem = widget.item.content.firstWhere((item) => item['label'] == key);
    return foundItem['value'];
  }

  bool isPassword() {
    try {
      if(getContentValue('type') == 'password') {
        return true;
      } else {
        return false;
      }
    } catch(e) {
      return false;
    }
  }

  bool isEmail() {
    try {
      if(getContentValue('type') == 'email') {
        return true;
      } else {
        return false;
      }
    } catch(e) {
      return false;
    }
  }

  bool isNumber() {
    try {
      if(getContentValue('type') == 'number') {
        return true;
      } else {
        return false;
      }
    } catch(e) {
      return false;
    }
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
            child: TextFormField(
              readOnly: widget.item.disabled,
              initialValue: widget.item.value,
              keyboardType: isNumber() ? TextInputType.number : TextInputType.multiline,
              maxLines: isPassword() ? 1 : null,
              minLines: 1,
              decoration: InputDecoration(
                contentPadding: const EdgeInsets.all(16), // Padding inside the TextFormField
                border: InputBorder.none, // Remove the default underline
                hintText: "Enter text here...",
                hintStyle: TextStyle(
                  color: Theme.of(context).hintColor.toMaterialColor().shade100
                ),
                fillColor: Theme.of(context).hintColor.toMaterialColor().shade50,
                filled: true, // Fill the background color
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(16),
                  borderSide: const BorderSide(
                    color: Colors.transparent,
                  ),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(16),
                  borderSide: const BorderSide(
                    color: Colors.transparent,
                  ),
                ),
              ),
              onChanged: (value) {
                setValue(value);
              },
              key: key,
              validator: isEmail() ? FormValidation().checkIsEmail : null,
              obscureText: isPassword(),
            ),
          ),
          FormErrorMessage(item: widget.item, message: emailValidationText),
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