import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_form_bloc/flutter_form_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:travelgrid/common/constants/flavour_constants.dart';
import 'package:travelgrid/common/enum/dropdown_types.dart';
import 'package:travelgrid/common/extensions/parse_data_type.dart';
import 'package:travelgrid/common/utils/show_alert.dart';
import 'package:travelgrid/data/datasources/te_summary_response.dart';
import 'package:travelgrid/data/models/expense_model.dart';
import 'package:travelgrid/data/models/ge_misc_model.dart';
import 'package:travelgrid/presentation/screens/te/bloc/visit_form_bloc.dart';
import 'package:travelgrid/presentation/widgets/button.dart';
import 'package:travelgrid/presentation/widgets/date_time_view.dart';
import 'package:travelgrid/presentation/widgets/icon.dart';
import 'package:travelgrid/presentation/widgets/search_selector_view.dart';
import 'package:travelgrid/presentation/widgets/text_view.dart';

class AddVisitDetails extends StatefulWidget {
  Function(ExpenseVisitDetails)? onAdd;
  bool isEdit;
  GEMiscModel? miscModel;
  AddVisitDetails({this.onAdd,this.isEdit=false,this.miscModel});
  @override
  _AddVisitDetailsState createState() => _AddVisitDetailsState();
}

class _AddVisitDetailsState extends State<AddVisitDetails> {
  Map<String,dynamic> jsonData = {};
  List items=[];
  double cardHt = 90.h;
  VisitFormBloc? formBloc;
  bool loaded=false;
  File? file;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    jsonData = FlavourConstants.teAddVisitData;
  //  prettyPrint(jsonData);

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
                onButtonPressed: ()async{
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
          Expanded(
            child: Container(
              child: BlocProvider(
                create: (context) => VisitFormBloc(),
                child: Builder(
                    builder: (context) {

                     formBloc =  BlocProvider.of<VisitFormBloc>(context);


                     if(widget.isEdit){

                       formBloc!.checkInDate.updateValue(widget.miscModel!.startDate.toString());
                       formBloc!.checkOutDate.updateValue(widget.miscModel!.endDate.toString());

                       formBloc!.cityName.updateValue(widget.miscModel!.cityName.toString());
                       formBloc!.cityID.updateValue(widget.miscModel!.city.toString());
                     }else{

                     String  dateText = DateFormat('dd-MM-yyyy').format(DateTime.now());

                       formBloc!.checkInDate.updateValue(dateText);
                       formBloc!.checkOutDate.updateValue(dateText);
                     }



                     return Container(
                      margin: EdgeInsets.symmetric(horizontal: 10.w),
                      child: FormBlocListener<VisitFormBloc, String, String>(
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
                            ExpenseVisitDetails modelResponse = ExpenseVisitDetails.fromJson(jsonDecode(state.successResponse.toString()));

                            widget.onAdd!(modelResponse);
                            Navigator.pop(context);


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

                                  Container(
                                    child: MetaSearchSelectorView(mapData: jsonData['selectCity'],
                                      text: getInitialText(formBloc!.cityName.value),
                                      onChange:(value){
                                        formBloc!.cityName.updateValue(value.name);
                                        formBloc!.cityID.updateValue(value.id.toString());
                                      },),
                                    alignment: Alignment.centerLeft,
                                  ),
                                  
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
