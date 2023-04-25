import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_form_bloc/flutter_form_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:travelgrid/common/constants/flavour_constants.dart';
import 'package:travelgrid/common/enum/dropdown_types.dart';
import 'package:travelgrid/common/extensions/parse_data_type.dart';
import 'package:travelgrid/common/utils/date_time_util.dart';
import 'package:travelgrid/common/utils/show_alert.dart';
import 'package:travelgrid/common/utils/upload_util.dart';
import 'package:travelgrid/data/models/expense_model.dart';
import 'package:travelgrid/data/models/ge/ge_misc_model.dart';
import 'package:travelgrid/data/models/success_model.dart';
import 'package:travelgrid/presentation/components/upload_component.dart';
import 'package:travelgrid/presentation/screens/dashboard/ge/bloc/misc_form_bloc.dart';
import 'package:travelgrid/presentation/widgets/button.dart';
import 'package:travelgrid/presentation/widgets/date_time_view.dart';
import 'package:travelgrid/presentation/widgets/dialog_selector_view.dart';
import 'package:travelgrid/presentation/widgets/icon.dart';
import 'package:travelgrid/presentation/widgets/search_selector_view.dart';
import 'package:travelgrid/presentation/widgets/text_field.dart';
import 'package:travelgrid/presentation/widgets/text_view.dart';

class AddTravellerDetails extends StatelessWidget {
  Function(Map)? onAdd;
  bool isEdit;
  bool isView;
  GEMiscModel? miscModel;
  String? tripType;
  AddTravellerDetails(this.tripType,{this.onAdd,
    this.isEdit=false,
    this.isView=false,
    this.miscModel});
  
  Map<String,dynamic> jsonData = {};
  List items=[];
  double cardHt = 90.h;
  MiscFormBloc? formBloc;
  bool loaded=false;
  File? file;
  int days =1;
  String violationMessage ="";

  Map errorMap={
    "text" : '',
    "color" : "0xFFFFFFFF",
    "size": "10",
    "family": "regular",
    "align" : "center-left"
  };


  @override
  Widget build(BuildContext context) {
    jsonData = FlavourConstants.trAddTraveller;
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
                onButtonPressed: ()async{

              if(formBloc!.showError.value!){
                if(formBloc!.unitTypeID.value=="288"  && (formBloc!.tfAmount.valueToDouble! > (200*days))){
                  MetaAlert.showErrorAlert(message: "Please submit valid amount");
                  return;
                }else if(formBloc!.unitTypeID.value=="289"  && (formBloc!.tfAmount.valueToDouble! > (400*days))){
                  MetaAlert.showErrorAlert(message: "Please submit valid amount");
                  return;
                }

              }


            if(file!=null){
              SuccessModel model = await  MetaUpload().uploadImage(file!,"GE");
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
                create: (context) => MiscFormBloc(jsonData),
                child: Builder(
                    builder: (context) {

                     formBloc =  BlocProvider.of<MiscFormBloc>(context);


                     if(isEdit){

                       formBloc!.checkInDate.updateValue(miscModel!.startDate.toString());
                       formBloc!.checkOutDate.updateValue(miscModel!.endDate.toString());

                       formBloc!.cityName.updateValue(miscModel!.cityName.toString());
                       formBloc!.cityID.updateValue(miscModel!.city.toString());

                       formBloc!.miscID.updateValue(miscModel!.miscellaneousType.toString());
                       formBloc!.miscName.updateValue(miscModel!.miscellaneousTypeName.toString());

                       violationMessage=miscModel!.voilationMessage!;
                       formBloc!.unitTypeName.updateValue(miscModel!.unitType.toString());
                       formBloc!.unitTypeID.updateValue(miscModel!.unitType.toString());

                       formBloc!.tfVoucher.updateValue(miscModel!.voucherNumber.toString());
                       if(miscModel!.voucherNumber.toString().isEmpty){
                         formBloc!.tfVoucher.updateValue("nill");
                       }
                       formBloc!.voucherPath.updateValue(miscModel!.voucherPath.toString());

                      formBloc!.tfAmount.updateValue(miscModel!.amount.toString());
                      formBloc!.tfDescription.updateValue(miscModel!.description.toString());
                     }else{

                     String  dateText = DateFormat('dd-MM-yyyy').format(DateTime.now());

                       formBloc!.checkInDate.updateValue(dateText);
                       formBloc!.checkOutDate.updateValue(dateText);
                     }



                     return Container(
                      margin: EdgeInsets.symmetric(horizontal: 10.w),
                      child: FormBlocListener<MiscFormBloc, String, String>(
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

                            if(state.successResponse!=null) {
                              GEMiscModel modelResponse = GEMiscModel.fromJson(
                                  jsonDecode(state.successResponse.toString()));

                              onAdd!(
                                  {
                                    "data": jsonDecode(
                                        state.successResponse.toString()),
                                    "item": ExpenseModel(
                                        type: GETypes.MISCELLANEOUS,
                                        amount: modelResponse.amount.toString())
                                  }
                              );
                              Navigator.pop(context);
                            }


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
                                  ...[
                                    AbsorbPointer(
                                      
                                      child: Column(
                                        children: [

                                          Row(
                                              children: [
                                                Expanded(
                                                  child: Container(
                                                    child: MetaDialogSelectorView(mapData: jsonData['selectGender'],
                                                      text :getInitialText(formBloc!.miscName.value),
                                                      onChange:(value){
                                                        print(value);
                                                        formBloc!.miscName.updateValue(value['label']);
                                                        formBloc!.miscID.updateValue(value['id'].toString());


                                                      },),
                                                  ),
                                                ),

                                              ]),

                                          Row(
                                            children: [
                                              Expanded(
                                                child: Container(
                                                  child: MetaTextFieldBlocView(mapData: jsonData['text_field_fname'],
                                                      textFieldBloc: formBloc!.tfAmount,
                                                      onChanged:(value){
                                                        formBloc!.tfAmount.updateValue(value);

                                                      }),
                                                ),
                                              ),

                                              SizedBox(width: 10.w,),

                                              Expanded(
                                                child: MetaTextFieldBlocView(mapData: jsonData['text_field_lname'],
                                                    textFieldBloc: formBloc!.tfVoucher,
                                                    onChanged:(value){
                                                      formBloc!.tfVoucher.updateValue(value);
                                                    }),
                                              ),

                                            ],
                                          ),
                                          Row(
                                            children: [
                                              Expanded(
                                                child: Container(
                                                  child: MetaTextFieldBlocView(mapData: jsonData['text_field_contact'],
                                                      textFieldBloc: formBloc!.tfAmount,
                                                      onChanged:(value){
                                                        formBloc!.tfAmount.updateValue(value);

                                                      }),
                                                ),
                                              ),

                                              SizedBox(width: 10.w,),

                                              Expanded(
                                                child: MetaTextFieldBlocView(mapData: jsonData['text_field_email'],
                                                    textFieldBloc: formBloc!.tfVoucher,
                                                    onChanged:(value){
                                                      formBloc!.tfVoucher.updateValue(value);
                                                    }),
                                              ),

                                            ],
                                          ),
                                          Row(
                                            children: [
                                              Expanded(
                                                child: Container(
                                                  child: MetaTextFieldBlocView(mapData: jsonData['text_field_address'],
                                                      textFieldBloc: formBloc!.tfAmount,
                                                      onChanged:(value){
                                                        formBloc!.tfAmount.updateValue(value);

                                                      }),
                                                ),
                                              ),

                                              SizedBox(width: 10.w,),

                                              Expanded(
                                                child:   Container(
                                                  child: MetaSearchSelectorView(
                                                    tripType,
                                                    mapData: jsonData['selectCity'],
                                                    text: getInitialText(formBloc!.cityName.value),
                                                    onChange:(value){
                                                      formBloc!.cityName.updateValue(value.name);
                                                      formBloc!.cityID.updateValue(value.id.toString());
                                                    },),
                                                  alignment: Alignment.centerLeft,
                                                ),
                                              ),

                                            ],
                                          ),
                                          MetaTextFieldBlocView(mapData: jsonData['text_field_pincode'],
                                              textFieldBloc: formBloc!.tfVoucher,
                                              onChanged:(value){
                                                formBloc!.tfVoucher.updateValue(value);
                                              })
                                        ],
                                      ),
                                      absorbing: isView,
                                    )
                                  ],

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
