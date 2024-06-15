import 'package:flutter/material.dart';
import 'package:flutter_clean_architecture/presentation/pages/form/model/form_answer.dart';
import 'package:flutter_clean_architecture/presentation/pages/form/widget/form_button.dart';
import 'package:flutter_clean_architecture/presentation/pages/form/widget/form_date_picker.dart';
import 'package:flutter_clean_architecture/presentation/pages/form/widget/form_radio.dart';
import 'package:flutter_clean_architecture/presentation/pages/form/widget/form_slider.dart';
import 'package:flutter_clean_architecture/presentation/pages/form/widget/form_switch.dart';
import 'package:flutter_clean_architecture/presentation/pages/form/widget/form_text_field.dart';
import '../model/form_item.dart';
import '../widget/form_time_picker.dart';
import '../widget/form_unknown.dart';

class FormDesigner extends StatefulWidget {
  final List<FormItem> items;
  final Function(List<FormAnswer>) onSubmit;

  const FormDesigner({
    Key? key,
    required this.items,
    required this.onSubmit,
  }) : super(key: key);

  @override
  _FormDesignerState createState() => _FormDesignerState();
}

class _FormDesignerState extends State<FormDesigner> {

  bool validateForm() {
    bool isValid = true;
    for (var item in widget.items) {
      try {
        if (
            item.value == null ||
            item.value == "" ||
            item.value == "No Data" ||
            item.value == false ||
            (item.type == '05' && item.value == item.content.elementAt(0)['value'])
        ) {
          if(item.required) {
            item.error = true;
            isValid = false;
          } else {
            item.error = false;
          }
        } else {
          item.error = false;
        }
      } catch(e) {
        item.error = true;
        isValid = false;
      }
    }
    return isValid;
  }

  Widget getItem(FormItem item) {
    switch (item.type) {
      case '01':
        /// e.g. value: "2024-06-15"
        return FormDatePicker(item: item);
      case '02':
        /// e.g. value: "13:15"
        return FormTimePicker(item: item);
      case '03':
        /// e.g. value: "Monday"
        return FormRadio(item: item);
      case '04':
        /// e.g. value: true
        return FormSwitch(item: item);
      case '05':
        /// e.g. value: 5
        return FormSlider(item: item);
      case '06':
        /// e.g. value: "Indonesia"
        return FormTextField(item: item);
      default:
        return const FormUnknown(
            label: "Unknown Type",
            message: "Unknown Type"
        );
    }
  }

  List<Widget> getForm() {

    List<Widget> widgets = widget.items.map<Widget>((item) {
      return getItem(item);
    }).toList();

    widgets.add(
      FormButton(
        onPressed: () {
          if (validateForm()) {
            List<FormAnswer> answers = widget.items.map((e) => FormAnswer(id: e.id, answer: e.value)).toList();
            widget.onSubmit(answers);
          } else {
            setState((){});
          }
        }
      )
    );

    return widgets;
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      clipBehavior: Clip.none,
      children: getForm(),
    );
  }

}
