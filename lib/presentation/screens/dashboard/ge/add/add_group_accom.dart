import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_form_bloc/flutter_form_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:travelgrid/common/constants/flavour_constants.dart';
import 'package:travelgrid/common/extensions/parse_data_type.dart';
import 'package:travelgrid/data/models/ge/ge_group_accom_model.dart';
import 'package:travelgrid/presentation/screens/dashboard/ge/bloc/group_accom_form_bloc.dart';
import 'package:travelgrid/presentation/widgets/button.dart';
import 'package:travelgrid/presentation/widgets/date_time_view.dart';
import 'package:travelgrid/presentation/widgets/dialog_selector_view.dart';
import 'package:travelgrid/presentation/widgets/icon.dart';
import 'package:travelgrid/presentation/widgets/text_view.dart';


class AddGroupAccommodation extends StatelessWidget {
  Function(GEGroupAccomModel)? onAdd;
  bool isEdit;
  bool isView;
  GEGroupAccomModel? accomModel;
  AddGroupAccommodation({this.onAdd,this.isEdit=false,this.isView=false,this.accomModel});
  Map<String,dynamic> jsonData = {};
  GroupAccomFormBloc?  formBloc;
  File? file;
  String violationMessage="";
  Map errorMap={
    "text" : '',
    "color" : "0xFFFFFFFF",
    "size": "10",
    "family": "regular",
    "align" : "center-left"
  };
  List<String> groupValues=[];
  @override
  Widget build(BuildContext context) {
    jsonData = FlavourConstants.addGroupAccom;


    return Scaffold(
      backgroundColor: Colors.white,
      bottomNavigationBar: BottomAppBar(
        color:ParseDataType().getHexToColor(jsonData['backgroundColor']),
        shape: CircularNotchedRectangle(),
        notchMargin: 5,
        elevation: 2.0,
        child:!isView ?  Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            MetaButton(mapData: jsonData['bottomButtonLeft'],
                onButtonPressed: (){
                Navigator.pop(context);
                }
            ),
            MetaButton(mapData: jsonData['bottomButtonRight'],
                onButtonPressed: () async{
                  formBloc!.submit();
                }
            )
          ],
        ) : SizedBox(),
      ),
      body: Column(
        children: [
          Container(
            height: 100.h,
            color:ParseDataType().getHexToColor(jsonData['backgroundColor']),
            child:  Column(
              children: [
                SizedBox(height:40.h),
                Container(
                  alignment: Alignment.center,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      MetaIcon(mapData:jsonData['backBar'],
                          onButtonPressed: (){
                            Navigator.pop(context);
                          }),
                      Container(
                        child:MetaTextView(mapData: jsonData['title']),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: Container(
              child: BlocProvider(
                create: (context) => GroupAccomFormBloc(jsonData),
                child: Builder(
                    builder: (context) {
                    formBloc =  BlocProvider.of<GroupAccomFormBloc>(context);

                    if(isEdit){

                      formBloc!.checkInDate.updateValue(accomModel!.checkInDate.toString());
                      formBloc!.checkInTime.updateValue(accomModel!.checkInTime.toString());

                      formBloc!.checkOutDate.updateValue(accomModel!.checkOutDate.toString());
                      formBloc!.checkOutTime.updateValue(accomModel!.checkOutTime.toString());

                    }else{

                      String  dateText = DateFormat('dd-MM-yyyy').format(DateTime.now());

                      formBloc!.checkInDate.updateValue(dateText);
                      formBloc!.checkOutDate.updateValue(dateText);
                    }

                    return Container(
                      margin: EdgeInsets.symmetric(horizontal: 10.w),
                      child: FormBlocListener<GroupAccomFormBloc, String, String>(
                          onSubmissionFailed: (context, state) {
                          print(state);
                          },
                          onSubmitting: (context, state) {
                            FocusScope.of(context).unfocus();
                          },
                          onSuccess: (context, state) {
                            print(state.successResponse);
                            GEGroupAccomModel modelResponse = GEGroupAccomModel.fromJson(jsonDecode(state.successResponse.toString()));

                            onAdd!(modelResponse);
                            Navigator.pop(context);

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
                                  ...[
                                    AbsorbPointer(
                                      child: Column(
                                        children: [

                                          Container(
                                            child: MetaDateTimeView(mapData: jsonData['checkInDateTime'],
                                              disableFutureDates:true,
                                              value: {
                                                "date": formBloc!.checkInDate.value,
                                                "time": formBloc!.checkInTime.value,
                                              },
                                              onChange: (value){
                                                print(value);
                                                formBloc!.checkInDate.updateValue(value['date'].toString());
                                                formBloc!.checkInTime.updateValue(value['time'].toString());
                                              },),
                                          ),
                                          Container(
                                            child: MetaDateTimeView(mapData: jsonData['checkOutDateTime'],
                                              disableFutureDates:true,
                                              value: {
                                                "date": formBloc!.checkOutDate.value,
                                                "time": formBloc!.checkOutTime.value,
                                              },
                                              onChange: (value){
                                                formBloc!.checkOutDate.updateValue(value['date'].toString());
                                                formBloc!.checkOutTime.updateValue(value['time'].toString());
                                              },),
                                          ),

                                          Container(
                                            margin: EdgeInsets.symmetric(horizontal: 10.w),
                                            child: Row(
                                              children: [
                                                Expanded(
                                                  child: BlocBuilder<SelectFieldBloc, SelectFieldBlocState>(
                                                      bloc: formBloc!.empName,
                                                      builder: (context, state) {
                                                        return Container(
                                                          child: MetaDialogSelectorView(mapData: jsonData['selectEmployeeName'],
                                                            text :getInitialText(formBloc!.empName.value ?? ""),
                                                            onChange:(value){
                                                              print(value);
                                                              formBloc!.empName.updateValue(value['name']);
                                                              formBloc!.empCode.updateValue(value['code']);

                                                            },),
                                                        );
                                                      }
                                                  ),
                                                ),
                                                Expanded(
                                                  child: BlocBuilder<SelectFieldBloc, SelectFieldBlocState>(
                                                      bloc: formBloc!.empCode,
                                                      builder: (context, state) {
                                                        return Container(
                                                          child: MetaDialogSelectorView(mapData: jsonData['selectEmployeeCode'],
                                                            text :getInitialText(formBloc!.empCode.value ?? ""),
                                                            onChange:(value){
                                                              print(value);
                                                              formBloc!.empName.updateValue(value['name']);
                                                              formBloc!.empCode.updateValue(value['code']);

                                                            },),
                                                        );
                                                      }
                                                  ),
                                                )
                                              ],
                                            ),
                                          ),

                                        ],
                                      ),
                                      absorbing: isView,
                                    )
                                  ],

                                  SizedBox(height: 30.h,),

                                ]
                            ),
                          )
                      ),
                    );
                  }
                ),
              ),
            ),
          )

        ],
      ),
    );
  }


  getInitialText(String text) {

    if(text.isNotEmpty){
      return text;
    }
    return null;
  }


}
