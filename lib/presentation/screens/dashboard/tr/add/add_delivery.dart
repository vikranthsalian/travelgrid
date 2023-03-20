import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_form_bloc/flutter_form_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:travelgrid/common/constants/flavour_constants.dart';
import 'package:travelgrid/presentation/components/upload_component.dart';
import 'package:travelgrid/presentation/screens/dashboard/tr/bloc/tr_delivery_form_bloc.dart';
import 'package:travelgrid/presentation/widgets/text_field.dart';

class TrDelivery extends StatelessWidget {
  Function? onNext;
  TrDelivery({this.onNext});

  Map<String,dynamic> jsonData = {};
  DeliveryTrFormBloc?  formBloc;

  @override
  Widget build(BuildContext context) {
    jsonData = FlavourConstants.trAddDelivery;

    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        margin: EdgeInsets.symmetric(vertical: 20.h),
        child: BlocProvider(
          create: (context) => DeliveryTrFormBloc(jsonData),
          child: Builder(
              builder: (context) {


                formBloc =  BlocProvider.of<DeliveryTrFormBloc>(context);
                return Container(
                  margin: EdgeInsets.symmetric(horizontal: 10.w),
                  child: FormBlocListener<DeliveryTrFormBloc, String, String>(
                      onSubmissionFailed: (context, state) {
                        print(state);
                      },
                      onSubmitting: (context, state) {
                        FocusScope.of(context).unfocus();
                      },
                      onSuccess: (context, state) {
                        print(state.successResponse);
                        onNext!(jsonDecode(state.successResponse.toString()));
                      },
                      onFailure: (context, state) {

                        print(state);
                      },
                      child: ScrollableFormBlocManager(
                        formBloc: formBloc!,
                        child:ListView(
                            padding: EdgeInsets.zero,
                            shrinkWrap: true,
                            children:[
                              Container(
                                child: MetaTextFieldBlocView(mapData: jsonData['text_field_appprover'],
                                    textFieldBloc: formBloc!.noteAgent,
                                    onChanged:(value){
                                      formBloc!.noteAgent.updateValue(value);
                                    }),
                              ),
                              Container(
                                child: MetaTextFieldBlocView(mapData: jsonData['text_field_agent'],
                                    textFieldBloc: formBloc!.noteApprover,
                                    onChanged:(value){
                                      formBloc!.noteApprover.updateValue(value);
                                    }),
                              ),
                              SizedBox(height: 20.h,),
                              UploadComponent(jsonData: jsonData['uploadButton'],
                                  onSelected: (File dataFile){
                                    formBloc!.voucherPath.updateValue(dataFile.path);
                                  })
                            ]
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

  delSubmit(){
    print('page1 submit');
    formBloc!.submit();
  }

  getInitialText(String text) {

    if(text.isNotEmpty){
      return text;
    }
    return null;
  }

}
