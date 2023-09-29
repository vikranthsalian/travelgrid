import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:travelex/common/constants/asset_constants.dart';
import 'package:travelex/common/extensions/parse_data_type.dart';

class MetaSVGView extends StatelessWidget {
  Map mapData;
  MetaSVGView({super.key, required this.mapData});

  @override
  Widget build(BuildContext context) {
    return  Container(
        child: SvgPicture.asset(
          AssetConstants.assetsBaseURLSVG +"/"+ mapData['icon'],
        color:mapData['color']!=null ?  ParseDataType().getHexToColor(mapData['color']):null
           )
    );
  }
}