import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:flutter/cupertino.dart';
import 'package:travelex/data/datasources/others/accom_type_list.dart';

part 'accom_type_state.dart';

class AccomTypeCubit extends Cubit<AccomTypeState> {
  AccomTypeCubit() : super(AccomTypeIn(response: []));

  setAccomTypeResponse(List<Data> response) {
    if(state is AccomTypeIn) {
      emit(AccomTypeIn( response: response));
    }
  }
  List<Data> getAccomTypeResponse() {
    List<Data> response = [];
    if(state is AccomTypeIn) {
      final current = state as AccomTypeIn;
      return current.response;
    }
    return response;
  }

}
