import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_form_bloc/flutter_form_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:travelgrid/common/constants/flavour_constants.dart';
import 'package:travelgrid/common/enum/dropdown_types.dart';
import 'package:travelgrid/common/extensions/parse_data_type.dart';
import 'package:travelgrid/common/utils/show_alert.dart';
import 'package:travelgrid/common/utils/upload_util.dart';
import 'package:travelgrid/data/models/expense_model.dart';
import 'package:travelgrid/data/models/ge/ge_accom_model.dart';
import 'package:travelgrid/data/models/ge/ge_group_accom_model.dart';
import 'package:travelgrid/data/models/success_model.dart';
import 'package:travelgrid/presentation/components/switch_component.dart';
import 'package:travelgrid/presentation/components/upload_component.dart';
import 'package:travelgrid/presentation/screens/dashboard/ge/add/add_group_accom.dart';
import 'package:travelgrid/presentation/screens/dashboard/ge/bloc/accom_form_bloc.dart';
import 'package:travelgrid/presentation/widgets/button.dart';
import 'package:travelgrid/presentation/widgets/checkbox.dart';
import 'package:travelgrid/presentation/widgets/date_time_view.dart';
import 'package:travelgrid/presentation/widgets/dialog_selector_view.dart';
import 'package:travelgrid/presentation/widgets/icon.dart';
import 'package:travelgrid/presentation/widgets/search_selector_view.dart';
import 'package:travelgrid/presentation/widgets/svg_view.dart';
import 'package:travelgrid/presentation/widgets/switch.dart';
import 'package:travelgrid/presentation/widgets/text_field.dart';
import 'package:travelgrid/presentation/widgets/text_view.dart';


class CreateAccommodationExpense extends StatelessWidget {
  Function(Map)? onAdd;
  bool isEdit;
  bool isView;
  GEAccomModel? accomModel;
  String? tripType;
  CreateAccommodationExpense(this.tripType,{this.onAdd,this.isEdit=false,this.isView=false,this.accomModel});
  Map<String,dynamic> jsonData = {};
  AccomFormBloc?  formBloc;
  File? file;
  String violationMessage="";
  Map errorMap={
    "text" : '',
    "color" : "0xFFFFFFFF",
    "size": "10",
    "family": "regular",
    "align" : "center-left"
  };
  List<GEGroupAccomModel> groupValues=[];
  @override
  Widget build(BuildContext context) {
    jsonData = FlavourConstants.accomCreateData;


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

              if(formBloc!.tfAmount.valueToDouble == 0){
                MetaAlert.showErrorAlert(message: "Amount value cannot be zero");
                return;
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
                create: (context) => AccomFormBloc(jsonData),
                child: Builder(
                    builder: (context) {
                    formBloc =  BlocProvider.of<AccomFormBloc>(context);

                    if(isEdit){


                      if(accomModel!.maGeAccomodationGroupExpense!.isNotEmpty){
                        formBloc!.showGroup.updateValue(true);
                        formBloc!.showAdd.updateValue(true);
                        List<GEGroupAccomModel> data= accomModel?.maGeAccomodationGroupExpense ?? [];

                        formBloc!.groupIds.updateValue(data);

                        groupValues.addAll(data);
                      }

                      formBloc!.checkInDate.updateValue(accomModel!.checkInDate.toString());
                      formBloc!.checkInTime.updateValue(accomModel!.checkInTime.toString());

                      formBloc!.checkOutDate.updateValue(accomModel!.checkOutDate.toString());
                      formBloc!.checkOutTime.updateValue(accomModel!.checkOutTime.toString());

                      formBloc!.cityName.updateValue(accomModel!.cityName.toString());
                      formBloc!.cityID.updateValue(accomModel!.city.toString());

                      formBloc!.selectAccomID.updateValue(accomModel!.accomodationType.toString());
                      formBloc!.accomName.updateValue(accomModel!.accomodationTypeName.toString());

                      formBloc!.tfHotelName.updateValue(accomModel!.hotelName.toString());
                      if(accomModel!.hotelName.toString().isEmpty){
                        formBloc!.tfHotelName.updateValue("nill");
                      }


                      formBloc!.tfVoucher.updateValue(accomModel!.voucherNumber.toString());
                      if(accomModel!.voucherNumber.toString().isEmpty){
                        formBloc!.tfVoucher.updateValue("nill");
                      }
                      violationMessage=accomModel!.voilationMessage!;

                      formBloc!.voucherPath.updateValue(accomModel!.voucherPath.toString());

                      formBloc!.tfTax.updateValue(accomModel!.tax.toString());
                      formBloc!.tfAmount.updateValue(accomModel!.amount.toString());
                      formBloc!.tfDescription.updateValue(accomModel!.description.toString());


                      formBloc!.selectWithBill.updateValue(accomModel!.withBill.toString());
                      formBloc!.swWithBill.updateValue(accomModel!.withBill!);

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

                            onAdd!(
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
                                  ...[
                                    AbsorbPointer(
                                      child: Column(
                                        children: [

                                          BlocBuilder<SelectFieldBloc, SelectFieldBlocState>(
                                              bloc: formBloc!.showAdd,
                                              builder: (context, state) {
                                                return Visibility(
                                                  visible: state.value,
                                                  child:  Container(
                                                    child: Row(
                                                      children: [
                                                        Container(
                                                          padding: EdgeInsets.only(right: 5.w,left: 5.w),
                                                          height:20.w,
                                                          width: 20.w,
                                                          child: MetaCheckBox(
                                                              value:formBloc!.showGroup.value,
                                                              onCheckPressed: (bool? value){
                                                                formBloc!.showGroup.updateValue(value);
                                                              }),
                                                        ),
                                                        SizedBox(width: 10.w,),
                                                        MetaTextView(mapData: {
                                                          "text" : 'Add Group',
                                                          "color" : "0xFF000000",
                                                          "size": "14",
                                                          "family": "regular",
                                                          "align" : "center-left"
                                                        })
                                                      ],
                                                    ),
                                                    margin: EdgeInsets.symmetric(vertical: 10.h,horizontal: 5.w),
                                                  ),
                                                );
                                              }
                                          ),


                                          BlocBuilder<SelectFieldBloc, SelectFieldBlocState>(
                                              bloc: formBloc!.showGroup,
                                              builder: (context, state) {
                                                return Visibility(
                                                  visible: state.value,
                                                  child:SwitchComponent(
                                                      color:ParseDataType().getHexToColor(jsonData['backgroundColor']),
                                                      jsonData: jsonData['groupItems'],
                                                      childWidget: buildGroupItemWidget(jsonData['groupItems']),
                                                      initialValue: formBloc!.showGroup.value),
                                                );
                                              }
                                          ),

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
                                          Row(
                                              children: [
                                                Expanded(
                                                  child: Container(
                                                    child: MetaSearchSelectorView(tripType,
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
                                          (violationMessage!=null && violationMessage.isNotEmpty) ?
                                          Container(
                                              padding: EdgeInsets.symmetric(horizontal: 10.w),
                                              height: 20.h,
                                              color: Color(0xFFB71C1C),
                                              child: MetaTextView(mapData: errorMap,text:violationMessage)):SizedBox(),
                                          Container(
                                            child: MetaSwitchBloc(
                                                mapData:  jsonData['withBillCheckBox'],
                                                bloc:  formBloc!.swWithBill,
                                                onSwitchPressed: (value){
                                                  formBloc!.selectWithBill.updateValue(value.toString());
                                                  formBloc!.swWithBill.updateValue(value);
                                                }),
                                          ),],
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
                                              isViewOnly: isView,
                                              url: formBloc!.voucherPath.value,
                                              onSelected: (dataFile){
                                                file=dataFile;
                                              }),
                                        );
                                      }
                                  ),
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
  Widget buildGroupItemWidget(Map map) {
    List items =[];
    items =  map['dataHeader'];


    return  BlocBuilder<SelectFieldBloc, SelectFieldBlocState>(
        bloc: formBloc!.groupIds,
        builder: (context, state) {


          List<GEGroupAccomModel>? list  = formBloc!.groupIds.value ?? [] ;
          print("Rebiuild formBloc!.groupIds");

          return Container(
            padding: EdgeInsets.symmetric(horizontal: 20.w,vertical: 10.h),
            color: Colors.white,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Container(
                    child: Row(
                      children: items.map((e) {

                        if(e['flex']==0){
                          return Container(
                              width: 50.w,
                              margin: EdgeInsets.symmetric(horizontal: 0.w),
                              child: MetaTextView(mapData: e));
                        }

                        return Expanded(
                            flex: e['flex'],
                            child: Container(
                                margin: EdgeInsets.symmetric(horizontal: 0.w),
                                child: MetaTextView(mapData: e)));
                      }).toList(),
                    )
                ),
                Divider(color: Color(0xff3D3D3D),),
                ListView.builder(
                    physics: NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    scrollDirection: Axis.vertical,
                    padding: EdgeInsets.zero,
                    itemBuilder: (BuildContext context, int i) {

                      return Container(
                        margin: EdgeInsets.symmetric(vertical: 2.h),
                        child: Row(
                            children: [
                              Expanded(flex:1, child: MetaTextView(mapData: map['listView']['item'],text:list[i].employeeName) ),
                              Expanded(flex:1, child: MetaTextView(mapData: map['listView']['item'],text:list[i].employeeCode) ),
                              !isView ? Container(
                                width: 56.w,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    InkWell(onTap: (){
                                      print("removing index:"+i.toString() );
                                      groupValues.removeAt(i);
                                      formBloc!.groupIds.clear();
                                      formBloc!.groupIds.changeValue(groupValues);

                                    },
                                        child: Container(
                                            width:25.w,
                                            height:25.w,
                                            child: MetaSVGView(mapData:  map['listView']['item']['items'][1]))),
                                  ],
                                ),
                              ):Container(width: 50.w)
                            ]),
                      );
                    },
                    itemCount: list.length
                ),
                !isView?
                Container(
                  margin: EdgeInsets.only(top: 5.h),
                  width: 90.w,
                  height: 20.h,
                  alignment: Alignment.centerRight,
                  child: MetaButton(mapData: map['addButton'],
                      onButtonPressed: ()async{

                    navigate("",context);


                      }
                  ),
                ):SizedBox()
              ],
            ),
          );
        }
    );
  }

  getInitialText(String text) {

    if(text.isNotEmpty){
      return text;
    }
    return null;
  }

  void navigate(data,context) {

    GEGroupAccomModel? model;
    if(data.isNotEmpty){
      model =  GEGroupAccomModel.fromMap(data);
    }

    Navigator.of(context).push(MaterialPageRoute(builder: (context) =>
        AddGroupAccommodation(
          isEdit:isEdit,
          isView:isView,
          accomModel:model,
          onAdd: (value){
            groupValues.add(value);
            formBloc!.groupIds.clear();
            formBloc!.groupIds.changeValue(groupValues);

          },)));
  }


}
