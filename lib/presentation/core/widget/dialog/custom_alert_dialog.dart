import 'package:flutter/material.dart';

class CustomAlertDialog extends StatelessWidget {
  final String title;
  final String content;
  final VoidCallback onConfirm;
  final VoidCallback onCancel;

  const CustomAlertDialog({super.key,
    required this.title,
    required this.content,
    required this.onConfirm,
    required this.onCancel,
  });

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
        side: const BorderSide(color: Colors.grey)
      ),
      backgroundColor: Theme.of(context).colorScheme.surface,
      child: _buildChild(context),
    );
  }

  Widget _buildChild(BuildContext context) {
    return IntrinsicHeight(
      child: IntrinsicWidth(
        child: Column(
          children: <Widget>[

            /// TITLE & SUBTITLE
            Padding(
              padding: const EdgeInsets.all(24.0),
              child: Column(
                children: [
                  Text(
                    title,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      fontSize: 18.0,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  const SizedBox(
                    height: 12.0,
                  ),
                  Text(
                    content,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      fontSize: 13.0,
                    ),
                  ),

                ],
              )
            ),

            /// BUTTONS
            Container(
              height: 50,
              decoration: const BoxDecoration(
                border: Border(
                  top: BorderSide(width: 1, color: Colors.grey)
                ),
                // color: Colors.green,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  Expanded(
                    child: MouseRegion(
                      cursor: SystemMouseCursors.click,
                      child: GestureDetector(
                        onTap: onCancel,
                        child: Container (
                          height: double.infinity,
                          alignment: Alignment.center,
                          color: Colors.transparent,
                          child: const Text(
                            'Cancel',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 14.0
                            ),
                          )
                        ),
                      )
                    )
                  ),
                  const VerticalDivider(
                      thickness: 1,
                      width: 0,
                      color: Colors.grey
                  ),
                  Expanded(
                    child: MouseRegion(
                      cursor: SystemMouseCursors.click,
                      child: GestureDetector(
                        onTap: onConfirm,
                        child: Container (
                            height: double.infinity,
                            alignment: Alignment.center,
                            color: Colors.transparent,
                            child: const Text(
                              'Yes, Delete',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 14.0
                              ),
                            )
                        ),
                      )
                    )
                  ),
                ],
              ),
            ),

          ],
        )
      )
    );
  }
}
