import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:flutter/cupertino.dart';
import 'package:travelex/data/datasources/others/cities_list.dart';
import 'package:travelex/data/datasources/others/countries_list.dart' as cn;

part 'city_state.dart';

class CityCubit extends Cubit<CityState> {
  CityCubit() : super(CityIn(response: [],responseCountry: []));
  List<Data> city=[];
  List<Data> countryCities=[];
  List<cn.Data> countries=[];
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


  setOverSeasCitiesResponse(List<Data> response) {
    print("setCountryResponse");
    if(state is CityIn) {
      countryCities = response;
      emit(CityIn( responseCountry: response));
    }
  }
  List<Data> getOverSeasCitiesResponse() {
    List<Data> response = [];
    if(state is CityIn) {
      final current = state as CityIn;
      return countryCities;
    }
    return response;
  }


  setCountryResponse(List<cn.Data> response) {
    if(state is CityIn) {
      countries = response;
      emit(CityIn( countryList: response));
    }
  }
  List<cn.Data> getCountryResponse() {
    List<cn.Data> response = [];
    if(state is CityIn) {
      final current = state as CityIn;

      return countries;
    }
    return response;
  }
}
