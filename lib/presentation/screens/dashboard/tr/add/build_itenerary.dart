import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:travelgrid/common/extensions/parse_data_type.dart';
import 'package:travelgrid/common/utils/city_util.dart';
import 'package:travelgrid/data/models/tr/tr_city_pair_model.dart';
import 'package:travelgrid/presentation/screens/dashboard/tr/add/add_itinery.dart';
import 'package:travelgrid/presentation/screens/dashboard/tr/add/add_round_itinery.dart';
import 'package:travelgrid/presentation/widgets/svg_view.dart';
import 'package:travelgrid/presentation/widgets/switch.dart';
import 'package:travelgrid/presentation/widgets/text_view.dart';

class BuildItinerary extends StatefulWidget {
  Map<String,dynamic> map;
  List<TRCityPairModel> list;
  Function? onAdded;
  String? type;
  String? tripType;
  BuildItinerary({required this.map,this.list=const [],this.onAdded,this.type,this.tripType});

  @override
  _CreateBuildItineraryState createState() => _CreateBuildItineraryState();
}

class _CreateBuildItineraryState extends State<BuildItinerary> {
 bool showItems =true;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

  }


  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          buildHeaders(widget.map),
          getView(widget.map,widget.list)
        ],
      ),
    );
  }

  Container buildHeaders(Map<String,dynamic> map) {
    return Container(
      height: 40.h,
      color:ParseDataType().getHexToColor(map['backgroundColor']),
      child: Row(

        children: [
          Container(
              margin: EdgeInsets.symmetric(horizontal: 20.w),
              child: MetaTextView(mapData: map['label'])),
          Expanded(child: Container(
            alignment: Alignment.centerRight,
            child: MetaSwitch(mapData: map['showDetails'],
              value: showItems,
              onSwitchPressed: (value){

                setState(() {
                  showItems=value;
                });

              },),
          )) ,
          Container(
              margin: EdgeInsets.symmetric(horizontal: 20.w),
              child: InkWell(
                onTap: (){
                  print("===========> "+widget.type.toString());
                  print("===========> "+widget.list.length.toString());
                  if((widget.type=="O" || widget.type=="R") && widget.list.isNotEmpty){
                    print("=========Alraedy Added for oneway");
                    return ;
                  }

                  if( widget.type=="R"){

                    Navigator.of(context).push(MaterialPageRoute(builder: (context) =>
                        AddRoundItinerary(
                          tripType: widget.tripType,
                          jsonData: map,
                          isEdit:false,
                          onAdd: (TRCityPairModel data1,TRCityPairModel data2){
                            print("===========> "+widget.type.toString());
                            if(widget.type=="R"){
                              widget.onAdded!([data1,data2]);
                            }

                          },)));
                  }else{
                    Navigator.of(context).push(MaterialPageRoute(builder: (context) =>
                        AddItinerary(
                          tripType: widget.tripType,
                          jsonData: map,
                          isEdit:false,
                          onAdd: (TRCityPairModel data){
                            print("===========> "+widget.type.toString());
                            if(widget.type=="O"){
                              widget.onAdded!([data]);
                            }
                            if(widget.type=="M"){
                              widget.list.add(data);
                              widget.onAdded!(widget.list);
                            }


                          },)));
                  }



                },
                  child: MetaTextView(mapData: map['add'],text: "ADD",))),

        ],
      ),
    );
  }

  getView(map,list) {
    return  Container(
      padding: EdgeInsets.symmetric(horizontal: 5.w),
      color: Colors.white,
      child: list.isNotEmpty ? Column(
        children: [
          ListView.builder(
              physics: NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              padding: EdgeInsets.zero,
              itemBuilder: (BuildContext context, int index) {
                TRCityPairModel item = list[index];
                return oneWayView(item,map);
              },
              itemCount: list.length
          ),
        ],
      ):Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          MetaTextView(mapData: map['listView']['emptyData']['title']),
        ],
      ),
    );
  }

  oneWayView(item,map){
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
                    if(item.price!=null && item.price!=0)
                      Container(
                        child: MetaTextView(mapData:  map['cityPair']['price'],text: "#Price: "+item.price.toString()),
                        alignment: Alignment.centerRight,
                      ),
                    Container(
                      child: Row(

                        children: [
                          Container(child:
                          Expanded(child: MetaTextView(mapData:  map['cityPair']['date'],text:item.startDate.toString()))),
                          Expanded(child: Container(
                              child: MetaTextView(mapData:  map['cityPair']['time'],text: item.startTime.toString())
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
                              if(item.leavingFrom!=null)
                                MetaTextView(mapData:  map['cityPair']['code'],text: CityUtil.getCityNameFromID( item.leavingFrom)),
                              MetaTextView(mapData:  map['cityPair']['city'],text:CityUtil.getCityNameFromID( item.leavingFrom,isCode: true))
                            ],
                          ),
                          Expanded(child: Container()),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              if(item.goingTo!=null)
                                MetaTextView(mapData:  map['cityPair']['code'],text: CityUtil.getCityNameFromID( item.goingTo)),
                              MetaTextView(mapData:  map['cityPair']['city'],text: CityUtil.getCityNameFromID( item.leavingFrom,isCode: true))
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
                      Expanded(child: MetaTextView(mapData:  map['cityPair']['byComp'],text: item.byCompany == 41 ?"BY COMPANY":"")),
                      Expanded(child: MetaTextView(mapData:  map['cityPair']['fare'],
                          text: CityUtil.getFareValueFromID(item.fareClass,item.travelMode,isValue: false))),
                      SizedBox(width: 10.w,),
                      InkWell(
                        onTap: (){

                        },
                        child: Container(
                            height: 25.w,
                            width: 25.w,
                            child: MetaSVGView(mapData: map['cityPair']['edit'])
                        ),
                      )
                    ]
                ),
              ),
              SizedBox(height: 3.h,),
            ],
          ),
        )

    );
  }


}
