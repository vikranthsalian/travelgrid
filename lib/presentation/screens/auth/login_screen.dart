import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_form_bloc/flutter_form_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:travelgrid/common/constants/flavour_constants.dart';
import 'package:travelgrid/common/constants/route_constants.dart';
import 'package:travelgrid/common/extensions/parse_data_type.dart';
import 'package:travelgrid/common/extensions/pretty.dart';
import 'package:travelgrid/common/utils/show_alert.dart';
import 'package:travelgrid/data/cubits/login_cubit/login_cubit.dart';
import 'package:travelgrid/data/datsources/login_response.dart';
import 'package:travelgrid/presentation/screens/auth/bloc/login_form_bloc.dart';
import 'package:travelgrid/presentation/widgets/button.dart';
import 'package:travelgrid/presentation/widgets/image_view.dart';
import 'package:travelgrid/presentation/widgets/text_field.dart';
import 'package:travelgrid/presentation/widgets/text_view.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return _Login();
  }
}

class _Login extends StatefulWidget {


  @override
  State<StatefulWidget> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<_Login> {
  Map<String,dynamic> loginJsonData = {};

  final double _sizedBoxHeight= 10.0.h;

  LoginFormBloc? formBloc ;
  @override
  void initState() {

    super.initState();
    loginJsonData = FlavourConstants.loginData;
    prettyPrint(loginJsonData);
  }

  @override
  Widget build(BuildContext context) {

      return BlocProvider(
        create: (context) => LoginFormBloc(loginJsonData),
        child: Builder(
            builder: (context) {
              LoginFormBloc  formBloc =  BlocProvider.of<LoginFormBloc>(context);
              formBloc.tfUsername.updateValue("cm05");
              formBloc.tfPassword.updateValue("Test123#");
              return Scaffold(
                backgroundColor: ParseDataType().getHexToColor(loginJsonData['backgroundColor']),
                body: Container(
                  margin: EdgeInsets.symmetric(horizontal: 20.w),
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
                       Navigator.of(context).pushNamed(RouteConstants.dashboardPath);
                      },
                      onFailure: (context, state) {


                      },
                      child: ScrollableFormBlocManager(
                        formBloc: formBloc,
                        child: ListView(
                            padding: EdgeInsets.zero,
                            shrinkWrap: true,
                            children:[
                              SizedBox(height: _sizedBoxHeight),
                              SizedBox(height: _sizedBoxHeight),
                              SizedBox(height: _sizedBoxHeight),
                              SizedBox(height: _sizedBoxHeight),
                              SizedBox(height: _sizedBoxHeight),
                              SizedBox(height: _sizedBoxHeight),
                              MetaTextView(mapData: loginJsonData['text_title']),
                              SizedBox(height: _sizedBoxHeight * 0.2),
                              MetaTextView(mapData: loginJsonData['text_subtitle']),
                              SizedBox(height: _sizedBoxHeight),
                              SizedBox(height: _sizedBoxHeight),
                              MetaImageView(mapData: loginJsonData['image_view']),
                              SizedBox(height: _sizedBoxHeight),
                              SizedBox(height: _sizedBoxHeight),
                              MetaTextFieldView(mapData: loginJsonData['text_field_username'],
                                  textFieldBloc: formBloc.tfUsername,
                                  onChanged:(value){
                                    formBloc.tfUsername.updateValue(value);
                                  }),
                              MetaTextFieldView(mapData: loginJsonData['text_field_password'],
                                  textFieldBloc: formBloc.tfPassword,
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
                              )
                            ]
                        ),
                      )
                  ),
                ),
              );
            }
        ),
      );
  }


}