import 'dart:convert';

import 'package:aad_oauth/aad_oauth.dart';
import 'package:aad_oauth/model/config.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_bloc/flutter_form_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:travelex/common/config/azure_sso.dart';
import 'package:travelex/common/constants/flavour_constants.dart';
import 'package:travelex/common/constants/route_constants.dart';
import 'package:travelex/common/extensions/parse_data_type.dart';
import 'package:travelex/common/utils/login_util.dart';
import 'package:travelex/data/datasources/login_response.dart';

import 'package:travelex/presentation/screens/auth/bloc/login_form_bloc.dart';
import 'package:travelex/presentation/widgets/button.dart';
import 'package:travelex/presentation/widgets/image_view.dart';
import 'package:travelex/presentation/widgets/text_field.dart';
import 'package:travelex/presentation/widgets/text_view.dart';
import 'package:webview_flutter/webview_flutter.dart';

class LoginScreen extends StatelessWidget {
  Map<String,dynamic> loginJsonData = {};
  WebViewController? controller ;
  final double _sizedBoxHeight= 10.0.h;
  AadOAuth? oauth ;
  LoginFormBloc? formBloc ;
  @override
  Widget build(BuildContext context) {
    loginJsonData = FlavourConstants.loginData;

      return SafeArea(
        child: Scaffold(
          backgroundColor: ParseDataType().getHexToColor(loginJsonData['backgroundColor']),
          resizeToAvoidBottomInset : false,
          body: BlocProvider(
            create: (context) => LoginFormBloc(loginJsonData),
            child: Builder(
                builder: (context) {

                  LoginFormBloc  formBloc =  BlocProvider.of<LoginFormBloc>(context);

               //  formBloc.tfUsername.updateValue("900898");
               // formBloc.tfPassword.updateValue("Pass@123");

                  return Container(
                    height: double.infinity,

                    child: FormBlocListener<LoginFormBloc, String, String>(

                        onSubmissionFailed: (context, state) {

                        },
                        onSubmitting: (context, state) {
                          FocusScope.of(context).unfocus();
                        },
                        onSuccess: (context, state) {

                          if(state.successResponse.toString().isEmpty){
                            return;
                          }


                          MetaLoginResponse modelResponse = MetaLoginResponse.fromJson(jsonDecode(state.successResponse.toString()));
                          MetaLogin().loggedIn(modelResponse);

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



}
