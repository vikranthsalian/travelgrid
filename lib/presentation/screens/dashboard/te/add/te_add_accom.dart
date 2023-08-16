import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_form_bloc/flutter_form_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:travelgrid/common/constants/flavour_constants.dart';
import 'package:travelgrid/common/enum/dropdown_types.dart';
import 'package:travelgrid/common/extensions/parse_data_type.dart';
import 'package:travelgrid/common/utils/city_util.dart';
import 'package:travelgrid/common/utils/date_time_util.dart';
import 'package:travelgrid/common/utils/show_alert.dart';
import 'package:travelgrid/common/utils/upload_util.dart';
import 'package:travelgrid/data/datasources/summary/te_summary_response.dart';
import 'package:travelgrid/data/models/expense_model.dart';
import 'package:travelgrid/data/models/success_model.dart';
import 'package:travelgrid/data/models/te/te_accom_model.dart';
import 'package:travelgrid/presentation/components/upload_component.dart';
import 'package:travelgrid/presentation/screens/dashboard/te/bloc/te_accom_form_bloc.dart';
import 'package:travelgrid/presentation/widgets/button.dart';
import 'package:travelgrid/presentation/widgets/date_time_view.dart';
import 'package:travelgrid/presentation/widgets/dialog_selector_view.dart';
import 'package:travelgrid/presentation/widgets/icon.dart';
import 'package:travelgrid/presentation/widgets/search_selector_view.dart';
import 'package:travelgrid/presentation/widgets/switch.dart';
import 'package:travelgrid/presentation/widgets/text_field.dart';
import 'package:travelgrid/presentation/widgets/text_view.dart';

class AddTeAccommodationExpense extends StatelessWidget {
  Function(Map)? onAdd;
  bool isEdit;
  bool isView;
  TEAccomModel? accomModel;
  String? tripType;
  AddTeAccommodationExpense(this.tripType,{this.expenseVisitDetails = const [],this.onAdd,this.isEdit=false,this.isView=false,this.accomModel});
  Map<String,dynamic> jsonData = {};
  AccomTeFormBloc?  formBloc;
  List<ExpenseVisitDetails?> expenseVisitDetails;
  File? file;
  String violationMessage="";

  Map errorMap={
    "text" : '',
    "color" : "0xFFFFFFFF",
    "size": "10",
    "family": "regular",
    "align" : "center-left"
  };

  @override
  Widget build(BuildContext context) {
    jsonData = FlavourConstants.teAccomAddData;

    return Scaffold(
      backgroundColor: Colors.white,
      bottomNavigationBar: BottomAppBar(
        color:ParseDataType().getHexToColor(jsonData['backgroundColor']),
        shape: CircularNotchedRectangle(),
        notchMargin: 5,
        elevation: 2.0,
        child: !isView ?  Row(
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


              ExpenseVisitDetails details=ExpenseVisitDetails(city: "");
              for(var item in expenseVisitDetails){
                print(jsonEncode(item));
                if(item!.city == formBloc!.cityID.value){
                  details =item;
                }
              }
              if(details.city!.isNotEmpty){

                DateTime visitStartDateTime = MetaDateTime().getDateTime(details.evdStartDate!+ " "+details.evdStartTime!);
                DateTime visitEndDateTime = MetaDateTime().getDateTime(details.evdEndDate!+ " "+details.evdEndTime!);

                DateTime checkIn = MetaDateTime().getDateTime(formBloc!.checkInDate.value+ " "+formBloc!.checkInTime.value);
                DateTime checkOut = MetaDateTime().getDateTime(formBloc!.checkOutDate.value+ " "+formBloc!.checkOutTime.value);


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
                print("-----------------------------------");

                print("checkOut");
                print(checkOut);

                if(checkOut.isBefore(visitStartDateTime) ){
                  MetaAlert.showErrorAlert(message: "Check-Out Date should be greater than visit start date");
                  return;
                }

                if(checkOut.isAfter(visitEndDateTime)){
                  MetaAlert.showErrorAlert(message: "Check-Out Date should be less than visit end date");
                  return;
                }


              }else{
                MetaAlert.showErrorAlert(message: "Please select appropriate city");
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
                create: (context) => AccomTeFormBloc(jsonData),
                child: Builder(
                    builder: (context) {
                    formBloc =  BlocProvider.of<AccomTeFormBloc>(context);

                    if(isEdit){

                      formBloc!.checkInDate.updateValue(accomModel!.checkInDate.toString());
                      formBloc!.checkInTime.updateValue(accomModel!.checkInTime.toString());

                      formBloc!.checkOutDate.updateValue(accomModel!.checkOutDate.toString());
                      formBloc!.checkOutTime.updateValue(accomModel!.checkOutTime.toString());

                      formBloc!.cityName.updateValue(accomModel!.city.toString());
                      formBloc!.cityID.updateValue(accomModel!.city.toString());

                      formBloc!.selectAccomID.updateValue(accomModel!.accomodationType.toString());
                      formBloc!.accomName.updateValue(accomModel!.accomodationType.toString());

                      formBloc!.tfHotelName.updateValue(accomModel!.hotelName.toString());
                      if(accomModel!.hotelName.toString().isEmpty){
                        formBloc!.tfHotelName.updateValue("nill");
                      }


                      formBloc!.tfVoucher.updateValue(accomModel!.voucherNumber.toString());
                      if(accomModel!.voucherNumber.toString().isEmpty){
                        formBloc!.tfVoucher.updateValue("nill");
                      }

                      formBloc!.voucherPath.updateValue(accomModel!.voucherPath.toString());

                      formBloc!.tfTax.updateValue(accomModel!.tax.toString());
                      formBloc!.tfAmount.updateValue(accomModel!.amount.toString());
                      formBloc!.tfDescription.updateValue(accomModel!.description.toString());

                      formBloc!.selectWithBill.updateValue(accomModel!.withBill.toString());
                      formBloc!.swWithBill.updateValue(accomModel!.withBill!);
                      violationMessage=accomModel!.voilationMessage!;

                    }

                    return Container(
                      margin: EdgeInsets.symmetric(horizontal: 10.w),
                      child: FormBlocListener<AccomTeFormBloc, String, String>(
                          onSubmissionFailed: (context, state) {
                          print(state);
                          },
                          onSubmitting: (context, state) {
                            FocusScope.of(context).unfocus();
                          },
                          onSuccess: (context, state) {
                            print(state.successResponse);
                            TEAccomModel modelResponse = TEAccomModel.fromJson(jsonDecode(state.successResponse.toString()));

                            onAdd!(
                                {
                                  "data": jsonDecode(state.successResponse.toString()),
                                  "item" : ExpenseModel(teType: TETypes.ACCOMMODATION,amount: (modelResponse.amount!+modelResponse.tax!).toString())
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
                                      child: Column(children: [
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
                                        Row(
                                            children: [
                                              Expanded(
                                                child: Container(
                                                  child: MetaSearchSelectorView(
                                                    tripType,
                                                    mapData: jsonData['selectCity'],
                                                    text: CityUtil.getCityNameFromID(formBloc!.cityName.value) ,
                                                    onChange:(value){
                                                      formBloc!.cityName.updateValue(value.name);
                                                      formBloc!.cityID.updateValue(value.id.toString());
                                                    },),
                                                  alignment: Alignment.centerLeft,
                                                ),
                                              ),
                                              Expanded(
                                                child: Container(
                                                  child: MetaDialogSelectorView(mapData: jsonData['selectType'],
                                                    text :CityUtil.getAccomNameFromID(formBloc!.accomName.value),
                                                    onChange:(value){
                                                      print(value);
                                                      formBloc!.selectAccomID.updateValue(value['id'].toString());
                                                      formBloc!.accomName.updateValue(value['label']);
                                                    },),
                                                ),
                                              ),
                                            ]),
                                        Container(
                                          child: MetaSwitchBloc(
                                              mapData:  jsonData['byCompanySwitch'],
                                              bloc:  formBloc!.swWithBill,
                                              onSwitchPressed: (value){
                                                formBloc!.selectWithBill.updateValue(value.toString());
                                                formBloc!.swWithBill.updateValue(value);
                                              }),
                                        ),
                                        BlocBuilder<SelectFieldBloc, SelectFieldBlocState>(
                                            bloc: formBloc!.selectAccomID,
                                            builder: (context, state) {
                                              return Visibility(
                                                visible: state.value == "250" ? true : false,
                                                child:MetaTextFieldBlocView(mapData: jsonData['text_field_hotel'],
                                                    textFieldBloc: formBloc!.tfHotelName,
                                                    onChanged:(value){
                                                      formBloc!.tfHotelName.updateValue(value);
                                                    }),
                                              );
                                            }
                                        ),
                                        BlocBuilder<SelectFieldBloc, SelectFieldBlocState>(
                                            bloc: formBloc!.selectWithBill,
                                            builder: (context, state) {
                                              return
                                                Visibility(
                                                  visible: state.value == "true" ? true : false,
                                                  child:MetaTextFieldBlocView(mapData: jsonData['text_field_voucher'],
                                                      textFieldBloc: formBloc!.tfVoucher,
                                                      onChanged:(value){
                                                        formBloc!.tfVoucher.updateValue(value);
                                                      }),
                                                );
                                            }
                                        ),

                                        Container(
                                          child: Row(
                                            children: [
                                              Expanded(
                                                child: MetaTextFieldBlocView(mapData: jsonData['text_field_amount'],
                                                    textFieldBloc: formBloc!.tfAmount,
                                                    onChanged:(value){
                                                      formBloc!.tfAmount.updateValue(value);
                                                    }),
                                              ),
                                              SizedBox(width: 30.w,),
                                              Expanded(
                                                child: MetaTextFieldBlocView(mapData: jsonData['text_field_tax'],
                                                    textFieldBloc: formBloc!.tfTax,
                                                    onChanged:(value){
                                                      formBloc!.tfTax.updateValue(value);
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
                                        (violationMessage!=null && violationMessage.isNotEmpty) ?
                                        Container(
                                            padding: EdgeInsets.symmetric(horizontal: 10.w),
                                            height: 20.h,
                                            color: Color(0xFFB71C1C),
                                            child: MetaTextView(mapData: errorMap,text:violationMessage)
                                        ):SizedBox(),
                                        Container(
                                          child: MetaSwitchBloc(
                                              mapData:  jsonData['withBillSwitch'],
                                              bloc:  formBloc!.swWithBill,
                                              onSwitchPressed: (value){
                                                formBloc!.selectWithBill.updateValue(value.toString());
                                                formBloc!.swWithBill.updateValue(value);
                                              }),
                                        ),
                                      ],),
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
                                              isViewOnly:isView,
                                              onSelected: (dataFile){
                                                file=dataFile;
                                              }),
                                        );
                                      }
                                  ),
                                  SizedBox(height: 20.h),

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

  getTimeInDouble(TimeOfDay time) {
    return (time.hour * 60) + time.minute;

  }


}
