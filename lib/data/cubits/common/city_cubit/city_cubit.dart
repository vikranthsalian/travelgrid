import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:flutter/cupertino.dart';
import 'package:travelgrid/data/datasources/cities_list.dart';

part 'city_state.dart';

class CityCubit extends Cubit<CityState> {
  CityCubit() : super(CityIn(response: []));

  setCityResponse(List<Data> response) {
    if(state is CityIn) {
      emit(CityIn( response: response));
    }
  }
  List<Data> getCityResponse() {
    List<Data> response = [];
    if(state is CityIn) {
      final current = state as CityIn;
      return current.response;
    }
    return response;
  }

}
