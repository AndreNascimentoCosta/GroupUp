import 'package:flutter/material.dart';

/// Extending the `BuildContext` class with the `GPNavigatiorExtension` extension.
extension GPNavigatiorExtension on BuildContext {
  /// Returns true if the navigator can be popped.
  ///
  /// Returns:
  ///   A boolean value.
  bool canPop() {
    return Navigator.of(this).canPop();
  }

  /// It goes back to the previous page.
  void pop<T>({T? result}) {
    Navigator.of(this).pop(result);
  }

  /// It pops the navigation stack until it finds a route that matches the predicate
  ///
  /// Args:
  ///   predicate (RoutePredicate): A function that takes a Route and returns a bool.
  void popUntil(RoutePredicate predicate) {
    Navigator.of(this).popUntil(predicate);
  }

  /// `pushNamed` is a function that takes a `chRouteName` and `arguments` as parameters and returns
  /// a `Future<T?>` where `T` is the type of the `arguments` object
  ///
  /// Args:
  ///   routeName (String): The name of the route to navigate to.
  ///   arguments (Object): This is the data that you want to pass to the next screen.
  Future<T?> pushNamed<T extends Object>(
    String chRouteName, {
    Object? arguments,
  }) async {
    return await Navigator.of(this).pushNamed<T?>(
      chRouteName,
      arguments: arguments,
    );
  }

  /// It navigates to a new page and removes the current page from the stack.
  ///
  /// Args:
  ///   chRouteName (String): The name of the route to navigate to.
  ///   arguments (Object): This is the data that you want to pass to the next screen.
  Future<T?> pushReplacementNamed<T extends Object?, TO extends Object?>(
    String chRouteName, {
    TO? result,
    Object? arguments,
  }) async {
    return await Navigator.of(this).pushReplacementNamed<T, TO>(
      chRouteName,
      result: result,
      arguments: arguments,
    );
  }

  /// It navigates to the route with the given name, and removes all the routes until the predicate
  /// returns true.
  ///
  /// Args:
  ///   chRouteName (String): The name of the route to navigate to.
  ///   predicate (RoutePredicate): A function that takes a Route<dynamic> and returns a bool. If the
  /// function returns true, the route is popped.
  ///   arguments (Object): The arguments to pass to the route.
  Future<T?> pushNamedAndRemoveUntil<T extends Object?>(
    String chRouteName, {
    RoutePredicate? predicate,
    Object? arguments,
  }) async {
    return await Navigator.of(this).pushNamedAndRemoveUntil<T?>(
      chRouteName,
      predicate ?? (_) => false,
      arguments: arguments,
    );
  }

  /// A getter that returns the `RouteSettings` of the current route.
  RouteSettings? get routeSettings => ModalRoute.of(this)?.settings;

  /// A getter that returns the name of the current route.
  String? get currentRoute => ModalRoute.of(this)?.settings.name;

  Future<T?> pushCustom<T extends Object>(
    Widget widget,
  ) {
    return Navigator.of(this).push<T>(pageRouteBuilder<T>(
      (context) => widget,
    ));
  }

  PageRouteBuilder<T> pageRouteBuilder<T extends Object>(
    Widget Function(BuildContext context) builder,
  ) {
    return PageRouteBuilder<T>(
      pageBuilder: (context, animation, secondaryAnimation) => builder(context),
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        return SlideTransition(
          position: Tween<Offset>(
            begin: const Offset(-1, 0),
            end: Offset.zero,
          ).animate(animation),
          child: child,
        );
      },
    );
  }
}
