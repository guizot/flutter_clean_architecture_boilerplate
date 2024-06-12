import 'package:flutter/material.dart';
import 'package:flutter_clean_architecture/presentation/pages/form/model/form_answer.dart';
import 'package:flutter_clean_architecture/presentation/pages/form/widget/form_date_picker.dart';
import '../model/form_item.dart';
import '../widget/form_time_picker.dart';

class FormDesigner {

  final BuildContext context;
  final List<FormItem> items;
  final Function(List<FormAnswer>) onSubmit;
  FormDesigner({required this.context, required this.items, required this.onSubmit});

  List<Widget> getForms() {

    List<Widget> widgets = items.map<Widget>((item) {
      return getItem(item);
    }).toList();

    widgets.add(
        ElevatedButton(
          onPressed: () {
            List<FormAnswer> answers = items.map((e) => FormAnswer(id: e.id, answer: e.value)).toList();
            onSubmit(answers);
          },
          style: ButtonStyle(
            elevation: const MaterialStatePropertyAll(0.0),
            shape: MaterialStatePropertyAll(
                RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                    side: const BorderSide(
                      width: 1.0,
                      color: Colors.grey,
                    )
                )
            ),
          ),
          child: Text(
              "Submit",
              style: TextStyle(
                color: Theme.of(context).colorScheme.inverseSurface,
                fontWeight: FontWeight.normal,
                fontSize: 16,
              )
          ),
        )
    );

    return widgets;

  }

  Widget getItem(FormItem item) {
    switch (item.type) {
      case '01':
        return FormDatePicker(item: item);
      case '02':
        return FormTimePicker(item: item);
      default:
        return const Text('Unknown type', style: TextStyle(fontSize: 16));
    }
  }

}