import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

extension GPNavigatiorExtension on BuildContext {
  void pop<T>({T? result}) {
    Navigator.of(this).pop(result);
  }

  void popUntil(RoutePredicate predicate) {
    Navigator.of(this).popUntil(predicate);
  }

  Future<T?> push<T extends Object?>(Widget newRoute) async {
    return await Navigator.of(this).push(
      MaterialPageRoute(
        builder: (context) => newRoute,
      ),
    );
  }

  Future<T?> pushCupertino<T extends Object?>(Widget newRoute) async {
    return await Navigator.of(this).push(
      CupertinoPageRoute(
        builder: (context) => newRoute,
        fullscreenDialog: true,
      ),
    );
  }

  Future<T?> pushAndRemoveUntil<T extends Object?>(Route<T> newRoute) async {
    return await Navigator.of(this).pushAndRemoveUntil(
      newRoute,
      (route) => false,
    );
  }

  RouteSettings? get routeSettings => ModalRoute.of(this)?.settings;

  String? get currentRoute => ModalRoute.of(this)?.settings.name;

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
