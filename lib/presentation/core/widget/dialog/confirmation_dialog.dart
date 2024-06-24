import 'package:flutter/material.dart';

class ConfirmationDialog extends StatelessWidget {
  final String title;
  final String subtitle;
  final String positiveText;
  final String negativeText;
  final VoidCallback? positiveCallback;
  final VoidCallback? negativeCallback;

  const ConfirmationDialog({super.key,
    required this.title,
    this.subtitle = "",
    this.positiveText = "Confirm",
    this.negativeText = "Cancel",
    this.positiveCallback,
    this.negativeCallback,
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
                  subtitle != "" ? const SizedBox(
                    height: 12.0,
                  ) : Container(),
                  subtitle != "" ? Text(
                    subtitle,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      fontSize: 13.0,
                    ),
                  ) : Container(),
                ],
              )
            ),

            /// BUTTONS
            (negativeCallback != null || positiveCallback != null) ? Container(
              height: 60,
              decoration: const BoxDecoration(
                border: Border(
                  top: BorderSide(width: 1, color: Colors.grey)
                ),
                // color: Colors.green,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  negativeCallback != null ? Expanded(
                    child: MouseRegion(
                      cursor: SystemMouseCursors.click,
                      child: GestureDetector(
                        onTap: negativeCallback,
                        child: Container (
                          height: double.infinity,
                          alignment: Alignment.center,
                          color: Colors.transparent,
                          child: Text(
                            negativeText,
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 14.0
                            ),
                          )
                        ),
                      )
                    )
                  ) : Container(),
                  (negativeCallback != null && positiveCallback != null) ? const VerticalDivider(
                      thickness: 1,
                      width: 0,
                      color: Colors.grey
                  ) : Container(),
                  positiveCallback != null ? Expanded(
                    child: MouseRegion(
                      cursor: SystemMouseCursors.click,
                      child: GestureDetector(
                        onTap: positiveCallback,
                        child: Container (
                            height: double.infinity,
                            alignment: Alignment.center,
                            color: Colors.transparent,
                            child: Text(
                              positiveText,
                              textAlign: TextAlign.center,
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 14.0
                              ),
                            )
                        ),
                      )
                    )
                  ) : Container(),
                ],
              ),
            ) : Container(),

          ],
        )
      )
    );
  }
}
