import 'package:flutter/material.dart';
import 'package:groupup/core/routes/gp_named_routes.dart';
import 'package:groupup/screens/home/screens/home.dart';

class GPRoute {
  const GPRoute._();

  factory GPRoute() => const GPRoute._();

  static Route<dynamic>? generateRoute(RouteSettings settings) {
    /// Getting the route name that were passed to the route.
    final routeName = settings.name;

    switch (routeName) {
      case GPNamedRoutes.home:
        return MaterialPageRoute(
          builder: (context) => const Home(),
        );
    }
    return null;
  }
}
