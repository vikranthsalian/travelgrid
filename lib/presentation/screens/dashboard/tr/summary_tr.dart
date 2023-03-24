import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_form_bloc/flutter_form_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:travelgrid/common/constants/flavour_constants.dart';
import 'package:travelgrid/common/extensions/parse_data_type.dart';
import 'package:travelgrid/common/extensions/pretty.dart';
import 'package:travelgrid/common/injector/injector.dart';
import 'package:travelgrid/data/blocs/travel_request/tr_bloc.dart';
import 'package:travelgrid/data/cubits/approver_type_cubit/approver_type_cubit.dart';
import 'package:travelgrid/data/cubits/login_cubit/login_cubit.dart';
import 'package:travelgrid/data/datasources/list/approver_list.dart' as app;
import 'package:travelgrid/data/datasources/login_response.dart';
import 'package:travelgrid/data/datasources/summary/tr_summary_response.dart';
import 'package:travelgrid/data/models/expense_model.dart';
import 'package:travelgrid/data/models/success_model.dart';
import 'package:travelgrid/domain/usecases/ge_usecase.dart';
import 'package:travelgrid/domain/usecases/tr_usecase.dart';
import 'package:travelgrid/presentation/components/bloc_map_event.dart';
import 'package:travelgrid/presentation/widgets/button.dart';
import 'package:travelgrid/presentation/widgets/dialog_selector_view.dart';
import 'package:travelgrid/presentation/widgets/icon.dart';
import 'package:travelgrid/presentation/widgets/switch.dart';
import 'package:travelgrid/presentation/widgets/text_field.dart';
import 'package:travelgrid/presentation/widgets/text_view.dart';
import 'package:tuple/tuple.dart';

class TravelRequestSummary extends StatefulWidget {
  bool isEdit;
  String? title;
  bool isApproval;
  String? status;
  TravelRequestSummary({this.isEdit=true,this.title,this.isApproval=false,this.status});

  @override
  _TravelRequestSummaryState createState() => _TravelRequestSummaryState();
}

class _TravelRequestSummaryState extends State<TravelRequestSummary> {
  Map<String,dynamic> jsonData = {};
  Map<String,dynamic> submitMap = {};
  List details=[];
  List expenseTypes=[];
  List<Tuple2<ExpenseModel,Map<String,dynamic>>> summaryItems=[];
  List<Tuple2<Map,String>> summaryDetails=[];
  List<String> values=[];

  bool showRequesterDetails=false;
  bool cityPairDetails=true;
  bool cashAdvanceDetails=false;
  bool forexAdvanceDetails=false;
  bool visaDetails=false;
  bool insuranceDetails=false;
  bool showApproverDetails=false;
  String tripType="";
  List<MaCityPairs>? cityPairList=[];
  List<MaCashAdvance>? cashAdvanceList=[];
  List<MaForexAdvance>? forexAdvanceList=[];
  List<MaTravelVisas>? visaList=[];
  List<MaTravelInsurance>? insuranceList=[];

  String total="0.00";
  MetaLoginResponse loginResponse = MetaLoginResponse();

  Tuple2<String,String>? approver1;
  Tuple2<String,String>? approver2;
  String description="";
  TextEditingController controller =TextEditingController();





  TravelRequestBloc?  bloc;
  bool loaded =false;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    loaded=false;
    jsonData = FlavourConstants.trViewData;
   // prettyPrint(jsonData);

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



      submitMap['employeeName']= loginResponse.data!.fullName;
      submitMap['selfApprovals']= false;
      submitMap['violated']= false;
    }catch(ex){
      approver1 = Tuple2("DUMMY", "cm01");
      approver2 = Tuple2("DUMMY", "cm02");
    }

    if(!widget.isEdit){
      bloc = Injector.resolve<TravelRequestBloc>()..add(GetTravelRequestSummaryEvent(recordLocator: widget.title!));
    }else{
      bloc = Injector.resolve<TravelRequestBloc>();
    }

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
        child:buildViewRow(),
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
            Expanded(
              child:  BlocBuilder<TravelRequestBloc, TravelRequestState>(
                  bloc: bloc,
                  builder:(context, state) {
                    return Container(
                        child: BlocMapToEvent(state: state.eventState, message: state.message,
                            callback: (){

                            },
                            child:buildView(state)
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

  Widget buildView(TravelRequestState state){
    loaded=false;
    if(state.responseSum!=null && !loaded) {
       TRSummaryResponse? response = state.responseSum;
       tripType = response!.data?.tripType  ?? "Domestic";

       cityPairList = response.data?.maCityPairs ?? [];
       cashAdvanceList = response.data?.maCashAdvance ?? [];
       forexAdvanceList = response.data?.maForexAdvance ?? [];
       visaList = response.data?.maTravelVisas ?? [];
       insuranceList = response.data?.maTravelInsurance ?? [];

        loaded=true;

    }


    return Container(
      color:Colors.white,
      child:SingleChildScrollView(
        child: Column(
          children: [
            buildExpandableView(jsonData,"requesterDetails"),
            buildExpandableView(jsonData,"cityPairDetails"),
            if(tripType=="Domestic")
            buildExpandableView(jsonData,"cashAdvanceDetails"),
            if(tripType=="Overseas")
            buildExpandableView(jsonData,"forexAdvanceDetails"),
            if(tripType=="Overseas")
            buildExpandableView(jsonData,"visaDetails"),
            if(tripType=="Overseas")
            buildExpandableView(jsonData,"insuranceDetails"),
            buildExpandableView(jsonData,"approverDetails"),
          ],
        ),
      ),
    );
  }

  Row buildSubmitRow() {
    return Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          MetaButton(mapData: jsonData['bottomButtonLeft'],
              onButtonPressed: (){

              }
          ),
          MetaButton(mapData: jsonData['bottomButtonRight'],
              onButtonPressed: (){
                submitGe("submit");
              }
          )
        ],
      );
  }

  Row buildViewRow() {
    bool isTBVisible=false;
    bool isAPVisible=false;
    if(widget.status!.toLowerCase()== "approver 1"){
      isTBVisible=true;
    }

    if(widget.isApproval){
      isTBVisible=false;
      isAPVisible=true;
    }

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Expanded(
          child: MetaButton(mapData: jsonData['bottomButtonLeft'],text: "Cancel",
              onButtonPressed: (){

              }
          ),
        ),
        isAPVisible?
        Expanded(
          child: MetaButton(mapData: jsonData['bottomButtonRight'],text: "Approve",
              onButtonPressed: ()async{
             SuccessModel  model =  await Injector.resolve<TrUseCase>().approveTR(widget.title!,controller.text);

                if(model.status==true){
                Navigator.pop(context);
                }
              }
          ),
        ):SizedBox(width: 0,),
        isTBVisible?
        Expanded(
          child: MetaButton(mapData: jsonData['bottomButtonRight'],text: "Take Back",
              onButtonPressed: (){

              }
          ),
        ):SizedBox(width: 0),
      ],
    );
  }


  Container buildExpandableView(Map mapData,String key){
    Map map= mapData[key];

    Container getSwitches(map,value){
      switch(value){
        case "requesterDetails":
          return Container(
            alignment: Alignment.centerLeft,
            child: MetaSwitch(mapData: map['showDetails'],
              value: showRequesterDetails,
              onSwitchPressed: (value){
                setState(() {
                  showRequesterDetails=value;
                });
              },),
          );
        case "cityPairDetails":
          return Container(
            alignment: Alignment.centerRight,
            child: MetaSwitch(mapData: map['showDetails'],
              value: cityPairDetails,
              onSwitchPressed: (value){

                setState(() {
                  cityPairDetails=value;
                });

              },),
          );
        case "cashAdvanceDetails":
          return Container(
            alignment: Alignment.centerRight,
            child: MetaSwitch(mapData: map['showDetails'],
              value: cashAdvanceDetails,
              onSwitchPressed: (value){

                setState(() {
                  cashAdvanceDetails=value;
                });

              },),
          );
        case "forexAdvanceDetails":
          return Container(
            alignment: Alignment.centerRight,
            child: MetaSwitch(mapData: map['showDetails'],
              value: forexAdvanceDetails,
              onSwitchPressed: (value){

                setState(() {
                  forexAdvanceDetails=value;
                });

              },),
          );
        case "visaDetails":
          return Container(
            alignment: Alignment.centerRight,
            child: MetaSwitch(mapData: map['showDetails'],
              value: visaDetails,
              onSwitchPressed: (value){

                setState(() {
                  visaDetails=value;
                });

              },),
          );
        case "insuranceDetails":
          return Container(
            alignment: Alignment.centerRight,
            child: MetaSwitch(mapData: map['showDetails'],
              value: insuranceDetails,
              onSwitchPressed: (value){

                setState(() {
                  insuranceDetails=value;
                });

              },),
          );
        case "approverDetails":
          return Container(
            alignment: Alignment.centerRight,
            child: MetaSwitch(mapData: map['showDetails'],
              value: showApproverDetails,
              onSwitchPressed: (value){

                setState(() {
                  showApproverDetails=value;
                });

              },),
          );
        default:
          return Container();

      }

    }

    Container getViews(map,value){
      switch(value){
        case "requesterDetails":
          return showRequesterDetails ? buildRequesterWidget(map):Container();
        case "cityPairDetails":
          return cityPairDetails ? buildCityPairWidget(map):Container();
        case "cashAdvanceDetails":
          return cashAdvanceDetails ? buildCashAdvanceWidget(map):Container();
        case "forexAdvanceDetails":
          return forexAdvanceDetails ? buildForexAdvanceWidget(map):Container();
        case "visaDetails":
          return visaDetails ? buildVisaWidget(map):Container();
        case "insuranceDetails":
          return insuranceDetails ? buildInsuranceWidget(map):Container();
        case "approverDetails":
          return showApproverDetails ? buildApproverWidget(map):Container();
        default:
          return Container();
      }

    }
    return Container(
      child: Column(
        children: [
          buildHeaders(map, getSwitches(map,key)),
          getViews(map,key)
        ],
      ),
    );
  }

  Container buildHeaders(Map map, Container child) {
    return Container(
            height: 40.h,
            color:ParseDataType().getHexToColor(jsonData['backgroundColor']),
            child: Row(

              children: [
                Container(
                    margin: EdgeInsets.symmetric(horizontal: 20.w),
                    child: MetaTextView(mapData: map['label'])),
                Expanded(child: child)
              ],
            ),
          );
  }

  Container buildCityPairWidget(Map map) {

    return  Container(
      padding: EdgeInsets.symmetric(horizontal: 5.w),
      color: Colors.white,
      child: cityPairList!.isNotEmpty ? Column(
        children: [
          ListView.builder(
              physics: NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              padding: EdgeInsets.zero,
              itemBuilder: (BuildContext context, int index) {
                MaCityPairs item = cityPairList![index];
                return Container(
                  padding: EdgeInsets.symmetric(vertical: 1.h),
                  color: Colors.white,
                  child: Card(
                    color: Color(0xFF2854A1),
                    elevation: 1,
                    child: Column(
                      children: [
                        Container(

                          padding: EdgeInsets.symmetric(horizontal: 10.w,vertical: 5.h),
                          color:Colors.white,
                          child:   Column(
                            children: [
                              if(item.price!=null)
                              Container(
                                child: MetaTextView(mapData:  map['price'],text: item.price.toString()),
                                alignment: Alignment.centerRight,
                              ),
                              Container(
                                child: Row(

                                  children: [
                                    Container(child:
                                    Expanded(child: MetaTextView(mapData:  map['date'],text:item.startDate.toString()))),
                                    Expanded(child: Container(
                                        child: MetaTextView(mapData:  map['time'],text: item.startTime.toString())
                                    )),
                                  ],
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                ),
                              ),
                              Container(

                                child: Row(
                                  children: [
                                    Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        if(item.leavingFrom!.cityCode!=null)
                                        MetaTextView(mapData:  map['code'],text: item.leavingFrom!.cityCode.toString()),
                                        MetaTextView(mapData:  map['city'],text: item.leavingFrom!.name!.toUpperCase().toString())
                                      ],
                                    ),
                                    Expanded(child: Container()),
                                    Column(
                                      crossAxisAlignment: CrossAxisAlignment.end,
                                      children: [
                                        if(item.goingTo!.cityCode!=null)
                                        MetaTextView(mapData:  map['code'],text: item.goingTo!.cityCode.toString()),
                                        MetaTextView(mapData:  map['city'],text: item.goingTo!.name!.toUpperCase().toString())
                                      ],
                                    )
                                  ],
                                ),
                              ),

                            ],
                          ),
                        ),
                        SizedBox(height: 3.h,),
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: 10.w),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Expanded(child: MetaTextView(mapData:  map['byComp'],text: item.byCompany!.label!.toLowerCase().toString()=="yes"?"BY COMPANY":"")),
                                Expanded(child: MetaTextView(mapData:  map['fare'],text: item.fareClass!.label!.toUpperCase().toString()))
                              ]
                          ),
                        ),
                        SizedBox(height: 3.h,),
                      ],
                    ),
                  )

                );
              },
              itemCount: cityPairList!.length
          ),
        ],
      ):SizedBox(),
    );

  }

  Container buildCashAdvanceWidget(Map map) {

    return  Container(
      padding: EdgeInsets.symmetric(horizontal: 10.w),
      color: Colors.white,
      child: cashAdvanceList!.isNotEmpty ? Column(
        children: [
          Row(
            children: [
              Container(
                  width: 40.w,
                  child: MetaTextView(mapData:  map['header'],text: "Sl.No.")),
              Expanded(child: MetaTextView(mapData:  map['header'],text: "Currency",)),
              Expanded(
                  flex: 2,
                  child: MetaTextView(mapData:  map['header'],text: "Requested Amount")),
              Expanded(child: MetaTextView(mapData:  map['header'],text: "Status")),
              //     Expanded(child: MetaTextView(mapData:  map['dAmount'])),
            ],
          ),
          ListView.builder(
              physics: NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              padding: EdgeInsets.zero,
              itemBuilder: (BuildContext context, int index) {
                MaCashAdvance item = cashAdvanceList![index];
                return Container(
                  padding: EdgeInsets.symmetric(vertical: 5.h),
                  color: Colors.white,
                  child:  Row(
                    children: [
                      Container(
                          width: 40.w,
                          child: MetaTextView(mapData:  map['item'],text: (index+1).toString())),
                      Expanded(child: MetaTextView(mapData:  map['item'],text: "INR",)),
                      Expanded(
                          flex: 2,
                          child: MetaTextView(mapData:  map['item'],text:item.totalCashAmount.toString(),)),
                      Expanded(child: MetaTextView(mapData:  map['item'],text: item.currentStatus)),
                      //     Expanded(child: MetaTextView(mapData:  map['dAmount'])),
                    ],
                  ),
                );
              },
              itemCount: cashAdvanceList!.length
          ),
        ],
      ):SizedBox(),
    );

  }

  Container buildForexAdvanceWidget(Map map) {

    return  Container(
      padding: EdgeInsets.symmetric(horizontal: 10.w),
      color: Colors.white,
      child: forexAdvanceList!.isNotEmpty ? Column(
        children: [
          Row(
            children: [
              Container(
                  width: 10.w,
                  child: MetaTextView(mapData:  map['header'],text: "#")),
              Expanded(child: MetaTextView(mapData:  map['header'],text: "Currency",)),
              Expanded(flex:2,child: MetaTextView(mapData:  map['header'],text: "Req Cash")),
              Expanded(flex:2,child: MetaTextView(mapData:  map['header'],text: "Req Card")),
              Expanded(flex:2,child: MetaTextView(mapData:  map['header'],text: "Total Forex(INR)")),
              //     Expanded(child: MetaTextView(mapData:  map['dAmount'])),
            ],
          ),
          ListView.builder(
              physics: NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              padding: EdgeInsets.zero,
              itemBuilder: (BuildContext context, int index) {

                MaForexAdvance item = forexAdvanceList![index];

                return Container(
                  margin: EdgeInsets.symmetric(vertical: 5.h),
                  color: Colors.white,
                  child:  Row(
                    children: [
                      Container(
                          width: 10.w,
                          child: MetaTextView(mapData:  map['item'],text: (index+1).toString())),
                      Expanded(child: MetaTextView(mapData:  map['item'],text: item.currency)),
                      Expanded(flex:2,child: MetaTextView(mapData:  map['item'],text: item.cash.toString(),)),
                      Expanded(flex:2,child: MetaTextView(mapData:  map['item'],text: item.card.toString(),)),
                      Expanded(flex:2,child: MetaTextView(mapData:  map['item'],text: item.totalForexAmount.toString())),
                    ],
                  ),
                );
              },
              itemCount: forexAdvanceList!.length
          ),
        ],
      ):SizedBox(),
    );

  }

  Container buildVisaWidget(Map map) {

    return  Container(
      padding: EdgeInsets.symmetric(horizontal: 10.w),
      color: Colors.white,
      child: visaList!.isNotEmpty ? Column(
        children: [
          Row(
            children: [
              Container(
                  width: 10.w,
                  child: MetaTextView(mapData:  map['header'],text: "#")),
              Expanded(child: MetaTextView(mapData:  map['header'],text: "Service Type",)),
              Expanded(
                  child: MetaTextView(mapData:  map['header'],text: "Visa Requirement")),
            ],
          ),
          ListView.builder(
              physics: NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              padding: EdgeInsets.zero,
              itemBuilder: (BuildContext context, int index) {
                MaTravelVisas item = visaList![index];
                return Container(
                  padding: EdgeInsets.symmetric(vertical: 5.h),
                  color: Colors.white,
                  child:  Row(
                    children: [
                      Container(
                          width: 10.w,
                          child: MetaTextView(mapData:  map['item'],text: (index+1).toString())),
                      Expanded(child: MetaTextView(mapData:  map['item'],text: "Visa")),
                      Expanded(child: MetaTextView(mapData:  map['item'],text:item.visaRequirement,)),
                    ],
                  ),
                );
              },
              itemCount: visaList!.length
          ),
        ],
      ):SizedBox(),
    );

  }

  Container buildInsuranceWidget(Map map) {

    return  Container(
      padding: EdgeInsets.symmetric(horizontal: 10.w),
      color: Colors.white,
      child: insuranceList!.isNotEmpty ? Column(
        children: [
          Row(
            children: [
              Container(
                  width: 10.w,
                  child: MetaTextView(mapData:  map['header'],text: "#")),
              Expanded(child: MetaTextView(mapData:  map['header'],text: "Service Type",)),
              Expanded(
                  child: MetaTextView(mapData:  map['header'],text: "Insurance Requirement")),
            ],
          ),
          ListView.builder(
              physics: NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              padding: EdgeInsets.zero,
              itemBuilder: (BuildContext context, int index) {
                MaTravelInsurance item = insuranceList![index];
                return Container(
                  padding: EdgeInsets.symmetric(vertical: 6.h),
                  color: Colors.white,
                  child:  Row(
                    children: [
                      Container(
                          width: 10.w,
                          child: MetaTextView(mapData:  map['item'],text: (index+1).toString())),

                      Expanded(child: MetaTextView(mapData:  map['item'],text: "Insurance")),
                      Expanded(child: MetaTextView(mapData:  map['item'],text:item.insuranceRequirement)),
                    ],
                  ),
                );
              },
              itemCount: insuranceList!.length
          ),
        ],
      ):SizedBox(),
    );

  }

  Container buildApproverWidget(Map map){
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20.w,vertical: 10.h),
      color: Colors.white,
      child:ListView(
        padding: EdgeInsets.zero,
        shrinkWrap: true,
        children:[
          Row(
              children: [
                Expanded(
                  child: Container(
                    child: MetaDialogSelectorView(
                        text: approver1!.item1,
                        mapData: map['selectApprover1']
                    ),
                    alignment: Alignment.centerLeft,
                  ),
                ),
                Expanded(
                  child: Container(
                    child: MetaDialogSelectorView(
                        text: approver2!.item1,
                        mapData: map['selectApprover2']
                    ),
                  ),
                ),
              ]),
          (widget.isEdit || widget.isApproval) ?
          MetaTextFieldView(
             controller: controller,
              mapData: map['text_field_desc'],
              onChanged:(value){
                description=value;
              }):SizedBox(),

        ],
      ),
    );
  }

  Container buildRequesterWidget(Map map){
    return Container(
        color: Colors.white,
        child: GridView.builder(
          physics: NeverScrollableScrollPhysics(),
          padding: EdgeInsets.zero,
          itemCount: details.length,
          shrinkWrap: true,
          gridDelegate: new SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount:2,
              childAspectRatio: 7,
              mainAxisSpacing: 3.h
          ),
          itemBuilder: (BuildContext context, int index) {
            return Container(
                margin: EdgeInsets.symmetric(horizontal: 20.w),
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      MetaTextView(mapData: map['gridLabel'],text:details[index],
                        key: UniqueKey(),),
                      MetaTextView(mapData: map['gridValue'],text:values[index],
                        key: UniqueKey(),)
                    ])
            );
          },
        )
    );
  }


  void submitGe(text) async{
    submitMap['selfApprovals']= false;
    submitMap['violated']= false;

    final String requestBody = json.encoder.convert(submitMap);

    Map<String, dynamic> valueMap = json.decode(requestBody);

   Map<String,dynamic> queryParams = {
     "approver1":approver1!.item2.toString().toLowerCase(),
     "approver2":approver2!.item2.toString().toLowerCase(),
     "action":text,
     "comment":"daskdsakdkasdka",
   };

   prettyPrint(valueMap);

    SuccessModel model =   await Injector.resolve<GeUseCase>().createGE(queryParams,valueMap);

    if(model.status==true){
      Navigator.pop(context);
    }

  }

}
