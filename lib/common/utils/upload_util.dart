
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter_form_bloc/flutter_form_bloc.dart';
import 'package:travelex/common/injector/injector.dart';
import 'package:travelex/data/models/success_model.dart';
import 'package:travelex/domain/usecases/common_usecase.dart';

class MetaUpload{


    Future<SuccessModel> uploadImage(File file,type) async{
      String fileName = file.path.split('/').last;
      String  dateText = DateFormat('ddMMyyyyhhss').format(DateTime.now());
      FormData formData = FormData.fromMap({
        "file": await MultipartFile.fromFile(file.path, filename:dateText+"_"+fileName),
      });
      SuccessModel model =  await Injector.resolve<CommonUseCase>().uploadFile(formData,type);
      return model;

    }
}