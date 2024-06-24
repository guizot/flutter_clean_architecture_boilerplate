import 'package:flutter/material.dart';
import 'package:flutter_clean_architecture/presentation/pages/form/model/form_answer.dart';
import 'package:flutter_clean_architecture/presentation/pages/form/service/form_controller.dart';
import 'package:flutter_clean_architecture/presentation/pages/form/widget/form_button.dart';
import 'package:flutter_clean_architecture/presentation/pages/form/widget/form_check_box.dart';
import 'package:flutter_clean_architecture/presentation/pages/form/widget/form_date_picker.dart';
import 'package:flutter_clean_architecture/presentation/pages/form/widget/form_drop_down.dart';
import 'package:flutter_clean_architecture/presentation/pages/form/widget/form_radio.dart';
import 'package:flutter_clean_architecture/presentation/pages/form/widget/form_slider.dart';
import 'package:flutter_clean_architecture/presentation/pages/form/widget/form_switch.dart';
import 'package:flutter_clean_architecture/presentation/pages/form/widget/form_text_field.dart';
import '../model/form_item.dart';
import '../widget/form_time_picker.dart';
import '../widget/form_unknown.dart';
import 'form_validation.dart';
import 'form_values.dart';

class FormDesigner extends StatefulWidget {
  final List<FormItem> items;
  final Function(List<FormAnswer>) handleForm;
  final FormController? controller;

  const FormDesigner({
    Key? key,
    required this.items,
    required this.handleForm,
    this.controller,
  }) : super(key: key);

  @override
  FormDesignerState createState() => FormDesignerState();
}

class FormDesignerState extends State<FormDesigner> {

  @override
  void initState() {
    widget.controller?.callback = submitForm;
    super.initState();
  }

  void submitForm() {
    if (FormValidation().checkFormItems(widget.items)) {
      List<FormAnswer> answers = widget.items.map((e) => FormAnswer(id: e.id, answer: e.value)).toList();
      widget.handleForm(answers);
    } else {
      setState((){});
    }
  }

  Widget getItem(FormItem item) {
    switch (item.type) {
      case FormValues.datePicker:
        return FormDatePicker(item: item); /// e.g. value: "2024-06-15"
      case FormValues.timePicker:
        return FormTimePicker(item: item); /// e.g. value: "13:15"
      case FormValues.radio:
        return FormRadio(item: item); /// e.g. value: "Monday"
      case FormValues.switcher:
        return FormSwitch(item: item); /// e.g. value: true
      case FormValues.slider:
        return FormSlider(item: item); /// e.g. value: 5
      case FormValues.textField:
        return FormTextField(item: item); /// e.g. value: "Indonesia"
      case FormValues.checkBox:
        return FormCheckBox(item: item); /// e.g. value: ['Germany', 'Switzerland']
      case FormValues.dropDown:
        return FormDropDown(item: item); /// e.g. value: "London"
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

    if(widget.controller == null) {
      widgets.add(FormButton(onPressed: submitForm));
    }

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
