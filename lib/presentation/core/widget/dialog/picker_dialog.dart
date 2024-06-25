import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_clean_architecture/presentation/pages/form/widget/form_button.dart';
import 'package:intl/intl.dart';

class PickerDialog extends StatefulWidget {
  final String title;
  final DateTime date;
  final Function(String) onChange;
  final bool isBottom;

  const PickerDialog({super.key,
    required this.title,
    required this.date,
    required this.onChange,
    this.isBottom = false
  });

  @override
  State<PickerDialog> createState() => _PickerDialogState();
}

class _PickerDialogState extends State<PickerDialog> {

  DateTime date = DateTime.now();

  @override
  void initState() {
    setState(() {
      date = widget.date;
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return widget.isBottom
        ? buildChild(context)
        : Dialog(
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
                  Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(color: Colors.grey),
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(16.0),
                      child: Container(
                        height: 215,
                        color: Theme.of(context).colorScheme.surface,
                        child: CupertinoDatePicker(
                          initialDateTime: DateTime.now(),
                          mode: CupertinoDatePickerMode.date,
                          onDateTimeChanged: (DateTime newDate) {
                            setState(() {
                              date = newDate;
                            });
                          },
                        )
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 16.0,
                  ),
                  FormButton(
                    label: "Set Date",
                    onPressed: () {
                      String formattedDate = DateFormat('yyyy-MM-dd').format(date);
                      widget.onChange(formattedDate);
                      Navigator.of(context).pop();
                    }
                  )
                ],
              )
          ),
        ],
      )
    );
  }

}
