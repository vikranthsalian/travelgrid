import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_form_bloc/flutter_form_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:travelex/common/constants/flavour_constants.dart';
import 'package:travelex/common/extensions/parse_data_type.dart';
import 'package:travelex/common/utils/city_util.dart';
import 'package:travelex/common/utils/show_alert.dart';
import 'package:travelex/data/datasources/summary/te_summary_response.dart';
import 'package:travelex/data/models/ge/ge_misc_model.dart';
import 'package:travelex/presentation/screens/dashboard/te/bloc/visit_form_bloc.dart';
import 'package:travelex/presentation/widgets/button.dart';
import 'package:travelex/presentation/widgets/date_time_view.dart';
import 'package:travelex/presentation/widgets/icon.dart';
import 'package:travelex/presentation/widgets/search_selector_view.dart';
import 'package:travelex/presentation/widgets/text_view.dart';

class AddVisitDetails extends StatelessWidget {
  Function(ExpenseVisitDetails)? onAdd;
  bool isEdit;
  ExpenseVisitDetails? expenseVisitDetails;
  String? tripType;
  AddVisitDetails(this.tripType,{this.onAdd,this.isEdit=false,this.expenseVisitDetails});
  
  Map<String,dynamic> jsonData = {};
  List items=[];
  double cardHt = 90.h;
  VisitFormBloc? formBloc;
  bool loaded=false;
  File? file;


  @override
  Widget build(BuildContext context) {
    jsonData = FlavourConstants.teAddVisitData;
    return Scaffold(
      backgroundColor: Colors.white,
      bottomNavigationBar: BottomAppBar(
        color:ParseDataType().getHexToColor(jsonData['backgroundColor']),
        shape: CircularNotchedRectangle(),
        notchMargin: 5,
        elevation: 2.0,
        child: Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            MetaButton(mapData: jsonData['bottomButtonLeft'],
                onButtonPressed: (){
                Navigator.pop(context);
                }
            ),
            MetaButton(mapData: jsonData['bottomButtonRight'],
                onButtonPressed: ()async{
               formBloc!.submit();

           }
            )
          ],
        ),
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
                create: (context) => VisitFormBloc(),
                child: Builder(
                    builder: (context) {

                     formBloc =  BlocProvider.of<VisitFormBloc>(context);


                     if(isEdit){
                       print("expenseVisitDetails!.toMap()");
                       print(expenseVisitDetails!.toMap());

                       formBloc!.checkInDate.updateValue(expenseVisitDetails!.evdStartDate.toString());
                       formBloc!.checkInTime.updateValue(expenseVisitDetails!.evdStartTime.toString());

                       formBloc!.checkOutDate.updateValue(expenseVisitDetails!.evdEndDate.toString());
                       formBloc!.checkOutTime.updateValue(expenseVisitDetails!.evdEndTime.toString());

                       formBloc!.cityName.updateValue(expenseVisitDetails!.city.toString());
                       formBloc!.cityID.updateValue(expenseVisitDetails!.city.toString());
                     }else{

                     String  dateText = DateFormat('dd-MM-yyyy').format(DateTime.now());

                       formBloc!.checkInDate.updateValue(dateText);
                       formBloc!.checkOutDate.updateValue(dateText);
                     }



                     return Container(
                      margin: EdgeInsets.symmetric(horizontal: 10.w),
                      child: FormBlocListener<VisitFormBloc, String, String>(
                          onSubmissionFailed: (context, state) {
                            print(state);
                            MetaAlert.showErrorAlert(
                              message: "Please Select All Fields",
                            );

                          },
                          onSubmitting: (context, state) {
                            FocusScope.of(context).unfocus();
                          },
                          onSuccess: (context, state) {
                            print(state.successResponse);
                            ExpenseVisitDetails modelResponse = ExpenseVisitDetails.fromJson(jsonDecode(state.successResponse.toString()));

                            onAdd!(modelResponse);
                            Navigator.pop(context);


                          },
                          onFailure: (context, state) {
                            print(state);

                          },
                          child: ScrollableFormBlocManager(
                            formBloc: formBloc!,
                            child: ListView(
                                padding: EdgeInsets.zero,
                                shrinkWrap: true,
                                children:[
                                  Container(
                                    child: MetaDateTimeView(mapData: jsonData['checkInDateTime'],
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
                                    child: MetaSearchSelectorView(
                                      tripType,
                                      mapData: jsonData['selectCity'],
                                      text:CityUtil.getCityNameFromID(formBloc!.cityName.value) ,
                                      onChange:(value){
                                        formBloc!.cityName.updateValue(value.name);
                                        formBloc!.cityID.updateValue(value.id.toString());
                                      },),
                                    alignment: Alignment.centerLeft,
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
