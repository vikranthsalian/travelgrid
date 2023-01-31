import 'package:flutter/material.dart';
import 'package:flutter_form_bloc/flutter_form_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:travelgrid/presentation/screens/common/accom_type_screen.dart';


class DialogType extends StatelessWidget{
  Widget? child;
  double? size;
  DialogType({this.child,this.size=0.3});
  @override
  Widget build(BuildContext context) {

    return Dialog(
      backgroundColor: Colors.transparent,
      child: Container(
        height: MediaQuery.of(context).size.height * size!,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(12.r),
          child: child,
        ),
      ),
    );
  }

}
