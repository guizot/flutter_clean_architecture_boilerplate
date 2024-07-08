import 'package:flutter/material.dart';
import 'package:flutter_clean_architecture/presentation/pages/form/model/form_item.dart';
import 'package:flutter_clean_architecture/presentation/pages/form/service/form_validation.dart';
import 'package:flutter_clean_architecture/presentation/pages/form/widget/form_button.dart';
import 'package:flutter_clean_architecture/presentation/pages/form/widget/form_text_field.dart';

import '../form/service/form_values.dart';

class NotesItemDialog extends StatefulWidget {
  final String title;
  final String? noteTitle;
  final String? noteDesc;
  final Function(String, String) addCallback;

  const NotesItemDialog({super.key,
    required this.title,
    this.noteTitle,
    this.noteDesc,
    required this.addCallback,
  });

  @override
  State<NotesItemDialog> createState() => _NotesItemDialogState();
}

class _NotesItemDialogState  extends State<NotesItemDialog> {

  List<FormItem> formList = [];

  @override
  void didChangeDependencies() {
    formList = [
      FormItem(
        type: FormValues.textField,
        label: "Title",
        required: true,
        value: widget.noteTitle
      ),
      FormItem(
        type: FormValues.textField,
        label: "Description",
        required: true,
          value: widget.noteDesc
      )
    ];
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
          side: const BorderSide(color: Colors.grey)
      ),
      backgroundColor: Theme.of(context).colorScheme.surface,
      child: buildChild(context),
    );
  }

  Widget buildChild(BuildContext context) {
    return IntrinsicHeight(
      child: Column(
        children: <Widget>[
          Padding(
              padding: const EdgeInsets.only(
                top: 24.0,
                left: 24.0,
                right: 24.0,
                bottom: 24.0,
              ),
              child: Column(
                children: [
                  Row(
                    children: [
                      Expanded(
                          child: Container(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              widget.title,
                              textAlign: TextAlign.start,
                              style: const TextStyle(
                                fontSize: 22.0,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          )
                      ),
                      const SizedBox(
                        width: 8.0,
                      ),
                      MouseRegion(
                          cursor: SystemMouseCursors.click,
                          child: GestureDetector(
                            onTap: () => Navigator.of(context).pop(),
                            child: Container (
                                padding: const EdgeInsets.all(6.0),
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  border: Border.all(
                                      color: Colors.grey,
                                      width: 1.5
                                  ),
                                ),
                                child: const Icon(
                                  Icons.close,
                                  size: 20.0,
                                  color: Colors.grey,
                                )
                            ),
                          )
                      )
                    ],
                  ),
                  const SizedBox(
                    height: 16.0,
                  ),
                  FormTextField(
                    item: formList[0],
                    withSpacer: true,
                  ),
                  FormTextField(
                    item: formList[1],
                    withSpacer: true,
                  ),
                  FormButton(
                    label: "Save",
                    onPressed: () {
                      if(!FormValidation().checkFormItems(formList)) {
                        setState(() => {});
                      }
                      else {
                        widget.addCallback(
                            formList[0].value.toString(),
                            formList[1].value.toString()
                        );
                        Navigator.of(context).pop();
                      }
                    },
                  )
                ],
              )
          ),
        ],
      )
    );
  }
}
