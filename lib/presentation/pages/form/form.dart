import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_clean_architecture/presentation/core/services/language_service.dart';
import 'package:flutter_clean_architecture/presentation/pages/form/model/form_item.dart';
import 'package:flutter_clean_architecture/presentation/pages/form/service/form_designer.dart';
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

class _FormPageState extends State<FormPage> {
  final List<FormItem> forms = [
    FormItem(
        id: "A0001",
        type: '01',
        typeName: "Date Picker",
        label: "When will you go to Switzerland?",
        value: "",
        error: false,
        required: false,
        content: []
    ),
    FormItem(
        id: "A0002",
        type: '02',
        typeName: "Time Picker",
        label: "What time did you sleep?",
        value: "",
        error: false,
        required: true,
        content: []
    ),
    FormItem(
        id: "A0003",
        type: '03',
        typeName: "Radio Picker",
        label: "What day will you stay?",
        value: "",
        error: false,
        required: true,
        content: [
          {
            'value': 'Monday',
            'label': 'Monday',
          },
          {
            'value': 'Tuesday',
            'label': 'Tuesday',
          },
          {
            'value': 'Wednesday',
            'label': 'Wednesday',
          }
        ]
    ),
    FormItem(
        id: "A0004",
        type: '04',
        typeName: "Switch Picker",
        label: "Do you agree to the terms?",
        value: false,
        error: false,
        required: true,
        content: [
          {
            'value': 'Agree',
            'label': 'Agree',
          },
          {
            'value': 'Not Agree',
            'label': 'Not Agree',
          },
        ]
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Consumer2<ThemeService, LanguageService> (
      builder: (context, ThemeService themeService, LanguageService languageService, child) {
        return Scaffold(
          appBar: AppBar(
            backgroundColor: Theme.of(context).colorScheme.inversePrimary,
            title: Text(widget.title),
          ),
          body: Container(
            padding: const EdgeInsets.all(16.0),
            child: FormDesigner(
              items: forms,
              onSubmit: (List<FormAnswer> answers) {
                print(jsonEncode(answers.map((answer) => answer.toJson()).toList()));
              },
            )
          )
        );
      }
    );
  }

}

