import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_form_bloc/flutter_form_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:travelgrid/common/constants/flavour_constants.dart';
import 'package:travelgrid/common/constants/route_constants.dart';
import 'package:travelgrid/common/enum/dropdown_types.dart';
import 'package:travelgrid/common/extensions/capitalize.dart';
import 'package:travelgrid/common/extensions/parse_data_type.dart';
import 'package:travelgrid/common/extensions/pretty.dart';
import 'package:travelgrid/common/injector/injector.dart';
import 'package:travelgrid/common/utils/show_alert.dart';
import 'package:travelgrid/data/blocs/general_expense/ge_bloc.dart';
import 'package:travelgrid/data/cubits/approver_type_cubit/approver_type_cubit.dart';
import 'package:travelgrid/data/cubits/login_cubit/login_cubit.dart';
import 'package:travelgrid/data/datasources/list/approver_list.dart' as app;
import 'package:travelgrid/data/datasources/summary/ge_summary_response.dart';
import 'package:travelgrid/data/datasources/login_response.dart';
import 'package:travelgrid/data/models/expense_model.dart';
import 'package:travelgrid/data/models/ge/ge_accom_model.dart';
import 'package:travelgrid/data/models/ge/ge_conveyance_model.dart';
import 'package:travelgrid/data/models/ge/ge_misc_model.dart';
import 'package:travelgrid/data/models/success_model.dart';
import 'package:travelgrid/domain/usecases/ge_usecase.dart';
import 'package:travelgrid/presentation/components/bloc_map_event.dart';
import 'package:travelgrid/presentation/components/switch_component.dart';
import 'package:travelgrid/presentation/dialog_expense_picker.dart';
import 'package:travelgrid/presentation/screens/dashboard/ge/add/add_accom.dart';
import 'package:travelgrid/presentation/screens/dashboard/ge/add/add_misc.dart';
import 'package:travelgrid/presentation/screens/dashboard/ge/add/add_travel.dart';
import 'package:travelgrid/presentation/widgets/button.dart';
import 'package:travelgrid/presentation/widgets/dialog_selector_view.dart';
import 'package:travelgrid/presentation/widgets/icon.dart';
import 'package:travelgrid/presentation/widgets/svg_view.dart';
import 'package:travelgrid/presentation/widgets/text_field.dart';
import 'package:travelgrid/presentation/widgets/text_view.dart';
import 'package:tuple/tuple.dart';


TextEditingController controller =TextEditingController();

class CreateGeneralExpense extends StatelessWidget {
  bool isEdit;
  String? title;
  bool isApproval;
  CreateGeneralExpense({this.isEdit=true,this.title,this.isApproval=false});
  GeneralExpenseBloc?  bloc;
  Map? jsonData;
   Color customSurfaceWhite = Color(0xFF2854A1);
  Color primaryColor = Color(0XFF2854A1);

  @override
  Widget build(BuildContext context) {
    jsonData = FlavourConstants.geCreateData;


    if(title!=null) {
      bloc = Injector.resolve<GeneralExpenseBloc>()
        ..add(GetGeneralExpenseSummaryEvent(recordLocator: title!));
    }else{
      bloc = Injector.resolve<GeneralExpenseBloc>();
    }


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
                child:  BlocBuilder<GeneralExpenseBloc, GeneralExpenseState>(
                    bloc: bloc,
                    builder:(context, state) {
                      return Container(
                        color: Colors.white,
                          child: BlocMapToEvent(state: state.eventState, message: state.message,
                              callback: (){

                              },
                              child:CreateGeneralExpenseBody(state,isEdit,isApproval,title??"")
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
      children: <Widget>[
        Expanded(
          child: MetaButton(mapData: jsonData!['bottomButtonLeft'],text: "Reject",
              onButtonPressed: ()async{
                SuccessModel  model =  await Injector.resolve<GeUseCase>().rejectGE(title,controller.text);
                if(model.status==true){
                  Navigator.pop(ctx);
                }
              }
          ),
        ),
        Expanded(
          child: MetaButton(mapData: jsonData!['bottomButtonRight'],text: "Approve",
              onButtonPressed: ()async{
                SuccessModel  model =  await Injector.resolve<GeUseCase>().approveGE(title,controller.text);

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

class CreateGeneralExpenseBody extends StatefulWidget {
  GeneralExpenseState state;
  bool isEdit;
  bool isApproval;
  String title;
  CreateGeneralExpenseBody(this.state,this.isEdit,this.isApproval,this.title);

  @override
  _CreateGeneralExpenseState createState() => _CreateGeneralExpenseState();
}

class _CreateGeneralExpenseState extends State<CreateGeneralExpenseBody> {
  Map<String,dynamic> jsonData = {};
  Map<String,dynamic> submitMap = {};
  List details=[];
  List expenseTypes=[];
  List<Tuple2<ExpenseModel,Map<String,dynamic>>> summaryItems=[];
  List<Tuple2<Map,String>> summaryDetails=[];
  List<String> values=[];

  bool showRequesterDetails=false;
  bool showSummaryItems=true;
  bool showSummaryDetails=false;
  bool showApproverDetails=false;

  String total="0.00";
  MetaLoginResponse loginResponse = MetaLoginResponse();
  bool loaded=false;
  bool isCalculated=false;
  Tuple2<String,String>? approver1;
  Tuple2<String,String>? approver2;
  String description="";


  GeneralExpenseBloc?  bloc;
  @override
  void initState() {
    super.initState();
    jsonData = FlavourConstants.geCreateData;
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

  }


  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: Colors.transparent,
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
        child: !widget.isApproval ? (widget.isEdit ? buildSubmitRow():buildViewRow(widget.state)):null,
      ),
      body: buildView(widget.state),
    );
  }

  Widget buildView(GeneralExpenseState state){
    if(state.responseSum!=null && !loaded) {
      GESummaryResponse? response = state.responseSum;
      for(int i=0;i<summaryDetails.length;i++){
        Map map = summaryDetails[i].item1;
        if(summaryDetails[i].item1['key']=="AE"){
          summaryDetails[i]= Tuple2(map, response!.data![0].accommodationSelf.toString());
        }
        if(summaryDetails[i].item1['key']=="TE"){
          summaryDetails[i]= Tuple2(map,  response!.data![0].conveyanceSelf.toString());
        }
        if(summaryDetails[i].item1['key']=="ME"){
          summaryDetails[i]= Tuple2(map,  response!.data![0].miscellaneousSelf.toString());
        }
      }
      total = response!.data![0].totalExpense.toString();

      for (var item in response.data![0].maGeConveyanceExpense!) {
        summaryItems.add(
            Tuple2(
                ExpenseModel(id: item.id,
                    type: GETypes.CONVEYANCE,
                    amount: item.amount.toString()),
                item.toJson()));
      }
      for (var item in response.data![0].maGeAccomodationExpense!) {
        summaryItems.add(
            Tuple2(
                ExpenseModel(id: item.id,
                    type: GETypes.ACCOMMODATION,
                    amount: (item.amount!+item.tax!).toString()),
                item.toJson()));
      }
      print('response.data![0].maGeMiscellaneousExpense!');

      for (var item in response.data![0].maGeMiscellaneousExpense!) {
        print(item.toJson());
        summaryItems.add(
            Tuple2(
                ExpenseModel(id: item.id,
                    type: GETypes.MISCELLANEOUS,
                    amount: item.amount.toString()),
                item.toJson()));
      }

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
            SwitchComponent(
                color:ParseDataType().getHexToColor(jsonData['backgroundColor']),
                jsonData: jsonData['summaryItems'],
                childWidget: buildSummaryItemWidget(jsonData['summaryItems']),
                initialValue: showSummaryItems),
            SwitchComponent(
                color:ParseDataType().getHexToColor(jsonData['backgroundColor']),
                jsonData: jsonData['summaryDetails'],
                childWidget: buildSummaryWidget(jsonData['summaryDetails']),
                initialValue: showSummaryDetails),
            SwitchComponent(
                color:ParseDataType().getHexToColor(jsonData['backgroundColor']),
                jsonData: jsonData['approverDetails'],
                childWidget: buildApproverWidget(jsonData['approverDetails']),
                initialValue: showApproverDetails),
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
          MetaButton(mapData: jsonData['bottomButtonLeft'],text: "Cancel",
              onButtonPressed: (){
                  Navigator.pop(context);
              }
          ),
          MetaButton(mapData: jsonData['bottomButtonRight'],
              onButtonPressed: (){

                if(summaryItems.isNotEmpty && isCalculated){
                  submit();
                }else{
                  MetaAlert.showErrorAlert(
                      message: "Please add expenses"
                  );
                }
              }
          )
        ],
      );
  }

   buildViewRow(GeneralExpenseState state) {
    if(state.responseSum!=null) {
      String status = state.responseSum!.data![0].currentStatus!
          .toLowerCase();

      print(status);
      bool isTBVisible = false;

      if (status.toLowerCase() == "approver 1") {
        isTBVisible = true;
      }

      return Row(
        mainAxisSize: MainAxisSize.max,
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
            ) : SizedBox(width: 0),
        ],
      );
    }
    return Container();
  }

  Container buildSummaryWidget(Map map) {


    return Container(
            padding: EdgeInsets.symmetric(horizontal: 20.w,vertical: 10.h),
            margin: EdgeInsets.symmetric(horizontal:10.w,vertical: 10.h),
      color: Colors.white,
            // decoration: BoxDecoration(
            //     color: Colors.white,
            //     borderRadius: BorderRadius.all(Radius.circular(5.r)),
            //     border: Border.all(
            //       color: ParseDataType().getHexToColor(jsonData['backgroundColor']),
            //       width: 2.r,
            //     ),
            //
            // ),
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
                              Expanded(child: MetaTextView(mapData: summaryDetails[index].item1['value'],text:summaryDetails[index].item2.inRupeesFormat()))
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
                      Expanded(child: MetaTextView(mapData:  map['dataFooter']['value'],text:total.inRupeesFormat()))
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
              childAspectRatio: 5,
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
                        Expanded(flex:2, child: MetaTextView(mapData: map['listView']['item'],text: configureExpenseTypes(type))),
                        Expanded(flex:1,child: MetaTextView(mapData: map['listView']['item_amount'],text:amount.inRupeesFormat())),
                        widget.isEdit?
                        Expanded(flex:1,child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            type != GETypes.CONVEYANCE?
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
                        Expanded(flex:1,child:
                        type != GETypes.CONVEYANCE? InkWell(
                                onTap: (){
                              navigate({"onClick": type}, true,summaryItems[index].item2,index,true);
                            },
                            child: Container(
                                width:25.w,
                                height:25.w,
                                child: MetaSVGView(mapData:  map['listView']['item']['items'][2]))):SizedBox())
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

    isCalculated=true;
    double miscTotal=0;
    double accomTotal=0;
    double travelTotal=0;
    double dailyTotal=0;
    print("summaryItems.length");
    print(summaryItems.length);
    List items1=[];
    List items2=[];
    List items3=[];

    for(var item in summaryItems){

      if(item.item1.type==GETypes.ACCOMMODATION){
        accomTotal=accomTotal + double.parse(item.item1.amount.toString() );
        items1.add(item.item2);
      }

      if(item.item1.type==GETypes.CONVEYANCE){
        travelTotal=travelTotal + double.parse(item.item1.amount.toString());
        items2.add(item.item2);
      }

      if(item.item1.type==GETypes.MISCELLANEOUS){
        miscTotal=miscTotal + double.parse(item.item1.amount.toString());
        items3.add(item.item2);
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

  void navigate(e,bool isEdit,Map<String,dynamic> data,int index,isView) {
    print(e);
    print(GETypes.ACCOMMODATION.toString());

    if(e['onClick'].toString()  == RouteConstants.createMiscExpensePath || e['onClick'].toString()   == GETypes.MISCELLANEOUS.toString()){
      print(GETypes.MISCELLANEOUS);
      print(data);
      GEMiscModel? model;
      if(data.isNotEmpty){
        model =  GEMiscModel.fromMap(data);
      }


      Navigator.of(context).push(MaterialPageRoute(builder: (context) =>
          CreateMiscExpense(
            "D",
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

    if(e['onClick'].toString() == RouteConstants.createAccommodationExpensePath  || e['onClick'].toString()  == GETypes.ACCOMMODATION.toString()){
      print(GETypes.MISCELLANEOUS);
      print(data);
      GEAccomModel? model;
      if(data.isNotEmpty){
        model =  GEAccomModel.fromMap(data);
      }

      Navigator.of(context).push(MaterialPageRoute(builder: (context) =>
          CreateAccommodationExpense(
            "D",
            isEdit:isEdit,
            isView:isView,
            accomModel:model,
            onAdd: (values){
              if(isEdit){
                summaryItems.removeAt(index);
                print("removed");
              }
              setState(() {

              });

              summaryItems.add(Tuple2(values['item'] as ExpenseModel, values['data']));
              calculateSummary();

          },)));
    }

    if(e['onClick'].toString()  == RouteConstants.createTravelExpensePath || e['onClick'].toString()   == GETypes.CONVEYANCE.toString()){


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

  void submit() async{
    final String requestBody = json.encoder.convert(submitMap);

    Map<String, dynamic> valueMap = json.decode(requestBody);

   Map<String,dynamic> queryParams = {
     "approver1":approver1!.item2.toString().toLowerCase(),
     "approver2":approver2!.item2.toString().toLowerCase(),
     "comment":controller.text,
   //  if(widget.isEdit)
     //"tripId":widget.title,
   };

    if(widget.isEdit){
      queryParams['action']="submit";
    }else{
      queryParams['action']="submit";
    }

   prettyPrint(valueMap);

    SuccessModel model =   await Injector.resolve<GeUseCase>().createGE(queryParams,valueMap);

    if(model.status==true){
      Navigator.pop(context);
    }

  }

  void takeBack() async{

    Map<String,dynamic> queryParams = {
      "comment":controller.text,
      "tripId":widget.title,
    };
    SuccessModel model =   await Injector.resolve<GeUseCase>().takeBackGE(queryParams);

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
