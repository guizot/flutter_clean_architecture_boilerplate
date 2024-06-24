import 'package:flutter/material.dart';
import 'package:flutter_clean_architecture/presentation/core/extension/color_extension.dart';

class CommonListItem extends StatelessWidget {
  const CommonListItem({super.key, required this.title, required this.subtitle, required this.onTap});
  final String title;
  final String subtitle;
  final Function onTap;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(
        title,
        style: TextStyle(
          fontWeight: FontWeight.bold,
          color: Theme.of(context).colorScheme.primary.toMaterialColor().shade700,
        ),
      ),
      subtitle: Text(subtitle),
      trailing: const Icon(Icons.arrow_forward),
      onTap: () => onTap(context),
    );
  }
}