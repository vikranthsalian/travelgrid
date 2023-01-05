import 'package:flutter_flavor/flutter_flavor.dart';

class FlavourConfig {
  initConfig(Map<String, dynamic> flavour) {
    FlavorConfig(
      variables: {
        "appName":  flavour['appName'],
        "appLogo": flavour['appLogo'],
        "splashLogo": flavour['splashLogo'],
        "svgLogo": flavour['svgLogo'],
        "poweredBy": flavour['poweredBy'],
        "baseUrl":  flavour['baseUrl'],
        "enableUnitTesting":  flavour['enableUnitTesting'],
      },);
  }
}

