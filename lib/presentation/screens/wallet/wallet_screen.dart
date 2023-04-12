import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:image_picker/image_picker.dart';
import 'package:travelgrid/common/config/navigator_key.dart';
import 'package:travelgrid/common/config/preferences_config.dart';
import 'package:travelgrid/common/constants/asset_constants.dart';
import 'package:travelgrid/common/constants/flavour_constants.dart';
import 'package:travelgrid/common/constants/preference_constants.dart';
import 'package:travelgrid/common/constants/route_constants.dart';
import 'package:travelgrid/common/extensions/parse_data_type.dart';
import 'package:travelgrid/common/extensions/pretty.dart';
import 'package:travelgrid/common/utils/image_utility.dart';
import 'package:travelgrid/presentation/widgets/icon.dart';
import 'package:travelgrid/presentation/widgets/text_view.dart';


class WalletHome extends StatefulWidget {
  @override
  _WalletHomeState createState() => _WalletHomeState();
}

class _WalletHomeState extends State<WalletHome> {
  Map<String,dynamic> jsonData = {};
  List items=[];
  final ImagePicker _picker = ImagePicker();
  List<Image> imageList =[];
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    jsonData = FlavourConstants.walletData;
    items = jsonData['listView']['data'];
    loadImageFromPreferences();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        floatingActionButton:  FloatingActionButton(
            child:MetaIcon(mapData:jsonData['bottomButtonFab'],onButtonPressed: ()async{
              if(jsonData['bottomButtonFab']['onClick'].isNotEmpty){
                _onImageButtonPressed(ImageSource.camera);
              }
            },),
            backgroundColor: ParseDataType().getHexToColor(jsonData['backgroundColor']),
            onPressed: () {}),
        body: Column(
          children: [
            Container(
              color:ParseDataType().getHexToColor(jsonData['backgroundColor']),
              height: 120.h,
              child:  Column(
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
                  SizedBox(height:10.h),
                  Container(
                    margin: EdgeInsets.symmetric(horizontal: 20.w),
                    child:MetaTextView(mapData: jsonData['listView']['recordsFound'],text: imageList.length.toString() +" Records Found",),
                  ),
                  SizedBox(height:10.h),
                ],
              ),
            ),
            SizedBox(height:10.h),
            Expanded(child: getListView())
          ],
        )
    );
  }

  Widget getListView(){
    double cardHt=90.h;
    return GridView.builder(
      padding: EdgeInsets.zero,
      itemCount: imageList.length,
      shrinkWrap: true,
      gridDelegate: new SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount:2,mainAxisSpacing: 3.h),
      itemBuilder: (BuildContext context, int index) {

        return InkWell(
          onTap: () async{
            Navigator.of(appNavigatorKey.currentState!.context).pushNamed(jsonData['bottomButtonFab']["onSave"],arguments: {
              "image":imageList[index]
            }).then((value) {
            loadImageFromPreferences();
          });;

          },
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 10.w),
            child: Card(
              color: Color(0xFF2854A1),
              elevation: 5,
              child: Container(
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        height: cardHt * 0.1,
                      ),
                      Expanded(
                        child: Container(
                          child: imageList[index],
                          width: 150.w,
                          height: 50.w,
                        ),
                      ),
                      Container(
                        height: cardHt * 0.20,
                        child: MetaTextView( mapData:  {
                          "text" : "Tap to view",
                          "color" : "0xFFFFFFFF",
                          "size": "10",
                          "family": "bold",
                          "align": "center"
                        }),
                      ),
                    ]),
              ),
            ),
          ),
        );
      },
    );

  }

  Future<void> _onImageButtonPressed(ImageSource source) async {

              final XFile? pickedFile = await _picker.pickImage(
                source: source,
               // maxWidth: maxWidth,
               // maxHeight: maxHeight,
                //imageQuality: quality,
              );

              if(jsonData['bottomButtonFab']['onSave'].isNotEmpty && pickedFile!=null){

                Navigator.of(appNavigatorKey.currentState!.context).pushNamed(jsonData['bottomButtonFab']["onSave"],arguments: {
                  "file":pickedFile
                });
              }

  }

  loadImageFromPreferences() async {
    imageList.clear();
    List list=[];
    var data = await  PreferenceConfig.getString(PreferenceConstants.image);
    if(data!=null && data.isNotEmpty) {
      list = jsonDecode(data.toString());
    }
    for(var item in list){
      imageList.add(Utility.imageFromBase64String(item,context));
    }
    setState(() {

    });

  }

}
