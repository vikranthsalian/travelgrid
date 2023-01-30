part of 'misc_type_bloc.dart';


@immutable
abstract class MiscTypeState {
  MetaMiscTypeListResponse? response ;
  BlocEventState eventState;
  String message;
  MiscTypeState({this.response, this.message="", this.eventState=BlocEventState.LOADING});
}

class MiscTypeInitialState extends MiscTypeState {
  MiscTypeInitialState() : super(eventState: BlocEventState.LOADING);
}

class MiscTypeLoadedState extends MiscTypeState {
  final MetaMiscTypeListResponse? data;
  MiscTypeLoadedState({required this.data}) : super(response: data, eventState: BlocEventState.LOADED);
}


class ErrorState extends MiscTypeState{
  String message;
  ErrorState({required this.message}) : super(eventState:  BlocEventState.ERROR,message: message);
}
