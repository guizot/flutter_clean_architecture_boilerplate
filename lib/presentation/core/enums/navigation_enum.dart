enum NavigateEnum {
  navigatePush,     /// Push a new route onto the stack.
  navigateReplace,  /// Replace the current route with a new one.
  navigateRemove,   /// Remove all previous routes and push the new one.
  popPush,          /// Pop the current route and push a new one.
}

enum PopEnum {
  popUntil,         /// Pop routes until the specified route is reached.
  popOnce,          /// Pop the current route.
}