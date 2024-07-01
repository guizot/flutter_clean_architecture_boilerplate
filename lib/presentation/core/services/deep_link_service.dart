import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:app_links/app_links.dart';
import 'dart:async';
import '../constant/routes_values.dart';

class DeepLinkService {
  late AppLinks _appLinks;
  late StreamSubscription<Uri> _linkSubscription;
  final RouteObserver<PageRoute> routeObserver = RouteObserver<PageRoute>();

  void init() {
    _appLinks = AppLinks();
    log("TEST: _appLinks");
    _linkSubscription = _appLinks.uriLinkStream.listen((Uri? uri) {
      log("URI: $uri");
      if (uri != null) {
        _handleDeepLink(uri);
      }
    });
    log("TEST: _linkSubscription");
    _initDeepLink();
  }

  Future<void> _initDeepLink() async {
    final uri = await _appLinks.getInitialLink();
    if (uri != null) {
      _handleDeepLink(uri);
    }
    log("TEST: _initDeepLink");
  }

  void _handleDeepLink(Uri uri) {
    if (uri.pathSegments.contains('product')) {
      String? id = uri.queryParameters['id'];
      if (id != null) {
        routeObserver.navigator?.pushNamed(RoutesValues.githubDetail, arguments: id);
      }
    }
    log("TEST: _handleDeepLink");
  }

  void dispose() {
    _linkSubscription.cancel();
    log("TEST: _linkSubscription.cancel");
  }
}