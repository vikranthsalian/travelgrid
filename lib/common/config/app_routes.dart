import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_offline/flutter_offline.dart';
import 'package:travelgrid/common/constants/route_constants.dart';
import 'package:travelgrid/presentation/components/pdf_component.dart';
import 'package:travelgrid/presentation/screens/auth/login_screen.dart';
import 'package:travelgrid/presentation/screens/dashboard/dashboard.dart';
import 'package:travelgrid/presentation/screens/dashboard/dashboard_2.dart';
import 'package:travelgrid/presentation/screens/ge/create_ge.dart';
import 'package:travelgrid/presentation/screens/policy/policy_screen.dart';
import 'package:travelgrid/presentation/screens/splash/splash_screen.dart';
import 'package:travelgrid/presentation/screens/tabs/approval_expense.dart';
import 'package:travelgrid/presentation/screens/ge/general_expense.dart';
import 'package:travelgrid/presentation/screens/tabs/travel_expense.dart';
import 'package:travelgrid/presentation/screens/tabs/travel_request.dart';
import 'package:travelgrid/presentation/widgets/pdf.dart';
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

      case RouteConstants.travelRequestPath:
        return  TravelRequest();

      case RouteConstants.travelExpensePath:
        return  TravelExpense();

      case RouteConstants.generalExpensePath:
        return  GeneralExpense();

      case RouteConstants.generalCreateExpensePath:
        return  CreateGeneralExpense();

      case RouteConstants.approvalExpensePath:
        return ApprovalExpense();

      case RouteConstants.policyPath:
        return PolicyHome();

      case RouteConstants.pdfPath:
        return PDFComponent(path: args.toString());



      default:
        return SplashScreen();
    }
  }

}