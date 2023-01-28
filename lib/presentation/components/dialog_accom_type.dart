import 'package:flutter/material.dart';
import 'package:flutter_form_bloc/flutter_form_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:travelgrid/presentation/screens/common/accom_type_screen.dart';


class DialogAccomType extends StatelessWidget{
  Widget? child;
  DialogAccomType({this.child});
  @override
  Widget build(BuildContext context) {

    return Dialog(
      backgroundColor: Colors.transparent,
      child: Container(
        height: MediaQuery.of(context).size.height * 0.3,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(12.r),
          child: child,
        ),
      ),
    );
  }

}
