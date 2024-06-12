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
      child: const FormPage(title: "Form"),
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
    FormItem(id: "A001", type: '01', typeName: "Date Picker", label: "Label 1", value: ""),
    FormItem(id: "A002", type: '02', typeName: "Time Picker", label: "Label 2", value: ""),
  ];

  @override
  void initState() {
    super.initState();
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
          body: Container(
            padding: const EdgeInsets.all(16.0),
            child: ListView(
              clipBehavior: Clip.none,
              children: FormDesigner(
                context: context,
                items: forms,
                onSubmit: (List<FormAnswer> answers) {
                  print(answers.map((answer) => '${answer.id}: ${answer.answer}').join('\n'));
                },
              ).getForms(),
            )
          )
        );
      }
    );
  }

}

