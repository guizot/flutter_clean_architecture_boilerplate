import 'package:flutter/material.dart';

class MenuItem {
  final int id;
  final String label;
  final IconData icon;

  MenuItem(this.id, this.label, this.icon);
}

List<MenuItem> getDummyMenuItem() {
  return [
    MenuItem(1, 'Home', Icons.home),
    MenuItem(2, 'Profile', Icons.person),
    MenuItem(3, 'Settings', Icons.settings),
    MenuItem(4, 'Favorites', Icons.favorite),
    MenuItem(5, 'Notifications', Icons.notifications),
    MenuItem(6, 'Messages', Icons.message),
    MenuItem(7, 'Explore', Icons.explore),
    MenuItem(8, 'Search', Icons.search),
    MenuItem(9, 'Chat', Icons.chat),
    MenuItem(10, 'Calendar', Icons.calendar_today),
  ];
}