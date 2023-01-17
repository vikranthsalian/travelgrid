import 'package:chips_choice/chips_choice.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:travelgrid/common/constants/flavour_constants.dart';
import 'package:travelgrid/common/constants/route_constants.dart';
import 'package:travelgrid/common/extensions/parse_data_type.dart';
import 'package:travelgrid/common/extensions/pretty.dart';
import 'package:travelgrid/presentation/widgets/button.dart';
import 'package:travelgrid/presentation/widgets/icon.dart';
import 'package:travelgrid/presentation/widgets/text_view.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Map<String,dynamic> homeJsonData = {};
  List items=[];
  int _choiceIndex=0;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    homeJsonData = FlavourConstants.homeData;
    prettyPrint(homeJsonData);

    for(var badges in homeJsonData['badges']){
      items.add(badges);
    }


  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // extendBody for floating bar get better perfomance
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        leadingWidth: 50.w,
        backgroundColor: Colors.transparent,
        automaticallyImplyLeading:homeJsonData['app_bar']['leading'] !=null ? true: false,
        leading: MetaIcon(mapData:homeJsonData['app_bar']['leading'],onButtonPressed: (){

        }) ,
        title: Container(
          height: 25.h,
          child: MetaTextView(mapData: homeJsonData['app_bar']['title']),
        ),
        centerTitle: homeJsonData['app_bar']['isCenter'] ?? false,
        actions: [
          MetaIcon(mapData:homeJsonData['app_bar']['actions'][0],
              onButtonPressed: (){

          })
        ],
      ),
      body: Center(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            Container(
              margin: EdgeInsets.symmetric(vertical: 10.h,horizontal: 10.w),
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.all(Radius.circular(10.w))
              ),
              child:StaggeredGrid.count(
                crossAxisCount: 4,

                crossAxisSpacing: 5.w,

                mainAxisSpacing: 5.h,
                children: items.map((e) => StaggeredGridTile.count(
                  crossAxisCellCount: e['cross'],
                  mainAxisCellCount: e['main'],
                  child: InkWell(
                    onTap: (){

                    },
                    child: Container(
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                          colors: getColor(e['cardColor']),
                        ),
                        borderRadius: BorderRadius.circular(0),
                      ),
                      child:Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              MetaIcon(mapData: e['icon'],onButtonPressed: (){

                              }),
                              MetaTextView(mapData: e['count']),

                            ],
                          ),
                          MetaTextView(mapData:e['label']),
                        ],
                      ),
                    ),
                  ),
                )).toList(),
              ),
              // child: GridView.count(
              //     physics:  const NeverScrollableScrollPhysics(),
              //     crossAxisCount: 2,
              //     crossAxisSpacing: 10.w,
              //     childAspectRatio:3/2,
              //     shrinkWrap: true,
              //     mainAxisSpacing: 10.h,
              //     children: List.generate(items.length, (index) {
              //       return InkWell(
              //         onTap: (){
              //
              //         },
              //         child: Container(
              //           decoration: BoxDecoration(
              //               gradient: LinearGradient(
              //                 begin: Alignment.topLeft,
              //                 end: Alignment.bottomRight,
              //                 colors: getColor(items[index]['cardColor']),
              //               ),
              //             borderRadius: BorderRadius.circular(8),
              //           ),
              //           child:Column(
              //             mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              //             crossAxisAlignment: CrossAxisAlignment.start,
              //             children: [
              //               Row(
              //                 mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              //                 crossAxisAlignment: CrossAxisAlignment.start,
              //                 children: [
              //                   MetaIcon(mapData: items[index]['icon'],onButtonPressed: (){
              //
              //                   }),
              //                   MetaTextView(mapData: items[index]['count']),
              //
              //                 ],
              //               ),
              //               MetaTextView(mapData: items[index]['label']),
              //             ],
              //           ),
              //         ),
              //       );
              //     })
              // ),
            ),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 10.w),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Expanded(
                    child: MetaButton(mapData: homeJsonData['policiesButton'],
                        onButtonPressed: (){
                          Navigator.of(context).pushNamed(RouteConstants.dashboardPath);
                        }
                    ),
                  ),
                 SizedBox(width: 5.w,),
                  Expanded(
                    child: MetaButton(mapData: homeJsonData['walletButton'],
                        onButtonPressed: (){
                          Navigator.of(context).pushNamed(RouteConstants.dashboardPath);
                        }
                    ),
                  )
                ],
              ),
            )
            // Container(
            //   color: Colors.white,
            //   child: ListView(
            //     shrinkWrap: true,
            //     padding: EdgeInsets.zero,
            //     children: [
            //       Row(
            //         mainAxisAlignment: MainAxisAlignment.spaceAround,
            //           children: [
            //             MetaTextView(mapData: homeJsonData['upcoming_details']['title']),
            //             MetaTextView(mapData: homeJsonData['upcoming_details']['button']),
            //           ]
            //       ),
            //       _buildChoiceChips( homeJsonData['upcoming_details']['list_data']['chip_data']['chips'])
            //     ],
            //   ),
            // )


          ]
        ),
      ),
    //  bottomNavigationBar: _buildBottomNavigationBar(),
    );
  }

  List<Color> getColor(List items) {
    List<Color> colors=[];
    for(var color in items){
      colors.add(ParseDataType().getHexToColor(color));
    }
    return colors;
  }

  Widget _buildChoiceChips(items) {

    // int tag=4;
    //
    // return  ChipsChoice<int>.single(
    //   value: tag,
    //   onChanged: (val) => setState(() => tag = val),
    //   choiceItems: C2Choice.listFrom<int, String>(
    //     source: ["1","2","3","4"],
    //     value: (i, v) => i,
    //     label: (i, v) => v,
    //     tooltip: (i, v) => v,
    //   ),
    //   choiceCheckmark: false,
    //   choiceStyle: C2ChipStyle.filled(
    //     selectedStyle: const C2ChipStyle(
    //       checkmarkColor: Colors.blueAccent,
    //       borderRadius: BorderRadius.all(
    //         Radius.circular(25),
    //       ),
    //     ),
    //   ),
    // );
    //


    return Container(
      height: 20,
      alignment: Alignment.center,
      child: ListView.builder(
        itemCount: items.length,
        scrollDirection: Axis.horizontal,
        padding: EdgeInsets.zero,
        shrinkWrap: true,
        itemBuilder: (BuildContext context, int index) {
          return ChoiceChip(
            elevation: 0.0,

            label: MetaTextView(mapData:items[index]),
            selected: _choiceIndex == index,
            selectedColor: Colors.red,
            onSelected: (bool selected) {
              setState(() {
                _choiceIndex = selected ? index : 0;
              });
            },
            backgroundColor:ParseDataType().getHexToColor(items[index]['backgroundColor']),
            labelStyle:MetaStyle(mapData: items[index]).getStyle(),
          );
        },
      ),
    );
  }



}
