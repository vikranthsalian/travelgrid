import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:flutter/cupertino.dart';

import '../../datasources/fare_class_list.dart';


part 'fare_class_state.dart';

class FareClassCubit extends Cubit<FareClassState> {
  FareClassCubit() : super(FareClassIn(airResponse: [],railResponse: [],roadResponse: []));

  setAirFareClassResponse(List<Data> response) {
    if(state is FareClassIn) {
      emit(FareClassIn( airResponse: response));
    }
  }

  setRoadFareClassResponse(List<Data> response) {
    if(state is FareClassIn) {
      emit(FareClassIn( roadResponse: response));
    }
  }

  setRailFareClassResponse(List<Data> response) {
    if(state is FareClassIn) {
      emit(FareClassIn(railResponse: response));
    }
  }

  List<Data> getFareClassResponse(mode) {
    List<Data> response = [];
    if(state is FareClassIn) {
      final current = state as FareClassIn;

      if(mode=="A"){
        return current.airResponse!;
      }
      if(mode=="R"){
        return current.roadResponse!;
      }
      if(mode=="B"){
        return current.railResponse!;
      }

      return [];
    }
    return response;
  }

}
