import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:travelgrid/common/constants/asset_constants.dart';
import 'package:travelgrid/common/constants/flavour_constants.dart';
import 'package:travelgrid/common/extensions/parse_data_type.dart';

class MetaSVGView extends StatelessWidget {
  Map mapData;
  MetaSVGView({super.key, required this.mapData});

  @override
  Widget build(BuildContext context) {
    return  Container(
        child: SvgPicture.asset(
          AssetConstants.assetsBaseURLSVG +"/"+ mapData['icon'],
          color:  ParseDataType().getHexToColor(mapData['color']))
    );
  }
}