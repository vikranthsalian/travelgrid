
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:travelgrid/common/config/navigator_key.dart';
import 'package:travelgrid/common/constants/route_constants.dart';
import 'package:travelgrid/common/injector/injector.dart';
import 'package:travelgrid/common/utils/show_alert.dart';
import 'package:travelgrid/data/blocs/accom/accom_type_bloc.dart';
import 'package:travelgrid/data/datasources/login_response.dart';
import 'package:travelgrid/common/injector/injector.dart';
import 'package:travelgrid/common/utils/show_alert.dart';
import 'package:travelgrid/data/blocs/accom/accom_type_bloc.dart';
import 'package:travelgrid/data/blocs/approver/approver_type_bloc.dart';
import 'package:travelgrid/data/blocs/cities/city_bloc.dart';
import 'package:travelgrid/data/blocs/currency/currency_bloc.dart';
import 'package:travelgrid/data/blocs/employee/employee_bloc.dart';
import 'package:travelgrid/data/blocs/fare_class/fare_class_bloc.dart';
import 'package:travelgrid/data/blocs/misc/misc_type_bloc.dart';
import 'package:travelgrid/data/blocs/travel/travel_mode_bloc.dart';
import 'package:travelgrid/data/blocs/travel_purpose/travel_purpose_bloc.dart';
import 'package:travelgrid/data/cubits/login_cubit/login_cubit.dart';
import 'package:flutter_form_bloc/flutter_form_bloc.dart';
class MetaLogin{


     loggedIn(response) {
      var ctx=  appNavigatorKey.currentState!.context;


      ctx.read<LoginCubit>().setLoginResponse(response);
      MetaAlert.showSuccessAlert(
          message: "Login Success"
      );

      Injector.resolve<AccomTypeBloc>()..add(GetAccomTypeListEvent());
      Injector.resolve<TravelModeBloc>()..add(GetTravelModeListEvent());
      Injector.resolve<MiscTypeBloc>()..add(GetMiscTypeListEvent());


      Injector.resolve<ApproverTypeBloc>()..add(GetApproverTypeListEvent());

      Injector.resolve<FareClassBloc>()..add(GetAirFareClassListEvent());

      Injector.resolve<FareClassBloc>()..add(GetRailFareClassListEvent());
      Injector.resolve<FareClassBloc>()..add(GetRoadFareClassListEvent());
      Injector.resolve<TravelPurposeBloc>()..add(GetTravelPurposeListEvent());

      Injector.resolve<CurrencyBloc>()..add(GetCurrencyListEvent());
      Injector.resolve<CityBloc>()..add(GetCityListEvent());
      Injector.resolve<CityBloc>()..add(GetCountryListEvent());
      Injector.resolve<CityBloc>()..add(GetCountryListEvent());
      Injector.resolve<EmployeeBloc>()..add(GetEmployeeListEvent());
      Injector.resolve<EmployeeBloc>()..add(GetNonEmployeeListEvent());


      Navigator.of(ctx).pushReplacementNamed(RouteConstants.dashboardPath);
    }
}