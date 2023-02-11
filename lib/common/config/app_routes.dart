import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:travelgrid/common/constants/route_constants.dart';
import 'package:travelgrid/presentation/components/pdf_component.dart';
import 'package:travelgrid/presentation/screens/auth/login_screen.dart';
import 'package:travelgrid/presentation/screens/dashboard/dashboard_2.dart';
import 'package:travelgrid/presentation/screens/ge/add/add_accom.dart';
import 'package:travelgrid/presentation/screens/ge/add/add_misc.dart';
import 'package:travelgrid/presentation/screens/ge/add/add_travel.dart';
import 'package:travelgrid/presentation/screens/ge/add/add_travel_ov.dart';
import 'package:travelgrid/presentation/screens/ge/create_ge.dart';
import 'package:travelgrid/presentation/screens/policy/policy_screen.dart';
import 'package:travelgrid/presentation/screens/splash/splash_screen.dart';
import 'package:travelgrid/presentation/screens/tabs/approval_expense.dart';
import 'package:travelgrid/presentation/screens/ge/general_expense.dart';
import 'package:travelgrid/presentation/screens/tabs/travel_expense.dart';
import 'package:travelgrid/presentation/screens/tabs/travel_request.dart';
class AppRoutes {

  Route generateRoute(RouteSettings routeSettings) {
    return MaterialPageRoute(
        builder: (_) => getScreen(routeSettings),
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


        if(args!=null){
          args as Map<String, dynamic>;

          final bool isEdit = args["isEdit"] ?? false;
          final String title = args["title"]  ?? null;
          return  CreateGeneralExpense(isEdit: isEdit,title: title);
        }
        return CreateGeneralExpense();


      case RouteConstants.approvalExpensePath:
        return ApprovalExpense();

      case RouteConstants.policyPath:
        return PolicyHome();

      case RouteConstants.pdfPath:
        return PDFComponent(path: args.toString());

      case RouteConstants.createAccommodationExpensePath:
        return CreateAccommodationExpense();

      case RouteConstants.createTravelExpensePath:
        return CreateTravelExpense();

      case RouteConstants.createMiscExpensePath:
        return CreateMiscExpense(onAdd: (data){
        });

      default:
        return SplashScreen();
    }
  }

}