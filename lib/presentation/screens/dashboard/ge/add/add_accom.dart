import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_bloc/flutter_form_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:travelgrid/common/constants/flavour_constants.dart';
import 'package:travelgrid/common/enum/dropdown_types.dart';
import 'package:travelgrid/common/extensions/parse_data_type.dart';
import 'package:travelgrid/common/injector/injector.dart';
import 'package:travelgrid/data/models/expense_model.dart';
import 'package:travelgrid/data/models/ge/ge_accom_model.dart';
import 'package:travelgrid/data/models/success_model.dart';
import 'package:travelgrid/domain/usecases/common_usecase.dart';
import 'package:travelgrid/presentation/components/upload_component.dart';
import 'package:travelgrid/presentation/screens/dashboard/ge/bloc/accom_form_bloc.dart';
import 'package:travelgrid/presentation/widgets/button.dart';
import 'package:travelgrid/presentation/widgets/date_time_view.dart';
import 'package:travelgrid/presentation/widgets/dialog_selector_view.dart';
import 'package:travelgrid/presentation/widgets/icon.dart';
import 'package:travelgrid/presentation/widgets/search_selector_view.dart';
import 'package:travelgrid/presentation/widgets/switch.dart';
import 'package:travelgrid/presentation/widgets/text_field.dart';
import 'package:travelgrid/presentation/widgets/text_view.dart';

class CreateAccommodationExpense extends StatefulWidget {
  Function(Map)? onAdd;
  bool isEdit;
  GEAccomModel? accomModel;
  String? tripType;
  CreateAccommodationExpense(this.tripType,{this.onAdd,this.isEdit=false,this.accomModel});
  @override
  _CreateAccommodationExpenseState createState() => _CreateAccommodationExpenseState();
}

class _CreateAccommodationExpenseState extends State<CreateAccommodationExpense> {
  Map<String,dynamic> jsonData = {};
  AccomFormBloc?  formBloc;
  File? file;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    jsonData = FlavourConstants.accomCreateData;
   // prettyPrint(jsonData);

  }


  @override
  Widget build(BuildContext context) {


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
                onButtonPressed: () async{
                  if(formBloc!.swWithBill.value && file!=null){
                    String fileName = file!.path.split('/').last;
                    String  dateText = DateFormat('dd-MM-yyyy_hh:ss').format(DateTime.now());
                    FormData formData = FormData.fromMap({
                      "file": await MultipartFile.fromFile(file!.path, filename:dateText+"_"+fileName),
                    });
                    SuccessModel model =  await Injector.resolve<CommonUseCase>().uploadFile(formData,"GE");
                    if(model.status!){
                      formBloc!.voucherPath.updateValue(model.data!);
                      formBloc!.submit();
                    }
                  }
                  else{
                    formBloc!.submit();
                  }
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
                create: (context) => AccomFormBloc(jsonData),
                child: Builder(
                    builder: (context) {
                    formBloc =  BlocProvider.of<AccomFormBloc>(context);

                    if(widget.isEdit){

                      formBloc!.checkInDate.updateValue(widget.accomModel!.checkInDate.toString());
                      formBloc!.checkInTime.updateValue(widget.accomModel!.checkInTime.toString());

                      formBloc!.checkOutDate.updateValue(widget.accomModel!.checkOutDate.toString());
                      formBloc!.checkOutTime.updateValue(widget.accomModel!.checkOutTime.toString());

                      formBloc!.cityName.updateValue(widget.accomModel!.cityName.toString());
                      formBloc!.cityID.updateValue(widget.accomModel!.city.toString());

                      formBloc!.selectAccomID.updateValue(widget.accomModel!.accomodationType.toString());
                      formBloc!.accomName.updateValue(widget.accomModel!.accomodationTypeName.toString());

                      formBloc!.tfHotelName.updateValue(widget.accomModel!.hotelName.toString());
                      if(widget.accomModel!.hotelName.toString().isEmpty){
                        formBloc!.tfHotelName.updateValue("nill");
                      }


                      formBloc!.tfVoucher.updateValue(widget.accomModel!.voucherNumber.toString());
                      if(widget.accomModel!.voucherNumber.toString().isEmpty){
                        formBloc!.tfVoucher.updateValue("nill");
                      }

                      formBloc!.voucherPath.updateValue(widget.accomModel!.voucherPath.toString());

                      formBloc!.tfTax.updateValue(widget.accomModel!.tax.toString());
                      formBloc!.tfAmount.updateValue(widget.accomModel!.amount.toString());
                      formBloc!.tfDescription.updateValue(widget.accomModel!.description.toString());
                    }else{

                      String  dateText = DateFormat('dd-MM-yyyy').format(DateTime.now());

                      formBloc!.checkInDate.updateValue(dateText);
                      formBloc!.checkOutDate.updateValue(dateText);
                    }

                    return Container(
                      margin: EdgeInsets.symmetric(horizontal: 10.w),
                      child: FormBlocListener<AccomFormBloc, String, String>(
                          onSubmissionFailed: (context, state) {
                          print(state);
                          },
                          onSubmitting: (context, state) {
                            FocusScope.of(context).unfocus();
                          },
                          onSuccess: (context, state) {
                            print(state.successResponse);
                            GEAccomModel modelResponse = GEAccomModel.fromJson(jsonDecode(state.successResponse.toString()));

                            widget.onAdd!(
                                {
                                  "data": jsonDecode(state.successResponse.toString()),
                                  "item" : ExpenseModel(type: GETypes.ACCOMMODATION,amount: (modelResponse.amount!+modelResponse.tax!).toString())
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
                                            child: MetaSearchSelectorView(widget.tripType,
                                              mapData: jsonData['selectCity'],
                                              text: getInitialText(formBloc!.cityName.value),
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
                                              text :getInitialText(formBloc!.accomName.value),
                                              onChange:(value){
                                                print(value);
                                                formBloc!.selectAccomID.updateValue(value['id'].toString());
                                                formBloc!.accomName.updateValue(value['label']);
                                              },),
                                          ),
                                        ),
                                      ]),
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
                                  Container(
                                    child: MetaSwitchBloc(
                                        mapData:  jsonData['withBillCheckBox'],
                                        bloc:  formBloc!.swWithBill,
                                        onSwitchPressed: (value){
                                          formBloc!.selectWithBill.updateValue(value.toString());
                                          formBloc!.swWithBill.updateValue(value);
                                        }),
                                  ),
                                  BlocBuilder<SelectFieldBloc, SelectFieldBlocState>(
                                      bloc: formBloc!.selectWithBill,
                                      builder: (context, state) {
                                        return Visibility(
                                          visible: state.value == "true" ? true : false,
                                          child:UploadComponent(jsonData: jsonData['uploadButton'],
                                              onSelected: (dataFile){
                                                file=dataFile;
                                              }),
                                        );
                                      }
                                  )

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
