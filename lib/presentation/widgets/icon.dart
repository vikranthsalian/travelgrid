import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:travelgrid/common/extensions/parse_data_type.dart';


class MetaIcon extends StatelessWidget {

  Function()? onButtonPressed;
  Map mapData;

  MetaIcon({super.key,
     this.onButtonPressed ,
    required this.mapData
  });


  @override
  Widget build(BuildContext context) {

    print(mapData);
    return IconButton(
        color: Colors.redAccent,
        icon: FaIcon(
          iconMapping[mapData['icon']],
          color: ParseDataType().getHexToColor(mapData['color']),
          size: mapData['size'],
        ),
        onPressed: (){
          if(onButtonPressed!=null)
            onButtonPressed!();
        }
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
  'filter' : Icons.filter_list_outlined,

};