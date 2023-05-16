import 'dart:async';
import 'dart:convert';

import 'package:aad_oauth/aad_oauth.dart';
import 'package:aad_oauth/model/config.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_bloc/flutter_form_bloc.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:travelgrid/common/config/azure_sso.dart';
import 'package:travelgrid/common/constants/flavour_constants.dart';
import 'package:travelgrid/common/constants/route_constants.dart';
import 'package:travelgrid/common/extensions/capitalize.dart';
import 'package:travelgrid/common/extensions/parse_data_type.dart';
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
import 'package:travelgrid/data/datasources/login_response.dart';
import 'package:travelgrid/data/remote/remote_datasource.dart';
import 'package:travelgrid/presentation/screens/auth/bloc/login_form_bloc.dart';
import 'package:travelgrid/presentation/widgets/button.dart';
import 'package:travelgrid/presentation/widgets/image_view.dart';
import 'package:travelgrid/presentation/widgets/text_field.dart';
import 'package:travelgrid/presentation/widgets/text_view.dart';

class LoginScreen extends StatelessWidget {
  Map<String,dynamic> loginJsonData = {};

  final double _sizedBoxHeight= 10.0.h;
  AadOAuth? oauth ;
  LoginFormBloc? formBloc ;
  late StreamSubscription<bool> keyboardSubscription;
  @override
  Widget build(BuildContext context) {

    loginJsonData = FlavourConstants.loginData;
   // APIRemoteDatasource().ssoSignIn();
  //  print('"1000000".toString().formatize()');
  //  print("1000000".inRupeesFormat());


      return SafeArea(
        child: Scaffold(
          backgroundColor: ParseDataType().getHexToColor(loginJsonData['backgroundColor']),
          resizeToAvoidBottomInset : false,
          body: BlocProvider(
            create: (context) => LoginFormBloc(loginJsonData),
            child: Builder(
                builder: (context) {

                  LoginFormBloc  formBloc =  BlocProvider.of<LoginFormBloc>(context);
             //   formBloc.tfUsername.updateValue("nh09");
             //   formBloc.tfPassword.updateValue("Test123#");

                  return Container(
                    height: double.infinity,

                    child: FormBlocListener<LoginFormBloc, String, String>(
                        onSubmissionFailed: (context, state) {

                        },
                        onSubmitting: (context, state) {
                          FocusScope.of(context).unfocus();
                        },
                        onSuccess: (context, state) {
                          MetaLoginResponse modelResponse = MetaLoginResponse.fromJson(jsonDecode(state.successResponse.toString()));
                          print(modelResponse.data?.toJson());
                          context.read<LoginCubit>().setLoginResponse(modelResponse);
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


                          Navigator.of(context).pushReplacementNamed(RouteConstants.dashboardPath);
                        },
                        onFailure: (context, state) {


                        },
                        child: ScrollableFormBlocManager(
                          formBloc: formBloc,
                          child: SingleChildScrollView (
                            padding: EdgeInsets.symmetric(horizontal: 20.w),
                            child: Column(
                                children:[
                                  SizedBox(height: _sizedBoxHeight),
                                  MetaTextView(mapData: loginJsonData['text_title']),
                                  SizedBox(height: _sizedBoxHeight * 0.2),
                                  MetaTextView(mapData: loginJsonData['text_subtitle']),
                                  MetaImageView(mapData: loginJsonData['image_view']),
                                  MetaImageView(mapData: loginJsonData['image_view_2']),
                                  MetaTextFieldBlocView(mapData: loginJsonData['text_field_username'],
                                      textFieldBloc: formBloc.tfUsername,
                                      onChanged:(value){
                                        formBloc.tfUsername.updateValue(value);
                                      }),
                                  MetaTextFieldBlocView(mapData: loginJsonData['text_field_password'],
                                      textFieldBloc: formBloc.tfPassword,
                                      isPassword: true,

                                      onChanged: (value){
                                        formBloc.tfPassword.updateValue(value);
                                      }),
                                  SizedBox(height: _sizedBoxHeight),
                                  SizedBox(height: _sizedBoxHeight),
                                  SizedBox(height: _sizedBoxHeight),
                                  MetaButton(mapData: loginJsonData['bottomButton'],
                                      onButtonPressed: (){
                                        formBloc.submit();
                                      }
                                  ),
                                ]
                            ),
                          ),
                        )
                    ),
                  );
                }
            ),
          ),
        ),
      );
  }


  void login(bool redirect) async {
    Config config = AzureSSO().getConfig();
    oauth = new AadOAuth(config);
    config.webUseRedirect = redirect;

    final result = await oauth!.login();
    result.fold(
          (l) => print(l.toString()),
          (r) => print('Logged in successfully, your access token: $r'),
    );
    var accessToken = await oauth!.getAccessToken();
    if (accessToken != null) {
      print(accessToken);
    }
  }

  void hasCachedAccountInformation() async {
    var hasCachedAccountInformation = await oauth!.hasCachedAccountInformation;

        print('HasCachedAccountInformation: $hasCachedAccountInformation');


  }

}
