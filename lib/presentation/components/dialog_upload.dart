import 'package:flutter/material.dart';
import 'package:flutter_form_bloc/flutter_form_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:travelgrid/presentation/screens/common/accom_type_screen.dart';
import 'package:travelgrid/presentation/screens/common/file_upload_screen.dart';


class DialogUpload extends StatelessWidget{
  @override
  Widget build(BuildContext context) {

    return Dialog(
      backgroundColor: Colors.transparent,
      child: Container(
        height: MediaQuery.of(context).size.height * 0.25,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(12.r),
          child: FileUploadScreen(),
        ),
      ),
    );
  }

}
