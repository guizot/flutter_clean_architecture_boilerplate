import 'package:flutter/material.dart';
import 'package:flutter_clean_architecture/presentation/core/extension/color_extension.dart';

class FormUnknown extends StatefulWidget {
  const FormUnknown({super.key});

  @override
  State<FormUnknown> createState() => _FormUnknownState();
}

class _FormUnknownState extends State<FormUnknown> {

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        const Text(
          "Unknown Type",
          style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 18
          ),
        ),
        const SizedBox(height: 8),
        Container(
            width: double.infinity,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: Colors.grey),
            ),
            child: ClipRRect(
                borderRadius: BorderRadius.circular(16.0),
                child: Container(
                  color: Theme.of(context).hintColor.toMaterialColor().shade50,
                  padding: const EdgeInsets.all(16),
                  child: Text(
                      "Unknown Type",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Theme.of(context).colorScheme.inverseSurface,
                        fontWeight: FontWeight.normal,
                        fontSize: 16,
                      )
                  ),
                )
            )
        ),
        const SizedBox(height: 16.0),
      ],
    );
  }

}