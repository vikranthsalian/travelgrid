import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:flutter/cupertino.dart';
import 'package:tuple/tuple.dart';

import '../../datasources/list/approver_list.dart';

part 'approver_type_state.dart';

class ApproverTypeCubit extends Cubit<ApproverTypeState> {
  ApproverTypeCubit() : super(ApproverTypeIn(response: []));

  setApproverTypeResponse(List<Data> response) {
    if(state is ApproverTypeIn) {
      emit(ApproverTypeIn( response: response));
    }
  }
  List<Data> getApproverTypeResponse() {
    List<Data> response = [];
    if(state is ApproverTypeIn) {
      final current = state as ApproverTypeIn;
      return current.response;
    }
    return response;
  }

  Tuple2<Data,Data> getApprovers() {
    if(state is ApproverTypeIn) {
      final current = state as ApproverTypeIn;
      return Tuple2(current.response[0],current.response[1]);
    }
    return Tuple2(Data(),Data());
  }

}
