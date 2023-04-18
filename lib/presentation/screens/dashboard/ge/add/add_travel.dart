import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_form_bloc/flutter_form_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:travelgrid/common/constants/flavour_constants.dart';
import 'package:travelgrid/common/enum/dropdown_types.dart';
import 'package:travelgrid/common/extensions/parse_data_type.dart';
import 'package:travelgrid/common/utils/upload_util.dart';
import 'package:travelgrid/data/models/expense_model.dart';
import 'package:travelgrid/data/models/ge/ge_conveyance_model.dart';
import 'package:travelgrid/data/models/success_model.dart';
import 'package:travelgrid/presentation/components/upload_component.dart';
import 'package:travelgrid/presentation/screens/dashboard/ge/add/add_travel_ov.dart';
import 'package:travelgrid/presentation/screens/dashboard/ge/bloc/travel_form_bloc.dart';
import 'package:travelgrid/presentation/widgets/button.dart';
import 'package:travelgrid/presentation/widgets/date_time_view.dart';
import 'package:travelgrid/presentation/widgets/dialog_selector_view.dart';
import 'package:travelgrid/presentation/widgets/icon.dart';
import 'package:travelgrid/presentation/widgets/switch.dart';
import 'package:travelgrid/presentation/widgets/text_field.dart';
import 'package:travelgrid/presentation/widgets/text_view.dart';

class CreateConveyanceExpense extends StatefulWidget {
  Function(Map)? onAdd;
  bool isEdit;
  GeConveyanceModel? conveyanceModel;
  CreateConveyanceExpense({this.onAdd,this.isEdit=false,this.conveyanceModel});
  @override
  _CreateConveyanceExpenseState createState() => _CreateConveyanceExpenseState();
}

class _CreateConveyanceExpenseState extends State<CreateConveyanceExpense> {
  Map<String,dynamic> jsonData = {};
  bool loaded=false;
  TravelFormBloc?  formBloc;
  File? file;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    jsonData = FlavourConstants.conveyanceCreateData;
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
                onButtonPressed: () async {

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
                create: (context) => TravelFormBloc(jsonData),
                child: Builder(
                    builder: (context) {
                        formBloc =  BlocProvider.of<TravelFormBloc>(context);

                      if(widget.isEdit){

                        print(widget.conveyanceModel!.toJson());

                        formBloc!.checkInDate.updateValue(widget.conveyanceModel!.conveyanceDate.toString());
                      //  formBloc!.checkOutDate.updateValue(widget.conveyanceModel!.endDate.toString());

                        formBloc!.tfOrigin.updateValue(widget.conveyanceModel!.origin.toString());
                        formBloc!.tfDestination.updateValue(widget.conveyanceModel!.destination.toString());

                        formBloc!.selectModeID.updateValue(widget.conveyanceModel!.travelMode.toString());
                        formBloc!.modeName.updateValue(widget.conveyanceModel!.travelModeName.toString());


                      //  formBloc!.unitTypeName.updateValue("test");
                      //  formBloc!.unitTypeID.updateValue(widget.conveyanceModel!.unitType.toString());

                        formBloc!.tfVoucher.updateValue(widget.conveyanceModel!.voucherNumber.toString());
                        if(widget.conveyanceModel!.voucherNumber.toString().isEmpty){
                          formBloc!.tfVoucher.updateValue("nill");
                        }
                        formBloc!.voucherPath.updateValue(widget.conveyanceModel!.voucherPath.toString());

                        formBloc!.tfAmount.updateValue(widget.conveyanceModel!.amount.toString());
                        formBloc!.tfDescription.updateValue(widget.conveyanceModel!.description.toString());
                      }else{

                        String  dateText = DateFormat('dd-MM-yyyy').format(DateTime.now());

                        formBloc!.checkInDate.updateValue(dateText);
                      }
                    return Container(
                      margin: EdgeInsets.symmetric(horizontal: 10.w),
                      child: FormBlocListener<TravelFormBloc, String, String>(
                          onSubmissionFailed: (context, state) {
                            print("onSubmissionFailed");
                            print(state);
                          },
                          onSubmitting: (context, state) {
                            print("onSubmitting");
                            print(state);
                            FocusScope.of(context).unfocus();
                          },
                          onSuccess: (context, state) {
                            print("onSuccess");
                            print(state.successResponse);
                            GeConveyanceModel modelResponse = GeConveyanceModel.fromJson(jsonDecode(state.successResponse.toString()));

                            print(modelResponse.toJson());
                            print(modelResponse.amount.toString());

                            widget.onAdd!(
                                {
                                  "data": jsonDecode(state.successResponse.toString()),
                                  "item" : ExpenseModel(type: GETypes.CONVEYANCE,amount: modelResponse.amount.toString())
                                }
                            );
                            Navigator.pop(context);
                          },
                          onFailure: (context, state) {
                            print("onFailure");
                            print(state);
                          },
                          child: ScrollableFormBlocManager(
                            formBloc: formBloc!,
                            child: BlocBuilder<SelectFieldBloc, SelectFieldBlocState>(
                                bloc: formBloc!.selectModeID,
                                builder: (context, state) {
                                  return  ListView(
                                      padding: EdgeInsets.zero,
                                      shrinkWrap: true,
                                      children:[
                                        Container(
                                          child: MetaDateTimeView(mapData: jsonData['checkInDateTime'],
                                            isEnabled: formBloc!.selectModeID.value=="193" ? false: true,
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
                                                child:MetaTextFieldBlocView(mapData: jsonData['text_field_origin'],
                                                    textFieldBloc: formBloc!.tfOrigin,
                                                    isEnabled :  formBloc!.selectModeID.value=="193" ? false: true,
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
                                                    isEnabled :  formBloc!.selectModeID.value=="193" ? false: true,
                                                    onChanged:(value){
                                                      formBloc!.tfDestination.updateValue(value);
                                                    }),
                                                alignment: Alignment.centerLeft,
                                              ),
                                            ),
                                          ],
                                        ),

                                        BlocBuilder<SelectFieldBloc, SelectFieldBlocState>(
                                            bloc: formBloc!.selectModeID,
                                            builder: (context, state) {
                                              return Container(
                                                child: MetaDialogSelectorView(mapData: jsonData['selectMode'],
                                                  text :getInitialText(formBloc!.modeName.value),
                                                  onChange:(value){
                                                    print(value);
                                                    formBloc!.selectModeID.updateValue(value['id'].toString());
                                                    formBloc!.modeName.updateValue(value['label']);

                                                    if(value['id']==193){
                                                      Navigator.of(context).push(MaterialPageRoute(builder: (context) =>
                                                          CreateTravelExpenseOV(
                                                              onClose:(data){
                                                                print(data);
                                                                formBloc!.selectModeID.updateValue(data['id'].toString());
                                                                formBloc!.modeName.updateValue(data['label']);
                                                              },
                                                              onAdd: (values,date){

                                                                print("CreateTravelExpenseOVdate");
                                                                print(date);

                                                                List<MaGeConveyanceCityPair> list = values;

                                                                formBloc!.tfOrigin.updateValue(list[0].origin.toString());
                                                                formBloc!.tfDestination.updateValue(list[list.length-1].destination.toString());
                                                                double amt=0;
                                                                double dist=0;
                                                                for(int i=0;i<list.length;i++){
                                                                  amt= amt +double.parse(list[i].amount.toString());
                                                                  dist= dist +double.parse(list[i].distance.toString());
                                                                }


                                                                formBloc!.checkInTime.updateValue(list[0].startTime.toString());
                                                                formBloc!.checkOutTime.updateValue(list[list.length-1].endTime.toString());
                                                                formBloc!.distance.updateValue(dist.toString());
                                                                formBloc!.checkInDate.updateValue(date);

                                                                formBloc!.tfAmount.updateValue(amt.toString());
                                                                formBloc!.selectModeID.updateValue("193");

                                                                formBloc!.onCityPairAdded.updateValue(list);


                                                              },
                                                              jsonData: jsonData['own_vehicle'])));
                                                    }


                                                  },),
                                              );
                                            }
                                        ),

                                        Container(
                                          child: Row(
                                            children: [
                                              Expanded(
                                                child: Container(
                                                  child: MetaTextFieldBlocView(mapData: jsonData['text_field_amount'],
                                                      textFieldBloc: formBloc!.tfAmount,
                                                      isEnabled :  formBloc!.selectModeID.value=="193" ? false: true,
                                                      onChanged:(value){
                                                        formBloc!.tfAmount.updateValue(value);
                                                      }),
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
                                  );
                                }
                            )
                              ,
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
