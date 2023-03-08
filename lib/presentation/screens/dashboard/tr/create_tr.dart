import 'package:flutter/material.dart';
import 'package:flutter_form_bloc/flutter_form_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:travelgrid/common/constants/flavour_constants.dart';
import 'package:travelgrid/common/extensions/parse_data_type.dart';
import 'package:travelgrid/common/injector/injector.dart';
import 'package:travelgrid/data/blocs/general_expense/ge_bloc.dart';
import 'package:travelgrid/data/cubits/approver_type_cubit/approver_type_cubit.dart';
import 'package:travelgrid/data/cubits/login_cubit/login_cubit.dart';
import 'package:travelgrid/data/datasources/login_response.dart';
import 'package:travelgrid/data/models/success_model.dart';
import 'package:travelgrid/domain/usecases/tr_usecase.dart';
import 'package:travelgrid/presentation/components/dialog_yes_no.dart';
import 'package:travelgrid/presentation/screens/dashboard/tr/add/add_approval.dart';
import 'package:travelgrid/presentation/screens/dashboard/tr/add/add_delivery.dart';
import 'package:travelgrid/presentation/screens/dashboard/tr/add/add_processed.dart';
import 'package:travelgrid/presentation/widgets/button.dart';
import 'package:travelgrid/presentation/widgets/icon.dart';
import 'package:travelgrid/presentation/widgets/text_view.dart';
import 'package:tuple/tuple.dart';
import 'package:travelgrid/data/datasources/approver_list.dart' as app;

class CreateTravelRequest extends StatefulWidget {
  bool isEdit;
  String? title;
  bool isApproval;
  String? status;
  String? tripType;
  CreateTravelRequest({this.isEdit=true,this.title,this.isApproval=false,this.status,this.tripType});

  @override
  _CreateTravelRequestState createState() => _CreateTravelRequestState();
}

class _CreateTravelRequestState extends State<CreateTravelRequest> {
  Map<String,dynamic> jsonData = {};
  Map<String,dynamic> submitMap = {};
  List details=[];


  List<String> values=[];

  MetaLoginResponse loginResponse = MetaLoginResponse();


  Tuple2<String,String>? approver1;
  Tuple2<String,String>? approver2;

  TrApproval? trApproval;
  TrProcessed? trProcessed;
  TrDelivery? trDelivery;

  GeneralExpenseBloc?  bloc;
  bool loaded =false;
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
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    jsonData = FlavourConstants.trCreateData;
    items = <Widget>[
      MetaTextView(mapData: map,text: 'Approval'),
      MetaTextView(mapData: map,text: 'Processed'),
      MetaTextView(mapData: map,text: 'Delivery'),
    ];

     details = jsonData['requesterDetails']['data'];

    loginResponse = context.read<LoginCubit>().getLoginResponse();


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
      Tuple2<app.Data,app.Data> approvers = context.read<ApproverTypeCubit>().getApprovers();
      approver1 = Tuple2(approvers.item1.approverName.toString(), approvers.item1.approverCode.toString());
      approver2 = Tuple2(approvers.item2.approverName.toString(), approvers.item1.approverCode.toString());

      submitMap['emergencyContactNo']= loginResponse.data!.currentContact!.telephoneNo ?? "";
      submitMap['mobileNumber']= loginResponse.data!.currentContact!.mobile ?? "";
      submitMap['tripType']= "D";
      submitMap['maTravelerDetails']= [];
      submitMap['maForexAdvance']= [];
      submitMap['maTravelVisas']= [];
      submitMap['maTravelInsurance']= [];
      submitMap['maAccomodationPlanDetail']= [];
      submitMap['maTaxiPlanDetail']= [];
    }catch(ex){

    }

    trApproval = TrApproval(onNext: (value){
      submitMap.addAll(value);
     setState(() {
       selected=1;
     });
    });
    trProcessed = TrProcessed(
      tripType: widget.tripType,
      onNext: (Map<String,dynamic> value){
        if(widget.tripType=="D"){
          value.remove("maForexAdvance");
          value.remove("maTravelVisas");
          value.remove("maTravelInsurance");
        }
        submitMap.addAll(value);
     setState(() {
       selected=2;
     });
    });
    trDelivery = TrDelivery(onNext: (value){
      submitMap.addAll(value);
      submitTr();


    });


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
                onButtonPressed: () async {

              if(selected==0){
                await showDialog(
                context: context,
                builder: (_) => DialogYesNo(
                    title: "Are you sure you want to close, All Data will be lost.Please confirm before closing.",
                    onPressed: (value){

                      if(value == "YES"){
                        Navigator.pop(context);
                      }


                    }));
              }else{
                setState(() {
                  selected= selected-1;

                });
              }



                }
            ),

            MetaButton(mapData: jsonData['bottomButtonRight'],
                onButtonPressed: (){

              if(selected == 0){
                trApproval!.apprSubmit();
              }

              if(selected == 1){
                trProcessed!.procSubmit();
              }

              if(selected == 2){
                trDelivery!.delSubmit();
              }

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
                    child:MetaTextView(mapData: jsonData['title'],text:widget.title),
                  ),
                ],
              ),
            ),
            // Container(
            //   alignment: Alignment.center,
            //   width: double.infinity,
            //   child: MetaToggleButton(
            //     onCheckPressed: (index){
            //
            //       setState(() {
            //         selected = index;
            //       });
            //
            //     },
            //     steps: steps,items: items,enabledColor:ParseDataType().getHexToColor(jsonData['backgroundColor']) ,)
            // ),
            SizedBox(height: 10.h,),
            Expanded(
              child: Container(
                color: Colors.white,
                child:  getBody(),
              ),
            ),

          ],
        ),
      ),
    );
  }


  submitTr()async{

    print(submitMap);

    Map<String,dynamic> queryParams = {
      "approver1":approver1!.item2.toString().toLowerCase(),
      "approver2":approver2!.item2.toString().toLowerCase(),
      "comment":"daskdsakdkasdka",
    };

    SuccessModel model =   await Injector.resolve<TrUseCase>().createTR(queryParams,submitMap);

    if(model.status==true){
      Navigator.pop(context);
    }
  }


  getBody() {
    switch(selected){

      case 0:
        return trApproval;
      case 1:
        return trProcessed;
      case 2:
        return trDelivery;
      default :
        return Container();
    }


  }

}
