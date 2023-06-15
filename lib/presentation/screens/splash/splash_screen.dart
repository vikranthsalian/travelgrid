import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:privacy_screen/privacy_screen.dart';
import 'package:travelgrid/common/constants/color_constants.dart';
import 'package:travelgrid/common/constants/flavour_constants.dart';
import 'package:travelgrid/common/constants/route_constants.dart';
import 'package:travelgrid/common/dio/dio_client.dart';
import 'package:travelgrid/common/extensions/parse_data_type.dart';
import 'package:travelgrid/common/extensions/pretty.dart';
import 'package:travelgrid/common/injector/injector.dart';
import 'package:travelgrid/common/utils/login_util.dart';
import 'package:travelgrid/data/datasources/azure_reponse.dart';
import 'package:travelgrid/data/datasources/login_response.dart';
import 'package:travelgrid/data/remote/remote_datasource.dart';
import 'package:travelgrid/domain/usecases/login_usecase.dart';
import 'package:travelgrid/presentation/widgets/button.dart';

class SplashScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => SplashScreenState();
}

class SplashScreenState extends State<SplashScreen> {

  Map<String,dynamic> splashData = {};
  Map<String,dynamic> splashBottomText = {};

  @override
  void initState() {
   // setPrivacyScreenConfig();
    splashData = FlavourConstants.splashData;
    prettyPrint(splashData);
    splashBottomText = FlavourConstants.splashData['splash_bottom_text'];

    getInitRoute();

    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: ParseDataType().getHexToColor(splashData['splash_bg_color']),
      body:Container(
          height: double.infinity,
          width: double.infinity,
          child: Column(
           children: [
             Expanded(child: Container()),
          Container(alignment: Alignment.center,
            child: Image.asset(
              FlavourConstants.path +"images/"+ splashData['splash_logo'],
              width: 250,
              height: 250
            ),
          ),

             Expanded(child: Container()),
             MetaButton(
                 width: 300,
                 mapData: {
               "text" : "Continue with Microsoft Azure",
               "color" : "0xFFFFFFFF",
               "backgroundColor" : "0xFF2854A1",
               "size": "18",
               "family": "regular",
               "borderRadius": 25.0
             },
                 onButtonPressed: () async{
                   AzureResponse azureResponse = await APIRemoteDatasource().ssoSignIn();
                   print("azureResponse");
                   print(jsonEncode(azureResponse));

                   MetaLoginResponse? response = await Injector.resolve<LoginUseCase>()
                       .callApi(
                       {
                         "loginId" :azureResponse.userPrincipalName,
                         "password" : 'Test123#',
                         "domain" :'172.104.189.54',
                         "enterpriseName" :'NH',
                       });

                        if(response.toString().isEmpty){
                          return;
                        }

                      MetaLogin.loggedIn(context, response);

                 }
             ),
                 SizedBox(height:20.h,),
                 MetaButton(
                   width: 300,
                     mapData: {
                   "text" : "Continue with NH Login",
                   "color" : "0xFFFFFFFF",
                   "backgroundColor" : "0xFF2854A1",
                   "size": "18",
                   "family": "regular",
                   "borderRadius": 25.0
                 },
                 onButtonPressed: (){
                   Navigator.of(context).pushNamed(RouteConstants.loginPath);
                 }
             ),
             SizedBox(height:20.h,),
          Container(
              alignment: Alignment.bottomCenter,
              margin: EdgeInsets.symmetric(vertical: 10.h),
              child: Text(
                  splashBottomText['text'],
                  style:Theme.of(context).textTheme.
                  caption?.copyWith(
                      fontSize: ParseDataType().getDouble(splashBottomText['size']).sp,
                      color: ParseDataType().getHexToColor(splashBottomText['color']) ,
                      fontFamily: splashBottomText['family'])
              )
          ),
             SizedBox(height:20.h,),
        ],
      )),
    );
  }

  void getInitRoute() async{
    await CustomDio().setDio();
   // APIRemoteDatasource().ssoLogOut();
      // if(PreferenceConfig.containsKey(PreferenceConstants.sessionID)) {
      //   Timer(const Duration(seconds: 3),(){
      //     Navigator.of(context).pushNamed(RouteConstants.dashBoardTabsPath, arguments: { "tab" : 0 });
      //   });
      // }else{
        Timer(
          Duration(seconds: 3),(){
         // Navigator.of(context).pushReplacementNamed(RouteConstants.loginPath);
        });
      // }
  }

  Future setPrivacyScreenConfig() async {
    await PrivacyScreen.instance.enable(
      iosOptions: const PrivacyIosOptions(
        enablePrivacy: true,
        // privacyImageName: "LaunchImage",
        autoLockAfterSeconds: 3,
        lockTrigger: IosLockTrigger.didEnterBackground,
      ),
      androidOptions: const PrivacyAndroidOptions(
        enableSecure: true,
        autoLockAfterSeconds: 3,
      ),
      backgroundColor: ColorConstants.primaryColor.withOpacity(0),
      blurEffect: PrivacyBlurEffect.dark,
    );
  }
}