import 'package:flutter/material.dart';
import 'package:skeletonizer/skeletonizer.dart';

class ListSkeleton extends StatelessWidget {
  const ListSkeleton({super.key});

  @override
  Widget build(BuildContext context) {
    return const Skeletonizer(
        enabled: true,
        child: Column(
          children: [
            ListTile(
              title: Text('Title Text Long Text Needed'),
              subtitle: Text('Subtitle Text Long Text Needed'),
              leading: CircleAvatar(
                backgroundImage: NetworkImage('Image Url'),
              ),
            ),
            ListTile(
              title: Text('Title Text Long Text Needed'),
              subtitle: Text('Subtitle Text Long Text Needed'),
              leading: CircleAvatar(
                backgroundImage: NetworkImage('Image Url'),
              ),
            ),
            ListTile(
              title: Text('Title Text Long Text Needed'),
              subtitle: Text('Subtitle Text Long Text Needed'),
              leading: CircleAvatar(
                backgroundImage: NetworkImage('Image Url'),
              ),
            ),
            ListTile(
              title: Text('Title Text Long Text Needed'),
              subtitle: Text('Subtitle Text Long Text Needed'),
              leading: CircleAvatar(
                backgroundImage: NetworkImage('Image Url'),
              ),
            ),
            ListTile(
              title: Text('Title Text Long Text Needed'),
              subtitle: Text('Subtitle Text Long Text Needed'),
              leading: CircleAvatar(
                backgroundImage: NetworkImage('Image Url'),
              ),
            ),
            ListTile(
              title: Text('Title Text Long Text Needed'),
              subtitle: Text('Subtitle Text Long Text Needed'),
              leading: CircleAvatar(
                backgroundImage: NetworkImage('Image Url'),
              ),
            ),
            ListTile(
              title: Text('Title Text Long Text Needed'),
              subtitle: Text('Subtitle Text Long Text Needed'),
              leading: CircleAvatar(
                backgroundImage: NetworkImage('Image Url'),
              ),
            ),
            ListTile(
              title: Text('Title Text Long Text Needed'),
              subtitle: Text('Subtitle Text Long Text Needed'),
              leading: CircleAvatar(
                backgroundImage: NetworkImage('Image Url'),
              ),
            ),
            ListTile(
              title: Text('Title Text Long Text Needed'),
              subtitle: Text('Subtitle Text Long Text Needed'),
              leading: CircleAvatar(
                backgroundImage: NetworkImage('Image Url'),
              ),
            ),
            ListTile(
              title: Text('Title Text Long Text Needed'),
              subtitle: Text('Subtitle Text Long Text Needed'),
              leading: CircleAvatar(
                backgroundImage: NetworkImage('Image Url'),
              ),
            ),
          ],
        )
    );
  }
}