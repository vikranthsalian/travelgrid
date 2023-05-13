import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_form_bloc/flutter_form_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:travelgrid/common/config/navigator_key.dart';
import 'package:travelgrid/common/constants/flavour_constants.dart';
import 'package:travelgrid/common/enum/dropdown_types.dart';
import 'package:travelgrid/common/extensions/parse_data_type.dart';
import 'package:travelgrid/common/utils/date_time_util.dart';
import 'package:travelgrid/common/utils/show_alert.dart';
import 'package:travelgrid/common/utils/upload_util.dart';
import 'package:travelgrid/data/models/expense_model.dart';
import 'package:travelgrid/data/models/ge/ge_misc_model.dart';
import 'package:travelgrid/data/models/success_model.dart';
import 'package:travelgrid/presentation/components/dialog_group.dart';
import 'package:travelgrid/presentation/components/switch_component.dart';
import 'package:travelgrid/presentation/components/upload_component.dart';
import 'package:travelgrid/presentation/screens/dashboard/ge/bloc/misc_form_bloc.dart';
import 'package:travelgrid/presentation/widgets/button.dart';
import 'package:travelgrid/presentation/widgets/checkbox.dart';
import 'package:travelgrid/presentation/widgets/date_time_view.dart';
import 'package:travelgrid/presentation/widgets/dialog_selector_view.dart';
import 'package:travelgrid/presentation/widgets/icon.dart';
import 'package:travelgrid/presentation/widgets/search_selector_view.dart';
import 'package:travelgrid/presentation/widgets/svg_view.dart';
import 'package:travelgrid/presentation/widgets/text_field.dart';
import 'package:travelgrid/presentation/widgets/text_view.dart';

class CreateMiscExpense extends StatelessWidget {
  Function(Map)? onAdd;
  bool isEdit;
  bool isView;
  GEMiscModel? miscModel;
  String? tripType;
  CreateMiscExpense(this.tripType,{this.onAdd,
    this.isEdit=false,
    this.isView=false,
    this.miscModel});
  
  Map<String,dynamic> jsonData = {};
  List items=[];
  double cardHt = 90.h;
  MiscFormBloc? formBloc;
  File? file;
  String violationMessage ="";

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
    jsonData = FlavourConstants.miscCreateData;
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
                MetaAlert.showErrorAlert(message: "Please submit valid amount");
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

                       if(miscModel!.groupExpense == true){
                         formBloc!.showGroup.updateValue(true);
                         formBloc!.showAdd.updateValue(true);


                         List<String> data= miscModel!.groupEmployees!.split(",");

                         formBloc!.groupIds.updateValue(data);

                         groupValues.addAll(data);
                       }

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

                                          Row(
                                            children: [
                                              Expanded(
                                                child: Container(
                                                  child: MetaDateTimeView(mapData: jsonData['checkInDateTime'],
                                                      disableFutureDates:true,
                                                      value: {"date": formBloc!.checkInDate.value},
                                                      onChange: (value){
                                                        formBloc!.checkInDate.updateValue(value['date'].toString());
                                                        getDays();
                                                      }),
                                                ),
                                              ),
                                              Expanded(
                                                child: Container(
                                                  child: MetaDateTimeView(mapData: jsonData['checkOutDateTime'],
                                                      disableFutureDates:true,
                                                      value: {"date": formBloc!.checkOutDate.value},
                                                      onChange: (value){
                                                        formBloc!.checkOutDate.updateValue(value['date'].toString());
                                                        getDays();
                                                      }),
                                                ),
                                              ),
                                            ],
                                          ),

                                          Container(
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

                                          Row(
                                              children: [
                                                Expanded(
                                                  child: Container(
                                                    child: MetaDialogSelectorView(mapData: jsonData['selectMiscType'],
                                                      text :getInitialText(formBloc!.miscName.value),
                                                      onChange:(value){
                                                        print(value);
                                                        formBloc!.miscName.updateValue(value['label']);
                                                        formBloc!.miscID.updateValue(value['id'].toString());

                                                        if(
                                                        formBloc!.miscID.value=="212" ||
                                                            formBloc!.miscID.value=="213" ||
                                                            formBloc!.miscID.value=="290"
                                                        ){
                                                          formBloc!.showAdd.updateValue(true);
                                                        }else{
                                                          groupValues.clear();
                                                          formBloc!.groupIds.clear();
                                                          formBloc!.groupIds.updateValue([]);
                                                          formBloc!.showAdd.updateValue(false);
                                                        }


                                                      },),
                                                  ),
                                                ),
                                                Expanded(
                                                  child: BlocBuilder<SelectFieldBloc, SelectFieldBlocState>(
                                                      bloc: formBloc!.miscID,
                                                      builder: (context, state) {
                                                        return Visibility(
                                                          visible: state.value == "212" ? true : false,
                                                          child:MetaDialogSelectorView(mapData: jsonData['selectUnitType'],
                                                            text :getInitialText(formBloc!.unitTypeName.value),
                                                            onChange:(value){
                                                              print(value);
                                                              formBloc!.unitTypeName.updateValue(value['text']);
                                                              formBloc!.unitTypeID.updateValue(value['id'].toString());
                                                              getDays();
                                                            },),
                                                        );
                                                      }
                                                  ),
                                                ),
                                              ]),

                                          Row(
                                            children: [
                                              Expanded(
                                                child: Container(
                                                  child: MetaTextFieldBlocView(mapData: jsonData['text_field_amount'],
                                                      textFieldBloc: formBloc!.tfAmount,
                                                      onChanged:(value){
                                                        formBloc!.tfAmount.updateValue(value);
                                                        getDays();
                                                      }),
                                                ),
                                              ),

                                              SizedBox(width: 10.w,),

                                              Expanded(
                                                child: MetaTextFieldBlocView(mapData: jsonData['text_field_voucher'],
                                                    textFieldBloc: formBloc!.tfVoucher,
                                                    onChanged:(value){
                                                      formBloc!.tfVoucher.updateValue(value);
                                                    }),
                                              ),

                                            ],
                                          ),
                                          BlocBuilder<SelectFieldBloc, SelectFieldBlocState>(
                                              bloc: formBloc!.showError,
                                              builder: (context, state) {
                                                return Visibility(
                                                  visible:state.value,
                                                  child:Container(
                                                      padding: EdgeInsets.symmetric(horizontal: 10.w),
                                                      height: 20.h,
                                                      color: Color(0xFFB71C1C),
                                                      child: MetaTextView(mapData: errorMap,text: "Eligible amount is "+formBloc!.showErrorValue.value)
                                                  ),
                                                );
                                              }
                                          ),
                                          (isView && violationMessage!=null && violationMessage.isNotEmpty) ?
                                          Container(
                                              padding: EdgeInsets.symmetric(horizontal: 10.w),
                                              height: 20.h,
                                              color: Color(0xFFB71C1C),
                                              child: MetaTextView(mapData: errorMap,text:violationMessage)
                                          ):SizedBox(),
                                          MetaTextFieldBlocView(mapData: jsonData['text_field_desc'],
                                              textFieldBloc: formBloc!.tfDescription,
                                              onChanged:(value){
                                                formBloc!.tfDescription.updateValue(value);
                                              }),
                                        ],
                                      ),
                                      absorbing: isView,
                                    )
                                  ],

                                  UploadComponent(jsonData: jsonData['uploadButton'],
                                      url:formBloc!.voucherPath.value,
                                      isViewOnly:isView,
                                      onSelected: (dataFile){

                                        file=dataFile;
                                  }),
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

  Widget buildGroupItemWidget(Map map) {
    List items =[];
    items =  map['dataHeader'];


    return  BlocBuilder<SelectFieldBloc, SelectFieldBlocState>(
        bloc: formBloc!.groupIds,
        builder: (context, state) {

          List<String>? list  = formBloc!.groupIds.value ?? [] ;
          if(list.length > 0){
            formBloc!.count.updateValue(1 + list.length);
          }else{
            formBloc!.count.updateValue(1);
          }

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
                                child: MetaTextView(mapData: e)
                            )
                        );
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
                              Expanded(flex:1, child: MetaTextView(mapData: map['listView']['item'],text:list[i]) ),
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
                        await showDialog(
                            context: appNavigatorKey.currentState!.context,
                            builder: (_) =>
                                DialogGrooup(
                                    isName:"Code",
                                    onSubmit: (value) {
                                      groupValues.add(value);
                                      formBloc!.groupIds.clear();
                                      formBloc!.groupIds.changeValue(groupValues);
                                    }));

                      }
                  ),
                ):SizedBox()
              ],
            ),
          );
        }
    );
  }

  getDays(){
    DateTime dob1 = MetaDateTime().getDateTime(formBloc!.checkInDate.value);
    DateTime dob2 = MetaDateTime().getDateTime(formBloc!.checkOutDate.value);
    Duration dur =  dob2.difference(dob1);


    int count = (dur.inDays);
    formBloc!.days.updateValue(count == 0 ? 1: count);


  }


}
