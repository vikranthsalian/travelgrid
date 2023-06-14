import 'package:flutter/material.dart';
import 'package:travelgrid/common/constants/flavour_constants.dart';
import 'package:travelgrid/common/extensions/parse_data_type.dart';

class MetaImageView extends StatelessWidget {
  Map mapData;
  MetaImageView({super.key, required this.mapData});

  @override
  Widget build(BuildContext context) {
    return  Container(
        alignment: ParseDataType().getAlign(mapData['align'] ?? ""),
        child: Image.asset(
          FlavourConstants.path +"images/"+ mapData['image'],
          width: mapData['wd'],
          height: mapData['ht'],
        )
    );
  }

}

class MetaBaseImageView extends StatelessWidget {
  Map mapData;
  MetaBaseImageView({super.key, required this.mapData});

  @override
  Widget build(BuildContext context) {
    return  Container(
        alignment: ParseDataType().getAlign(mapData['align'] ?? ""),
        child: Image.asset(
          "assets/build-runner/images/"+ mapData['image'],
          width: mapData['wd'],
          height: mapData['ht'],
          fit: BoxFit.fitHeight,)
    );
  }

}