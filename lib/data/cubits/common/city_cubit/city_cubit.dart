import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:flutter/cupertino.dart';
import 'package:travelgrid/data/datasources/cities_list.dart';

part 'city_state.dart';

class CityCubit extends Cubit<CityState> {
  CityCubit() : super(CityIn(response: []));
  List<Data> city=[];
  List<Data> country=[];
  setCityResponse(List<Data> response) {
    if(state is CityIn) {
      city = response;
      emit(CityIn( response: response));
    }
  }
  List<Data> getCityResponse() {
    List<Data> response = [];
    if(state is CityIn) {
      final current = state as CityIn;

      return city;
    }
    return response;
  }


  setCountryResponse(List<Data> response) {

    if(state is CityIn) {
      print("country.length");
      print(country.length);
      country = response;
      emit(CityIn( responseCountry: response));
    }
  }
  List<Data> getCountryResponse() {
    List<Data> response = [];
    if(state is CityIn) {
      final current = state as CityIn;
      return city+country;
    }
    return response;
  }

}
