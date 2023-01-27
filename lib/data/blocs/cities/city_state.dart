part of 'city_bloc.dart';


@immutable
abstract class CityState {
  MetaCityListResponse? response ;
  BlocEventState eventState;
  String message;
  CityState({this.response, this.message="", this.eventState=BlocEventState.LOADING});
}

class CityInitialState extends CityState {
  CityInitialState() : super(eventState: BlocEventState.LOADING);
}

class CityLoadedState extends CityState {
  final MetaCityListResponse? data;
  CityLoadedState({required this.data}) : super(response: data, eventState: BlocEventState.LOADED);
}


class ErrorState extends CityState{
  String message;
  ErrorState({required this.message}) : super(eventState:  BlocEventState.ERROR,message: message);
}
