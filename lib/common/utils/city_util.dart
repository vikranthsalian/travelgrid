import 'package:flutter_form_bloc/flutter_form_bloc.dart';
import 'package:travelgrid/data/cubits/common/city_cubit/city_cubit.dart';
import 'package:travelgrid/data/cubits/fare_class_cubit/fare_class_cubit.dart';
import 'package:travelgrid/data/datasources/cities_list.dart' as city;
import 'package:travelgrid/data/datasources/fare_class_list.dart' as fare;

import '../../data/datasources/fare_class_list.dart';
import '../config/navigator_key.dart';

class CityUtil{
  CityUtil._();


  static String? getCityNameFromID(id) {

    if(id.toString().isEmpty){
      return null;
    }

   List<city.Data> list = appNavigatorKey.currentState!.context.read<CityCubit>().getCityResponse();

   Iterable<city.Data> data= list.where((item) => (item.id.toString() == id.toString()));
   return data.first.name;
  }

  static String? getFareNameFromID(id,mode) {

    if(id.toString().isEmpty){
      return null;
    }

    List<fare.Data> list = appNavigatorKey.currentState!.context.read<FareClassCubit>().getFareClassResponse(mode);

    Iterable<fare.Data> data = list.where((item) => (item.value.toString() == id.toString()));
    return data.first.label;
  }

  static String? getTraveModeFromID(id) {

    if(id.toString().isEmpty){
      return null;
    }

    if(id=="A"){
      return "Air";
    }else if(id=="R"){
      return "Rail";
    }else if(id=="B"){
      return "Road";
    }

    return null;
  }
  
}