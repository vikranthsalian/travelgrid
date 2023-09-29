import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_form_bloc/flutter_form_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:travelex/common/extensions/parse_data_type.dart';
import 'package:travelex/common/utils/city_util.dart';
import 'package:travelex/data/models/tr/tr_insurance_model.dart';
import 'package:travelex/presentation/screens/dashboard/tr/bloc/tr_insurance%20_form_bloc.dart';
import 'package:travelex/presentation/widgets/button.dart';
import 'package:travelex/presentation/widgets/icon.dart';
import 'package:travelex/presentation/widgets/search_selector_view.dart';
import 'package:travelex/presentation/widgets/text_field.dart';
import 'package:travelex/presentation/widgets/text_view.dart';

class AddInsurance  extends StatelessWidget {

  Map<String,dynamic> jsonData = {};
  Function? onAdd;
  String? city;
  bool isEdit;
  TRTravelInsurance? travelInsurance;
  AddInsurance({required this.jsonData,this.onAdd,this.city,this.isEdit=false,this.travelInsurance});


  InsuranceFormBloc?  formBloc;

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
                  create: (context) => InsuranceFormBloc(jsonData),
                  child: Builder(
                      builder: (context) {

                        formBloc =  BlocProvider.of<InsuranceFormBloc>(context);


                        return Container(
                          child: FormBlocListener<InsuranceFormBloc, String, String>(
                              onSubmissionFailed: (context, state) {
                                print(state);
                              },
                              onSubmitting: (context, state) {
                                FocusScope.of(context).unfocus();
                              },
                              onSuccess: (context, state) {
                                print(state.successResponse);
                                TRTravelInsurance modelResponse = TRTravelInsurance.fromJson(jsonDecode(state.successResponse.toString()));

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
                                        MetaSearchSelectorView(
                                        "OO",
                                        mapData: jsonData['selectCountry'],
                                        text: CityUtil.getCityNameFromID(formBloc!.tfCountry.value),
                                        onChange:(value){
                                          print(value);
                                          formBloc!.tfCountry.updateValue(value.countryName);
                                        },),
                                        MetaTextFieldBlocView(mapData: jsonData['text_field_days'],
                                            textFieldBloc: formBloc!.tfDays,
                                            onChanged:(value){
                                              formBloc!.tfDays.updateValue(value);
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
