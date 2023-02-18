import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:flutter/cupertino.dart';

import '../../datasources/misc_type_list.dart';

part 'misc_type_state.dart';

class MiscTypeCubit extends Cubit<MiscTypeState> {
  MiscTypeCubit() : super(MiscTypeIn(response: []));

  setMiscTypeResponse(List<Data> response) {
    if(state is MiscTypeIn) {
      emit(MiscTypeIn( response: response));
    }
  }
  List<Data> getMiscTypeResponse() {
    List<Data> response = [];
    if(state is MiscTypeIn) {
      final current = state as MiscTypeIn;
      return current.response;
    }
    return response;
  }

}
