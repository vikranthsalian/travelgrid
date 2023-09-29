import 'package:flutter/material.dart';
import 'package:flutter_form_bloc/flutter_form_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:travelex/common/config/navigator_key.dart';
import 'package:travelex/common/constants/flavour_constants.dart';
import 'package:travelex/common/extensions/parse_data_type.dart';
import 'package:travelex/data/blocs/cities/city_bloc.dart';
import 'package:travelex/data/cubits/common/city_cubit/city_cubit.dart';
import 'package:travelex/presentation/components/search_bar_component.dart';
import 'package:travelex/presentation/widgets/button.dart';
import 'package:travelex/presentation/widgets/icon.dart';
import 'package:travelex/presentation/widgets/svg_view.dart';
import 'package:travelex/presentation/widgets/text_view.dart';
import 'package:travelex/data/datasources/others/countries_list.dart';
class CountriesScreen extends StatefulWidget {
  Function(Data)? onTap;
  CountriesScreen({this.onTap});

  @override
  _CountriesScreenState createState() => _CountriesScreenState();
}

class _CountriesScreenState extends State<CountriesScreen> {
  Map<String,dynamic> jsonData = {};
  List<Data> dataList = [];
  bool enableSearch = false;
  final TextEditingController _searchController = TextEditingController();
  bool loaded=false;
  CityBloc? bloc;
  List<Data> list=[];
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    jsonData = FlavourConstants.countryData;

    list = appNavigatorKey.currentState!.context.read<CityCubit>().getCountryResponse();
    dataList =list;

  }


  @override
  Widget build(BuildContext context) {

    return Scaffold(
        backgroundColor: ParseDataType().getHexToColor(
            jsonData['backgroundColor']),
      body: Column(
        children: [
          SizedBox(height: 40.h),
          Container(
            height: 40.h,
            alignment: Alignment.center,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                MetaIcon(mapData: jsonData['backBar'],
                    onButtonPressed: () {
                      Navigator.pop(context);
                    }),
                Container(
                  child: MetaTextView(mapData: jsonData['title']),
                ),
              ],
            ),
          ),
          Container(
            margin: EdgeInsets.symmetric(horizontal: 20.w),
            padding: EdgeInsets.symmetric(vertical: 5.h),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8.r),
                color: Color(0xFFFFFFFF),
                border: Border.all(color: Colors.black12)),
            child: SearchBarComponent(
              barHeight: 40.h,
              hintText: "Search.....",
              searchController: _searchController,
              onClear: () {

              },
              onSubmitted: (text) {

              },
              onChange: (text) {
                search(text);
              },
            ),
          ),
          SizedBox(height: 10.h),
          Container(
            margin: EdgeInsets.symmetric(horizontal: 20.w),
            child: MetaTextView(mapData: jsonData['listView']['recordsFound'],
                text: list.length.toString() + " Records Found"),
          ),
          SizedBox(height: 10.h),
          Expanded(
            child: Container(
                color: Colors.white,
                child: getListView()),
          )
        ],
      )
    );
  }


  Widget getListView(){

    return  list.isNotEmpty ? ListView.separated(
      shrinkWrap: true,
      padding: EdgeInsets.zero,
      itemBuilder: (BuildContext context, int index) {

        Map city = {
          "text" :"",
          "color" : "0xFF000000",
          "size": "15",
          "family": "bold",
          "align" : "center-left"
        };

        return Container(
          padding: EdgeInsets.symmetric(horizontal: 20.w),
          child: ListTile(
            leading: Container(
                height: 30.w,
                width: 30.w,
                child: MetaSVGView(mapData:  jsonData['listView']['svgIcon'])
            ),
            title: Container(
                child: MetaTextView(mapData: city,
                    text:list[index].countryName.toString() +list[index].countryCode.toString() )
            ),
            trailing: const Icon(Icons.flight_outlined),
            onTap: () {
                widget.onTap!(list[index]);
            },
          ),
        );


      },
      separatorBuilder: (BuildContext context, int index) {
        return Divider(height: 3.h);
      },
      itemCount:list.length,
    ):  Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        MetaTextView(mapData: jsonData['listView']['emptyData']['title']),
        SizedBox(height: 10.h,),
        MetaButton(mapData: jsonData['listView']['emptyData']['bottomButtonRefresh'],
            onButtonPressed: (){

            })
      ],
    );
  }

  void search(String key) {
    List<Data> newList=[];
    for(var item in dataList){
      print(item.countryName!.toLowerCase());
      if (item.countryName!.toLowerCase().contains(key.toLowerCase())) {
        newList.add(item);
      }
    }
    setState(() {
      list=newList;
    });
  }

}
