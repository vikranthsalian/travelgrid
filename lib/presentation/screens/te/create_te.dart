import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_form_bloc/flutter_form_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:travelgrid/common/constants/flavour_constants.dart';
import 'package:travelgrid/common/constants/route_constants.dart';
import 'package:travelgrid/common/enum/dropdown_types.dart';
import 'package:travelgrid/common/extensions/parse_data_type.dart';
import 'package:travelgrid/common/extensions/pretty.dart';
import 'package:travelgrid/common/injector/injector.dart';
import 'package:travelgrid/common/utils/city_util.dart';
import 'package:travelgrid/data/blocs/travel_expense/te_bloc.dart';
import 'package:travelgrid/data/cubits/approver_type_cubit/approver_type_cubit.dart';
import 'package:travelgrid/data/cubits/login_cubit/login_cubit.dart';
import 'package:travelgrid/data/datasources/approver_list.dart' as app;
import 'package:travelgrid/data/datasources/login_response.dart';
import 'package:travelgrid/data/datasources/te_summary_response.dart';
import 'package:travelgrid/data/models/expense_model.dart';
import 'package:travelgrid/data/models/success_model.dart';
import 'package:travelgrid/data/models/te/te_accom_model.dart';
import 'package:travelgrid/data/models/te/te_conveyance_model.dart';
import 'package:travelgrid/data/models/te/te_misc_model.dart';
import 'package:travelgrid/data/models/te/te_ticket_model.dart';
import 'package:travelgrid/domain/usecases/te_usecase.dart';
import 'package:travelgrid/presentation/components/bloc_map_event.dart';
import 'package:travelgrid/presentation/dialog_expense_picker.dart';
import 'package:travelgrid/presentation/screens/te/add/te_add_accom.dart';
import 'package:travelgrid/presentation/screens/te/add/te_add_conveyance.dart';
import 'package:travelgrid/presentation/screens/te/add/te_add_misc.dart';
import 'package:travelgrid/presentation/screens/te/add/add_visit.dart';
import 'package:travelgrid/presentation/screens/te/add/te_add_ticket.dart';
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
  List<Tuple3<Map,String,String>> summaryDetails=[];
  List<String> values=[];
  List<ExpenseVisitDetails> visitItems=[];

  bool showRequesterDetails=false;
  bool showVisitDetails=true;
  bool showSummaryItems=true;
  bool showSummaryDetails=false;
  bool showApproverDetails=false;

  Tuple2<String,String> total=Tuple2("0.00", "0.00");
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
      summaryDetails.add(Tuple3(item, "0","0"));
    }


      bloc = Injector.resolve<TravelExpenseBloc>()..add(GetTravelExpenseSummaryEvent(recordLocator: widget.title!));

  }


  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: Colors.white,
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton:  FloatingActionButton(
          child:MetaIcon(mapData:jsonData['bottomButtonFab'],onButtonPressed: ()async{

              await showDialog(
                  context: context,
                  builder: (_) => DialogExpensePicker(
                    mapData: expenseTypes,
                    onSelected: (e){
                      navigate(e,false,{},0);
                    },
                  ));

          },),
          backgroundColor: ParseDataType().getHexToColor(jsonData['backgroundColor']),
          onPressed: () {}),
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
            // widget.isEdit ?
            // Container(
            //   color: Colors.white,
            //   height:70.h,
            //   child: Container(
            //     margin: EdgeInsets.symmetric(horizontal: 10.w),
            //     child: Row(
            //       children: expenseTypes.map((e) {
            //
            //         return Container(
            //           margin: EdgeInsets.symmetric(horizontal: 5.w),
            //           width: 60.w,
            //           height: 60.w,
            //           child: InkWell(
            //               onTap: () async{
            //                 navigate(e,false,{},0);
            //               },
            //               child:Container(
            //                 height: 50.h,
            //                 decoration: BoxDecoration(
            //                   color: ParseDataType().getHexToColor(jsonData['backgroundColor']),
            //                   shape: BoxShape.circle,
            //                 ),
            //                 child: Stack(
            //                   alignment: Alignment.center,
            //                   children: [
            //                     Container(
            //                       width: 25.w,
            //                       height: 25.w,
            //                       child: SvgPicture.asset(
            //                         AssetConstants.assetsBaseURLSVG +"/"+  e['svgIcon']['icon'],//e['svgIcon']['color']
            //                         color: ParseDataType().getHexToColor(e['svgIcon']['color']),
            //                         width: 25.w,
            //                         height: 25.w,
            //                       ),
            //                     ),
            //                   ],
            //                 ),
            //               )
            //           ),
            //         );
            //       }).toList(),
            //     ),
            //   ),
            // ):SizedBox(),
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
       TESummaryResponse? response = state.responseSum;
      visitItems = response!.data!.expenseVisitDetails ?? [];

         for (var item in response.data!.conveyanceExpenses!) {
           summaryItems.add(
               Tuple2(
                   ExpenseModel(id: item.id,
                       teType: TETypes.CONVEYANCE,
                       amount: item.amount.toString()),
                   item.toJson()));
         }
         for (var item in response.data!.accommodationExpenses!) {
           summaryItems.add(
               Tuple2(
                   ExpenseModel(id: item.id,
                       teType: TETypes.ACCOMMODATION,
                       amount:(item.amount!+item.tax!).toString()),
                   item.toJson()));
         }
         for (var item in response.data!.miscellaneousExpenses!) {
           summaryItems.add(
               Tuple2(
                   ExpenseModel(id: item.id,
                       teType: TETypes.MISCELLANEOUS,
                       amount: item.amount.toString()),
                   item.toJson()));
         }

      for (var item in response.data!.ticketExpenses!) {
        summaryItems.add(
            Tuple2(
                ExpenseModel(id: item.id,
                    teType: TETypes.TICKET,
                    amount: item.amount.toString()),
                item.toJson()));
      }


        for(int i=0;i<summaryDetails.length;i++){
          Map map = summaryDetails[i].item1;
          if(summaryDetails[i].item1['key']=="BTE"){
            summaryDetails[i]= Tuple3(map,
                response.data!.maExpenseSummary!.bookedTicketCost.toString(),
                response.data!.maExpenseSummary!.bookedTicketCost.toString()
            );
          }
          if(summaryDetails[i].item1['key']=="CA"){
            summaryDetails[i]= Tuple3(map,
                response.data!.maExpenseSummary!.advanceByCard.toString(),
                response.data!.maExpenseSummary!.advanceByCash.toString(),
            );
          }
          if(summaryDetails[i].item1['key']=="TE"){
            summaryDetails[i]= Tuple3(map,
                response.data!.maExpenseSummary!.ticketByCompany.toString(),
                response.data!.maExpenseSummary!.ticketSelf.toString()
            );
          }
          if(summaryDetails[i].item1['key']=="AE"){
            summaryDetails[i]= Tuple3(map,
                response.data!.maExpenseSummary!.accommodationByCompany.toString(),
                response.data!.maExpenseSummary!.accommodationSelf.toString(),
            );
          }
          if(summaryDetails[i].item1['key']=="PE"){
            summaryDetails[i]= Tuple3(map,
                response.data!.maExpenseSummary!.dailyAllowanceByCompany.toString(),
                response.data!.maExpenseSummary!.dailyAllowanceByCompany.toString(),
            );
          }
          if(summaryDetails[i].item1['key']=="CE"){
            summaryDetails[i]= Tuple3(map,
                response.data!.maExpenseSummary!.conveyanceByCompany.toString(),
                response.data!.maExpenseSummary!.conveyanceSelf.toString()
            );
          }
          if(summaryDetails[i].item1['key']=="ME"){
            summaryDetails[i]= Tuple3(map,
                response.data!.maExpenseSummary!.miscellaneousByCompany.toString(),
                response.data!.maExpenseSummary!.miscellaneousSelf.toString()
            );
          }
        }
        total =Tuple2(
            response.data!.maExpenseSummary!.totalAmountByCompany.toString(),
            response.data!.maExpenseSummary!.totalAmountSelf.toString()
        );

      loaded=true;
     }


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
                      Expanded(child: MetaTextView(mapData:  map['dataHeader']['value'])),
                      Expanded(child: MetaTextView(mapData:  map['dataHeader']['value2'])),
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
                              Expanded(child: MetaTextView(mapData: summaryDetails[index].item1['value'],text:summaryDetails[index].item2)),
                              Expanded(child: MetaTextView(mapData: summaryDetails[index].item1['value2'],text:summaryDetails[index].item3)),
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
                      Expanded(child: MetaTextView(mapData:  map['dataFooter']['value'],text:total.item1)),
                      Expanded(child: MetaTextView(mapData:  map['dataFooter']['value2'],text:total.item2))
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
                        Expanded(flex:1, child: MetaTextView(mapData: map['listView']['item'],text: CityUtil.getCityNameFromID(visitItems[i].city) )),
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
                  Navigator.of(context).push(MaterialPageRoute(builder: (context) =>
                      AddVisitDetails(
                        isEdit:false,
                     //   conveyanceModel:model,
                        onAdd: (value){

                          setState(() {
                            visitItems.add(value);
                          });


                        },)));
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

                  TETypes? type = summaryItems[index].item1.teType;
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
                            type != TETypes.CONVEYANCE?
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

      if(item.item1.type==TETypes.ACCOMMODATION){
        accomTotal=accomTotal + double.parse(item.item1.amount.toString() ?? "0");
      }

      if(item.item1.type==TETypes.CONVEYANCE){
        travelTotal=travelTotal + double.parse(item.item1.amount.toString() ?? "0");
      }

      if(item.item1.type==TETypes.MISCELLANEOUS){
        miscTotal=miscTotal + double.parse(item.item1.amount.toString() ?? "0");
      }


    }
    for(int i=0;i<summaryDetails.length;i++){
      Map map = summaryDetails[i].item1;

      if(summaryDetails[i].item1['key']=="AE"){
        summaryDetails[i]= Tuple3(map, accomTotal.toString(),"");
      }

      if(summaryDetails[i].item1['key']=="TE"){
        summaryDetails[i]= Tuple3(map, travelTotal.toString(),"");
      }

      if(summaryDetails[i].item1['key']=="ME"){
        summaryDetails[i]= Tuple3(map, miscTotal.toString(),"");
      }


    }

    total = Tuple2("0.00",
        ( miscTotal+accomTotal+travelTotal+dailyTotal).toString());
    List items1=[];
    List items2=[];
    List items3=[];
    for(var item in summaryItems){

      if(item.item1.type == TETypes.ACCOMMODATION){
        items1.add(item.item2);
      }

      if(item.item1.type == TETypes.CONVEYANCE){
        items2.add(item.item2);
      }

      if(item.item1.type == TETypes.MISCELLANEOUS){
        items3.add(item.item2);
      }


    }

    submitMap['maGeAccomodationExpense']=items1;
    submitMap['maGeConveyanceExpense']=items2;
    submitMap['maGeMiscellaneousExpense']= items3;



    submitMap['accommodationSelf']= accomTotal;
    submitMap['conveyanceSelf']= travelTotal;
    submitMap['miscellaneousSelf']= miscTotal;
    submitMap['totalExpense']= double.parse(total.item1);


    setState(() {

    });


  }

  void navigate(e,bool isEdit,Map<String,dynamic> data,int index) {

    if(e['onClick'] == RouteConstants.createTeMiscExpensePath || e['onClick']  == TETypes.MISCELLANEOUS.toString()){
      print(TETypes.MISCELLANEOUS);
      print(data);
      TEMiscModel? model;
      if(data.isNotEmpty){
        model =  TEMiscModel.fromMap(data);
      }


      Navigator.of(context).push(MaterialPageRoute(builder: (context) =>
          AddTeMiscExpense(
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

    if(e['onClick'] == RouteConstants.createTeAccommodationExpensePath  || e['onClick']  == TETypes.ACCOMMODATION.toString()){

      print(data);
      TEAccomModel? model;
      if(data.isNotEmpty){
        model =  TEAccomModel.fromMap(data);
      }

      Navigator.of(context).push(MaterialPageRoute(builder: (context) =>
          AddTeAccommodationExpense(
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

    if(e['onClick'] == RouteConstants.createTeConveyanceExpensePath || e['onClick']  == TETypes.CONVEYANCE.toString()){


      print(data);
      TeConveyanceModel? model;
      if(data.isNotEmpty){
        model =  TeConveyanceModel.fromMap(data);
      }


      Navigator.of(context).push(MaterialPageRoute(builder: (context) =>
          AddTeConveyance(
            isEdit:isEdit,
            teConveyanceModel:model,
            onAdd: (values){
            if(isEdit){
              summaryItems.removeAt(index);
            }
            summaryItems.add(Tuple2(values['item'] as ExpenseModel, values['data']));
            calculateSummary();
          },)));
    }

    if(e['onClick'] == RouteConstants.createTeTicketExpensePath || e['onClick']  == TETypes.TICKET.toString()){


      print(data);
      TETicketModel? model;
      if(data.isNotEmpty){
        model =  TETicketModel.fromMap(data);
      }


      Navigator.of(context).push(MaterialPageRoute(builder: (context) =>
          AddTeTicketExpense(
            isEdit:isEdit,
            teTicketModel:model,
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
      case TETypes.ACCOMMODATION :
        return "Accommodation";
      case TETypes.CONVEYANCE :
        return "Conveyance";
      case TETypes.MISCELLANEOUS :
        return "Miscellaneous";
      case TETypes.TICKET :
        return "Ticket";
    }

    return "";
  }

}
