import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:travelgrid/common/constants/flavour_constants.dart';
import 'package:travelgrid/common/extensions/map_widgets.dart';
import 'package:travelgrid/common/extensions/parse_data_type.dart';
import 'package:travelgrid/common/extensions/pretty.dart';
import 'package:travelgrid/presentation/widgets/button.dart';
import 'package:travelgrid/presentation/widgets/image_view.dart';
import 'package:travelgrid/presentation/widgets/text_field.dart';
import 'package:travelgrid/presentation/widgets/text_view.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return _Login();
  }
}

class _Login extends StatefulWidget {


  @override
  State<StatefulWidget> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<_Login> {
  Map<String,dynamic>  loginData= {};
  List widgets=[];
  final _formKey = GlobalKey<FormState>();
  @override
  void initState() {

    super.initState();
    loginData = FlavourConstants.loginData;
    widgets =  loginData['widgets'];
    prettyPrint(loginData);
  }

  @override
  Widget build(BuildContext context) {

      return Scaffold(
        backgroundColor: ParseDataType().getHexToColor(loginData['backgroundColor']),
        bottomNavigationBar: MapWidget().getWidget(loginData['bottomButton']),
        body: Center(
          child: Container(
            margin: EdgeInsets.symmetric(horizontal: 20.w),
            child: ListView(
              shrinkWrap: true,
              padding: EdgeInsets.zero,
              children: widgets.map((data) =>  MapWidget().getWidget(
                                                    data,
                                                    formKey: _formKey,
                                                    onChanged:(){

                                                    })).toList(),
            ),
          ),
        ),
      );
  }




}