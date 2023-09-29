import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_form_bloc/flutter_form_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:travelex/common/constants/flavour_constants.dart';
import 'package:travelex/common/enum/dropdown_types.dart';
import 'package:travelex/common/extensions/parse_data_type.dart';
import 'package:travelex/common/utils/city_util.dart';
import 'package:travelex/common/utils/date_time_util.dart';
import 'package:travelex/common/utils/show_alert.dart';
import 'package:travelex/common/utils/upload_util.dart';
import 'package:travelex/data/datasources/summary/te_summary_response.dart';
import 'package:travelex/data/models/expense_model.dart';
import 'package:travelex/data/models/success_model.dart';
import 'package:travelex/data/models/te/te_ticket_model.dart';
import 'package:travelex/presentation/components/upload_component.dart';
import 'package:travelex/presentation/screens/dashboard/te/bloc/te_ticket_form_bloc.dart';
import 'package:travelex/presentation/widgets/button.dart';
import 'package:travelex/presentation/widgets/date_time_view.dart';
import 'package:travelex/presentation/widgets/dialog_selector_view.dart';
import 'package:travelex/presentation/widgets/icon.dart';
import 'package:travelex/presentation/widgets/search_selector_view.dart';
import 'package:travelex/presentation/widgets/switch.dart';
import 'package:travelex/presentation/widgets/text_field.dart';
import 'package:travelex/presentation/widgets/text_view.dart';

class AddTeTicketExpense extends StatelessWidget {
  Function(Map)? onAdd;
  bool isEdit;
  bool isView;
  TETicketModel? teTicketModel;
  String? tripType;
  AddTeTicketExpense(this.tripType,{this.expenseVisitDetails = const [],this.onAdd,this.isEdit=false,this.isView=false,this.teTicketModel});
  List<ExpenseVisitDetails?> expenseVisitDetails;
  
  Map<String,dynamic> jsonData = {};
  TicketTeFormBloc?  formBloc;
  File? file;


  @override
  Widget build(BuildContext context) {
    jsonData = FlavourConstants.teTicketAddData;

    return Scaffold(
      backgroundColor: Colors.white,
      bottomNavigationBar: BottomAppBar(
        color:ParseDataType().getHexToColor(jsonData['backgroundColor']),
        shape: CircularNotchedRectangle(),
        notchMargin: 5,
        elevation: 2.0,
        child:!isView ?   Row(
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

                  if(formBloc!.tfAmount.valueToDouble == 0){
                    MetaAlert.showErrorAlert(message: "Amount value cannot be zero");
                    return;
                  }

                  ExpenseVisitDetails details = ExpenseVisitDetails(city: "");
                  for(var item in expenseVisitDetails){
                    print(jsonEncode(item));
                    print(formBloc!.destination.value);
                    if(item!.city == formBloc!.destination.value){
                      details = item;
                    }
                  }
                  if(details.city!.isNotEmpty){

                    DateTime visitStartDateTime = MetaDateTime().getDateTime(details.evdStartDate!+ " "+details.evdStartTime!);
                    DateTime visitEndDateTime = MetaDateTime().getDateTime(details.evdEndDate!+ " "+details.evdEndTime!);

                    DateTime checkIn = MetaDateTime().getDateTime(formBloc!.checkInDate.value+ " "+formBloc!.checkInTime.value);

                    print("visitStartDateTime");
                    print(visitStartDateTime);
                    print("visitEndDateTime");
                    print(visitEndDateTime);
                    print("checkIn");
                    print(checkIn);
                    if(checkIn.isBefore(visitStartDateTime)){
                      MetaAlert.showErrorAlert(message: "Check-In Date should be greater than visit start date");
                      return;
                    }
                    if(checkIn.isAfter(visitEndDateTime)){
                      MetaAlert.showErrorAlert(message: "Check-In Date should be less than visit end date");
                      return;
                    }

                  }else{
                    MetaAlert.showErrorAlert(message: "Please select appropriate destination city");
                    return;
                  }

                  if(file!=null){
                    SuccessModel model = await  MetaUpload().uploadImage(file!,"EX");
                    if(model.status!){
                      formBloc!.voucherPath.updateValue(model.data!);
                      formBloc!.submit();
                    }
                  }else{
                    formBloc!.submit();
                  }
                }
            )
          ],
        ):SizedBox(),
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
                create: (context) => TicketTeFormBloc(jsonData),
                child: Builder(
                    builder: (context) {
                    formBloc =  BlocProvider.of<TicketTeFormBloc>(context);

                    if(isEdit){

                      formBloc!.checkInDate.updateValue(teTicketModel!.travelDate.toString());
                      formBloc!.checkInTime.updateValue(teTicketModel!.traveltime.toString());


                      formBloc!.origin.updateValue(teTicketModel!.leavingFrom.toString());
                      formBloc!.destination.updateValue(teTicketModel!.goingTo.toString());

                      formBloc!.travelMode.updateValue(teTicketModel!.travelMode.toString());
                      
                      formBloc!.fareClass.updateValue(teTicketModel!.fareClass.toString());

                      formBloc!.tfFlight.updateValue(teTicketModel!.flightTrainBusNo.toString());
                      formBloc!.tfTicket.updateValue(teTicketModel!.ticketNumber.toString());
                      formBloc!.tfPNR.updateValue(teTicketModel!.pnrNumber.toString());
                      formBloc!.tfAmount.updateValue(teTicketModel!.amount.toString());
                      formBloc!.voucherPath.updateValue(teTicketModel!.voucherPath.toString());

                      formBloc!.tfAmount.updateValue(teTicketModel!.amount.toString());
                      formBloc!.tfDescription.updateValue(teTicketModel!.description.toString());
                      formBloc!.selectWithBill.updateValue(teTicketModel!.withBill.toString());
                      formBloc!.swWithBill.updateValue(teTicketModel!.withBill!);

                    }else{

                      String  dateText = DateFormat('dd-MM-yyyy').format(DateTime.now());

                      formBloc!.checkInDate.updateValue(dateText);
                      formBloc!.travelMode.updateValue("A");
                    }

                    return Container(
                      margin: EdgeInsets.symmetric(horizontal: 10.w),
                      child: FormBlocListener<TicketTeFormBloc, String, String>(
                          onSubmissionFailed: (context, state) {
                          print(state);
                          },
                          onSubmitting: (context, state) {
                            FocusScope.of(context).unfocus();
                          },
                          onSuccess: (context, state) {
                            print(state.successResponse);
                            TETicketModel modelResponse = TETicketModel.fromJson(jsonDecode(state.successResponse.toString()));

                            onAdd!(
                                {
                                  "data": jsonDecode(state.successResponse.toString()),
                                  "item" : ExpenseModel(teType: TETypes.TICKET,amount: modelResponse.amount.toString())
                                }
                            );
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
                                          Row(
                                              children: [
                                                Expanded(
                                                  child: Container(
                                                    child: MetaSearchSelectorView(
                                                      tripType,
                                                      mapData: jsonData['selectOrigin'],
                                                      text: CityUtil.getCityNameFromID(formBloc!.origin.value),
                                                      onChange:(value){
                                                        print(value);
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
                                                        formBloc!.destination.updateValue(value.id.toString());
                                                      },),
                                                    alignment: Alignment.centerLeft,
                                                  ),
                                                ),
                                              ]),
                                          // Container(
                                          //   child: MetaSwitchBloc(
                                          //       mapData:  jsonData['byCompanySwitch'],
                                          //       bloc:  formBloc!.swWithBill,
                                          //       onSwitchPressed: (value){
                                          //         formBloc!.selectWithBill.updateValue(value.toString());
                                          //         formBloc!.swWithBill.updateValue(value);
                                          //       }),
                                          // ),
                                          Row(
                                              children: [
                                                Expanded(
                                                  child: Container(
                                                    child: AbsorbPointer(

                                                      child: MetaDialogSelectorView(mapData: jsonData['selectMode'],
                                                        text :CityUtil.getTraveModeFromID(formBloc!.travelMode.value),
                                                        onChange:(value){
                                                          print(value);
                                                          formBloc!.travelMode.updateValue(value['id'].toString());
                                                        },),
                                                    ),
                                                  ),
                                                ),
                                                Expanded(
                                                  child: Container(
                                                    child: MetaDialogSelectorView(mapData: jsonData['selectFare'],
                                                      text :CityUtil.getFareValueFromID(
                                                          formBloc!.fareClass.value,
                                                          formBloc!.travelMode.value),
                                                      onChange:(value){
                                                        print(value);
                                                        formBloc!.fareClass.updateValue(value['value'].toString());
                                                      },),
                                                  ),
                                                ),
                                              ]),

                                          Container(
                                            child: Row(
                                              children: [
                                                Expanded(
                                                  child: MetaTextFieldBlocView(mapData: jsonData['text_field_flight'],
                                                      textFieldBloc: formBloc!.tfFlight,
                                                      onChanged:(value){
                                                        formBloc!.tfFlight.updateValue(value);
                                                      }),
                                                ),
                                                SizedBox(width: 30.w,),
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
                                          MetaTextFieldBlocView(mapData: jsonData['text_field_desc'],
                                              textFieldBloc: formBloc!.tfDescription,
                                              onChanged:(value){
                                                formBloc!.tfDescription.updateValue(value);
                                              }),
                                          Container(
                                            child: MetaSwitchBloc(
                                                mapData:  jsonData['withBillSwitch'],
                                                bloc:  formBloc!.swWithBill,
                                                onSwitchPressed: (value){
                                                  formBloc!.selectWithBill.updateValue(value.toString());
                                                  formBloc!.swWithBill.updateValue(value);
                                                }),
                                          ),
                                        ],
                                      ),
                                      absorbing: isView,
                                    )
                                  ],


                                  BlocBuilder<SelectFieldBloc, SelectFieldBlocState>(
                                      bloc: formBloc!.selectWithBill,
                                      builder: (context, state) {
                                        return Visibility(
                                          visible: state.value == "true" ? true : false,
                                          child:UploadComponent(jsonData: jsonData['uploadButton'],
                                              url:formBloc!.voucherPath.value,
                                              isViewOnly: isView,
                                              onSelected: (dataFile){
                                                file=dataFile;
                                              }),
                                        );
                                      }
                                  ),
                                  SizedBox(height: 20.h)

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
