import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_form_bloc/flutter_form_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:travelgrid/common/extensions/parse_data_type.dart';
import 'package:travelgrid/common/injector/injector.dart';
import 'package:travelgrid/common/utils/city_util.dart';
import 'package:travelgrid/data/blocs/currency/currency_bloc.dart';
import 'package:travelgrid/data/models/success_model.dart';
import 'package:travelgrid/data/models/tr/tr_forex_model.dart';
import 'package:travelgrid/presentation/screens/dashboard/tr/bloc/tr_forex%20_form_bloc.dart';
import 'package:travelgrid/presentation/widgets/button.dart';
import 'package:travelgrid/presentation/widgets/dialog_selector_view.dart';
import 'package:travelgrid/presentation/widgets/icon.dart';
import 'package:travelgrid/presentation/widgets/text_field.dart';
import 'package:travelgrid/presentation/widgets/text_view.dart';

class AddForex  extends StatelessWidget {

  Map<String,dynamic> jsonData = {};
  Function? onAdd;
  bool isEdit;
  TrForexAdvance? forexAdvance;
  AddForex({required this.jsonData,this.onAdd,this.isEdit=false,this.forexAdvance});


  ForexFormBloc?  formBloc;
  CurrencyBloc?  currencyBloc;
  String  dateText="";
  int  rate=1;
  @override
  Widget build(BuildContext context) {
    dateText = DateFormat('dd-MM-yyyy').format(DateTime.now());



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
      body: Container(
        color:ParseDataType().getHexToColor(jsonData['backgroundColor']),
        child: Column(
          children: [
            SizedBox(height:40.h),
            Container(
              height: 40.h,
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
            Expanded(
              child: Container(
                color:Colors.white,
                child: BlocProvider(
                  create: (context) => ForexFormBloc(jsonData),
                  child: Builder(
                      builder: (context) {

                        formBloc =  BlocProvider.of<ForexFormBloc>(context);


                        return Container(
                          child: FormBlocListener<ForexFormBloc, String, String>(
                              onSubmissionFailed: (context, state) {
                                print(state);
                              },
                              onSubmitting: (context, state) {
                                FocusScope.of(context).unfocus();
                              },
                              onSuccess: (context, state) {
                                print(state.successResponse);
                                TrForexAdvance modelResponse = TrForexAdvance.fromJson(jsonDecode(state.successResponse.toString()));

                                onAdd!(modelResponse);
                                Navigator.pop(context);
                              },
                              onFailure: (context, state) {

                                print(state);
                              },
                              child: ScrollableFormBlocManager(
                                formBloc: formBloc!,
                                child:Container(
                                  margin: EdgeInsets.symmetric(horizontal: 10.w,vertical: 10.h),
                                  child: ListView(
                                    padding: EdgeInsets.zero,
                                      shrinkWrap: true,
                                      physics: NeverScrollableScrollPhysics(),
                                      children:[
                                        MetaTextFieldBlocView(mapData: jsonData['text_field_cash'],
                                            textFieldBloc: formBloc!.tfCash,
                                            onChanged:(value){
                                              formBloc!.tfCash.updateValue(value);
                                            }),
                                        MetaTextFieldBlocView(mapData: jsonData['text_field_card'],
                                            textFieldBloc: formBloc!.tfCard,
                                            onChanged:(value){
                                              formBloc!.tfCard.updateValue(value);
                                            }),

                                        MetaTextFieldBlocView(mapData: jsonData['text_field_forex'],
                                            textFieldBloc: formBloc!.tfForex,
                                            onChanged:(value){
                                              formBloc!.tfForex.updateValue(value);
                                            }),

                                        SizedBox(height: 10.h,),
                                        Container(
                                          child: MetaDialogSelectorView(mapData: jsonData['selectCurrency'],
                                            text :CityUtil.getEntriesFromID(formBloc!.currencyID.value),
                                            onChange:(value){
                                              print(value);
                                              formBloc!.currencyID.updateValue(value['id'].toString());

                                              currencyBloc = Injector.resolve<CurrencyBloc>()..add(
                                                  GetExchangeRateEvent(currency:value['label'],date: dateText));
                                            },),
                                        ),
                                        BlocBuilder<CurrencyBloc, CurrencyState>(
                                            bloc: currencyBloc,
                                            builder: (context, state) {

                                              SuccessModel? model = state.rate;
                                              rate = model!.data;

                                              return  SizedBox();
                                            }
                                        ),


                                        MetaTextFieldBlocView(mapData: jsonData['text_field_comment'],
                                            textFieldBloc: formBloc!.tfComment,
                                            onChanged:(value){
                                              formBloc!.tfComment.updateValue(value);
                                            }),

                                      ]
                                  ),
                                ),
                              )
                          ),
                        );
                      }
                  ),
                ),
              ),
            ),
          ],
        ),
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
