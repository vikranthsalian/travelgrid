import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_form_bloc/flutter_form_bloc.dart';
import 'package:travelgrid/common/config/preferences_config.dart';
import 'package:travelgrid/common/constants/color_constants.dart';
import 'package:travelgrid/common/constants/flavour_constants.dart';
import 'package:travelgrid/common/constants/theme_constants.dart';
import 'package:travelgrid/data/cubits/accom_type_cubit/accom_type_cubit.dart';
import 'package:travelgrid/data/cubits/approver_type_cubit/approver_type_cubit.dart';
import 'package:travelgrid/data/cubits/common/city_cubit/city_cubit.dart';
import 'package:travelgrid/data/cubits/curreny_cubit/currency_cubit.dart';
import 'package:travelgrid/data/cubits/employee_cubit/employee_cubit.dart';
import 'package:travelgrid/data/cubits/fare_class_cubit/fare_class_cubit.dart';
import 'package:travelgrid/data/cubits/login_cubit/login_cubit.dart';
import 'package:travelgrid/data/cubits/misc_type_cubit/misc_type_cubit.dart';
import 'package:travelgrid/data/cubits/travel_mode_cubit/travel_mode_cubit.dart';
import 'package:travelgrid/data/cubits/travel_purpose_cubit/travel_purpose_cubit.dart';
import 'app_routes.dart';
import 'package:flutter/services.dart';

import 'navigator_key.dart';

enum BuildEnvironment { dev, prod, staging }

class InitRoot extends StatefulWidget {

  @override
  State<InitRoot> createState() => _InitRootState();
}

class _InitRootState extends State<InitRoot> {

  @override
  void initState() {
    super.initState();
    configLoading();
  }


  void configLoading() {
    EasyLoading.instance
      ..displayDuration = const Duration(seconds: 2)
      ..indicatorType = EasyLoadingIndicatorType.wanderingCubes
      ..loadingStyle = EasyLoadingStyle.custom
      ..indicatorSize = 70.0
      ..radius = 10.0
      ..progressColor = ColorConstants.secondaryColor
      ..backgroundColor = ColorConstants.black
      ..indicatorColor = ColorConstants.colorWhite
      ..textColor = ColorConstants.colorWhite
      ..maskColor = ColorConstants.black.withOpacity(0.2)
      ..userInteractions = false
      ..dismissOnTap = false;
  }

  @override
  Widget build(BuildContext context) {
    // final ThemeData globalTheme = Provider.of<GlobalTheme>(context).globalTheme;
    // var mySystemTheme =  SystemUiOverlayStyle.light
    //     .copyWith(
    //     statusBarColor: ColorConstants.priceRed,
    //     statusBarIconBrightness: Brightness.light);

    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
    PreferenceConfig.init();
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => LoginCubit()),
        BlocProvider(create: (context) => AccomTypeCubit()),
        BlocProvider(create: (context) => MiscTypeCubit()),
        BlocProvider(create: (context) => TravelModeCubit()),
        BlocProvider(create: (context) => ApproverTypeCubit()),
        BlocProvider(create: (context) => CityCubit()),
        BlocProvider(create: (context) => FareClassCubit()),
        BlocProvider(create: (context) => TravelPurposeCubit()),
        BlocProvider(create: (context) => CurrencyCubit()),
        BlocProvider(create: (context) => EmployeeCubit()),
      ],
      child:  BlocBuilder<AccomTypeCubit, AccomTypeState>(
          builder: (context, state) {
            return BlocBuilder<CityCubit, CityState>(
                builder: (context, state) {
                  return BlocBuilder<CurrencyCubit, CurrencyState>(
                      builder:  (context, state) {
                      return BlocBuilder<TravelPurposeCubit, TravelPurposeState>(
                          builder:  (context, state) {
                          return BlocBuilder<EmployeeCubit, EmployeeState>(
                                builder:  (context, state) {
                            return BlocBuilder<FareClassCubit, FareClassState>(
                              builder:  (context, state) {
                                return BlocBuilder<MiscTypeCubit, MiscTypeState>(
                                    builder: (context, state) {
                                      return BlocBuilder<ApproverTypeCubit, ApproverTypeState>(
                                          builder: (context, state) {
                                        return BlocBuilder<TravelModeCubit, TravelModeState>(
                                            builder: (context, state) {
                                          return BlocBuilder<LoginCubit, LoginState>(
                                              builder: (context, state) {
                                              return MaterialApp(
                                                useInheritedMediaQuery: true,
                                                navigatorKey: appNavigatorKey,
                                                builder: EasyLoading.init(),
                                                debugShowCheckedModeBanner: false,
                                                title: FlavourConstants.appName,
                                                onGenerateRoute: AppRoutes().generateRoute,
                                                themeMode: ThemeMode.system,
                                                theme: GlobalTheme().globalTheme,
                                              );
                                            }
                                          );
                                        }
          );
                                      }
                                    );
                                  }
                                );
                              }
                            );
                          }
                        );
                      }
                );
                    }
                  );
              }
            );
        }
      ),
    );
  }
}
