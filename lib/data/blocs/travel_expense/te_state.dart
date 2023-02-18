part of 'te_bloc.dart';

@immutable
abstract class TravelExpenseState {
  TEListResponse? response ;
  TESummaryResponse? responseSum ;
  BlocEventState eventState;
  String message;
  TravelExpenseState({this.response,this.responseSum, this.message="", this.eventState=BlocEventState.LOADING});
}

class TravelExpenseInitialState extends TravelExpenseState {
  TravelExpenseInitialState() : super(eventState: BlocEventState.LOADING);
}

class TravelExpenseLoadedState extends TravelExpenseState {
  final TEListResponse? data;
  TravelExpenseLoadedState({required this.data}) : super(response: data, eventState: BlocEventState.LOADED);
}

class TravelExpenseSummaryLoadedState extends TravelExpenseState {
  final TESummaryResponse? data;
  TravelExpenseSummaryLoadedState({required this.data}) : super(responseSum: data, eventState: BlocEventState.LOADED);
}


class ErrorState extends TravelExpenseState{
  String message;
  ErrorState({required this.message}) : super(eventState:  BlocEventState.ERROR,message: message);
}
