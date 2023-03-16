import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:flutter/cupertino.dart';

import '../../datasources/others/fare_class_list.dart';


part 'fare_class_state.dart';

class FareClassCubit extends Cubit<FareClassState> {
  FareClassCubit() : super(FareClassIn(airResponse: [],railResponse: [],roadResponse: []));
  List<Data> air=[];
  List<Data> road=[];
  List<Data> rail=[];

  setAirFareClassResponse(List<Data> response) {
    if(state is FareClassIn) {
      air=response;
      emit(FareClassIn( airResponse: response));
    }
  }

  setRoadFareClassResponse(List<Data> response) {

    if(state is FareClassIn) {
      road=response;
      emit(FareClassIn( roadResponse: response));
    }
  }

  setRailFareClassResponse(List<Data> response) {
    if(state is FareClassIn) {
      rail=response;
      emit(FareClassIn(railResponse: response));
    }
  }

  List<Data> getFareClassResponse(mode) {
    List<Data> response = [];
    if(state is FareClassIn) {
      final current = state as FareClassIn;

      if(mode=="A"){
        return air;
      }
      if(mode=="R"){
        return rail;
      }
      if(mode=="B"){
        return road;
      }

      return [];
    }
    return response;
  }

}
