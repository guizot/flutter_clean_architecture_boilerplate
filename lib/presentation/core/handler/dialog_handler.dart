import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_clean_architecture/presentation/core/enums/toast_enum.dart';
import 'package:flutter_clean_architecture/presentation/core/extension/color_extension.dart';

import '../../../injector.dart';
import '../services/screen_size_service.dart';

class DialogHandler {

  static void showAlertDialog({
    required BuildContext context,
    required Widget child,
  }) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return child;
      },
    );
  }

  static void showBottomSheet({
    required BuildContext context,
    required Widget child,
  }) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      // isDismissible: false,
      // enableDrag: false,
      builder: (BuildContext context) {
        return SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.only(
              bottom: MediaQuery.of(context).viewInsets.bottom,
            ),
            child: Wrap(
              children: [child]
            ),
          ),
        );
      },
    );
  }

  static void showToast({
    required BuildContext context,
    required String title,
    required String subtitle,
    ToastEnum from = ToastEnum.top,
    int seconds = 3,
    bool canRemove = true,
    int? subtitleMaxLines = 2,
  }) {

    final Completer<void> completer = Completer<void>();
    late OverlayEntry overlayEntry;
    final overlayState = Overlay.of(context);

    final animationController = AnimationController(
      vsync: overlayState,
      duration: const Duration(milliseconds: 500),
    );

    Offset offset = const Offset(0, 0);
    switch(from) {
      case ToastEnum.top:
        offset = const Offset(0, -3);
      case ToastEnum.topLeft || ToastEnum.bottomLeft:
        offset = const Offset(-3, 0);
      case ToastEnum.topRight || ToastEnum.bottomRight:
        offset = const Offset(3, 0);
      case ToastEnum.bottom:
        offset = const Offset(0, 3);
    }

    final animation = Tween<Offset>(
      begin: offset,
      end: Offset.zero,
    ).animate(
        CurvedAnimation(
          parent: animationController,
          curve: Curves.easeInOut,
        )
    );

    final double offsetHeight = Scaffold.of(context).appBarMaxHeight ?? 0;
    bool isTop = from == ToastEnum.top || from == ToastEnum.topLeft || from == ToastEnum.topRight;
    bool isBottom = from == ToastEnum.bottom || from == ToastEnum.bottomLeft || from == ToastEnum.bottomRight;

    overlayEntry = OverlayEntry(
        builder: (context) => AnimatedBuilder(
            animation: animationController,
            builder: (context, child) {
              var ss = sl<ScreenSizeService>()..init(context);
              return Positioned(
                  top: isTop ? (offsetHeight + 16) : null,
                  bottom: isBottom ? 16 : null,
                  width: ss.screenSize.width,
                  child: Material(
                      color: Colors.transparent,
                      child: Container(
                          padding: const EdgeInsets.symmetric(horizontal: 16.0),
                          child: SlideTransition(
                              position: animation,
                              child: Container(
                                decoration: BoxDecoration(
                                    color: Theme.of(context).colorScheme.surface,
                                    borderRadius: BorderRadius.circular(16.0),
                                    border: Border.all(
                                        color: Colors.grey,
                                        width: 1.0
                                    )
                                ),
                                child: ListTile(
                                  title: Text(
                                    title,
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Theme.of(context).colorScheme.primary.toMaterialColor().shade700,
                                    ),
                                  ),
                                  subtitle: Text(
                                    subtitle,
                                    maxLines: subtitleMaxLines,
                                    overflow: subtitleMaxLines != null ? TextOverflow.ellipsis : TextOverflow.visible,
                                  ),
                                  trailing: canRemove ? GestureDetector(
                                      onTap: () {
                                        animationController.reverse().then((_) {
                                          overlayEntry.remove();
                                          if (!completer.isCompleted) {
                                            completer.complete();
                                          }
                                        });
                                      },
                                      child: const Icon(Icons.close_rounded)
                                  ) : null,
                                ),
                              )
                          )
                      )
                  )
              );
            }
        )
    );

    overlayState.insert(overlayEntry);

    animationController.forward();

    completer.future.timeout(Duration(seconds: seconds), onTimeout: () {
      animationController.reverse().then((_) {
        if (!completer.isCompleted) {
          overlayEntry.remove();
          completer.complete();
        }
      });
    });

  }

}