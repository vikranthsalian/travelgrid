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
import 'package:travelgrid/data/datasources/list/approver_list.dart' as app;
import 'package:travelgrid/data/datasources/login_response.dart';
import 'package:travelgrid/data/datasources/summary/te_summary_response.dart';
import 'package:travelgrid/data/models/expense_model.dart';
import 'package:travelgrid/data/models/success_model.dart';
import 'package:travelgrid/data/models/te/te_accom_model.dart';
import 'package:travelgrid/data/models/te/te_conveyance_model.dart';
import 'package:travelgrid/data/models/te/te_misc_model.dart';
import 'package:travelgrid/data/models/te/te_ticket_model.dart';
import 'package:travelgrid/domain/usecases/te_usecase.dart';
import 'package:travelgrid/presentation/components/bloc_map_event.dart';
import 'package:travelgrid/presentation/components/switch_component.dart';
import 'package:travelgrid/presentation/dialog_expense_picker.dart';
import 'package:travelgrid/presentation/screens/dashboard/te/add/te_add_accom.dart';
import 'package:travelgrid/presentation/screens/dashboard/te/add/te_add_conveyance.dart';
import 'package:travelgrid/presentation/screens/dashboard/te/add/te_add_misc.dart';
import 'package:travelgrid/presentation/screens/dashboard/te/add/add_visit.dart';
import 'package:travelgrid/presentation/screens/dashboard/te/add/te_add_ticket.dart';
import 'package:travelgrid/presentation/widgets/button.dart';
import 'package:travelgrid/presentation/widgets/dialog_selector_view.dart';
import 'package:travelgrid/presentation/widgets/icon.dart';
import 'package:travelgrid/presentation/widgets/svg_view.dart';
import 'package:travelgrid/presentation/widgets/switch.dart';
import 'package:travelgrid/presentation/widgets/text_field.dart';
import 'package:travelgrid/presentation/widgets/text_view.dart';
import 'package:tuple/tuple.dart';



TextEditingController controller = TextEditingController();
class CreateTravelExpense extends StatelessWidget {
  bool isEdit;
  String? title;
  bool isApproval;
  CreateTravelExpense({this.isEdit=true,this.title,this.isApproval=false});
  TravelExpenseBloc?  bloc;
  Map? jsonData;
  @override
  Widget build(BuildContext context) {
    jsonData = FlavourConstants.teCreateData;

    bloc = Injector.resolve<TravelExpenseBloc>()
      ..add(GetTravelExpenseSummaryEvent(recordLocator: title!));

    return  Scaffold(
      backgroundColor: Colors.white,
      bottomNavigationBar: isApproval ? buildApprovalRow(title, context):SizedBox(),
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
                child:  BlocBuilder<TravelExpenseBloc, TravelExpenseState>(
                    bloc: bloc,
                    builder:(context, state) {
                      return Container(
                          color: Colors.white,
                          child: BlocMapToEvent(state: state.eventState, message: state.message,
                              callback: (){

                              },
                              child:CreateTravelExpenseBody(state,isEdit,isApproval,title!)
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


  Row buildApprovalRow(title,ctx) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Expanded(
          child: MetaButton(mapData: jsonData!['bottomButtonLeft'],text: "Reject",
              onButtonPressed: ()async{
                SuccessModel  model =  await Injector.resolve<TeUseCase>().rejectTE(title,controller.text);
                if(model.status==true){
                  Navigator.pop(ctx);
                }
              }
          ),
        ),
        Expanded(
          child: MetaButton(mapData: jsonData!['bottomButtonRight'],text: "Approve",
              onButtonPressed: ()async{
                SuccessModel  model =  await Injector.resolve<TeUseCase>().approveGE(title!,controller.text);

                if(model.status==true){
                  Navigator.pop(ctx);
                }
              }
          ),
        )
      ],
    );
  }

}

class CreateTravelExpenseBody extends StatefulWidget {
  TravelExpenseState state;
  bool isEdit;
  bool isApproval;
  String title;
  CreateTravelExpenseBody(this.state,this.isEdit,this.isApproval,this.title);

  @override
  _CreateTravelExpenseBodyState createState() => _CreateTravelExpenseBodyState();
}

class _CreateTravelExpenseBodyState extends State<CreateTravelExpenseBody> {
  Map<String,dynamic> jsonData = {};
  Map<String,dynamic> submitMap = {};
  List details=[];
  List expenseTypes=[];
  List<Tuple2<ExpenseModel,Map<String,dynamic>>> summaryItems=[];
  List<Tuple3<Map,String,String>> summaryDetails=[];
  List<String> values=[];
  List<ExpenseVisitDetails> visitItems=[];
  List<MaTravelExpenseComment> commentList=[];

  bool showRequesterDetails=false;
  bool showVisitDetails=true;
  bool showSummaryItems=true;
  bool showSummaryDetails=false;
  bool showApproverDetails=false;
  bool showCommentDetails=false;

  Tuple2<String,String> total=Tuple2("0.00", "0.00");
  MetaLoginResponse loginResponse = MetaLoginResponse();

  Tuple2<String,String>? approver1;
  Tuple2<String,String>? approver2;

  TravelExpenseBloc?  bloc;
  bool loaded =false;
  MaExpenseSummary summary = MaExpenseSummary();
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
      approver2 = Tuple2(approvers.item2.approverName.toString(), approvers.item2.approverCode.toString());



    }catch(ex){
      approver1 = Tuple2("DUMMY", "cm01");
      approver2 = Tuple2("DUMMY", "cm02");
    }


    for(var item in jsonData['summaryDetails']['data']){
      summaryDetails.add(Tuple3(item, "0","0"));
    }

  }


  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: Colors.white,
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton:  widget.isEdit ?  FloatingActionButton(
          child:MetaIcon(mapData:jsonData['bottomButtonFab'],onButtonPressed: ()async{

              await showDialog(
                  context: context,
                  builder: (_) => DialogExpensePicker(
                    mapData: expenseTypes,
                    onSelected: (e){
                      navigate(e,false,{},0,false);
                    },
                  ));

          },),
          backgroundColor: ParseDataType().getHexToColor(jsonData['backgroundColor']),
          onPressed: () {}):null,
      bottomNavigationBar: BottomAppBar(
        color:ParseDataType().getHexToColor(jsonData['backgroundColor']),
        shape: CircularNotchedRectangle(),
        notchMargin: 5,
        elevation: 2.0,
        child:!widget.isApproval ? ( widget.isEdit ? buildSubmitRow():buildViewRow(widget.state)):null,
      ),
      body: buildView(widget.state),
    );
  }


  Widget buildView(state){

     if(state.responseSum!=null && !loaded) {
       TESummaryResponse? response = state.responseSum!;

       submitMap['id']= response!.data!.id;
       submitMap['recordLocator']=  response.data!.recordLocator;
       submitMap['currentStatus']= response.data!.currentStatus;
       submitMap['startDate']= response.data!.startDate;;
       submitMap['startTime']= response.data!.startTime;;
       submitMap['endDate']= response.data!.endDate;;
       submitMap['endTime']= response.data!.endTime;;

      summary.bookedTicketCost = response.data!.maExpenseSummary?.bookedTicketCost ?? 0.00;
      summary.advanceByCard = response.data!.maExpenseSummary?.advanceByCard ?? 0.00;
      summary.advanceByCash =response.data!.maExpenseSummary?.advanceByCash ?? 0.00;
      summary.ticketByCompany =response.data!.maExpenseSummary?.ticketByCompany ?? 0.00;
      summary.accommodationByCompany =response.data!.maExpenseSummary?.accommodationByCompany ?? 0.00;
      summary.dailyAllowanceByCompany =response.data!.maExpenseSummary?.dailyAllowanceByCompany ?? 0.00;
      summary.conveyanceByCompany =response.data!.maExpenseSummary?.conveyanceByCompany ?? 0.00;
      summary.miscellaneousByCompany =response.data!.maExpenseSummary?.miscellaneousByCompany ?? 0.00;
      summary.totalAmountByCompany=response.data!.maExpenseSummary?.totalAmountByCompany ?? 0.00;
      summary.dueToCompany=response.data!.maExpenseSummary?.dueToCompany ?? 0.00;

       summary.ticketSelf =response.data!.maExpenseSummary?.ticketSelf ?? 0.00;
       summary.accommodationSelf =response.data!.maExpenseSummary?.accommodationSelf ?? 0.00;
       summary.miscellaneousSelf =response.data!.maExpenseSummary?.miscellaneousSelf ?? 0.00;
       summary.conveyanceSelf =response.data!.maExpenseSummary?.conveyanceSelf ?? 0.00;
       summary.totalAmountSelf=response.data!.maExpenseSummary?.totalAmountSelf ?? 0.00;
       summary.dueFromCompany=response.data!.maExpenseSummary?.dueFromCompany ?? 0.00;
       summary.totalExpense=response.data!.maExpenseSummary?.totalExpense ?? 0.00;


      getMiscModel(response.data!.miscellaneousExpenses!);

      getAccomModel(response.data!.accommodationExpenses!);

      getConvModel(response.data!.conveyanceExpenses!);

      getTicketModel(response.data!.ticketExpenses!);

      visitItems = response.data!.expenseVisitDetails ?? [];

      commentList= response.data!.matravelExpenseComment ?? [];

      getSummaryDetails();

      loaded=true;
     }


    return Container(
      color:Colors.white,
      child:SingleChildScrollView(
        child: Column(
          children: [
            if(widget.isEdit)
            SwitchComponent(
                color:ParseDataType().getHexToColor(jsonData['backgroundColor']),
                jsonData: jsonData['requesterDetails'],
                childWidget: buildRequesterWidget(jsonData['requesterDetails']),
                initialValue: showRequesterDetails),
           // buildExpandableView(jsonData,"requesterDetails"),
         //   buildExpandableView(jsonData,"visitItems"),
            SwitchComponent(
                color:ParseDataType().getHexToColor(jsonData['backgroundColor']),
                jsonData: jsonData['visitItems'],
                childWidget: buildVisitItemWidget(jsonData['visitItems']),
                initialValue: showVisitDetails),
         //   buildExpandableView(jsonData,"summaryItems"),
            SwitchComponent(
                color:ParseDataType().getHexToColor(jsonData['backgroundColor']),
                jsonData: jsonData['summaryItems'],
                childWidget: buildSummaryItemWidget(jsonData['summaryItems']),
                initialValue: showSummaryItems),
          //  buildExpandableView(jsonData,"summaryDetails"),
            SwitchComponent(
                color:ParseDataType().getHexToColor(jsonData['backgroundColor']),
                jsonData: jsonData['summaryDetails'],
                childWidget: buildSummaryWidget(jsonData['summaryDetails']),
                initialValue: showSummaryDetails),
            if(widget.isEdit)
              SwitchComponent(
                  color:ParseDataType().getHexToColor(jsonData['backgroundColor']),
                  jsonData: jsonData['approverDetails'],
                  childWidget: buildApproverWidget(jsonData['approverDetails']),
                  initialValue: showSummaryDetails),
           // buildExpandableView(jsonData,"approverDetails"):SizedBox(),
           // widget.status!.toLowerCase()!="create"  ?  buildExpandableView(jsonData,"commentDetails"):SizedBox(),
            SwitchComponent(
                color:ParseDataType().getHexToColor(jsonData['backgroundColor']),
                jsonData: jsonData['commentDetails'],
                childWidget: buildCommentWidget(jsonData['commentDetails']),
                initialValue: showCommentDetails)
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
          Visibility(
            visible: false,
            child: MetaButton(mapData: jsonData['bottomButtonLeft'],
                onButtonPressed: (){
                  submitGe("modify");
                }
            ),
          ),

          MetaButton(mapData: jsonData['bottomButtonRight'],
              onButtonPressed: (){
                submitGe("submit");
              }
          )
        ],
      );
  }

  buildViewRow(TravelExpenseState state) {
    if(state.responseSum!=null) {
      String status = state.responseSum!.data!.currentStatus!
          .toLowerCase();

      print(status);
      bool isTBVisible = false;

      if (status.toLowerCase() == "approver 1") {
        isTBVisible = true;
      }

      return Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          MetaButton(
                mapData: jsonData['bottomButtonLeft'], text: "Cancel",
                onButtonPressed: () {
                  Navigator.pop(context);
                }
            ),
          isTBVisible ?
         MetaButton(
                mapData: jsonData['bottomButtonRight'], text: "Take Back",
                onButtonPressed: () {
                  takeBack();
                }
            ): SizedBox(width: 0),
        ],
      );
    }
    return Container();
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
                              Expanded(child: MetaTextView(mapData: summaryDetails[index].item1['label'],textAlign: TextAlign.start,)),
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
             controller: controller,
              mapData: map['text_field_desc'],
              onChanged:(value){
                controller.text=value;
              }):SizedBox(),

        ],
      ),
    );
  }

  Container buildCommentWidget(Map map){
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20.w,vertical: 10.h),
      color: Colors.white,
      child:ListView.builder(
        padding: EdgeInsets.zero,
        itemCount: commentList.length,
        shrinkWrap: true,
        itemBuilder: (BuildContext context, int index) {
          return Container(
            child: Column(
                children: [
                  MetaTextView(mapData:map['name'],text: commentList[index].actionBy!+"("+commentList[index].actionFrom!+")"),
                  MetaTextView(mapData:map['date'],text: "Last 7 days"),
                  MetaTextView(mapData:map['message'],text: "Fill out the initial form. You can edit this later if needed. Click Save when done."),
                ]),
          );

        }
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
                        widget.isEdit? Container(
                          width: 56.w,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              InkWell(
                                  onTap: (){
                                     navigate({"onClick": "visit"}, true,visitItems[i].toMap(),i,false);
                                  },
                                  child: Container(
                                      width:25.w,
                                      height:25.w,
                                      child: MetaSVGView(mapData:  map['listView']['item']['items'][0]))),
                              SizedBox(width: 5.h,),

                              InkWell(onTap: (){
                                print("removing index:"+i.toString() );
                                setState(() {
                                  visitItems.removeAt(i);
                                  calculateSummary();
                                });

                              },
                                  child: Container(
                                      width:25.w,
                                      height:25.w,
                                      child: MetaSVGView(mapData:  map['listView']['item']['items'][1]))),
                            ],
                          ),
                        ):Container(width: 50.w)
                      ]),
                );
              },
              itemCount: visitItems.length
          ),
          widget.isEdit?
          Container(
            margin: EdgeInsets.only(top: 5.h),
            width: 70.w,
            height: 20.h,
            alignment: Alignment.centerRight,
            child: MetaButton(mapData: map['addButton'],
                onButtonPressed: ()async{
                  Navigator.of(context).push(MaterialPageRoute(builder: (context) =>
                      AddVisitDetails(
                        "D",
                        isEdit:false,
                        onAdd: (value){

                          setState(() {
                            visitItems.add(value);
                          });


                        },)));
                }
            ),
          ):SizedBox()
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
                                  navigate({"onClick": type}, true,summaryItems[index].item2,index,false);
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
                        Expanded(flex:1,child: InkWell(
                            onTap: (){
                              navigate({"onClick": type}, true,summaryItems[index].item2,index,true);
                            },
                            child: Container(
                                width:25.w,
                                height:25.w,
                                child: MetaSVGView(mapData:  map['listView']['item']['items'][2]))))
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
    double convTotal=0;
    double ticketTotal=0;

    for(var item in summaryItems){

      if(item.item1.teType==TETypes.ACCOMMODATION){
        accomTotal=accomTotal + double.parse(item.item1.amount.toString() );
      }

      if(item.item1.teType==TETypes.CONVEYANCE){
        convTotal=convTotal + double.parse(item.item1.amount.toString());
      }

      if(item.item1.teType==TETypes.MISCELLANEOUS){
        miscTotal=miscTotal + double.parse(item.item1.amount.toString());
      }

      if(item.item1.teType==TETypes.TICKET){
        ticketTotal=ticketTotal + double.parse(item.item1.amount.toString() );
      }

    }
    for(int i=0;i<summaryDetails.length;i++){
      Map map = summaryDetails[i].item1;
      String value1 = summaryDetails[i].item2;

      if(summaryDetails[i].item1['key']=="AE"){
        summaryDetails[i]= Tuple3(map, value1,accomTotal.toString());
      }

      if(summaryDetails[i].item1['key']=="CE"){
        summaryDetails[i]= Tuple3(map, value1,convTotal.toString());
      }

      if(summaryDetails[i].item1['key']=="ME"){
        summaryDetails[i]= Tuple3(map, value1,miscTotal.toString());
      }

      if(summaryDetails[i].item1['key']=="TE"){
        summaryDetails[i]= Tuple3(map, value1,ticketTotal.toString());
      }


    }

    String tot= total.item1;

    double allTotal = miscTotal+accomTotal+convTotal+ticketTotal;

    total = Tuple2(tot, allTotal.toString());
    List items1=[];
    List items2=[];
    List items3=[];
    List items4=[];
    for(var item in summaryItems){

      if(item.item1.teType == TETypes.ACCOMMODATION){
        items1.add(item.item2);
      }

      if(item.item1.teType == TETypes.CONVEYANCE){
        items2.add(item.item2);
      }

      if(item.item1.teType == TETypes.MISCELLANEOUS){
        items3.add(item.item2);
      }

      if(item.item1.teType == TETypes.TICKET){
        items4.add(item.item2);
      }

    }
    submitMap['expenseVisitDetails']=visitItems;


    submitMap['accommodationExpenses']= items1;
    submitMap['conveyanceExpenses']= items2;
    submitMap['miscellaneousExpenses']= items3;
    submitMap['ticketExpenses']=items4;

    submitMap['cashAdvances']= [];
    submitMap['dailyAllowances']= [];
    submitMap['matravelExpenseComment']= [];




    summary.ticketSelf =ticketTotal;
    summary.accommodationSelf =accomTotal;
    summary.miscellaneousSelf =miscTotal;
    summary.conveyanceSelf =convTotal;
    summary.totalAmountSelf=allTotal;
    summary.dueFromCompany=allTotal;
    summary.totalExpense=allTotal;
    submitMap['maExpenseSummary']= {};
    print("summary.toJson()");
    print(summary.toJson());



    setState(() {

    });


  }

  void navigate(e,bool isEdit,Map<String,dynamic> data,int index,isView) {
    print(e);

    if(e['onClick']  == "visit"){
      print(data);
      ExpenseVisitDetails? model;
      if(data.isNotEmpty){
        model =  ExpenseVisitDetails.fromMap(data);
      }


      Navigator.of(context).push(MaterialPageRoute(builder: (context) =>

          AddVisitDetails(
            "D",
            isEdit:true,
            expenseVisitDetails: model,
            onAdd: (value){
              if(isEdit){
                visitItems.removeAt(index);
              }
              visitItems.add(value);
              calculateSummary();
            },)

      ));
    }


    if(e['onClick'].toString()  == RouteConstants.createTeMiscExpensePath || e['onClick'].toString()  == TETypes.MISCELLANEOUS.toString()){
      print(TETypes.MISCELLANEOUS);
      print(data);
      TEMiscModel? model;
      if(data.isNotEmpty){
        model =  TEMiscModel.fromMap(data);
      }


      Navigator.of(context).push(MaterialPageRoute(builder: (context) =>
          AddTeMiscExpense(
            isEdit:isEdit,
            isView:isView,
            miscModel:model,
            onAdd: (values){
              if(isEdit){
                summaryItems.removeAt(index);
              }
              summaryItems.add(Tuple2(values['item'] as ExpenseModel, values['data']));
              calculateSummary();
            },)));
    }

    if(e['onClick'].toString()  == RouteConstants.createTeAccommodationExpensePath  || e['onClick'].toString()  == TETypes.ACCOMMODATION.toString()){

      print(data);
      TEAccomModel? model;
      if(data.isNotEmpty){
        model =  TEAccomModel.fromMap(data);
      }

      Navigator.of(context).push(MaterialPageRoute(builder: (context) =>
          AddTeAccommodationExpense(
            "D",
            isEdit:isEdit,
            isView:isView,
            accomModel:model,
            onAdd: (values){
              if(isEdit){
                summaryItems.removeAt(index);
              }
              summaryItems.add(Tuple2(values['item'] as ExpenseModel, values['data']));
              calculateSummary();

          },)));
    }

    if(e['onClick'].toString()  == RouteConstants.createTeConveyanceExpensePath || e['onClick'].toString()  == TETypes.CONVEYANCE.toString()){


      print(data);
      TeConveyanceModel? model;
      if(data.isNotEmpty){
        model =  TeConveyanceModel.fromMap(data);
      }


      Navigator.of(context).push(MaterialPageRoute(builder: (context) =>
          AddTeConveyance(
            isEdit:isEdit,
            isView:isView,
            teConveyanceModel:model,
            onAdd: (values){
            if(isEdit){
              summaryItems.removeAt(index);
            }
            summaryItems.add(Tuple2(values['item'] as ExpenseModel, values['data']));
            calculateSummary();
          },)));
    }

    if(e['onClick'].toString()  == RouteConstants.createTeTicketExpensePath || e['onClick'].toString()  == TETypes.TICKET.toString()){


      print(data);
      TETicketModel? model;
      if(data.isNotEmpty){
        model =  TETicketModel.fromMap(data);
      }


      Navigator.of(context).push(MaterialPageRoute(builder: (context) =>
          AddTeTicketExpense(
            "D",
            isEdit:isEdit,
            isView:isView,
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

    final String requestBody = json.encoder.convert(submitMap);

    Map<String, dynamic> valueMap = json.decode(requestBody);

   Map<String,dynamic> queryParams = {
     "approver1":approver1!.item2.toString().toLowerCase(),
     "approver2":approver2!.item2.toString().toLowerCase(),
     "action":text,
     "recordLocator":widget.title,
     "comment":controller.text,
   };

   prettyPrint("submitTe");
   prettyPrint(valueMap);

    SuccessModel model =   await Injector.resolve<TeUseCase>().createTe(queryParams,valueMap);

    if(model.status==true){
      Navigator.pop(context);
    }

  }

  void takeBack() async{

    Map<String,dynamic> queryParams = {
      "comment":"Take Back",
      "recordLocator":widget.title,
    };
    SuccessModel model =   await await Injector.resolve<TeUseCase>().takeBackTE(queryParams);

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

  getMiscModel(List<MiscellaneousExpense> miscellaneousExpenses) {

    List<TEMiscModel> list=[];

      for (var item in miscellaneousExpenses) {
        Map<String, dynamic> map = item.toMap();

          map['currency'] = "48";
          map['miscellaneousType'] =
              CityUtil.getMiscIDFromName(item.miscellaneousType);

        TEMiscModel model = TEMiscModel.fromMap(map);
        list.add(model);

    }


    for(int i=0;i<list.length;i++) {
      summaryItems.add(
          Tuple2(
              ExpenseModel(id: i+1,
                  teType: TETypes.MISCELLANEOUS,
                  amount: list[i].amount.toString()),
              list[i].toJson()));
    }


    submitMap['miscellaneousExpenses']= list;

  }

  getAccomModel(List<AccommodationExpense> dataList) {

    List<TEAccomModel> list=[];


      for (var item in dataList) {
        Map<String, dynamic> map = item.toMap();

          map['currency'] = "48";
          map['accomodationType'] =
              CityUtil.getAccomIDFromName(item.accomodationType);
          map['city'] = int.parse(item.city.toString());


        TEAccomModel model = TEAccomModel.fromMap(map);


        list.add(model);

    }

    for (int i=0;i<list.length;i++) {
      summaryItems.add(
          Tuple2(
              ExpenseModel(id: i+1,
                  teType: TETypes.ACCOMMODATION,
                  amount: list[i].amount.toString()),
              list[i].toJson()));
    }

    submitMap['accommodationExpenses']= list;

  }

  getConvModel(List<ConveyanceExpense> dataList) {

    List<TeConveyanceModel> list=[];

      for (var item in dataList) {
        Map<String, dynamic> map = item.toMap();
        map['currency'] = "48";
        map['travelMode'] = CityUtil.getModeIDFromName(item.travelMode);

        TeConveyanceModel model = TeConveyanceModel.fromMap(map);


        list.add(model);
      }


    for (int i=0;i<list.length;i++) {
      summaryItems.add(
          Tuple2(
              ExpenseModel(id: i+1,
                  teType: TETypes.CONVEYANCE,
                  amount: list[i].amount.toString()),
              list[i].toJson()));
    }


    submitMap['conveyanceExpenses']= list;



  }

  getTicketModel(List<TicketExpense> dataList) {

    List<TETicketModel> list=[];




      for(var item in dataList){
        Map<String,dynamic> map = item.toMap();
          map['currency'] = "48";
          String mode = "";
          if (item.travelMode == "Air") {
            mode = "A";
          }
          if (item.travelMode == "Rail") {
            mode = "R";
          }
          if (item.travelMode == "Road") {
            mode = "B";
          }
          map['travelMode'] = mode;
          map['fareClass'] =
              CityUtil.getFareValueFromName(item.fareClass, item.travelMode)
                  .toString();

        TETicketModel model = TETicketModel.fromMap(map);


        list.add(model);

    }






    for (int i=0;i<list.length;i++) {
      summaryItems.add(
          Tuple2(
              ExpenseModel(id: i+1,
                  teType: TETypes.TICKET,
                  amount: list[i].amount.toString()),
              list[i].toJson()));
    }

    submitMap['ticketExpenses']=list;


  }

  void getSummaryDetails() {

    for(int i=0;i<summaryDetails.length;i++){
      Map map = summaryDetails[i].item1;
      if(summaryDetails[i].item1['key']=="BTE"){
        summaryDetails[i]= Tuple3(map,
            summary.bookedTicketCost.toString(),
            summary.bookedTicketCost.toString()
        );
      }
      if(summaryDetails[i].item1['key']=="CA"){
        summaryDetails[i]= Tuple3(map,
          summary.advanceByCash.toString(),
          summary.advanceByCard.toString() ,
        );
      }
      if(summaryDetails[i].item1['key']=="TE"){
        summaryDetails[i]= Tuple3(map,
            summary.ticketByCompany.toString(),
            summary.ticketSelf.toString()
        );
      }
      if(summaryDetails[i].item1['key']=="AE"){
        summaryDetails[i]= Tuple3(map,
          summary.accommodationByCompany.toString() ,
          summary.accommodationSelf.toString(),
        );
      }
      if(summaryDetails[i].item1['key']=="PE"){
        summaryDetails[i]= Tuple3(map,
          summary.dailyAllowanceByCompany.toString(),
          summary.dailyAllowanceByCompany.toString(),
        );
      }
      if(summaryDetails[i].item1['key']=="CE"){
        summaryDetails[i]= Tuple3(map,
            summary.conveyanceByCompany.toString(),
            summary.conveyanceSelf.toString()
        );
      }
      if(summaryDetails[i].item1['key']=="ME"){
        summaryDetails[i]= Tuple3(map,
            summary.miscellaneousByCompany.toString() ,
            summary.miscellaneousSelf.toString()
        );
      }
    }
    total =Tuple2(
        summary.totalAmountByCompany.toString(),
        summary.totalAmountSelf.toString()
    );

  }

}
