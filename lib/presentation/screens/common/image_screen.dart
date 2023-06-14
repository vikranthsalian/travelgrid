import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:travelgrid/common/config/preferences_config.dart';
import 'package:travelgrid/common/constants/flavour_constants.dart';
import 'package:travelgrid/common/constants/preference_constants.dart';
import 'package:travelgrid/common/extensions/parse_data_type.dart';
import 'package:travelgrid/common/utils/image_utility.dart';
import 'package:travelgrid/common/utils/show_alert.dart';
import 'package:travelgrid/presentation/widgets/button.dart';


class ImageScreen extends StatelessWidget {
  XFile? file;
  String? image;
  ImageScreen({this.file,this.image});
  List list =[];

  Map<String,dynamic> jsonData = {};


  @override
  Widget build(BuildContext context) {
    jsonData = FlavourConstants.imageData;
    loadImageFromPreferences();

    return Scaffold(
      backgroundColor: Colors.white,
      //
      // floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      // floatingActionButton:  FloatingActionButton(
      //     child:MetaIcon(mapData:jsonData['bottomButtonFab'],onButtonPressed: ()async{
      //
      //     },),
      //     backgroundColor: ParseDataType().getHexToColor(jsonData['backgroundColor']),
      //     onPressed: () {}),
      bottomNavigationBar: BottomAppBar(
        color:ParseDataType().getHexToColor(jsonData['backgroundColor']),
        shape: CircularNotchedRectangle(),
        notchMargin: 5,
        elevation: 2.0,
        child: Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            MetaButton(mapData: jsonData['bottomButtonLeft'],
                onButtonPressed: () async {
                   Navigator.pop(context);
                }
            ),
            if(file!=null)
            MetaButton(mapData: jsonData['bottomButtonRight'],
                onButtonPressed: (){

                list.add(Utility.base64String(File(file!.path).readAsBytesSync()));

                  PreferenceConfig.setString(PreferenceConstants.image,jsonEncode(list));
                  MetaAlert.showSuccessAlert(message: "Image Added");

                Navigator.pop(context);
                }
            )
          ],
        ),
      ),
      body:file!=null ? Image.file(
          File(file!.path),
        width: MediaQuery.of(context).size.width,
        fit: BoxFit.cover,
      ):Container(
        child: Utility.imageFromBase64String(image!,context)
      )
    );
  }

  loadImageFromPreferences() async {

    var data = await  PreferenceConfig.getString(PreferenceConstants.image);
    if(data!=null && data.isNotEmpty) {
      list = jsonDecode(data.toString());
    }

  }



}
