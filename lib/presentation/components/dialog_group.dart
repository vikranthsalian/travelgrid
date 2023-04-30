import 'package:flutter/material.dart';
import 'package:flutter_form_bloc/flutter_form_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:travelgrid/common/constants/flavour_constants.dart';
import 'package:travelgrid/common/injector/injector.dart';
import 'package:travelgrid/data/models/success_model.dart';
import 'package:travelgrid/domain/usecases/ge_usecase.dart';
import 'package:travelgrid/presentation/widgets/button.dart';
import 'package:travelgrid/presentation/widgets/text_field.dart';
import 'package:travelgrid/presentation/widgets/text_view.dart';


class DialogGrooup extends StatelessWidget{
  Function? onSubmit;
  double? size;
  bool isAccommodation;
  String isName;
  DialogGrooup({this.onSubmit,this.size=0.2,this.isAccommodation=false,required this.isName});
  Map<String,dynamic> jsonData={};
  TextEditingController controller= TextEditingController();
  @override
  Widget build(BuildContext context) {

    jsonData = FlavourConstants.groupPickerData;

    return Dialog(
      backgroundColor: Colors.transparent,
      child: Container(
        height: MediaQuery.of(context).size.height * size!,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(12.r),
          child: Container(
                color: Colors.white,
              child: Column(children: [
                SizedBox(height: 20.h,),
                MetaTextView(mapData: jsonData['title']),
                MetaTextFieldView(
                  mapData:{
                    "name": "Employee "+isName,
                    "apiKey": "code",
                    "type": "text_field_view",
                    "inputType": "text",
                    "isPassword": false,
                    "backgroundColor": "0XFFFFFFFF",
                    "borderColor": "0XFFAEAEAE",
                    "text" : {
                      "text" : "",
                      "color" : "0xFF2854A1",
                      "size": "14",
                      "family": "regular"
                    },
                    "labelText" : {
                      "text" : "Employee "+isName+"*",
                      "color" : "0xFF2854A1",
                      "size": "14",
                      "family": "regular",
                      "align" : "center-left"
                    },
                    "hintText" : {
                      "text" : "Enter "+isName,
                      "color" : "0xFF2854A1",
                      "size": "14",
                      "family": "regular"
                    },
                    "errorText" : {
                      "text" : "",
                      "color" : "0xFFFF0000",
                      "size": "14",
                      "family": "regular"
                    },
                    "validators" : [
                      {
                        "type" : "empty"
                      }
                    ]
                  },
                    onChanged:(value){

                    }, controller: controller,),
                Expanded(
                  child: Row(
                    children: [
                      Expanded(
                        child: Container(
                          child: MetaButton(mapData: jsonData['bottomButtonCentre'],
                              onButtonPressed: (){
                                Navigator.pop(context);
                              }
                          ),
                        ),
                      ),
                      Expanded(
                        child: Container(
                          child: MetaButton(mapData: jsonData['bottomButtonCentre'],
                              text: "Submit",
                              onButtonPressed: ()async{

                                if(controller.text.isNotEmpty){

                                  Map<String,dynamic> data={
                                    "checked":"",
                                    "requestType":"",
                                    "employeeCode":isName == "Code" ? controller.text :"",
                                    "employeeName":isName == "Name" ? controller.text :"",
                                    "employeeType":"Employee",
                                    if(isAccommodation)
                                    "isAccommodation":true
                                  };

                                  SuccessModel model=   await Injector.resolve<GeUseCase>().getGeGroup(data);

                                  if(isAccommodation){
                                    if(model.message == "User valid"){
                                      onSubmit!({
                                        "name": isName == "Name" ? controller.text :model.data,
                                        "code": isName == "Code" ? controller.text :model.data
                                      });
                                    }
                                  }else{

                                    if(model.message == null){
                                      onSubmit!(controller.text.toUpperCase());
                                    }
                                  }


                                  Navigator.pop(context);

                                }


                              }
                          ),
                        ),
                      ),
                    ],
                  ),
                )
              ])
          ),
        ),
      ),
    );
  }

}
