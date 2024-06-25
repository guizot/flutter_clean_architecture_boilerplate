import 'package:flutter/material.dart';
import 'package:flutter_clean_architecture/presentation/pages/form/model/form_item.dart';
import 'package:flutter_clean_architecture/presentation/pages/form/service/form_controller.dart';
import 'package:flutter_clean_architecture/presentation/pages/form/widget/form_button.dart';
import 'package:flutter_clean_architecture/presentation/pages/form/widget/form_text_field.dart';
import '../../../pages/form/service/form_values.dart';

class SubmissionDialog extends StatefulWidget {
  final String title;
  final String labelCallback;
  final Function(String) addCallback;
  final bool isBottom;

  const SubmissionDialog({super.key,
    required this.title,
    this.labelCallback = "Add",
    required this.addCallback,
    this.isBottom = false
  });

  @override
  State<SubmissionDialog> createState() => _SubmissionDialogState();
}

class _SubmissionDialogState  extends State<SubmissionDialog> {

  final FormController controller = FormController();

  @override
  Widget build(BuildContext context) {
    return !widget.isBottom ? Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
        side: const BorderSide(color: Colors.grey)
      ),
      backgroundColor: Theme.of(context).colorScheme.surface,
      child: buildChild(context),
    ) : buildChild(context);
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
                            padding: const EdgeInsets.all(6.0),
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
                    item: FormItem(type: FormValues.textField),
                    controller: controller,
                    withSpacer: false,
                  ),
                  FormButton(
                    label: widget.labelCallback,
                    onPressed: () {
                      widget.addCallback(controller.item.value.toString());
                      Navigator.of(context).pop();
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
