part of 'travel_mode_bloc.dart';


@immutable
abstract class TravelModeState {
  MetaTravelModeListResponse? response ;
  BlocEventState eventState;
  String message;
  TravelModeState({this.response, this.message="", this.eventState=BlocEventState.LOADING});
}

class TravelModeInitialState extends TravelModeState {
  TravelModeInitialState() : super(eventState: BlocEventState.LOADING);
}

class TravelModeLoadedState extends TravelModeState {
  final MetaTravelModeListResponse? data;
  TravelModeLoadedState({required this.data}) : super(response: data, eventState: BlocEventState.LOADED);
}


class ErrorState extends TravelModeState{
  String message;
  ErrorState({required this.message}) : super(eventState:  BlocEventState.ERROR,message: message);
}
