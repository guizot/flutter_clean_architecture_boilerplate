import 'package:flutter/material.dart';
import 'package:flutter_clean_architecture/presentation/core/extension/color_extension.dart';
import 'package:flutter_clean_architecture/presentation/pages/form/model/form_content.dart';
import 'package:flutter_clean_architecture/presentation/pages/form/model/form_item.dart';
import 'package:flutter_clean_architecture/presentation/pages/form/service/form_controller.dart';
import 'package:flutter_clean_architecture/presentation/pages/form/widget/form_error_message.dart';
import '../service/form_validation.dart';
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

  final TextEditingController controller = TextEditingController();

  @override
  void initState() {
    getValue();
    setController();
    super.initState();
  }

  String getValue() {
    if(widget.item.value is String && (widget.item.value != null && widget.item.value != "")) {
      bool containValue = widget.item.content.any((item) => item.value == widget.item.value);
      if(containValue) {
        controller.text = widget.item.value;
        return widget.item.value;
      } else {
        controller.text = "";
        widget.item.value = "";
        return "";
      }
    } else {
      controller.text = "";
      widget.item.value = "";
      return "";
    }
  }

  void setValue(String value) {
    setState(() {
      widget.item.value = value;
      widget.item.error = false;
      controller.text = value;
    });
    setController();
  }

  void clearValue() {
    setState(() {
      widget.item.value = "";
      widget.item.error = false;
      controller.clear();
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
            child: Row(
              children: [
                Flexible(
                  child: DropdownMenu<String>(
                    controller: controller,
                    initialSelection: getValue(),
                    expandedInsets: const EdgeInsets.all(0.0),
                    hintText: "Select here...",
                    requestFocusOnTap: false,
                    enableFilter: false,
                    enableSearch: false,
                    menuStyle: MenuStyle(
                      surfaceTintColor: WidgetStatePropertyAll(
                          Theme.of(context).colorScheme.surface
                      ),
                      padding: const WidgetStatePropertyAll(
                          EdgeInsets.symmetric(vertical: 8.0, horizontal: 8.0)
                      ),
                      shape: const WidgetStatePropertyAll(
                          RoundedRectangleBorder(
                              borderRadius: BorderRadius.all(
                                  Radius.circular(16.0)
                              ),
                              side: BorderSide(color: Colors.grey)
                          )
                      ),
                      // elevation: const MaterialStatePropertyAll(0)
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
                    enabled: !widget.item.disabled,
                    dropdownMenuEntries: widget.item.content.map<DropdownMenuEntry<String>>((FormContent content) {
                      return DropdownMenuEntry<String>(
                        value: content.value,
                        label: content.label,
                        style: const ButtonStyle(
                          textStyle: WidgetStatePropertyAll(
                              TextStyle(
                                  fontSize: 16.0
                              )
                          ),
                          padding: WidgetStatePropertyAll(
                              EdgeInsets.symmetric(vertical: 16.0, horizontal: 8.0)
                          ),
                        ),
                      );
                    }).toList(),
                  ),
                ),
                (
                  !FormValidation().checkFormItem(widget.item) && !widget.item.disabled
                    ? GestureDetector(
                        onTap: clearValue,
                        child: const Padding(
                            padding: EdgeInsets.only(right: 16.0),
                            child: Icon(Icons.close_rounded)
                        ),
                      )
                    : Container()
                )
              ],
            )
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