import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_form_bloc/flutter_form_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:travelgrid/common/constants/flavour_constants.dart';
import 'package:travelgrid/common/extensions/parse_data_type.dart';
import 'package:travelgrid/data/models/tr/tr_traveller_details.dart';
import 'package:travelgrid/presentation/components/switch_component.dart';
import 'package:travelgrid/presentation/screens/dashboard/tr/bloc/tr_approval_form_bloc.dart';
import 'package:travelgrid/presentation/widgets/dialog_selector_view.dart';
import 'package:travelgrid/presentation/widgets/search_selector_view.dart';
import 'package:travelgrid/presentation/widgets/switch.dart';
import 'package:travelgrid/presentation/widgets/text_field.dart';
import 'package:travelgrid/presentation/widgets/text_view.dart';

class TrApproval extends StatelessWidget {
  Function? onNext;
  Map<String,dynamic> submitData;
  TrApproval({this.onNext,this.submitData=const {}});

  Map<String,dynamic> jsonData = {};
  ApprovalTrFormBloc?  formBloc;

  bool showTravellerItems=true;
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

                if(submitData.isNotEmpty){

                  print("submitData");
                  print(submitData);
                  if(submitData['requestType']!=null){
                    formBloc!.requestTypeID.updateValue(submitData['requestType']);
                    formBloc!.requestType.updateValue(submitData['requestType']);
                  }


                }

                return Container(
                //  margin: EdgeInsets.symmetric(horizontal: 10.w),
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
                                margin: EdgeInsets.symmetric(horizontal: 10.w),
                                child: Row(
                                  children: [
                                    Expanded(
                                      child: Container(
                                        child: MetaDialogSelectorView(mapData: jsonData['selectRequest'],
                                          text :getInitialText(formBloc!.requestType.value),
                                          onChange:(value){
                                            print(value);

                                            formBloc!.requestType.updateValue(value['text']);
                                            formBloc!.requestTypeID.updateValue(value['id']);
                                            if(formBloc!.requestTypeID.value == "self"){
                                              formBloc!.travellerDetails.clear();
                                              formBloc!.travellerDetails.updateValue(null);
                                              formBloc!.employeeType.updateValue("");
                                            }


                                          },),
                                      ),
                                    ),
                                    Expanded(
                                      child: BlocBuilder<SelectFieldBloc, SelectFieldBlocState>(
                                          bloc: formBloc!.requestTypeID,
                                          builder: (context, state) {
                                            return Visibility(
                                              visible: state.value == "onBehalf" ? true : false,
                                              child:Container(
                                                child: MetaDialogSelectorView(mapData: jsonData['selectEmployeeType'],
                                                  text :getInitialText(formBloc!.employeeType.value!??""),
                                                  onChange:(value){
                                                    formBloc!.employeeType.updateValue(value['text']);
                                                  },),
                                              ),
                                            );
                                          }
                                      ),
                                    ),
                                  ],
                                ),
                              ),

                              Container(
                                child: BlocBuilder<SelectFieldBloc, SelectFieldBlocState>(
                                    bloc: formBloc!.employeeType,
                                    builder: (context, state) {

                                      return Visibility(
                                        visible: (formBloc!.requestTypeID.value == "onBehalf") ? true : false,
                                        child:  Column(
                                          children: [
                                            Container(
                                              margin: EdgeInsets.symmetric(horizontal: 10.w),
                                              child: MetaSearchSelectorView(
                                                "",
                                                isCitySearch: false,
                                                mapData: jsonData['selectEmployeeCode'],
                                                text: getInitialText(formBloc!.travellerDetails.value?.name ?? ""),
                                                onChange:(value){
                                                  print(jsonEncode(value));

                                                  TRTravellerDetails data = TRTravellerDetails(
                                                      employeeCode: value.employeecode,
                                                      employeeName: value.fullName,
                                                      email: value.currentContact.email ?? "",
                                                      employeeType: "Employee",
                                                      mobileNumber: value.currentContact.mobile ?? "",
                                                      emergencyContactNo: value.currentContact.telephoneNo ?? ""
                                                  );

                                                  formBloc!.travellerDetails.updateValue(data);
                                                },),
                                              alignment: Alignment.centerLeft,
                                            ),

                                            SwitchComponent(
                                                color:ParseDataType().getHexToColor(jsonData['backgroundColor']),
                                                jsonData: jsonData['travellerDetails'],
                                                childWidget: buildTravellerWidget(jsonData['travellerDetails']),
                                                initialValue: showTravellerItems),
                                          ],
                                        ),
                                      );
                                    }
                                ),
                              ),


                              Container(
                                margin: EdgeInsets.symmetric(horizontal: 10.w),
                                child: MetaSwitchBloc(
                                    mapData:  jsonData['billableSwitch'],
                                    bloc:  formBloc!.swBillable,
                                    onSwitchPressed: (value){
                                      formBloc!.swBillable.updateValue(value);
                                    }),
                              ),
                              Container(
                                margin: EdgeInsets.symmetric(horizontal: 10.w),
                                child: MetaDialogSelectorView(mapData: jsonData['selectTravelPurpose'],
                                  text :getInitialText(formBloc!.purposeOfTravel.value),
                                  onChange:(value){
                                    print(value);
                                    formBloc!.purposeOfTravel.updateValue(value['label']);
                                    formBloc!.purposeOfTravelID.updateValue(value['id'].toString());
                                  },),
                              ),
                              Container(
                                margin: EdgeInsets.symmetric(horizontal: 10.w),
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

  buildTravellerWidget(Map map) {

    return BlocBuilder<SelectFieldBloc, SelectFieldBlocState>(
        bloc: formBloc!.travellerDetails,
        builder: (context, state) {

          if(formBloc!.travellerDetails.value == null){
            return Container(
              padding: EdgeInsets.symmetric(horizontal: 10.w,vertical: 10.h),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  MetaTextView(mapData: map['item'],text: "No Data Found",),
                ],
              ),
            );
          }

          TRTravellerDetails? details  = formBloc!.travellerDetails.value! ;
          return  Container(
            padding: EdgeInsets.symmetric(horizontal: 10.w,vertical: 10.h),
            color: Colors.white,
            child: Column(
              children: [
                Container(
                  child: Row(
                    children: [
                      Expanded(child: Column(
                        children: [
                          MetaTextView(mapData:  map['header'],text: "Emp. Code",),
                          MetaTextView(mapData:  map['item'],text: details.employeeCode!),
                        ],
                      )),
                      Expanded(child: Column(
                        children: [
                          MetaTextView(mapData:  map['header'],text: "Emp. Name",),
                          MetaTextView(mapData:  map['item'],text:details.employeeName),
                        ],
                      )),

                    ],
                  ),
                ),

                Container(
                  child: Row(
                    children: [
                      Expanded(child: Column(
                        children: [
                          MetaTextView(mapData:  map['header'],text: "Gender",),
                          MetaTextView(mapData:  map['item'],text: details.gender ?? ""),
                        ],
                      )),
                      Expanded(child: Column(
                        children: [
                          MetaTextView(mapData:  map['header'],text: "Grade",),
                          MetaTextView(mapData:  map['item'],text:details.organizationGrade ?? ""),
                        ],
                      )),
                      Expanded(child: Column(
                        children: [
                          MetaTextView(mapData:  map['header'],text: "Location",),
                          MetaTextView(mapData:  map['item'],text:details.location ?? ""),
                        ],
                      )),
                    ],
                  ),
                ),
                Column(
                  children: [
                    MetaTextView(mapData:  map['header'],text: "Email",),
                    MetaTextView(mapData:  map['item'],text: details.email!),
                  ],
                ),
              ],
            ),
          );
        }
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
