import 'package:flutter/material.dart';

import 'package:simple_attendances/app/routes.dart';
import 'package:simple_attendances/views/pages/404/screen.dart';
import 'package:simple_attendances/views/pages/home/home_screen.dart';
import 'package:simple_attendances/views/pages/sign_in/sign_in_screen.dart';
import 'package:simple_attendances/views/pages/startup/startup_screen.dart';
import 'package:simple_attendances/views/pages/location/location_screen.dart';

class OnGeneratedRoutes {
  static List<Route<dynamic>> initialRoute(_) {
    return [MaterialPageRoute(builder: (_) => const StartupScreen())];
  }

  static Route<dynamic> allRoutes(RouteSettings settings) {
    switch (settings.name) {
      case Routes.startup:
        return MaterialPageRoute(builder: (_) => const StartupScreen());
      case Routes.signIn:
        return MaterialPageRoute(builder: (_) => const SignInScreen());
      case Routes.location:
        return MaterialPageRoute(builder: (_) => const LocationScreen());
      case Routes.home:
        return MaterialPageRoute(builder: (_) => const HomeScreen());
    }

    return MaterialPageRoute(builder: (_) => const UnknownRouteScreen());
  }
}
