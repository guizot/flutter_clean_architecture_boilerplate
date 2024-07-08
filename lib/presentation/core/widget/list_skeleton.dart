import 'package:flutter/material.dart';
import 'package:skeletonizer/skeletonizer.dart';

class ListSkeleton extends StatelessWidget {

  const ListSkeleton({
    super.key,
    this.items = 10
  });
  final int items;

  @override
  Widget build(BuildContext context) {
    return Skeletonizer(
        enabled: true,
        child: Column(
          children: List.generate(items, (index) {
            return const ListTile(
              title:  Text('Title Text Long Text Needed'),
              subtitle:  Text('Subtitle Text Long Text Needed'),
              leading: CircleAvatar(),
            );
          })
        )
    );
  }
}