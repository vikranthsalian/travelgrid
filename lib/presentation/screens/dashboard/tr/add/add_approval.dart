import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_form_bloc/flutter_form_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:travelgrid/common/constants/flavour_constants.dart';
import 'package:travelgrid/presentation/screens/dashboard/tr/bloc/tr_approval_form_bloc.dart';
import 'package:travelgrid/presentation/widgets/dialog_selector_view.dart';
import 'package:travelgrid/presentation/widgets/switch.dart';
import 'package:travelgrid/presentation/widgets/text_field.dart';

class TrApproval extends StatelessWidget {
  Function? onNext;
  TrApproval({this.onNext});

  Map<String,dynamic> jsonData = {};
  ApprovalTrFormBloc?  formBloc;


  @override
  Widget build(BuildContext context) {
    jsonData = FlavourConstants.trAddApproval;

    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        margin: EdgeInsets.symmetric(vertical: 20.h),
        child: BlocProvider(
          create: (context) => ApprovalTrFormBloc(jsonData),
          child: Builder(
              builder: (context) {
                formBloc =  BlocProvider.of<ApprovalTrFormBloc>(context);
                return Container(
                  margin: EdgeInsets.symmetric(horizontal: 10.w),
                  child: FormBlocListener<ApprovalTrFormBloc, String, String>(
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
                                child: MetaDialogSelectorView(mapData: jsonData['selectRequest'],
                                  text :getInitialText(formBloc!.requestType.value),
                                  onChange:(value){
                                    print(value);
                                    formBloc!.requestType.updateValue(value['text']);
                                  },),
                              ),
                              Container(
                                child: MetaSwitchBloc(
                                    mapData:  jsonData['billableSwitch'],
                                    bloc:  formBloc!.swBillable,
                                    onSwitchPressed: (value){
                                      formBloc!.swBillable.updateValue(value);
                                    }),
                              ),
                              Container(
                                child: MetaDialogSelectorView(mapData: jsonData['selectTravelPurpose'],
                                  text :getInitialText(formBloc!.purposeOfTravel.value),
                                  onChange:(value){
                                    print(value);
                                    formBloc!.purposeOfTravel.updateValue(value['label']);
                                    formBloc!.purposeOfTravelID.updateValue(value['id'].toString());
                                  },),
                              ),
                              Container(
                                child: MetaTextFieldBlocView(mapData: jsonData['text_field_details'],
                                    textFieldBloc: formBloc!.purposeDetails,
                                    onChanged:(value){
                                      formBloc!.purposeDetails.updateValue(value);
                                    }),
                              ),

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


  apprSubmit(){
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
