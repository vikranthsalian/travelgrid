import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_form_bloc/flutter_form_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:travelgrid/common/constants/route_constants.dart';
import 'package:travelgrid/common/extensions/parse_data_type.dart';
import 'package:travelgrid/common/injector/injector.dart';
import 'package:travelgrid/common/utils/city_util.dart';
import 'package:travelgrid/common/utils/show_alert.dart';
import 'package:travelgrid/data/cubits/login_cubit/login_cubit.dart';
import 'package:travelgrid/data/datasources/login_response.dart';
import 'package:travelgrid/data/models/success_model.dart';
import 'package:travelgrid/data/models/tr/tr_city_pair_model.dart';
import 'package:travelgrid/domain/usecases/tr_usecase.dart';
import 'package:travelgrid/presentation/screens/dashboard/tr/bloc/tr_itinerary%20_form_bloc.dart';
import 'package:travelgrid/presentation/widgets/button.dart';
import 'package:travelgrid/presentation/widgets/date_time_view.dart';
import 'package:travelgrid/presentation/widgets/dialog_selector_view.dart';
import 'package:travelgrid/presentation/widgets/icon.dart';
import 'package:travelgrid/presentation/widgets/search_selector_view.dart';
import 'package:travelgrid/presentation/widgets/switch.dart';
import 'package:travelgrid/presentation/widgets/text_field.dart';
import 'package:travelgrid/presentation/widgets/text_view.dart';

class AddItinerary  extends StatelessWidget {
  Map<String,dynamic> jsonData = {};
  Function? onAdd;
  TRCityPairModel? cityPairs;
  bool isEdit;
  String? tripType;
  AddItinerary({required this.jsonData,this.onAdd,this.cityPairs,this.isEdit=false,this.tripType});

  Map errorMap={
    "text" : '',
    "color" : "0xFFFFFFFF",
    "size": "10",
    "family": "regular",
    "align" : "center-left"
  };
  String errorMsg="";
  ItineraryFormBloc?  formBloc;
  MetaLoginResponse loginResponse = MetaLoginResponse();
  String fromCode="";
  String toCode="";
  @override
  Widget build(BuildContext context) {
    loginResponse = context.read<LoginCubit>().getLoginResponse();

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
                onButtonPressed: (){
                formBloc!.submit();
                }
            )
          ],
        ),
      ),
      body: Container(
        color:ParseDataType().getHexToColor(jsonData['backgroundColor']),
        child: Column(
          children: [
            SizedBox(height:40.h),
            Container(
              height: 40.h,
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
            Expanded(
              child: Container(
                color:Colors.white,
                child: BlocProvider(
                  create: (context) => ItineraryFormBloc(jsonData),
                  child: Builder(
                      builder: (context) {


                        formBloc =  BlocProvider.of<ItineraryFormBloc>(context);
                        String  dateText = DateFormat('dd-MM-yyyy').format(DateTime.now());
                        formBloc!.checkInDate.updateValue(dateText);
                        //formBloc!.checkInTime.updateValue("00:00");

                        formBloc!.travelMode.updateValue("A");
                        formBloc!.travelModeID.updateValue("A");

                        formBloc!.swByCompany.updateValue(true);
                        formBloc!.swByCompanyID.updateValue(true);


                        if(tripType=="O"){
                          formBloc!.travelMode.updateValue("A");
                          formBloc!.travelModeID.updateValue("A");
                        }

                        if(isEdit){

                          print(cityPairs!.toJson());

                          formBloc!.origin.updateValue(cityPairs!.leavingFrom!);
                          formBloc!.destination.updateValue(cityPairs!.goingTo!);

                          formBloc!.checkInDate.updateValue(cityPairs!.startDate!);
                          formBloc!.checkInTime.updateValue(cityPairs!.startTime!);

                          formBloc!.travelMode.updateValue(cityPairs!.travelMode!);
                          formBloc!.travelModeID.updateValue(cityPairs!.travelMode!);


                          if(cityPairs!.byCompany==42){
                            formBloc!.swByCompany.updateValue(true);
                            formBloc!.swByCompanyID.updateValue(true);
                          }

                            formBloc!.fareClass.updateValue(cityPairs!.fareClass.toString());



                          if(cityPairs!.price!=null){
                            formBloc!.tfAmount.updateValue(cityPairs!.price!.toString());
                          }


                          formBloc!.tfTicket.updateValue(cityPairs!.ticket!);
                          formBloc!.tfPNR.updateValue(cityPairs!.pnr!);
                        }


                        return Container(
                          child: FormBlocListener<ItineraryFormBloc, String, String>(
                              onSubmissionFailed: (context, state) {
                                print(state);
                              },
                              onSubmitting: (context, state) {
                                FocusScope.of(context).unfocus();
                              },
                              onSuccess: (context, state) {
                                print(state.successResponse);
                                 TRCityPairModel modelResponse = TRCityPairModel.fromJson(jsonDecode(state.successResponse.toString()));

                                onAdd!(modelResponse);
                                Navigator.pop(context);
                              },
                              onFailure: (context, state) {

                                print(state);
                              },
                              child: ScrollableFormBlocManager(
                                formBloc: formBloc!,
                                child:Container(
                                  child: ListView(
                                    padding: EdgeInsets.zero,
                                      shrinkWrap: true,
                                      children:[
                                        Container(
                                          margin: EdgeInsets.symmetric(horizontal: 10.w,vertical: 10.h),
                                          child: Column(
                                            children: [
                                              Row(
                                                  children: [
                                                    Expanded(
                                                      child: Container(
                                                        child: MetaSearchSelectorView(
                                                          tripType,
                                                          mapData: jsonData['selectOrigin'],
                                                          text: CityUtil.getCityNameFromID(formBloc!.origin.value),
                                                          onChange:(value){
                                                            print(jsonEncode(value));
                                                            fromCode=value;
                                                            formBloc!.origin.updateValue(value.id.toString());
                                                          },),
                                                        alignment: Alignment.centerLeft,
                                                      ),
                                                    ),
                                                    Expanded(
                                                      child: Container(
                                                        child: MetaSearchSelectorView(
                                                          tripType,
                                                          mapData: jsonData['selectDestination'],
                                                          text: CityUtil.getCityNameFromID(formBloc!.destination.value),
                                                          onChange:(value){
                                                            fromCode=value;
                                                            formBloc!.destination.updateValue(value.id.toString());
                                                          },),
                                                        alignment: Alignment.centerLeft,
                                                      ),
                                                    ),
                                                  ]),

                                              Row(
                                                  children: [
                                                    tripType=="D"?
                                                    Expanded(
                                                      child: Container(
                                                        child: MetaDialogSelectorView(mapData: jsonData['selectMode'],
                                                          text :CityUtil.getTraveModeFromID(formBloc!.travelMode.value),
                                                          onChange:(value){
                                                            print(value);
                                                            formBloc!.travelMode.updateValue(value['id'].toString());
                                                            formBloc!.travelModeID.updateValue(value['id'].toString());
                                                            formBloc!.fareClass.updateValue("");
                                                          },),
                                                      ),
                                                    ):Expanded(
                                                      child: AbsorbPointer(
                                                        child: Container(
                                                          child: MetaDialogSelectorView(mapData: jsonData['selectMode'],
                                                            text :CityUtil.getTraveModeFromID(formBloc!.travelMode.value),
                                                            onChange:(value){
                                                              print(value);
                                                              formBloc!.travelMode.updateValue(value['id'].toString());
                                                              formBloc!.travelModeID.updateValue(value['id'].toString());
                                                              formBloc!.fareClass.updateValue("");
                                                            },),
                                                        ),
                                                      ),
                                                    ),

                                                    Expanded(
                                                      child: BlocBuilder<SelectFieldBloc, SelectFieldBlocState>(
                                                          bloc: formBloc!.travelModeID,
                                                          builder: (context, state) {
                                                            return Container(
                                                              child: MetaDialogSelectorView(mapData: jsonData['selectFare'],
                                                                modeType: formBloc!.travelMode.value,
                                                                text :CityUtil.getFareValueFromID(
                                                                    formBloc!.fareClass.value,
                                                                    formBloc!.travelMode.value,
                                                                  isValue: false
                                                                ),
                                                                onChange:(value)async{
                                                                  print(value);
                                                                  formBloc!.fareClass.updateValue(value['id'].toString());

                                                                  Map<String,dynamic> params = {
                                                                    "tripTypeFC": tripType,
                                                                    "gradeFC":loginResponse.data!.grade!.organizationGrade,
                                                                    "travelModeFC":formBloc!.travelModeID.value,
                                                                    "fareClassFC":value['value'],
                                                                    "index":value['id'].toString(),
                                                                  };

                                                                  SuccessModel model =   await Injector.resolve<TrUseCase>().checkFireFareClassRule(params);

                                                                  if(model.status! && model.message!=null){
                                                                    print("seterror");
                                                                    errorMsg = model.message.toString();
                                                                    formBloc!.showError.updateValue(true);
                                                                  }else{
                                                                    errorMsg = "";
                                                                    print("seterror false");
                                                                    formBloc!.showError.updateValue(false);
                                                                  }


                                                                },),
                                                            );
                                                          }
                                                      ),
                                                    ),
                                                  ]),
                                              BlocBuilder<SelectFieldBloc, SelectFieldBlocState>(
                                                  bloc: formBloc!.showError,
                                                  builder: (context, state) {
                                                    return Visibility(
                                                      visible:state.value,
                                                      child:Container(
                                                          padding: EdgeInsets.symmetric(horizontal: 10.w),
                                                          height: 20.h,
                                                          color: Color(0xFFB71C1C),
                                                          child: MetaTextView(mapData: errorMap,text: errorMsg)
                                                      ),
                                                    );
                                                  }
                                              ),

                                              BlocBuilder<SelectFieldBloc, SelectFieldBlocState>(
                                                  bloc: formBloc!.travelModeID,
                                                  builder: (context, state) {

                                                    if(formBloc!.travelModeID.value=="A"){
                                                      return  Container(
                                                        child: MetaSwitchBloc(
                                                            mapData:  jsonData['byCompanySwitch'],
                                                            bloc:  formBloc!.swByCompany,
                                                            onSwitchPressed: (value){
                                                              //  formBloc!.selectWithBill.updateValue(value.toString());
                                                              formBloc!.swByCompany.updateValue(value);
                                                              formBloc!.swByCompanyID.updateValue(value);
                                                            }),
                                                      );
                                                    }

                                                    formBloc!.swByCompany.updateValue(false);
                                                    formBloc!.swByCompanyID.updateValue(false);

                                                    return  AbsorbPointer(
                                                      child: Container(
                                                        child: MetaSwitchBloc(
                                                            mapData:  jsonData['byCompanySwitch'],
                                                            bloc:  formBloc!.swByCompany,
                                                            onSwitchPressed: (value){

                                                              formBloc!.swByCompany.updateValue(value);
                                                              formBloc!.swByCompanyID.updateValue(value);
                                                            }),
                                                      ),
                                                    );

                                                  }
                                              ),

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



                                             BlocBuilder<SelectFieldBloc, SelectFieldBlocState>(
                                                  bloc: formBloc!.swByCompanyID,
                                                  builder: (context, state) {

                                                    return  Visibility(
                                                      visible: !formBloc!.swByCompanyID.value! ,
                                                      child: Column(
                                                        children: [

                                                          Container(
                                                            child:InkWell(
                                                                onTap:(){

                                                                  if(fromCode.isNotEmpty && toCode.isNotEmpty && formBloc!.checkInDate.value.isNotEmpty)
                                                                  {
                                                                var data =  Navigator.of(context).pushReplacementNamed(RouteConstants.flightPath,
                                                                  arguments: {
                                                                    "from":fromCode,
                                                                    "to":   toCode,
                                                                    "date":formBloc!.checkInDate
                                                                  });
                                                                print("flightData");
                                                                print(data);
                                                                 }else{
                                                                    MetaAlert.showErrorAlert(message: "Please select fields");
                                                                 }
                                                                  },
                                                                child: MetaTextView(mapData: jsonData['flight'])),
                                                          ),

                                                          Container(
                                                            child: Row(
                                                              children: [
                                                                Expanded(
                                                                  child: MetaTextFieldBlocView(mapData: jsonData['text_field_pnr'],
                                                                      textFieldBloc: formBloc!.tfPNR,
                                                                      onChanged:(value){
                                                                        formBloc!.tfPNR.updateValue(value);
                                                                      }),
                                                                ),
                                                              ],
                                                            ),
                                                          ),
                                                          Container(
                                                            child: Row(
                                                              children: [
                                                                Expanded(
                                                                  child: MetaTextFieldBlocView(mapData: jsonData['text_field_ticket'],
                                                                      textFieldBloc: formBloc!.tfTicket,
                                                                      onChanged:(value){
                                                                        formBloc!.tfTicket.updateValue(value);
                                                                      }),
                                                                ),
                                                                SizedBox(width: 30.w,),

                                                                Expanded(
                                                                  child: MetaTextFieldBlocView(mapData: jsonData['text_field_amount'],
                                                                      textFieldBloc: formBloc!.tfAmount,
                                                                      onChanged:(value){
                                                                        formBloc!.tfAmount.updateValue(value);
                                                                      }),
                                                                ),
                                                              ],
                                                            ),
                                                          ),

                                                        ],
                                                      ),
                                                    );
                                                  }
                                             )


                                            ],
                                          ),
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
            ),
          ],
        ),
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
