import 'package:flutter/material.dart';
import 'package:flutter_form_bloc/flutter_form_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:travelgrid/common/constants/flavour_constants.dart';
import 'package:travelgrid/common/extensions/parse_data_type.dart';
import 'package:travelgrid/presentation/screens/ge/bloc/accom_form_bloc.dart';
import 'package:travelgrid/presentation/widgets/button.dart';
import 'package:travelgrid/presentation/widgets/date_time_view.dart';
import 'package:travelgrid/presentation/widgets/dialog_selector_view.dart';
import 'package:travelgrid/presentation/widgets/icon.dart';
import 'package:travelgrid/presentation/widgets/search_selector_view.dart';
import 'package:travelgrid/presentation/widgets/switch.dart';
import 'package:travelgrid/presentation/widgets/text_field.dart';
import 'package:travelgrid/presentation/widgets/text_view.dart';

class CreateAccommodation extends StatefulWidget {
  @override
  _CreateAccommodationState createState() => _CreateAccommodationState();
}

class _CreateAccommodationState extends State<CreateAccommodation> {
  Map<String,dynamic> jsonData = {};
  List items=[];
  double cardHt = 90.h;
  bool loaded=false;
  bool showWithBill=true;
  AccomFormBloc?  formBloc;
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
                onButtonPressed: (){
                  formBloc!.submit();
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
              create: (context) => AccomFormBloc(jsonData),
              child: Builder(
                  builder: (context) {
                      formBloc =  BlocProvider.of<AccomFormBloc>(context);
                  return Container(
                    margin: EdgeInsets.symmetric(horizontal: 10.w),
                    child: FormBlocListener<AccomFormBloc, String, String>(
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
                          formBloc: formBloc!,
                          child: ListView(
                              padding: EdgeInsets.zero,
                              shrinkWrap: true,
                              children:[
                                Container(
                                  child: MetaDateTimeView(mapData: jsonData['checkInDateTime'],onChange: (value){
                                    formBloc!.checkInDate.updateValue(value.toString());
                                  },),
                                ),
                                Container(
                                  child: MetaDateTimeView(mapData: jsonData['checkOutDateTime'],onChange: (value){
                                    formBloc!.checkOutDate.updateValue(value.toString());
                                  },),
                                ),
                                Row(
                                    children: [
                                  Expanded(
                                    child: Container(
                                      child: MetaSearchSelectorView(mapData: jsonData['selectCity'],
                                        onChange:(value){
                                           formBloc!.city.updateValue(value);
                                        },),
                                      alignment: Alignment.centerLeft,
                                    ),
                                  ),
                                  Expanded(
                                    child: Container(
                                      child: MetaDialogSelectorView(mapData: jsonData['selectType'],
                                        onChange:(value){

                                        },),
                                    ),
                                  ),
                                ]),

                                showWithBill ?  MetaTextFieldBlocView(mapData: jsonData['text_field_voucher'],
                                    textFieldBloc: formBloc!.tfVoucher,
                                    onChanged:(value){
                                      formBloc!.tfVoucher.updateValue(value);
                                    }):SizedBox(),
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

                                Row(
                                  children: [
                                    MetaSwitch(mapData:  jsonData['withBillCheckBox'],
                                      value:  formBloc!.swWithBill.value,
                                      onSwitchPressed: (value){

                                        setState(() {
                                         showWithBill=value;
                                         formBloc!.swWithBill.updateValue(value);
                                        });

                                      },),
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


}
