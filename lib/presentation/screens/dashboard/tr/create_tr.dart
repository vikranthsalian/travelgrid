import 'package:flutter/material.dart';
import 'package:flutter_form_bloc/flutter_form_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:travelgrid/common/constants/flavour_constants.dart';
import 'package:travelgrid/common/extensions/parse_data_type.dart';
import 'package:travelgrid/common/injector/injector.dart';
import 'package:travelgrid/data/blocs/travel_request/tr_bloc.dart';
import 'package:travelgrid/data/cubits/approver_type_cubit/approver_type_cubit.dart';
import 'package:travelgrid/data/cubits/login_cubit/login_cubit.dart';
import 'package:travelgrid/data/datasources/login_response.dart';
import 'package:travelgrid/data/models/success_model.dart';
import 'package:travelgrid/domain/usecases/tr_usecase.dart';
import 'package:travelgrid/presentation/components/bloc_map_event.dart';
import 'package:travelgrid/presentation/components/dialog_yes_no.dart';
import 'package:travelgrid/presentation/screens/dashboard/tr/add/add_processed.dart';
import 'package:travelgrid/presentation/widgets/button.dart';
import 'package:travelgrid/presentation/widgets/icon.dart';
import 'package:travelgrid/presentation/widgets/text_view.dart';
import 'package:tuple/tuple.dart';
import 'package:travelgrid/data/datasources/list/approver_list.dart' as app;

class CreateTravelRequest extends StatelessWidget {

  bool isEdit;
  String? title;
  String? tripType;
  CreateTravelRequest({required this.isEdit,this.title,this.tripType});
  TravelRequestBloc?  bloc;
  Map? jsonData;
  @override
  Widget build(BuildContext context) {
    jsonData = FlavourConstants.trCreateData;


    if(title!=null) {
      bloc = Injector.resolve<TravelRequestBloc>()
        ..add(GetTravelRequestSummaryEvent(recordLocator: title!));
    }else{
      bloc = Injector.resolve<TravelRequestBloc>();
    }
    print("tripType-------");
    print(tripType);


    return  Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        color:ParseDataType().getHexToColor(jsonData!['backgroundColor']),
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
                  MetaIcon(mapData:jsonData!['backBar'],
                      onButtonPressed: (){
                        Navigator.pop(context);
                      }),
                  Container(
                    child:MetaTextView(mapData: jsonData!['title'],text:title),
                  ),
                ],
              ),
            ),
            Expanded(
                child:  BlocBuilder<TravelRequestBloc, TravelRequestState>(
                    bloc: bloc,
                    builder:(context, state) {
                      return Container(
                          color: Colors.white,
                          child: BlocMapToEvent(state: state.eventState, message: state.message,
                              callback: (){

                              },
                              child:CreateTravelRequestBody(state,isEdit,title ?? "",tripType)
                          )
                      );
                    }
                )
            ),
          ],
        ),
      ),
    );
  }

}


class CreateTravelRequestBody extends StatelessWidget {
  TravelRequestState? state;
  bool isEdit;
  String? title;
  String? tripType;
  CreateTravelRequestBody(this.state,this.isEdit,this.title,this.tripType);

  Map<String,dynamic> jsonData = {};
  Map<String,dynamic> submitMap = {};
  List details=[];


  List<String> values=[];

  MetaLoginResponse loginResponse = MetaLoginResponse();


  Tuple2<String,String>? approver1;
  Tuple2<String,String>? approver2;

 // TrApproval? trApproval;
  TrProcessed? trProcessed;
  //TrDelivery? trDelivery;

  TravelRequestBloc?  bloc;
  var map = {
    "text" : '',
    "color" : "0xFFFFFFFF",
    "size": "14",
    "family": "regular",
    "align" : "center"
  };
  int selected = 0;
  final List<bool> steps = <bool>[true, false, false];
   List<Widget> items = <Widget>[];
   BuildContext? ctx;


  @override
  Widget build(BuildContext context) {
    ctx=context;

    jsonData = FlavourConstants.trCreateData;
    setData();



    return Scaffold(
      backgroundColor: Colors.transparent,
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
                onButtonPressed: () async {

                await showDialog(
                  context: context,
                  builder: (_) => DialogYesNo(
                    title: "Are you sure you want to close, All Data will be lost.Please confirm before closing.",
                    onPressed: (value){
                      if(value == "YES"){
                        Navigator.pop(context);
                      }
                    }));
                }
            ),

            MetaButton(mapData: jsonData['bottomButtonRight'],text: "Submit",
                onButtonPressed: (){
                trProcessed!.procSubmit();
                }
            )
          ],
        ),
      ),
      body: Container(
        color:ParseDataType().getHexToColor(jsonData['backgroundColor']),
        child: Container(
          child: trProcessed,
        ),
      ),
    );
  }


  checkCashAdvance()async{
    List cashList= submitMap['maCashAdvance']??[];

    if(cashList.isEmpty){

      await showDialog(
      context: ctx!,
      builder: (_) => DialogYesNo(
          title: "You have not added any cash advance, Do you want to continue?",
          onPressed: (value){
            if(value == "YES"){
              checkOverlapped();
            }
          }));
    }else{
      checkOverlapped();
    }

  }


  checkOverlapped()async{

    List cities= submitMap['maTravelRequestCityPair'];
    print(cities);


    Map<String,dynamic> overlapParams = {
      "owner":loginResponse.data!.employeecode,
      if(isEdit)...{
        "recordLocator":title,
      },
      "startDate": cities.first['startDate'],
      "endDate":cities.last['startDate'],
    };

    SuccessModel model =   await Injector.resolve<TrUseCase>().checkOverlapped(overlapParams);
    print(model.toJson());
    if(model.message == null){
      submitTr();
    }

  }

  submitTr() async{


    print(submitMap);


    Map<String,dynamic> queryParams = {
      "approver1":approver1!.item2.toString().toLowerCase(),
      "approver2":approver2!.item2.toString().toLowerCase(),
      if(isEdit)...{
       "id":"71",
       "action":"modify",
      },
    };
    SuccessModel model;
    if(isEdit){
     model =   await Injector.resolve<TrUseCase>().updateTR(queryParams,submitMap);
    }else{
      model =   await Injector.resolve<TrUseCase>().createTR(queryParams,submitMap);
    }



    if(model.status==true){
      Navigator.pop(ctx!);
    }
  }

  void setData() {

    items = <Widget>[
      MetaTextView(mapData: map,text: 'Approval'),
      MetaTextView(mapData: map,text: 'Processed'),
      MetaTextView(mapData: map,text: 'Delivery'),
    ];

    details = jsonData['requesterDetails']['data'];

    loginResponse = ctx!.read<LoginCubit>().getLoginResponse();


    try {
      values.add(loginResponse.data!.fullName ?? "");
      values.add(loginResponse.data!.grade!.organizationGradeName ?? "");
      //   values.add(loginResponse.data!.gender ?? "");
      values.add(loginResponse.data!.employeecode ?? "");
      //   values.add(loginResponse.data!.divName ?? "");
      values.add(loginResponse.data!.deptName ?? "");
      //  values.add(loginResponse.data!.costCenter!.costcenterName ?? "");
      values.add(loginResponse.data!.worklocation!.locationName ?? "");
      //   values.add(loginResponse.data!.currentContact!.mobile ?? "");
      //  values.add(loginResponse.data!.permanentContact ?? "");
      Tuple2<app.Data,app.Data> approvers = ctx!.read<ApproverTypeCubit>().getApprovers();
      approver1 = Tuple2(approvers.item1.approverName.toString(), approvers.item1.approverCode.toString());
      approver2 = Tuple2(approvers.item2.approverName.toString(), approvers.item1.approverCode.toString());

      submitMap['emergencyContactNo']= loginResponse.data!.currentContact!.telephoneNo ?? "";
      submitMap['mobileNumber']= loginResponse.data!.currentContact!.mobile ?? "";
      submitMap['tripType']= tripType;
      submitMap['maTravelerDetails']= [];
      submitMap['maForexAdvance']= [];
      submitMap['maTravelVisas']= [];
      submitMap['maTravelInsurance']= [];
      submitMap['maAccomodationPlanDetail']= [];
      submitMap['maTaxiPlanDetail']= [];
    }catch(ex){

    }

    trProcessed=TrProcessed(
        isEdit: isEdit,
        summaryResponse: state?.responseSum,
        tripType: tripType,
        onNext: (Map<String,dynamic> value){
          if(tripType == "D"){
            value.remove("maForexAdvance");
            value.remove("maTravelVisas");
            value.remove("maTravelInsurance");
          }
          submitMap.addAll(value);
          checkCashAdvance();
        });

  }

}
