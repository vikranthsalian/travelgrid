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
import 'package:travelgrid/data/cubits/login_cubit/login_cubit.dart';
import 'package:travelgrid/data/datsources/login_response.dart';
import 'package:travelgrid/data/models/expense_model.dart';
import 'package:travelgrid/presentation/screens/auth/bloc/login_form_bloc.dart';
import 'package:travelgrid/presentation/screens/ge/add/add_misc.dart';
import 'package:travelgrid/presentation/widgets/button.dart';
import 'package:travelgrid/presentation/widgets/dialog_selector_view.dart';
import 'package:travelgrid/presentation/widgets/icon.dart';
import 'package:travelgrid/presentation/widgets/svg_view.dart';
import 'package:travelgrid/presentation/widgets/switch.dart';
import 'package:travelgrid/presentation/widgets/text_field.dart';
import 'package:travelgrid/presentation/widgets/text_view.dart';
import 'package:tuple/tuple.dart';

class CreateGeneralExpense extends StatefulWidget {
  @override
  _CreateGeneralExpenseState createState() => _CreateGeneralExpenseState();
}

class _CreateGeneralExpenseState extends State<CreateGeneralExpense> {
  Map<String,dynamic> jsonData = {};
  List details=[];
  List expenseTypes=[];
  List<Tuple2<ExpenseModel,Map>> summaryItems=[];
  List<Tuple2<Map,String>> summaryDetails=[];
  bool loaded=false;
  LoginFormBloc? formBloc;
  List<String> values=[];
  bool showRequesterDetails=false;
  bool showSummaryItems=true;
  bool showSummaryDetails=true;
  bool showApproverDetails=true;
  String total="0.00";
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    jsonData = FlavourConstants.geCreateData;
   // prettyPrint(jsonData);

     details = jsonData['requesterDetails']['data'];
     expenseTypes = jsonData['expensesTypes'];

    MetaLoginResponse loginResponse = context.read<LoginCubit>().getLoginResponse();
    values.add(loginResponse.data!.fullName ?? "");
    values.add(loginResponse.data!.grade!.organizationGradeName ?? "");
    values.add(loginResponse.data!.gender ?? "");
    values.add(loginResponse.data!.employeecode ?? "");
    values.add(loginResponse.data!.divName ?? "");
    values.add(loginResponse.data!.deptName ?? "");
    values.add(loginResponse.data!.costCenter!.costcenterName ?? "");
    values.add(loginResponse.data!.worklocation!.locationName ?? "");
    values.add(loginResponse.data!.currentContact!.mobile ?? "");
    values.add(loginResponse.data!.permanentContact?? "");


    for(var item in jsonData['summaryDetails']['data']){
      print(item);
      summaryDetails.add(Tuple2(item, "0"));
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
        child: Row(
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
                    child:MetaTextView(mapData: jsonData['title']),
                  ),
                ],
              ),
            ),
            Container(
              color: Colors.white,
              height:80,
              child: Container(
                margin: EdgeInsets.symmetric(horizontal: 10.w),
                child: Row(
                  children: expenseTypes.map((e) {

                    return Expanded(
                        child: InkWell(
                            onTap: () async{

                              if(e['onClick'] == RouteConstants.createMiscExpensePath){
                                Navigator.of(context).push(MaterialPageRoute(builder: (context) =>
                                    CreateMiscExpense(onAdd: (values){
                                  //    print("CreateMiscExpense 2");
                                   //   print(values['item']);


                                        summaryItems.add(Tuple2(values['item'] as ExpenseModel, values['data']));

                                        calculateSummary();




                                      //summaryDetails.add(values['items']);

                                },)));
                              }

                            },
                            child: Container(
                              height: 60.h,
                              decoration: BoxDecoration(
                                color: Colors.lightBlueAccent,
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
                                      // color: ParseDataType().getHexToColor(e['svgIcon']['color']),
                                      width: 25.w,
                                      height: 25.w,
                                    ),
                                  ),
                                ],
                              ),
                            )
                        ));
                  }).toList(),
                ),
              ),
            ),
            Expanded(
              child: Container(
                color:Colors.white,
                child:BlocProvider(
                  create: (context) => LoginFormBloc({}),
                  child: Builder(
                      builder: (context) {
                        formBloc =  BlocProvider.of<LoginFormBloc>(context);
                        return FormBlocListener<LoginFormBloc, String, String>(
                            onSubmissionFailed: (context, state) {

                            },
                            onSubmitting: (context, state) {
                              FocusScope.of(context).unfocus();
                            },
                            onSuccess: (context, state) {

                            },
                            onFailure: (context, state) {


                            },
                            child:  SingleChildScrollView(
                              child: Column(
                                children: [
                                  buildExpandableView(jsonData,"requesterDetails"),
                                  buildExpandableView(jsonData,"summaryItems"),
                                  buildExpandableView(jsonData,"summaryDetails"),
                                  buildExpandableView(jsonData,"approverDetails"),
                                ],
                              ),
                            )
                        );
                      }
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
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
        case "summaryItems":
          return showSummaryItems ? buildSummaryItemWidget(map):Container();
        case "summaryDetails":
          return showSummaryDetails ? buildSummaryWidget(map):Container();
        case "approverDetails":
          return showApproverDetails ? buildApproverWidget(map, formBloc):Container();
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


                        print("summaryDetails.data");
                        print(summaryDetails[index]);

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

  Container buildApproverWidget(Map map,bloc){
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20.w,vertical: 10.h),
      color: Colors.white,
      child: ScrollableFormBlocManager(
        formBloc: bloc,
        child: ListView(
        padding: EdgeInsets.zero,
        shrinkWrap: true,
        children:[
          Row(
              children: [
                Expanded(
                  child: Container(
                    child: MetaDialogSelectorView(mapData: map['selectApprover1']),
                    alignment: Alignment.centerLeft,
                  ),
                ),
                Expanded(
                  child: Container(
                    child: MetaDialogSelectorView(mapData: map['selectApprover1']),
                  ),
                ),
              ]),
          MetaTextFieldBlocView(mapData: map['text_field_desc'],
              textFieldBloc: bloc.tfUsername,
              onChanged:(value){
                bloc.tfUsername.updateValue(value);
              }),

        ],
      )),
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
            child: ListView.builder(
                physics: NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                padding: EdgeInsets.zero,
                itemBuilder: (BuildContext context, int index) {

                  String type = summaryItems[index].item1.type.toString();
                  String amount = summaryItems[index].item1.amount.toString();

                  return Container(
                    margin: EdgeInsets.symmetric(vertical: 2.h),
                    child: Row(
                      children: [
                        Expanded(flex:2, child: MetaTextView(mapData: map['item'],text: type)),
                        Expanded(flex:1,child: MetaTextView(mapData: map['item'],text:amount)),
                        Expanded(flex:1,child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            InkWell(onTap: (){

                            },
                            child: Container(
                                width:25.w,
                                height:25.w,
                                child: MetaSVGView(mapData:  map['item']['items'][0]))),
                            SizedBox(width: 10.h,),
                            InkWell(onTap: (){

                            },
                            child: Container(
                                width:25.w,
                                height:25.w,
                                child: MetaSVGView(mapData:  map['item']['items'][1]))),
                          ],
                        ))
                        ]),
                  );
                },
                itemCount: summaryItems.length
            ),
          ),
          Divider(color: Color(0xff3D3D3D),),
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
      if(item.item1.type==GETypes.MISCELLANEOUS){
        miscTotal=miscTotal + double.parse(item.item1.amount.toString() ?? "0");
      }
    }
    for(int i=0;i<summaryDetails.length;i++){
      Map map = summaryDetails[i].item1;

      if(summaryDetails[i].item1['key']=="ME"){
        summaryDetails[i]= Tuple2(map, miscTotal.toString());
      }
    }

    total =( miscTotal+accomTotal+travelTotal+dailyTotal).toString();

    setState(() {

    });


  }

}
