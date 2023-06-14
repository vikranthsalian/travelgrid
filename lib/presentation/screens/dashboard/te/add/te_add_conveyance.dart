import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_form_bloc/flutter_form_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:travelgrid/common/constants/flavour_constants.dart';
import 'package:travelgrid/common/enum/dropdown_types.dart';
import 'package:travelgrid/common/extensions/parse_data_type.dart';
import 'package:travelgrid/common/utils/city_util.dart';
import 'package:travelgrid/common/utils/upload_util.dart';
import 'package:travelgrid/data/models/expense_model.dart';
import 'package:travelgrid/data/models/success_model.dart';
import 'package:travelgrid/data/models/te/te_conveyance_model.dart';
import 'package:travelgrid/presentation/components/upload_component.dart';
import 'package:travelgrid/presentation/screens/dashboard/te/bloc/te_conveyance_form_bloc.dart';
import 'package:travelgrid/presentation/widgets/button.dart';
import 'package:travelgrid/presentation/widgets/date_time_view.dart';
import 'package:travelgrid/presentation/widgets/dialog_selector_view.dart';
import 'package:travelgrid/presentation/widgets/icon.dart';
import 'package:travelgrid/presentation/widgets/switch.dart';
import 'package:travelgrid/presentation/widgets/text_field.dart';
import 'package:travelgrid/presentation/widgets/text_view.dart';

class AddTeConveyance extends StatelessWidget {
  Function(Map)? onAdd;
  bool isEdit;
  bool isView;
  TeConveyanceModel? teConveyanceModel;
  AddTeConveyance({this.onAdd,this.isEdit=false,this.isView=false,this.teConveyanceModel});
  Map<String,dynamic> jsonData = {};
  List items=[];
  double cardHt = 90.h;
  ConveyanceTeFormBloc? formBloc;
  bool loaded=false;
  File? file;


  @override
  Widget build(BuildContext context) {
    jsonData = FlavourConstants.teConvAddData;
    return Scaffold(
      backgroundColor: Colors.white,
      bottomNavigationBar: BottomAppBar(
        color:ParseDataType().getHexToColor(jsonData['backgroundColor']),
        shape: CircularNotchedRectangle(),

        notchMargin: 5,
        elevation: 2.0,
        child: !isView ? Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            MetaButton(mapData: jsonData['bottomButtonLeft'],
                onButtonPressed: (){

                  Navigator.pop(context);


                }
            ),
            MetaButton(mapData: jsonData['bottomButtonRight'],
                onButtonPressed: () async {
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
                create: (context) => ConveyanceTeFormBloc(jsonData),
                child: Builder(
                    builder: (context) {
                      formBloc =  BlocProvider.of<ConveyanceTeFormBloc>(context);
                      if(isEdit){

                        formBloc!.checkInDate.updateValue(teConveyanceModel!.conveyanceDate.toString());


                        formBloc!.tfOrigin.updateValue(teConveyanceModel!.fromPlace.toString());
                        formBloc!.tfDestination.updateValue(teConveyanceModel!.toPlace.toString());

                        formBloc!.modeName.updateValue(teConveyanceModel!.travelMode.toString());
                        formBloc!.selectModeID.updateValue(teConveyanceModel!.travelMode.toString());

                        formBloc!.swByCompany.updateValue(teConveyanceModel!.byCompany!);

                        formBloc!.tfVoucher.updateValue(teConveyanceModel!.voucherNumber.toString());
                        if(teConveyanceModel!.voucherNumber.toString().isEmpty){
                          formBloc!.tfVoucher.updateValue("nill");
                        }

                        formBloc!.voucherPath.updateValue(teConveyanceModel!.voucherPath.toString());

                        formBloc!.tfAmount.updateValue(teConveyanceModel!.amount.toString());
                        formBloc!.tfDescription.updateValue(teConveyanceModel!.description.toString());

                        formBloc!.selectWithBill.updateValue(teConveyanceModel!.withBill.toString());
                        formBloc!.swWithBill.updateValue(teConveyanceModel!.withBill!);

                      }else{
                        String  dateText = DateFormat('dd-MM-yyyy').format(DateTime.now());

                        formBloc!.checkInDate.updateValue(dateText);
                      }
           

                      return Container(
                        margin: EdgeInsets.symmetric(horizontal: 10.w),
                        child: FormBlocListener<ConveyanceTeFormBloc, String, String>(
                            onSubmissionFailed: (context, state) {
                              print(state);
                            },
                            onSubmitting: (context, state) {
                              FocusScope.of(context).unfocus();
                            },
                            onSuccess: (context, state) {

                              print(state.successResponse);
                              TeConveyanceModel modelResponse = TeConveyanceModel.fromJson(jsonDecode(state.successResponse.toString()));

                              onAdd!(
                                  {
                                    "data": jsonDecode(state.successResponse.toString()),
                                    "item" : ExpenseModel(teType: TETypes.CONVEYANCE,amount: modelResponse.amount.toString())
                                  }
                              );
                              Navigator.pop(context);


                            },
                            onFailure: (context, state) {


                            },
                            child: ScrollableFormBlocManager(
                              formBloc: formBloc!,
                              child: ListView(
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
                                              },
                                              onChange: (value){
                                                print(value);
                                                formBloc!.checkInDate.updateValue(value['date'].toString());

                                              },),
                                          ),
                                          Row(
                                            children: [
                                              Expanded(
                                                child:
                                                Container(
                                                  child:MetaTextFieldBlocView(mapData: jsonData['text_field_origin'],
                                                      textFieldBloc: formBloc!.tfOrigin,
                                                      onChanged:(value){
                                                        formBloc!.tfOrigin.updateValue(value);
                                                      }),
                                                  alignment: Alignment.centerLeft,
                                                ),
                                              ),
                                              SizedBox(width: 10.w,),

                                              Expanded(
                                                child: Container(
                                                  child:MetaTextFieldBlocView(mapData: jsonData['text_field_destination'],
                                                      textFieldBloc: formBloc!.tfDestination,
                                                      onChanged:(value){
                                                        formBloc!.tfDestination.updateValue(value);
                                                      }),
                                                  alignment: Alignment.centerLeft,
                                                ),
                                              ),
                                            ],
                                          ),

                                          Row(
                                            children: [
                                              Expanded(child: Container(
                                                child: MetaDialogSelectorView(mapData: jsonData['selectMode'],
                                                  text : CityUtil.getModeNameFromID(formBloc!.modeName.value.toString()),
                                                 // getInitialText(formBloc!.modeName.value),
                                                  onChange:(data)async{
                                                    print(data);
                                                    formBloc!.selectModeID.updateValue("193");
                                                    formBloc!.modeName.updateValue("Own Vehicle");
                                                  },),
                                              )),
                                              SizedBox(width: 10.w,),
                                              Expanded(child: Container(
                                                child: MetaSwitchBloc(
                                                    mapData:  jsonData['byCompanySwitch'],
                                                    bloc:  formBloc!.swByCompany,
                                                    onSwitchPressed: (value){
                                                      formBloc!.swByCompany.updateValue(value);
                                                    }),
                                              ))
                                            ],
                                          ),

                                          Row(
                                            children: [
                                              Expanded(
                                                child: Container(
                                                  child: Row(
                                                    children: [
                                                      Expanded(
                                                        child: MetaTextFieldBlocView(mapData: jsonData['text_field_amount'],
                                                            textFieldBloc: formBloc!.tfAmount,
                                                            onChanged:(value){
                                                              formBloc!.tfAmount.updateValue(value);
                                                            }),
                                                      )
                                                    ],
                                                  ),
                                                ),
                                              ),

                                              SizedBox(width: 10.w,),
                                              Expanded(
                                                child: BlocBuilder<SelectFieldBloc, SelectFieldBlocState>(
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
                                              ),
                                            ],
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
                                ] ,
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

