part of 'accom_type_bloc.dart';


@immutable
abstract class AccomTypeState {
  MetaAccomTypeListResponse? response ;
  BlocEventState eventState;
  String message;
  AccomTypeState({this.response, this.message="", this.eventState=BlocEventState.LOADING});
}

class AccomTypeInitialState extends AccomTypeState {
  AccomTypeInitialState() : super(eventState: BlocEventState.LOADING);
}

class AccomTypeLoadedState extends AccomTypeState {
  final MetaAccomTypeListResponse? data;
  AccomTypeLoadedState({required this.data}) : super(response: data, eventState: BlocEventState.LOADED);
}


class ErrorState extends AccomTypeState{
  String message;
  ErrorState({required this.message}) : super(eventState:  BlocEventState.ERROR,message: message);
}
