import 'package:flutter/material.dart';
import 'package:app_links/app_links.dart';
import 'dart:async';

class DeepLinkService {

  final GlobalKey<NavigatorState> navigatorKey;
  late AppLinks _appLinks;
  StreamSubscription<Uri>? _linkSubscription;

  DeepLinkService({required this.navigatorKey}) {
    _appLinks = AppLinks();
    _linkSubscription = _appLinks.uriLinkStream.listen((uri) {
      debugPrint("URI: $uri");
      if (uri.pathSegments.contains('product')) {
        String? id = uri.queryParameters['id'];
        if (id != null) {
          navigatorKey.currentState?.pushNamed(uri.path, arguments: id);
        }
      } else {
        navigatorKey.currentState?.pushNamed(uri.path);
      }
    });
  }

  void dispose() {
    _linkSubscription?.cancel();
  }
}