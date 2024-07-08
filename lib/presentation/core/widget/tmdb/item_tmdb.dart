import 'package:flutter/material.dart';
import 'package:flutter_clean_architecture/presentation/core/extension/color_extension.dart';

class ItemTMDB extends StatelessWidget {
  const ItemTMDB({super.key, required this.title, required this.subtitle, required this.url, required this.onTap});
  final String title;
  final String subtitle;
  final String url;
  final Function onTap;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(
        title,
        overflow: TextOverflow.ellipsis,
        maxLines: 1,
        style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Theme.of(context).colorScheme.primary.toMaterialColor().shade700
        ),
      ),
      subtitle: Text(
        subtitle,
        overflow: TextOverflow.ellipsis,
        maxLines: 2,
      ),
      leading: CircleAvatar(
        backgroundImage: url != "" ? NetworkImage(url) : null,
      ),
      onTap: () => onTap(),
    );
  }
}