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
      case '07':
        /// e.g. value: ['Germany', 'Switzerland']
        return FormCheckBox(item: item);
      case '08':
        /// e.g. value: "London"
        return FormDropDown(item: item);
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
