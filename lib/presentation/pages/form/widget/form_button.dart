import 'package:flutter/material.dart';

class FormButton extends StatefulWidget {
  final VoidCallback onPressed;

  const FormButton({super.key, required this.onPressed});

  @override
  State<FormButton> createState() => _FormButtonState();
}

class _FormButtonState extends State<FormButton> {

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: widget.onPressed,
      style: ButtonStyle(
        elevation: const MaterialStatePropertyAll(0.0),
        shape: MaterialStatePropertyAll(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
            side: const BorderSide(
              width: 1.0,
              color: Colors.grey,
            ),
          ),
        ),
        minimumSize: const MaterialStatePropertyAll(Size(double.infinity, 60)),
        backgroundColor: MaterialStatePropertyAll(
            Theme.of(context).colorScheme.inversePrimary
        ),
      ),
      child: Text(
        "Submit",
        style: TextStyle(
          color: Theme.of(context).colorScheme.inverseSurface,
          fontWeight: FontWeight.normal,
          fontSize: 16,
        ),
      ),
    );
  }

}