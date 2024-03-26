import 'package:flutter/cupertino.dart';
import 'package:flutter_clean_architecture/presentation/core/enums/screen_enum.dart';

class ScreenSizeService {

  late BuildContext _context;
  void init(BuildContext context) {
    _context = context;
  }
  Size get screenSize => MediaQuery.of(_context).size;

  /// SCREEN CATEGORY
  ScreenEnum get screenCategory {
    double width = screenSize.width;
    // double height = screenSize.height;
    if (width < 320) {
      return ScreenEnum.small;
    } else if (width >= 320 && width < 360) {
      return ScreenEnum.medium;
    } else if (width >= 360 && width < 420) {
      return ScreenEnum.large;
    } else if (width >= 420 && width < 600) {
      return ScreenEnum.extraLarge;
    } else if (width >= 600 && width < 800) {
      return ScreenEnum.smallTablet;
    } else if (width >= 800 && width < 1024) {
      return ScreenEnum.largeTablet;
    } else if (width >= 1024 && width < 1366) {
      return ScreenEnum.smallDesktop;
    } else if (width >= 1366 && width < 1920) {
      return ScreenEnum.mediumDesktop;
    } else if (width >= 1920) {
      return ScreenEnum.largeDesktop;
    } else {
      return ScreenEnum.medium;
    }
  }

  /// SIDEBAR
  bool get sidebarShowHide => screenSize.width >= 800;
  double get sidebarWidth => screenSize.width * (20/100);

  /// GRID VIEW
  int get gridCrossAxisCount {
    switch (screenCategory) {
      case ScreenEnum.small:
        return 1;
      case ScreenEnum.medium:
        return 2;
      case ScreenEnum.large:
        return 3;
      case ScreenEnum.extraLarge:
        return 3;
      case ScreenEnum.smallTablet:
        return 4;
      case ScreenEnum.largeTablet:
        return 6;
      case ScreenEnum.smallDesktop:
        return 8;
      case ScreenEnum.mediumDesktop:
        return 10;
      case ScreenEnum.largeDesktop:
        return 12;
      default:
        return 0;
    }
  }

}