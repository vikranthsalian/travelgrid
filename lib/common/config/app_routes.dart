import 'package:flutter/material.dart';
import 'package:travelgrid/common/constants/route_constants.dart';
import 'package:travelgrid/presentation/components/pdf_component.dart';
import 'package:travelgrid/presentation/screens/auth/login_screen.dart';
import 'package:travelgrid/presentation/screens/dashboard/approvals/approval_expense.dart';
import 'package:travelgrid/presentation/screens/dashboard/dashboard_2.dart';
import 'package:travelgrid/presentation/screens/dashboard/ge/add/add_accom.dart';
import 'package:travelgrid/presentation/screens/dashboard/ge/add/add_misc.dart';
import 'package:travelgrid/presentation/screens/dashboard/ge/add/add_travel.dart';
import 'package:travelgrid/presentation/screens/dashboard/ge/create_ge.dart';
import 'package:travelgrid/presentation/screens/dashboard/te/create_te.dart';
import 'package:travelgrid/presentation/screens/dashboard/tr/add/add_itinery.dart';
import 'package:travelgrid/presentation/screens/dashboard/tr/create_tr.dart';
import 'package:travelgrid/presentation/screens/dashboard/tr/summary_tr.dart';
import 'package:travelgrid/presentation/screens/dashboard/tr/travel_request.dart';
import 'package:travelgrid/presentation/screens/policy/policy_screen.dart';
import 'package:travelgrid/presentation/screens/splash/splash_screen.dart';
import 'package:travelgrid/presentation/screens/dashboard/ge/general_expense.dart';
import 'package:travelgrid/presentation/screens/dashboard/te/travel_expense.dart';
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

      case RouteConstants.travelCreateRequestPath:

        args as Map<String, dynamic>;
      //  if(args!=null){

        //
        //   final bool isEdit = args["isEdit"] ?? false;
        //   final String title = args["title"]  ?? null;
        //   final String status = args["status"]  ?? "";
        //   final bool isApproval = args["isApproval"]  ?? false;
        //   return  CreateTravelRequest(isEdit: isEdit,title: title,status: status,isApproval: isApproval);
       //  }
        return CreateTravelRequest(tripType: args['tripType']);


      case RouteConstants.travelRequestViewPath:


        if(args!=null){
          args as Map<String, dynamic>;

          final bool isEdit = args["isEdit"] ?? false;
          final String title = args["title"]  ?? null;
          final String status = args["status"]  ?? "";
          final bool isApproval = args["isApproval"]  ?? false;
          return  TravelRequestSummary(isEdit: isEdit,title: title,status: status,isApproval: isApproval);
        }
        return TravelRequestSummary();


      case RouteConstants.generalCreateExpensePath:


        if(args!=null){
          args as Map<String, dynamic>;

          final bool isEdit = args["isEdit"] ?? false;
          final String title = args["title"]  ?? null;
          final bool isApproval = args["isApproval"]  ?? false;
          return  CreateGeneralExpense(isEdit: isEdit,title: title,isApproval: isApproval);
        }
        return CreateGeneralExpense();

      case RouteConstants.travelCreateExpensePath:


        if(args!=null){
          args as Map<String, dynamic>;

          final bool isEdit = args["isEdit"] ?? false;
          final String title = args["title"]  ?? null;
          final String status = args["status"]  ?? "";
          final bool isApproval = args["isApproval"]  ?? false;
          return  CreateTravelExpense(isEdit: isEdit,title: title,status:status,isApproval: isApproval);
        }
        return CreateTravelExpense();

      case RouteConstants.approvalExpensePath:
        return ApprovalExpense();

      case RouteConstants.policyPath:
        return PolicyHome();

      case RouteConstants.pdfPath:
        return PDFComponent(path: args.toString());

      // case RouteConstants.createAccommodationExpensePath:
      //   return CreateAccommodationExpense();

      case RouteConstants.createTravelExpensePath:
        return CreateConveyanceExpense();
      //
      // case RouteConstants.createMiscExpensePath:
      //   return CreateMiscExpense(onAdd: (data){
      //   });

      default:
        return SplashScreen();
    }
  }

}