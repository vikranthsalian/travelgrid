import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:travelex/common/extensions/parse_data_type.dart';


class MetaIcon extends StatelessWidget {

  Function()? onButtonPressed;
  Map mapData;

  MetaIcon({super.key,
     this.onButtonPressed ,
    required this.mapData
  });


  @override
  Widget build(BuildContext context) {

    return IconButton(
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
  'error' : Icons.error,
  'camera' : Icons.camera,
  'select' : Icons.done_all,
  'close' : FontAwesomeIcons.xmark,
  'back' : FontAwesomeIcons.chevronLeft,
  'add' : FontAwesomeIcons.circlePlus,
  'home' : FontAwesomeIcons.house,
  'filter' : Icons.filter_list_outlined,
  'sort' : Icons.sort,
  'flight' : Icons.flight,
  'logout' : FontAwesomeIcons.powerOff

};