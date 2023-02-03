import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_bloc/flutter_form_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:travelgrid/common/constants/flavour_constants.dart';
import 'package:travelgrid/common/enum/dropdown_types.dart';
import 'package:travelgrid/common/extensions/parse_data_type.dart';
import 'package:travelgrid/common/extensions/pretty.dart';
import 'package:travelgrid/common/injector/injector.dart';
import 'package:travelgrid/common/utils/show_alert.dart';
import 'package:travelgrid/data/models/expense_model.dart';
import 'package:travelgrid/data/models/ge_misc_model.dart';
import 'package:travelgrid/data/models/success_model.dart';
import 'package:travelgrid/domain/usecases/common_usecase.dart';
import 'package:travelgrid/presentation/components/upload_component.dart';
import 'package:travelgrid/presentation/screens/ge/bloc/misc_form_bloc.dart';
import 'package:travelgrid/presentation/widgets/button.dart';
import 'package:travelgrid/presentation/widgets/date_time_view.dart';
import 'package:travelgrid/presentation/widgets/dialog_selector_view.dart';
import 'package:travelgrid/presentation/widgets/icon.dart';
import 'package:travelgrid/presentation/widgets/search_selector_view.dart';
import 'package:travelgrid/presentation/widgets/text_field.dart';
import 'package:travelgrid/presentation/widgets/text_view.dart';

class CreateMiscExpense extends StatefulWidget {
  Function(Map)? onAdd;
  bool isEdit;
  GEMiscModel? miscModel;
  CreateMiscExpense({this.onAdd,this.isEdit=false,this.miscModel});
  @override
  _CreateMiscExpenseState createState() => _CreateMiscExpenseState();
}

class _CreateMiscExpenseState extends State<CreateMiscExpense> {
  Map<String,dynamic> jsonData = {};
  List items=[];
  double cardHt = 90.h;
  MiscFormBloc? formBloc;
  bool loaded=false;
  File? file;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    jsonData = FlavourConstants.miscCreateData;
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
              if(file!=null){
                String fileName = file!.path.split('/').last;
                String  dateText = DateFormat('dd-MM-yyyy_hh:ss').format(DateTime.now());
                FormData formData = FormData.fromMap({
                  "file": await MultipartFile.fromFile(file!.path, filename:dateText+"_"+fileName),
                });
              SuccessModel model =  await Injector.resolve<CommonUseCase>().uploadFile(formData,"GE");
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
                create: (context) => MiscFormBloc(jsonData),
                child: Builder(
                    builder: (context) {

                     formBloc =  BlocProvider.of<MiscFormBloc>(context);


                     if(widget.isEdit){

                       formBloc!.checkInDate.updateValue(widget.miscModel!.startDate.toString());
                       formBloc!.checkOutDate.updateValue(widget.miscModel!.endDate.toString());

                       formBloc!.cityName.updateValue(widget.miscModel!.cityName.toString());
                       formBloc!.cityID.updateValue(widget.miscModel!.city.toString());

                       formBloc!.miscID.updateValue(widget.miscModel!.miscellaneousType.toString());
                       formBloc!.miscName.updateValue(widget.miscModel!.miscellaneousTypeName.toString());


                       formBloc!.unitTypeName.updateValue("test");
                       formBloc!.unitTypeID.updateValue(widget.miscModel!.unitType.toString());


                       formBloc!.tfVoucher.updateValue(widget.miscModel!.voucherNumber.toString());
                       if(widget.miscModel!.voucherNumber.toString().isEmpty){
                         formBloc!.tfVoucher.updateValue("nill");
                       }
                       formBloc!.voucherPath.updateValue(widget.miscModel!.voucherPath.toString());

                      formBloc!.tfAmount.updateValue(widget.miscModel!.amount.toString());
                      formBloc!.tfDescription.updateValue(widget.miscModel!.description.toString());
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
                           GEMiscModel modelResponse = GEMiscModel.fromJson(jsonDecode(state.successResponse.toString()));

                            widget.onAdd!(
                                {
                                  "data": jsonDecode(state.successResponse.toString()),
                                  "item" : ExpenseModel(type: GETypes.MISCELLANEOUS,amount: modelResponse.amount.toString())
                                }
                            );
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
                                  Row(
                                    children: [
                                      Container(
                                        child: MetaDateTimeView(mapData: jsonData['checkInDateTime'],
                                            value: {"date": formBloc!.checkInDate.value},
                                            onChange: (value){
                                          formBloc!.checkInDate.updateValue(value['date'].toString());
                                        }),
                                      ),
                                      Container(
                                        child: MetaDateTimeView(mapData: jsonData['checkOutDateTime'],
                                            value: {"date": formBloc!.checkOutDate.value},
                                            onChange: (value){
                                          formBloc!.checkOutDate.updateValue(value['date'].toString());
                                        }),
                                      ),
                                    ],
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
                                              },),
                                          ),
                                        ),
                                        BlocBuilder<SelectFieldBloc, SelectFieldBlocState>(
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
                                                  },),
                                              );
                                            }
                                        ),
                                      ]),

                                  MetaTextFieldBlocView(mapData: jsonData['text_field_voucher'],
                                      textFieldBloc: formBloc!.tfVoucher,
                                      onChanged:(value){
                                        formBloc!.tfVoucher.updateValue(value);
                                      }),
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
                                          ],
                                    ),
                                  ),
                                  MetaTextFieldBlocView(mapData: jsonData['text_field_desc'],
                                      textFieldBloc: formBloc!.tfDescription,
                                      onChanged:(value){
                                        formBloc!.tfDescription.updateValue(value);
                                      }),
                                  UploadComponent(jsonData: jsonData['uploadButton'],
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


}
