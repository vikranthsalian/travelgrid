import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:flutter/cupertino.dart';

import 'package:travelgrid/data/datsources/travel_mode_list.dart';

part 'travel_mode_state.dart';

class TravelModeCubit extends Cubit<TravelModeState> {
  TravelModeCubit() : super(TravelModeIn(response: []));

  setTravelModeResponse(List<Data> response) {
    if(state is TravelModeIn) {
      emit(TravelModeIn( response: response));
    }
  }
  List<Data> getTravelModeResponse() {
    List<Data> response = [];
    if(state is TravelModeIn) {
      final current = state as TravelModeIn;
      return current.response;
    }
    return response;
  }

}
