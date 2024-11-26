import 'package:flutter/material.dart';
import 'package:batterymonitor/navigator/customRoute.dart';
import 'package:batterymonitor/ui/pages/Auth/welcomePage.dart';
import 'package:batterymonitor/ui/pages/common/splashPage.dart';

class Routes {
  static dynamic route() {
    return {
      'SplashPage': (BuildContext context) => const SplashPage(),
    };
  }

  static void sendNavigationEventToFirebase(String? path) {
    if (path != null && path.isNotEmpty) {}
  }

  static Route? onGenerateRoute(RouteSettings settings) {
    final List<String> pathElements = settings.name!.split('/');
    if (pathElements[0] != '' || pathElements.length == 1) {
      return null;
    }
    switch (pathElements[1]) {
      case "WelcomePage":
        return CustomRoute<bool>(
          builder: (BuildContext context) => const WelcomePage(),
        );
      default:
        return onUnknownRoute(const RouteSettings(name: '/Feature'));
    }
  }

  static Route onUnknownRoute(RouteSettings settings) {
    return MaterialPageRoute(
      builder: (context) => Scaffold(
        appBar: AppBar(
          title: Text(
            settings.name!.split('/')[1],
            style: const TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.w500,
            ),
          ),
          centerTitle: true,
        ),
        body: Center(
          child: Text(
            '${settings.name!.split('/')[1]} Coming soon...',
            style: TextStyle(
              fontSize: 19,
              color: Colors.black,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      ),
    );
  }
}
