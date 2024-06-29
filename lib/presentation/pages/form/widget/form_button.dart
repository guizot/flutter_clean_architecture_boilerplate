import 'package:flutter/material.dart';

class FormButton extends StatefulWidget {
  final VoidCallback onPressed;
  final Color? color;
  final double? fontSize;
  final String label;

  const FormButton({
    super.key,
    required this.onPressed,
    this.color,
    this.fontSize = 16.0,
    this.label = "Submit"
  });

  @override
  State<FormButton> createState() => _FormButtonState();
}

class _FormButtonState extends State<FormButton> {

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: widget.onPressed,
      style: ButtonStyle(
        elevation: const WidgetStatePropertyAll(0.0),
        shape: WidgetStatePropertyAll(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
            side: const BorderSide(
              width: 1.0,
              color: Colors.grey,
            ),
          ),
        ),
        minimumSize: const WidgetStatePropertyAll(Size(double.infinity, 60)),
        backgroundColor: WidgetStatePropertyAll(
            widget.color ?? Theme.of(context).colorScheme.inversePrimary
        ),
      ),
      child: Text(
        widget.label,
        style: TextStyle(
          color: Theme.of(context).colorScheme.inverseSurface,
          fontWeight: FontWeight.bold,
          fontSize: widget.fontSize,
        ),
      ),
    );
  }

}