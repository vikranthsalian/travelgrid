import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_offline/flutter_offline.dart';
import 'package:travelgrid/common/constants/route_constants.dart';
import 'package:travelgrid/presentation/auth/login_screen.dart';
import 'package:travelgrid/presentation/dashboard/dashboard.dart';
import 'package:travelgrid/presentation/dashboard/dashboard_2.dart';
import 'package:travelgrid/presentation/screens/splash/splash_screen.dart';
class AppRoutes {

  Route generateRoute(RouteSettings routeSettings) {
    return MaterialPageRoute(
        builder: (_) => OfflineBuilder(
          connectivityBuilder: (
              BuildContext context,
              ConnectivityResult connectivityResult,
              Widget child
              ) {
            final bool connected = connectivityResult != ConnectivityResult.none;
            if(!connected) {
          //    return OfflineScreen();
              return Container();
            }
            return getScreen(routeSettings);
          },
          child: const SizedBox.shrink(),
        ),
        settings: routeSettings
    );
  }

  Widget getScreen(RouteSettings routeSettings) {
    final args = routeSettings.arguments;
    switch(routeSettings.name) {
      case RouteConstants.splashPath:
        return SplashScreen();

      case RouteConstants.loginPath:
        return const LoginScreen();

      case RouteConstants.dashboardPath:
        return  HomePage();

      default:
        return SplashScreen();
    }
  }

}