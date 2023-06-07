part of 'flight_bloc.dart';


@immutable
abstract class FlightState {
  MetaFlightListResponse? response ;
  BlocEventState eventState;
  String message;
  FlightState({this.response, this.message="", this.eventState=BlocEventState.LOADING});
}

class FlightInitialState extends FlightState {
  FlightInitialState() : super(eventState: BlocEventState.LOADING);
}

class FlightLoadedState extends FlightState {
  final MetaFlightListResponse? data;
  FlightLoadedState({required this.data}) : super(response: data, eventState: BlocEventState.LOADED);
}


class ErrorState extends FlightState{
  String message;
  ErrorState({required this.message}) : super(eventState:  BlocEventState.ERROR,message: message);
}
