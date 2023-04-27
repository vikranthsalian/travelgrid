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
  DialogGrooup({this.onSubmit,this.size=0.2});
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
                  mapData: jsonData['text_field_code'],
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
                                    "employeeCode":controller.text,
                                    "employeeName":"",
                                    "employeeType":"Employee"
                                  };

                                  SuccessModel model=   await Injector.resolve<GeUseCase>().getGeGroup(data);

                                  if(model.message == null){
                                    onSubmit!(controller.text.toUpperCase());
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
