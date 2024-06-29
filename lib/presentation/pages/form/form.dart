import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_clean_architecture/presentation/core/services/language_service.dart';
import 'package:flutter_clean_architecture/presentation/pages/form/model/form_content.dart';
import 'package:flutter_clean_architecture/presentation/pages/form/model/form_item.dart';
import 'package:flutter_clean_architecture/presentation/pages/form/service/form_controller.dart';
import 'package:flutter_clean_architecture/presentation/pages/form/service/form_designer.dart';
import 'package:flutter_clean_architecture/presentation/pages/form/service/form_values.dart';
import 'package:flutter_clean_architecture/presentation/pages/form/widget/form_button.dart';
import '../../core/handler/dialog_handler.dart';
import '../../core/mixins/logger_mixin.dart';
import '../../core/services/theme_service.dart';
import 'package:provider/provider.dart';
import '../../../injector.dart';
import 'cubit/form_cubit.dart';
import 'model/form_answer.dart';

class FormWrapperProvider extends StatelessWidget {
  const FormWrapperProvider({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => sl<FormCubit>(),
      child: const FormPage(title: "Form Designer"),
    );
  }
}

class FormPage extends StatefulWidget {
  const FormPage({super.key, required this.title});
  final String title;

  @override
  State<FormPage> createState() => _FormPageState();
}

class _FormPageState extends State<FormPage> with LoggerMixin {

  final List<FormItem> formList = [
    FormItem(
        id: "A0001",
        type: FormValues.datePicker,
        typeName: "Date Picker",
        label: "When will you go to Switzerland?",
        value: "",
        error: false,
        required: true,
        disabled: false,
        content: []
    ),
    FormItem(
        id: "A0002",
        type: FormValues.timePicker,
        typeName: "Time Picker",
        label: "What time did you sleep?",
        value: "",
        error: false,
        required: true,
        disabled: false,
        content: []
    ),
    FormItem(
        id: "A0003",
        type: FormValues.radio,
        typeName: "Radio Picker",
        label: "What day will you stay?",
        value: "",
        error: false,
        required: true,
        disabled: false,
        content: [
          FormContent(value: 'Monday', label: 'Monday'),
          FormContent(value: 'Tuesday', label: 'Tuesday'),
          FormContent(value: 'Wednesday', label: 'Wednesday')
        ]
    ),
    FormItem(
        id: "A0004",
        type: FormValues.switcher,
        typeName: "Switch Picker",
        label: "Do you agree to the terms?",
        value: false,
        error: false,
        required: true,
        disabled: false,
        content: [
          FormContent(value: 'Agree', label: 'positive'),
          FormContent(value: 'Not Agree', label: 'negative')
        ]
    ),
    FormItem(
        id: "A0005",
        type: FormValues.slider,
        typeName: "Slider Picker",
        label: "How much you satisfy?",
        value: 10.0,
        error: false,
        required: true,
        disabled: false,
        content: [
          FormContent(value: 20.0, label: 'min'),
          FormContent(value: 50.0, label: 'max'),
          FormContent(value: null, label: 'division'),
        ]
    ),
    FormItem(
        id: "A0006",
        type: FormValues.textField,
        typeName: "Text Field",
        label: "Where do you stay?",
        value: "",
        error: false,
        required: true,
        disabled: false,
        content: [
          /// 'password', 'email', 'number'
          FormContent(value: 'email', label: 'type'),
        ]
    ),
    FormItem(
        id: "A0007",
        type: FormValues.checkBox,
        typeName: "Check Box Picker",
        label: "Which country will you visit?",
        value: [],
        error: false,
        required: true,
        disabled: false,
        content: [
          FormContent(value: false, label: 'Germany'),
          FormContent(value: false, label: 'Switzerland'),
          FormContent(value: false, label: 'France'),
          FormContent(value: false, label: 'Australia'),
        ]
    ),
    FormItem(
        id: "A0008",
        type: FormValues.dropDown,
        typeName: "Drop Down Picker",
        label: "Which city will you visit?",
        value: null,
        error: false,
        required: true,
        disabled: false,
        content: [
          FormContent(value: 'Washington', label: 'Washington'),
          FormContent(value: 'London', label: 'London'),
          FormContent(value: 'Berlin', label: 'Berlin'),
          FormContent(value: 'Tokyo', label: 'Tokyo'),
          FormContent(value: 'Jakarta', label: 'Jakarta'),
          FormContent(value: 'Melbourne', label: 'Melbourne'),
          FormContent(value: 'Sydney', label: 'Sydney'),
          FormContent(value: 'Seoul', label: 'Seoul'),
        ]
    ),
  ];

  final FormController formController = FormController();

  void formHandle(BuildContext context, List<FormAnswer> answers) {
    DialogHandler.showToast(
      context: context,
      title: "Submitted!",
      subtitle: jsonEncode(answers.map((answer) => answer.toJson()).toList()),
      canRemove: false,
      subtitleMaxLines: null
    );
  }

  @override
  Widget build(BuildContext context) {
    return Consumer2<ThemeService, LanguageService> (
      builder: (context, ThemeService themeService, LanguageService languageService, child) {
        return Scaffold(
          appBar: AppBar(
            backgroundColor: Theme.of(context).colorScheme.inversePrimary,
            title: Text(widget.title),
          ),
          body: Builder(
            builder: (context) => Container(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    Expanded(
                      child: FormDesigner(
                        items: formList,
                        controller: formController,
                        handleForm: (List<FormAnswer> answers) {
                          formHandle(context, answers);
                        },
                      ),
                    ),
                    FormButton(
                        onPressed: () {
                          formController.callback();
                        }
                    )
                  ],
                )
            )
          )
        );
      }
    );
  }

}

