import 'package:flutter/material.dart';
import 'package:flutter_form_bloc/flutter_form_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:travelgrid/common/constants/flavour_constants.dart';
import 'package:travelgrid/presentation/widgets/button.dart';
import 'package:travelgrid/presentation/widgets/text_field.dart';
import 'package:travelgrid/presentation/widgets/text_view.dart';


class DialogCash extends StatelessWidget{
  Function? onSubmit;
  double? size;
  DialogCash({this.onSubmit,this.size=0.2});
  Map<String,dynamic> jsonData={};
  TextEditingController controller= TextEditingController();
  @override
  Widget build(BuildContext context) {

    jsonData = FlavourConstants.cashData;

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
                  mapData: jsonData['text_field_amount'],
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
                              onButtonPressed: (){
                            if(controller.text.isNotEmpty){
                              Navigator.pop(context);
                              onSubmit!(controller.text);
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
