import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_form_bloc/flutter_form_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:travelgrid/common/constants/asset_constants.dart';
import 'package:travelgrid/common/constants/flavour_constants.dart';
import 'package:travelgrid/common/constants/route_constants.dart';
import 'package:travelgrid/common/enum/dropdown_types.dart';
import 'package:travelgrid/common/extensions/parse_data_type.dart';
import 'package:travelgrid/common/extensions/pretty.dart';
import 'package:travelgrid/common/injector/injector.dart';
import 'package:travelgrid/data/blocs/travel_expense/te_bloc.dart';
import 'package:travelgrid/data/cubits/approver_type_cubit/approver_type_cubit.dart';
import 'package:travelgrid/data/cubits/login_cubit/login_cubit.dart';
import 'package:travelgrid/data/datasources/approver_list.dart' as app;
import 'package:travelgrid/data/datasources/login_response.dart';
import 'package:travelgrid/data/datasources/te_summary_response.dart';
import 'package:travelgrid/data/models/expense_model.dart';
import 'package:travelgrid/data/models/ge_accom_model.dart';
import 'package:travelgrid/data/models/ge_conveyance_model.dart';
import 'package:travelgrid/data/models/ge_misc_model.dart';
import 'package:travelgrid/data/models/success_model.dart';
import 'package:travelgrid/domain/usecases/te_usecase.dart';
import 'package:travelgrid/presentation/components/bloc_map_event.dart';
import 'package:travelgrid/presentation/screens/ge/add/add_accom.dart';
import 'package:travelgrid/presentation/screens/ge/add/add_misc.dart';
import 'package:travelgrid/presentation/screens/te/add/add_travel.dart';
import 'package:travelgrid/presentation/widgets/button.dart';
import 'package:travelgrid/presentation/widgets/dialog_selector_view.dart';
import 'package:travelgrid/presentation/widgets/icon.dart';
import 'package:travelgrid/presentation/widgets/svg_view.dart';
import 'package:travelgrid/presentation/widgets/switch.dart';
import 'package:travelgrid/presentation/widgets/text_field.dart';
import 'package:travelgrid/presentation/widgets/text_view.dart';
import 'package:tuple/tuple.dart';

class CreateTravelExpense extends StatefulWidget {
  bool isEdit;
  String? title;
  CreateTravelExpense({this.isEdit=true,this.title});

  @override
  _CreateTravelExpenseState createState() => _CreateTravelExpenseState();
}

class _CreateTravelExpenseState extends State<CreateTravelExpense> {
  Map<String,dynamic> jsonData = {};
  Map<String,dynamic> submitMap = {};
  List details=[];
  List expenseTypes=[];
  List<Tuple2<ExpenseModel,Map<String,dynamic>>> summaryItems=[];
  List<Tuple2<Map,String>> summaryDetails=[];
  List<String> values=[];
  List<ExpenseVisitDetails> visitItems=[];

  bool showRequesterDetails=false;
  bool showVisitDetails=true;
  bool showSummaryItems=true;
  bool showSummaryDetails=false;
  bool showApproverDetails=false;

  String total="0.00";
  MetaLoginResponse loginResponse = MetaLoginResponse();

  Tuple2<String,String>? approver1;
  Tuple2<String,String>? approver2;
  String description="";





  TravelExpenseBloc?  bloc;
  bool loaded =false;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    jsonData = FlavourConstants.teCreateData;
   // prettyPrint(jsonData);

     details = jsonData['requesterDetails']['data'];
     expenseTypes = jsonData['expensesTypes'];

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


    for(var item in jsonData['summaryDetails']['data']){
      summaryDetails.add(Tuple2(item, "0"));
    }


      bloc = Injector.resolve<TravelExpenseBloc>()..add(GetTravelExpenseSummaryEvent(recordLocator: widget.title!));

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
        child: widget.isEdit ? buildSubmitRow():SizedBox(),
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
            widget.isEdit ?
            Container(
              color: Colors.white,
              height:70.h,
              child: Container(
                margin: EdgeInsets.symmetric(horizontal: 10.w),
                child: Row(
                  children: expenseTypes.map((e) {

                    return Container(
                      margin: EdgeInsets.symmetric(horizontal: 5.w),
                      width: 60.w,
                      height: 60.w,
                      child: InkWell(
                          onTap: () async{
                            navigate(e,false,{},0);
                          },
                          child:Container(
                            height: 50.h,
                            decoration: BoxDecoration(
                              color: ParseDataType().getHexToColor(jsonData['backgroundColor']),
                              shape: BoxShape.circle,
                            ),
                            child: Stack(
                              alignment: Alignment.center,
                              children: [
                                Container(
                                  width: 25.w,
                                  height: 25.w,
                                  child: SvgPicture.asset(
                                    AssetConstants.assetsBaseURLSVG +"/"+  e['svgIcon']['icon'],//e['svgIcon']['color']
                                    color: ParseDataType().getHexToColor(e['svgIcon']['color']),
                                    width: 25.w,
                                    height: 25.w,
                                  ),
                                ),
                              ],
                            ),
                          )
                      ),
                    );
                  }).toList(),
                ),
              ),
            ):SizedBox(),
            Expanded(
              child:  BlocBuilder<TravelExpenseBloc, TravelExpenseState>(
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

  Widget buildView(TravelExpenseState state){


     if(state.responseSum!=null && !loaded) {

      visitItems=state.responseSum!.data!.expenseVisitDetails ?? [];

      print("visitItems");
      print(state.responseSum!.data);
      print(visitItems);
     }


    // if(state.responseSum!=null && !loaded) {
    //   TESummaryResponse? response = state.responseSum;
    //   for(int i=0;i<summaryDetails.length;i++){
    //     Map map = summaryDetails[i].item1;
    //     if(summaryDetails[i].item1['key']=="AE"){
    //       summaryDetails[i]= Tuple2(map, response!.data![0].accommodationSelf.toString());
    //     }
    //     if(summaryDetails[i].item1['key']=="TE"){
    //       summaryDetails[i]= Tuple2(map,  response!.data![0].conveyanceSelf.toString());
    //     }
    //     if(summaryDetails[i].item1['key']=="ME"){
    //       summaryDetails[i]= Tuple2(map,  response!.data![0].miscellaneousSelf.toString());
    //     }
    //   }
    //   total = response!.data![0].totalExpense.toString();
    //
    //   for (var item in response.data![0].maGeConveyanceExpense!) {
    //     summaryItems.add(
    //         Tuple2(
    //             ExpenseModel(id: item.id,
    //                 type: GETypes.CONVEYANCE,
    //                 amount: item.amount.toString()),
    //             item.toJson()));
    //   }
    //   for (var item in response.data![0].maGeAccomodationExpense!) {
    //     summaryItems.add(
    //         Tuple2(
    //             ExpenseModel(id: item.id,
    //                 type: GETypes.ACCOMMODATION,
    //                 amount: item.amount.toString()),
    //             item.toJson()));
    //   }
    //   for (var item in response.data![0].maGeMiscellaneousExpense!) {
    //     summaryItems.add(
    //         Tuple2(
    //             ExpenseModel(id: item.id,
    //                 type: GETypes.MISCELLANEOUS,
    //                 amount: item.amount.toString()),
    //             item.toJson()));
    //   }
    //   loaded=true;
    // }


    return Container(
      color:Colors.white,
      child:SingleChildScrollView(
        child: Column(
          children: [
            if(widget.isEdit)
            buildExpandableView(jsonData,"requesterDetails"),
            buildExpandableView(jsonData,"visitItems"),
            buildExpandableView(jsonData,"summaryItems"),
            buildExpandableView(jsonData,"summaryDetails"),
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

            }
        )
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
        case "visitItems":
          return Container(
            alignment: Alignment.centerRight,
            child: MetaSwitch(mapData: map['showDetails'],
              value: showVisitDetails,
              onSwitchPressed: (value){

                setState(() {
                  showVisitDetails=value;
                });

              },),
          );
        case "summaryItems":
          return Container(
            alignment: Alignment.centerRight,
            child: MetaSwitch(mapData: map['showDetails'],
              value: showSummaryItems,
              onSwitchPressed: (value){

                setState(() {
                  showSummaryItems=value;
                });

              },),
          );
        case "summaryDetails":
          return Container(
            alignment: Alignment.centerRight,
            child: MetaSwitch(mapData: map['showDetails'],
              value: showSummaryDetails,
              onSwitchPressed: (value){

                setState(() {
                  showSummaryDetails=value;
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
        case "visitItems":
          return showVisitDetails ? buildVisitItemWidget(map):Container();
        case "summaryItems":
          return showSummaryItems ? buildSummaryItemWidget(map):Container();
        case "summaryDetails":
          return showSummaryDetails ? buildSummaryWidget(map):Container();
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

  Container buildSummaryWidget(Map map) {


    return Container(
            padding: EdgeInsets.symmetric(horizontal: 20.w,vertical: 10.h),
            color: Colors.white,
            child: Column(
              children: [
                Container(
                  child: Row(
                    children: [
                      Expanded(child: MetaTextView(mapData:   map['dataHeader']['label'])),
                      Expanded(child: MetaTextView(mapData:  map['dataHeader']['value']))
                    ],
                  ),
                ),
                Divider(color: Color(0xff3D3D3D),),
                Container(
                  color: Colors.white,
                  child: ListView.separated(
                    physics: NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    padding: EdgeInsets.zero,
                      itemBuilder: (BuildContext context, int index) {

                        return Container(
                          padding: EdgeInsets.symmetric(vertical: 5.h),
                          child: Row(
                            children: [
                              Expanded(child: MetaTextView(mapData: summaryDetails[index].item1['label'])),
                              Expanded(child: MetaTextView(mapData: summaryDetails[index].item1['value'],text:summaryDetails[index].item2))
                            ],
                          ),
                        );
                      },
                      separatorBuilder: (BuildContext context, int index) {
                      return Container();
                      },
                      itemCount: summaryDetails.length
                  ),
                ),
                Divider(color: Color(0xff3D3D3D),),
                Container(
                  child: Row(
                    children: [
                      Expanded(child: MetaTextView(mapData:  map['dataFooter']['label'])),
                      Expanded(child: MetaTextView(mapData:  map['dataFooter']['value'],text:total))
                    ],
                  ),
                ),
              ],
            ),
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
                        mapData: map['selectApprover1']
                    ),
                  ),
                ),
              ]),
          widget.isEdit?
          MetaTextFieldView(
             controller: TextEditingController(),
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

  Container buildVisitItemWidget(Map map) {
    print("buildVisitItemWidget");
    List items =[];
    items =  map['dataHeader'];
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20.w,vertical: 10.h),
      color: Colors.white,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Container(
              child: Row(
                children: items.map((e) {

                  if(e['flex']==0){
                    return Container(
                        width: 50.w,
                        margin: EdgeInsets.symmetric(horizontal: 0.w),
                        child: MetaTextView(mapData: e));
                  }

                  return Expanded(
                      flex: e['flex'],
                      child: Container(
                          margin: EdgeInsets.symmetric(horizontal: 0.w),
                          child: MetaTextView(mapData: e)));
                }).toList(),
              )
          ),
          Divider(color: Color(0xff3D3D3D),),
          ListView.builder(
              physics: NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              scrollDirection: Axis.vertical,
              padding: EdgeInsets.zero,
              itemBuilder: (BuildContext context, int i) {

                print("visitItems[i].toJson()");
                print(visitItems[i].toJson());
                return Container(
                  margin: EdgeInsets.symmetric(vertical: 2.h),
                  child: Row(
                      children: [
                        Expanded(flex:1, child: MetaTextView(mapData: map['listView']['item'],text: visitItems[i].city )),
                        Expanded(flex:1,child: MetaTextView(mapData: map['listView']['item'],text:visitItems[i].evdStartDate!+"\n-"+visitItems[i].evdStartTime! )),
                        Expanded(flex:1,child: MetaTextView(mapData: map['listView']['item'],text:visitItems[i].evdEndDate!+"\n-"+visitItems[i].evdEndTime! )),
                        Container(
                          width: 50.w,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              InkWell(
                                  onTap: (){
                                    // navigate({"onClick": type}, true,summaryItems[index].item2,index);
                                  },
                                  child: Container(
                                      width:20.w,
                                      height:20.w,
                                      child: MetaSVGView(mapData:  map['listView']['item']['items'][0]))),
                              SizedBox(width: 5.h,),

                              InkWell(onTap: (){
                                // print("removing index:"+index.toString() );
                                // setState(() {
                                //   summaryItems.removeAt(index);
                                //   calculateSummary();
                                // });

                              },
                                  child: Container(
                                      width:20.w,
                                      height:20.w,
                                      child: MetaSVGView(mapData:  map['listView']['item']['items'][1]))),
                            ],
                          ),
                        )
                      ]),
                );
              },
              itemCount: visitItems.length
          ),
          Container(
            margin: EdgeInsets.only(top: 5.h),
            width: 70.w,
            height: 20.h,
            alignment: Alignment.centerRight,
            child: MetaButton(mapData: map['addButton'],
                onButtonPressed: ()async{


                }
            ),
          )
        ],
      ),
    );
  }

  Container buildSummaryItemWidget(Map map) {
    List items =[];
    items =  map['dataHeader'];
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20.w,vertical: 10.h),
      color: Colors.white,
      child: Column(
        children: [
          Container(
            child: Row(
              children: items.map((e) {
                return Expanded(
                    flex: e['flex'],
                    child: Container(
                    margin: EdgeInsets.symmetric(horizontal: 0.w),
                    child: MetaTextView(mapData: e)));
              }).toList(),
            )
          ),
          Divider(color: Color(0xff3D3D3D),),
          Container(
            color: Colors.white,
            child: summaryItems.isNotEmpty ? ListView.builder(
                physics: NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                padding: EdgeInsets.zero,
                itemBuilder: (BuildContext context, int index) {

                  GETypes? type = summaryItems[index].item1.type;
                  String amount = summaryItems[index].item1.amount.toString();

                  return Container(
                    margin: EdgeInsets.symmetric(vertical: 2.h),
                    child: Row(
                      children: [
                        Expanded(flex:2, child: MetaTextView(mapData: map['listView']['item'],text: configureExpenseTypes(type) )),
                        Expanded(flex:1,child: MetaTextView(mapData: map['listView']['item'],text:amount)),
                        widget.isEdit?
                        Expanded(flex:1,child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            type != GETypes.CONVEYANCE?
                            InkWell(
                            onTap: (){
                                  navigate({"onClick": type}, true,summaryItems[index].item2,index);
                            },
                            child: Container(
                                width:25.w,
                                height:25.w,
                                child: MetaSVGView(mapData:  map['listView']['item']['items'][0]))):Container(
                              width:25.w,
                              height:25.w),
                            SizedBox(width: 10.h,),

                            InkWell(onTap: (){
                              print("removing index:"+index.toString() );
                              setState(() {
                                summaryItems.removeAt(index);
                                calculateSummary();
                              });

                            },
                            child: Container(
                                width:25.w,
                                height:25.w,
                                child: MetaSVGView(mapData:  map['listView']['item']['items'][1]))),
                          ],
                        )):
                        Expanded(flex:1,child: SizedBox())
                        ]),
                  );
                },
                itemCount: summaryItems.length
            ):Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                MetaTextView(mapData: map['listView']['emptyData']['title']),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void calculateSummary() {
    double miscTotal=0;
    double accomTotal=0;
    double travelTotal=0;
    double dailyTotal=0;
    for(var item in summaryItems){

      if(item.item1.type==GETypes.ACCOMMODATION){
        accomTotal=accomTotal + double.parse(item.item1.amount.toString() ?? "0");
      }

      if(item.item1.type==GETypes.CONVEYANCE){
        travelTotal=travelTotal + double.parse(item.item1.amount.toString() ?? "0");
      }

      if(item.item1.type==GETypes.MISCELLANEOUS){
        miscTotal=miscTotal + double.parse(item.item1.amount.toString() ?? "0");
      }


    }
    for(int i=0;i<summaryDetails.length;i++){
      Map map = summaryDetails[i].item1;

      if(summaryDetails[i].item1['key']=="AE"){
        summaryDetails[i]= Tuple2(map, accomTotal.toString());
      }

      if(summaryDetails[i].item1['key']=="TE"){
        summaryDetails[i]= Tuple2(map, travelTotal.toString());
      }

      if(summaryDetails[i].item1['key']=="ME"){
        summaryDetails[i]= Tuple2(map, miscTotal.toString());
      }


    }

    total =( miscTotal+accomTotal+travelTotal+dailyTotal).toString();
    List items1=[];
    List items2=[];
    List items3=[];
    for(var item in summaryItems){

      if(item.item1.type == GETypes.ACCOMMODATION){
        items1.add(item.item2);
      }

      if(item.item1.type == GETypes.CONVEYANCE){
        items2.add(item.item2);
      }

      if(item.item1.type == GETypes.MISCELLANEOUS){
        items3.add(item.item2);
      }


    }

    submitMap['maGeAccomodationExpense']=items1;
    submitMap['maGeConveyanceExpense']=items2;
    submitMap['maGeMiscellaneousExpense']= items3;



    submitMap['accommodationSelf']= accomTotal;
    submitMap['conveyanceSelf']= travelTotal;
    submitMap['miscellaneousSelf']= miscTotal;
    submitMap['totalExpense']= double.parse(total);


    setState(() {

    });


  }

  void navigate(e,bool isEdit,Map<String,dynamic> data,int index) {

    if(e['onClick'] == RouteConstants.createMiscExpensePath || e['onClick']  == GETypes.MISCELLANEOUS.toString()){
      print(GETypes.MISCELLANEOUS);
      print(data);
      GEMiscModel? model;
      if(data.isNotEmpty){
        model =  GEMiscModel.fromMap(data);
      }


      Navigator.of(context).push(MaterialPageRoute(builder: (context) =>
          CreateMiscExpense(
            isEdit:isEdit,
            miscModel:model,
            onAdd: (values){
              if(isEdit){
                summaryItems.removeAt(index);
              }
              summaryItems.add(Tuple2(values['item'] as ExpenseModel, values['data']));
              calculateSummary();
            },)));
    }

    if(e['onClick'] == RouteConstants.createAccommodationExpensePath  || e['onClick']  == GETypes.ACCOMMODATION.toString()){

      print(data);
      GEAccomModel? model;
      if(data.isNotEmpty){
        model =  GEAccomModel.fromMap(data);
      }

      Navigator.of(context).push(MaterialPageRoute(builder: (context) =>
          CreateAccommodationExpense(
            isEdit:isEdit,
            accomModel:model,
            onAdd: (values){
              if(isEdit){
                summaryItems.removeAt(index);
              }
              summaryItems.add(Tuple2(values['item'] as ExpenseModel, values['data']));
              calculateSummary();

          },)));
    }

    if(e['onClick'] == RouteConstants.createTravelExpensePath || e['onClick']  == GETypes.CONVEYANCE.toString()){


      print(data);
      GeConveyanceModel? model;
      if(data.isNotEmpty){
        model =  GeConveyanceModel.fromMap(data);
      }


      Navigator.of(context).push(MaterialPageRoute(builder: (context) =>
          CreateConveyanceExpense(
            isEdit:isEdit,
            conveyanceModel:model,
            onAdd: (values){
            if(isEdit){
              summaryItems.removeAt(index);
            }
            summaryItems.add(Tuple2(values['item'] as ExpenseModel, values['data']));
            calculateSummary();
          },)));
    }

  }

  void submitGe(text) async{
    submitMap['selfApprovals']= false;
    submitMap['violated']= false;

    final String requestBody = json.encoder.convert(submitMap);

    Map<String, dynamic> valueMap = json.decode(requestBody);

   Map<String,dynamic> queryParams = {
     //"approver1":"cm01",
     "approver1":approver1!.item2.toString().toLowerCase(),
     "approver2":approver2!.item2.toString().toLowerCase(),
     //"approver2":"cm02",
     "action":text,
     "comment":"daskdsakdkasdka",
   };

   prettyPrint(valueMap);

    SuccessModel model =   await Injector.resolve<TeUseCase>().createTe(queryParams,valueMap);

    if(model.status==true){
      Navigator.pop(context);
    }

  }

  String configureExpenseTypes(text){


    switch(text){
      case GETypes.ACCOMMODATION :
        return "Accommodation";
      case GETypes.CONVEYANCE :
        return "Travel";
      case GETypes.MISCELLANEOUS :
        return "Miscellaneous";
    }

    return "";
  }

}
