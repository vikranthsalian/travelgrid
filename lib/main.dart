import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_flavor/flutter_flavor.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:travelgrid/common/config/init.dart';
import 'package:travelgrid/common/config/preferences_config.dart';
import 'package:travelgrid/common/injector/injector_config.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await configureFlavour();
  runApp(MyApp());
}

 configureFlavour() async {
    await PreferenceConfig.init();
    InjectorConfig.setup();
    String flavourData = await rootBundle.loadString("assets/build-runner/flavour.json");
    Map<String, dynamic> flavourJson = await json.decode(flavourData.toString());
    FlavorConfig(variables: flavourJson);
}


class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      useInheritedMediaQuery: true,
      builder: (_, child) {
        return InitRoot();
      },
    );
  }
}
