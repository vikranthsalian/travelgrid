import 'package:flutter/material.dart';
import 'package:flutter_form_bloc/flutter_form_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:travelgrid/common/constants/flavour_constants.dart';
import 'package:travelgrid/common/extensions/parse_data_type.dart';
import 'package:travelgrid/common/extensions/pretty.dart';
import 'package:travelgrid/common/injector/injector.dart';
import 'package:travelgrid/common/utils/date_time_util.dart';
import 'package:travelgrid/data/datsources/general_expense_list.dart';
import 'package:travelgrid/presentation/components/bloc_map_event.dart';
import 'package:travelgrid/presentation/screens/auth/bloc/login_form_bloc.dart';
import 'package:travelgrid/presentation/widgets/button.dart';
import 'package:travelgrid/presentation/widgets/checkbox.dart';
import 'package:travelgrid/presentation/widgets/date_time_view.dart';
import 'package:travelgrid/presentation/widgets/dialog_selector_view.dart';
import 'package:travelgrid/presentation/widgets/icon.dart';
import 'package:travelgrid/presentation/widgets/search_selector_view.dart';
import 'package:travelgrid/presentation/widgets/switch.dart';
import 'package:travelgrid/presentation/widgets/text_field.dart';
import 'package:travelgrid/presentation/widgets/text_view.dart';

class CreateTravelExpense extends StatefulWidget {
  Function(Map)? onAdd;
  CreateTravelExpense({this.onAdd});
  @override
  _CreateTravelExpenseState createState() => _CreateTravelExpenseState();
}

class _CreateTravelExpenseState extends State<CreateTravelExpense> {
  Map<String,dynamic> jsonData = {};
  List items=[];
  double cardHt = 90.h;
  bool loaded=false;
  bool showWithBill=true;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    jsonData = FlavourConstants.travelCreateData;
    prettyPrint(jsonData);

    createMapData();
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
                onButtonPressed: (){

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
          Container(
            child: BlocProvider(
              create: (context) => LoginFormBloc({}),
              child: Builder(
                  builder: (context) {
                    LoginFormBloc  formBloc =  BlocProvider.of<LoginFormBloc>(context);
                  return Container(
                    margin: EdgeInsets.symmetric(horizontal: 10.w),
                    child: FormBlocListener<LoginFormBloc, String, String>(
                        onSubmissionFailed: (context, state) {

                        },
                        onSubmitting: (context, state) {
                          FocusScope.of(context).unfocus();
                        },
                        onSuccess: (context, state) {

                        },
                        onFailure: (context, state) {


                        },
                        child: ScrollableFormBlocManager(
                          formBloc: formBloc,
                          child: ListView(
                              padding: EdgeInsets.zero,
                              shrinkWrap: true,
                              children:[
                                Container(
                                  child: MetaDateTimeView(mapData: jsonData['checkInDateTime']),
                                ),
                                Row(
                                    children: [
                                  Expanded(
                                    child: Container(
                                      child: MetaSearchSelectorView(mapData: jsonData['selectOrigin']),
                                      alignment: Alignment.centerLeft,
                                    ),
                                  ),
                                  Expanded(
                                    child: Container(
                                      child: MetaSearchSelectorView(mapData: jsonData['selectDestination']),
                                    ),
                                  ),
                                ]),
                                Container(
                                  child: MetaDialogSelectorView(mapData: jsonData['selectMode']),
                                ),
                                showWithBill ?  MetaTextFieldBlocView(mapData: jsonData['text_field_voucher'],
                                    textFieldBloc: formBloc.tfUsername,
                                    onChanged:(value){
                                      formBloc.tfUsername.updateValue(value);
                                    }):SizedBox(),
                                Container(
                                  child: Row(
                                    children: [
                                          Expanded(
                                            child: MetaTextFieldBlocView(mapData: jsonData['text_field_amount'],
                                            textFieldBloc: formBloc.tfUsername,
                                            onChanged:(value){
                                              formBloc.tfUsername.updateValue(value);
                                            }),
                                          ),
                                      SizedBox(width: 30.w,),
                                      Expanded(
                                        child: MetaTextFieldBlocView(mapData: jsonData['text_field_tax'],
                                            textFieldBloc: formBloc.tfUsername,
                                            onChanged:(value){
                                              formBloc.tfUsername.updateValue(value);
                                            }),
                                      ),
                                        ],
                                  ),
                                ),
                                MetaTextFieldBlocView(mapData: jsonData['text_field_desc'],
                                    textFieldBloc: formBloc.tfUsername,
                                    onChanged:(value){
                                      formBloc.tfUsername.updateValue(value);
                                    }),

                                Row(
                                  children: [
                                    Container(
                                      child: MetaSwitch(mapData:  jsonData['withBillCheckBox'],
                                        value: showWithBill,
                                        onSwitchPressed: (value){

                                        setState(() {
                                          showWithBill=value;
                                        });

                                      },),
                                    ),
                                    showWithBill ? Container(
                                      margin: EdgeInsets.symmetric(vertical: 20.h),
                                      width: 180.w,
                                      child: MetaButton(mapData: jsonData['uploadButton'],
                                          onButtonPressed: (){

                                          }
                                      ),
                                    ):SizedBox(),
                                  ],
                                )

                              ]
                          ),
                        )
                    ),
                  );
                }
              ),
            ),
          )

        ],
      ),
    );
  }

  void createMapData() {
    Map<String,dynamic> saveTravelData = {
      "conveyanceDate": "06-01-2023",
      "origin": "cbi",
      "destination": "hebbal",
      "travelMode": 193,
      "travelModeName": "Own Vehicle",
      "amount": 1000.0,
      "description": "",
      "voucherNumber": "",
      "withBill": false,
      "voucherPath": "",
      "voucherFile": null,
    };
  }


}
