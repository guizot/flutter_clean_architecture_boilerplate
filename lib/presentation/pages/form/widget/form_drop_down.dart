import 'package:flutter/material.dart';
import 'package:flutter_clean_architecture/presentation/core/extension/color_extension.dart';
import 'package:flutter_clean_architecture/presentation/pages/form/model/form_item.dart';
import 'package:flutter_clean_architecture/presentation/pages/form/service/form_controller.dart';
import 'package:flutter_clean_architecture/presentation/pages/form/widget/form_error_message.dart';
import 'form_label.dart';
import 'form_unknown.dart';

class FormDropDown extends StatefulWidget {
  final FormItem item;
  final FormController? controller;
  const FormDropDown({super.key, required this.item, this.controller});

  @override
  State<FormDropDown> createState() => _FormDropDownState();
}

class _FormDropDownState extends State<FormDropDown> {

  @override
  void initState() {
    getValue();
    setController();
    super.initState();
  }

  String getValue() {
    if(widget.item.value is String && (widget.item.value != null && widget.item.value != "")) {
      bool containValue = widget.item.content.any((item) => item['value'] == widget.item.value);
      if(containValue) {
        return widget.item.value;
      } else {
        widget.item.value = "";
        return "";
      }
    } else {
      widget.item.value = "";
      return "";
    }
  }

  void setValue(String value) {
    setState(() {
      widget.item.value = value;
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
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: widget.item.error ? Colors.red : Colors.grey),
              color: Theme.of(context).hintColor.toMaterialColor().shade50,
            ),
            child: DropdownMenu<String>(
              initialSelection: getValue(),
              expandedInsets: const EdgeInsets.all(0.0),
              hintText: "Select here...",
              requestFocusOnTap: false,
              enableFilter: false,
              enableSearch: false,
              menuStyle: MenuStyle(
                surfaceTintColor: MaterialStatePropertyAll(
                    Theme.of(context).colorScheme.background
                ),
                padding: const MaterialStatePropertyAll(
                    EdgeInsets.symmetric(vertical: 8.0, horizontal: 8.0)
                ),
                shape: const MaterialStatePropertyAll(
                    RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(
                            Radius.circular(16.0)
                        ),
                        side: BorderSide(color: Colors.grey)
                    )
                ),
              ),
              inputDecorationTheme: InputDecorationTheme(
                isDense: true,
                border: InputBorder.none,
                contentPadding: const EdgeInsets.all(16.0),
                hintStyle: TextStyle(
                    color: Theme.of(context).hintColor.toMaterialColor().shade100
                ),
              ),
              onSelected: (String? value) {
                setValue(value ?? "");
              },
              dropdownMenuEntries: widget.item.content.map<DropdownMenuEntry<String>>((dynamic content) {
                return DropdownMenuEntry<String>(
                    value: content['value'],
                    label: content['label'],
                    style: const ButtonStyle(
                      textStyle: MaterialStatePropertyAll(
                        TextStyle(
                          fontSize: 16.0
                        )
                      ),
                      padding: MaterialStatePropertyAll(
                        EdgeInsets.symmetric(vertical: 16.0, horizontal: 8.0)
                      ),
                  ),
                );
              }).toList(),
            ),
          ),
          FormErrorMessage(item: widget.item),
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