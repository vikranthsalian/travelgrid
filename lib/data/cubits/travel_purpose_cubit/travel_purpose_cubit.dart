import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:flutter/cupertino.dart';
import 'package:travelgrid/data/datasources/travel_purpose_list.dart';

part 'travel_purpose_state.dart';

class TravelPurposeCubit extends Cubit<TravelPurposeState> {
  TravelPurposeCubit() : super(TravelPurposeIn(response: []));

  setTravelPurposeResponse(List<Data> response) {
    if(state is TravelPurposeIn) {
      emit(TravelPurposeIn( response: response));
    }
  }
  List<Data> getTravelPurposeResponse() {
    List<Data> response = [];
    if(state is TravelPurposeIn) {
      final current = state as TravelPurposeIn;
      return current.response;
    }
    return response;
  }

}
