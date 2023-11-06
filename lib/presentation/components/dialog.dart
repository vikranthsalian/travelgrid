import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class MetaDialog extends StatelessWidget {
  final Widget child;
  MetaDialog({required this.child});

  @override
  Widget build(BuildContext context) {
    return Dialog(
        shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(10.r))),
        child: Container(
            padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 15.h),
            child: child
        )
    );
  }

}
