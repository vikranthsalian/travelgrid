part of 'travel_purpose_bloc.dart';


@immutable
abstract class TravelPurposeState {
  MetaTravelPurposeListResponse? response ;
  BlocEventState eventState;
  String message;
  TravelPurposeState({this.response, this.message="", this.eventState=BlocEventState.LOADING});
}

class TravelPurposeInitialState extends TravelPurposeState {
  TravelPurposeInitialState() : super(eventState: BlocEventState.LOADING);
}

class TravelPurposeLoadedState extends TravelPurposeState {
  final MetaTravelPurposeListResponse? data;
  TravelPurposeLoadedState({required this.data}) : super(response: data, eventState: BlocEventState.LOADED);
}


class ErrorState extends TravelPurposeState{
  String message;
  ErrorState({required this.message}) : super(eventState:  BlocEventState.ERROR,message: message);
}
