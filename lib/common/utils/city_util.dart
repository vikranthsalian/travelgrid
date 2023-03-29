import 'package:flutter_form_bloc/flutter_form_bloc.dart';
import 'package:travelgrid/data/cubits/accom_type_cubit/accom_type_cubit.dart';
import 'package:travelgrid/data/cubits/common/city_cubit/city_cubit.dart';
import 'package:travelgrid/data/cubits/curreny_cubit/currency_cubit.dart';
import 'package:travelgrid/data/cubits/fare_class_cubit/fare_class_cubit.dart';
import 'package:travelgrid/data/cubits/misc_type_cubit/misc_type_cubit.dart';
import 'package:travelgrid/data/cubits/travel_mode_cubit/travel_mode_cubit.dart';
import 'package:travelgrid/data/cubits/travel_purpose_cubit/travel_purpose_cubit.dart';
import 'package:travelgrid/data/datasources/others/cities_list.dart' as city;
import 'package:travelgrid/data/datasources/others/currency_list.dart' as currency;
import 'package:travelgrid/data/datasources/others/fare_class_list.dart' as fare;
import 'package:travelgrid/data/datasources/others/misc_type_list.dart' as misc;
import 'package:travelgrid/data/datasources/others/accom_type_list.dart' as accom;
import 'package:travelgrid/data/datasources/others/travel_mode_list.dart' as mode;
import 'package:travelgrid/data/datasources/others/currency_list.dart' as curr;
import 'package:travelgrid/data/datasources/others/travel_purpose_list.dart' as tp;

import '../config/navigator_key.dart';

class CityUtil{
  CityUtil._();


  static String? getCityNameFromID(id,{bool isCode=false}) {

    print("getCityNameFromID:==>");
    print(id);
    if(id.toString().isEmpty){
      return null;
    }

   List<city.Data> list = appNavigatorKey.currentState!.context.read<CityCubit>().getCityResponse();
   List<city.Data> list2 = appNavigatorKey.currentState!.context.read<CityCubit>().getCountryResponse();
   list=list+list2;

    if(isCode){
      Iterable<city.Data> data= list.where((item) => (item.id.toString() == id.toString()));
      return data.first.code;
    }else{
      Iterable<city.Data> data= list.where((item) => (item.id.toString() == id.toString()));
      if(data.isEmpty){
        return id;
      }
      return data.first.name;
    }


  }

  static String? getIDFromTravelPurpose(text) {

    print("getIDFromTravelPurpose:==>    "+text+">");

    List<tp.Data> list = appNavigatorKey.currentState!.context.read<TravelPurposeCubit>().getTravelPurposeResponse();
    Iterable<tp.Data> data= list.where((item) => (item.label.toString().trim() == text.toString().trim()));
    return data.first.id.toString();

  }

  static String? getCurrencyFromID(id) {

    print("getCityNameFromID:==>");
    print(id);
    if(id.toString().isEmpty){
      return null;
    }

    List<currency.Data> list = appNavigatorKey.currentState!.context.read<CurrencyCubit>().getCurrencyResponse();

      Iterable<currency.Data> data= list.where((item) => (item.id.toString() == id.toString()));
      return data.first.label;

    }


  static String? getFareValueFromID(id,mode,{bool isValue=true}) {
    print("getFareValueFromID:==>");
    print(id);
    print(mode);

    if(id.toString().isEmpty){
      return null;
    }
    print("isValue");
    print(isValue);

    List<fare.Data> list = appNavigatorKey.currentState!.context.read<FareClassCubit>().getFareClassResponse(mode);

    if(isValue){
      Iterable<fare.Data> data = list.where((item) => (item.value.toString() == id.toString()));
      if(data.isNotEmpty){
        return data.first.label;
      }
      return null;

    }else{
      Iterable<fare.Data> data = list.where((item) => (item.id.toString() == id.toString()));
      if(data.isNotEmpty){
        return data.first.label;
      }
      return null;
    }

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

  static String? getEntriesFromID(id) {

    if(id.toString().isEmpty){
      return null;
    }

    if(id=="139") {
      return "Single";
    }else{
      return "Multiple";
    }

  }

  static  getCurrenciesFromID(id,{isID=true}) {
    print("getCurrenciesFromID");
    if(id.toString().isEmpty){
      return null;
    }

    List<curr.Data> list = appNavigatorKey.currentState!.context.read<CurrencyCubit>().getCurrencyResponse();

    if(isID){

      Iterable<curr.Data> data= list.where((item) => (item.id.toString() == id.toString()));
      return data.first.label;
    }else{

      Iterable<curr.Data> data= list.where((item) => (item.label.toString() == id.toString()));
      print(data.first.id);
      return data.first.id;
    }


  }



  static int? getMiscIDFromName(name) {

    if(name.toString().isEmpty){
      return null;
    }

    List<misc.Data> list = appNavigatorKey.currentState!.context.read<MiscTypeCubit>().getMiscTypeResponse();

    Iterable<misc.Data> data= list.where((item) => (item.label.toString() == name.toString()));
    return data.first.id;
  }

  static int? getAccomIDFromName(name) {

    if(name.toString().isEmpty){
      return null;
    }

    List<accom.Data> list = appNavigatorKey.currentState!.context.read<AccomTypeCubit>().getAccomTypeResponse();

    Iterable<accom.Data> data= list.where((item) => (item.label.toString() == name.toString()));
    return data.first.id;
  }
  
  static int? getModeIDFromName(name) {

    if(name.toString().isEmpty){
      return null;
    }

    List<mode.Data> list = appNavigatorKey.currentState!.context.read<TravelModeCubit>().getTravelModeResponse();

    Iterable<mode.Data> data= list.where((item) => (item.label.toString() == name.toString()));
    return data.first.id;
  }

  static String? getFareValueFromName(name,mode) {

    if(mode=="Air"){
      mode="A";
    }
    if(mode=="Rail"){
      mode="R";
    }
    if(mode=="Road"){
      mode="B";
    }

    if(name.toString().isEmpty){
      return null;
    }

    List<fare.Data> list = appNavigatorKey.currentState!.context.read<FareClassCubit>().getFareClassResponse(mode);

    Iterable<fare.Data> data= list.where((item) => (item.label.toString() == name.toString()));
    return data.first.value;
  }

}