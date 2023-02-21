import 'package:flutter_form_bloc/flutter_form_bloc.dart';
import 'package:travelgrid/data/cubits/common/city_cubit/city_cubit.dart';
import 'package:travelgrid/data/datasources/cities_list.dart';

import '../config/navigator_key.dart';

class CityUtil{
  CityUtil._();


  static String? getNameFromID(id) {

   List<Data> list = appNavigatorKey.currentState!.context.read<CityCubit>().getCityResponse();

   Iterable<Data> data= list.where((item) => (item.id.toString() == id.toString()));
   return data.first.name;
  }
  
}