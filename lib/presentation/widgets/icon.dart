import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:travelgrid/common/extensions/parse_data_type.dart';
import 'package:travelgrid/presentation/widgets/text_view.dart';


class MetaIcon extends StatelessWidget {

  Function() onButtonPressed;
  Map mapData;

  MetaIcon({super.key,
    required this.onButtonPressed ,
    required this.mapData
  });


  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10.w),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15.w),
          color:ParseDataType().getHexToColor(mapData['backgroundColor'] ?? 'transparent') ,
        ),
        height:50.w,
        width:50.w,
        child: Align(
          alignment: Alignment.center,
          child: IconButton(
              icon: FaIcon(
                iconMapping[mapData['icon']],
                color: ParseDataType().getHexToColor(mapData['color']),
                size: mapData['size'],
              ),
              onPressed: (){

                if( mapData['onPress']){
                  onButtonPressed();
                }

              }
          ),
        ),
      ),
    );
  }

}
Map<String, IconData> iconMapping = {
  'search' : FontAwesomeIcons.magnifyingGlass,
  'search_close' : Icons.search_off,
  'close' : FontAwesomeIcons.xmark,
  'back' : FontAwesomeIcons.chevronLeft,
  'facebook' : FontAwesomeIcons.facebook,
  'add' : FontAwesomeIcons.circlePlus,
  'twitter' : FontAwesomeIcons.twitter,
  'home' : FontAwesomeIcons.house,
  'audiotrack' : Icons.audiotrack,

};