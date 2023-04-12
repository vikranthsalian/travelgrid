import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_form_bloc/flutter_form_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';
import 'package:travelgrid/common/config/navigator_key.dart';
import 'package:travelgrid/common/config/preferences_config.dart';
import 'package:travelgrid/common/constants/flavour_constants.dart';
import 'package:travelgrid/common/constants/preference_constants.dart';
import 'package:travelgrid/common/extensions/parse_data_type.dart';
import 'package:travelgrid/common/utils/image_utility.dart';
import 'package:travelgrid/common/utils/show_alert.dart';
import 'package:travelgrid/data/cubits/accom_type_cubit/accom_type_cubit.dart';
import 'package:travelgrid/data/datasources/others/accom_type_list.dart';
import 'package:travelgrid/presentation/widgets/button.dart';
import 'package:travelgrid/presentation/widgets/icon.dart';
import 'package:travelgrid/presentation/widgets/text_view.dart';


class ImageScreen extends StatelessWidget {
  XFile? file;
  Image? image;
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
      ):image
    );
  }

  loadImageFromPreferences() async {

    var data = await  PreferenceConfig.getString(PreferenceConstants.image);
    if(data!=null && data.isNotEmpty) {
      list = jsonDecode(data.toString());
      print("loadImageFromPreferences length: "+list.length.toString());
      print(list);
    }
  print("loadImageFromPreferences length: "+list.length.toString());
      // setState(() {
      //   imageFromPreferences = Utility.imageFromBase64String(img);
      // });

  }



}
