part of 'ge_bloc.dart';

@immutable
abstract class GeneralExpenseState {
  GEListResponse? response ;
  BlocEventState eventState;
  String message;
  GeneralExpenseState({this.response, this.message="", this.eventState=BlocEventState.LOADING});
}

class GeneralExpenseInitialState extends GeneralExpenseState {
  GeneralExpenseInitialState() : super(eventState: BlocEventState.LOADING);
}

class GeneralExpenseLoadedState extends GeneralExpenseState {
  final GEListResponse? data;
  GeneralExpenseLoadedState({required this.data}) : super(response: data, eventState: BlocEventState.LOADED);
}


class ErrorState extends GeneralExpenseState{
  String message;
  ErrorState({required this.message}) : super(eventState:  BlocEventState.ERROR,message: message);
}
