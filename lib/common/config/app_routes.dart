import 'package:flutter/material.dart';
import 'package:travelex/common/constants/route_constants.dart';
import 'package:travelex/presentation/components/pdf_component.dart';
import 'package:travelex/presentation/screens/auth/login_screen.dart';
import 'package:travelex/presentation/screens/common/image_screen.dart';
import 'package:travelex/presentation/screens/dashboard/approvals/approval_expense.dart';
import 'package:travelex/presentation/screens/dashboard/home.dart';
import 'package:travelex/presentation/screens/dashboard/ge/add/add_travel.dart';
import 'package:travelex/presentation/screens/dashboard/ge/create_ge.dart';
import 'package:travelex/presentation/screens/dashboard/home_new.dart';
import 'package:travelex/presentation/screens/dashboard/profile/profile_screen.dart';
import 'package:travelex/presentation/screens/dashboard/te/create_te.dart';
import 'package:travelex/presentation/screens/dashboard/tr/create_tr.dart';
import 'package:travelex/presentation/screens/dashboard/tr/summary_tr.dart';
import 'package:travelex/presentation/screens/dashboard/tr/travel_request.dart';
import 'package:travelex/presentation/screens/dashboard/tr/upcoming_tr.dart';
import 'package:travelex/presentation/screens/flight/flight_list.dart';
import 'package:travelex/presentation/screens/policy/policy_screen.dart';
import 'package:travelex/presentation/screens/splash/splash_screen.dart';
import 'package:travelex/presentation/screens/dashboard/ge/general_expense.dart';
import 'package:travelex/presentation/screens/dashboard/te/travel_expense.dart';
import 'package:travelex/presentation/screens/wallet/wallet_screen.dart';
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
        return LoginScreen();

      case RouteConstants.dashboardPath:
        return  HomeNewPage();

      case RouteConstants.upcomingTRPath:
        return  UpcomingTR();

      case RouteConstants.profilePath:
        return  ProfileScreen();

      case RouteConstants.flightPath:
        args as Map<String, dynamic>;
        final String from = args["from"] ?? "";
        final String to = args["to"]  ?? "";
        final String date = args["date"]  ?? "";
        final String paxCount = args["paxCount"]  ?? "1";
        final String fareClass = args["fareClass"]  ?? "";
        return  FlightScreen(from:from,to:to, date:date,paxCount:paxCount,fareClass: fareClass);

      case RouteConstants.travelRequestPath:
        return  TravelRequest();

      case RouteConstants.travelExpensePath:
        return  TravelExpense();

      case RouteConstants.generalExpensePath:
        return  GeneralExpense();

      case RouteConstants.travelCreateRequestPath:

        args as Map<String, dynamic>;
       if(args['isEdit']== true){
          final bool isEdit = args["isEdit"] ?? false;
          final String title = args["title"]  ?? null;
          return  CreateTravelRequest(isEdit: isEdit,title: title,tripType: args['tripType'],);
        }
        return CreateTravelRequest(tripType: args['tripType'],isEdit:args['isEdit']);


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
          final bool isApproval = args["isApproval"]  ?? false;
          return  CreateTravelExpense(isEdit: isEdit,title: title,isApproval: isApproval);
        }
        return CreateTravelExpense();

      case RouteConstants.approvalExpensePath:
        return ApprovalExpense();

      case RouteConstants.policyPath:
        return PolicyHome();

      case RouteConstants.walletPath:
        if(args!=null) {
          args as Map<String, dynamic>;
          return WalletHome(isSelectable:args['selectable']);
        }
        return Container();

      case RouteConstants.imagePath:
        if(args!=null) {
          args as Map<String, dynamic>;

          if(args["file"] !=null){
            return ImageScreen(file:args["file"]);
          }else {
            return ImageScreen(image:args["image"]);
          }

        }
        return Container();

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