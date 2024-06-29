import 'package:flutter/material.dart';

import '../../../pages/form/widget/form_button.dart';

class ConfirmationDialog extends StatelessWidget {
  final String title;
  final String subtitle;
  final String positiveText;
  final String negativeText;
  final VoidCallback? positiveCallback;
  final VoidCallback? negativeCallback;
  final bool isBottom;

  const ConfirmationDialog({super.key,
    required this.title,
    this.subtitle = "",
    this.positiveText = "Confirm",
    this.negativeText = "Cancel",
    this.positiveCallback,
    this.negativeCallback,
    this.isBottom = false
  });

  @override
  Widget build(BuildContext context) {
    return !isBottom ? Dialog(
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
      child: IntrinsicWidth(
        child: Column(
          children: <Widget>[

            /// TITLE & SUBTITLE
            Padding(
              padding: const EdgeInsets.only(
                left: 24.0,
                right: 24.0,
                top: 24.0,
                bottom: 24.0
              ),
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
            (negativeCallback != null || positiveCallback != null)
                ? Container(
                    padding: const EdgeInsets.only(
                      left: 16.0,
                      right: 16.0,
                      bottom: 24.0
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        negativeCallback != null
                            ? Expanded(
                                child: FormButton(
                                  label: negativeText,
                                  color: Theme.of(context).colorScheme.surfaceBright,
                                  fontSize: 14.0,
                                  onPressed: negativeCallback ?? () {},
                                )
                              )
                            : Container(),
                        (negativeCallback != null && positiveCallback != null)
                            ? const SizedBox(width: 16.0)
                            : Container(),
                        positiveCallback != null
                            ? Expanded(
                                child: FormButton(
                                label: positiveText,
                                fontSize: 14.0,
                                onPressed: positiveCallback ?? () {},
                              )
                              )
                            : Container(),
                      ],
                    ),
                  )
                : Container(),

          ],
        )
      )
    );
  }
}
