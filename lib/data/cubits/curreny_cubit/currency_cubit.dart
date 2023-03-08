import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:flutter/cupertino.dart';
import 'package:travelgrid/data/datasources/currency_list.dart';

part 'currency_state.dart';

class CurrencyCubit extends Cubit<CurrencyState> {
  CurrencyCubit() : super(CurrencyIn(response: []));

  setCurrencyResponse(List<Data> response) {
    if(state is CurrencyIn) {
      emit(CurrencyIn( response: response));
    }
  }
  List<Data> getCurrencyResponse() {
    List<Data> response = [];
    if(state is CurrencyIn) {
      final current = state as CurrencyIn;
      return current.response;
    }
    return response;
  }

}
