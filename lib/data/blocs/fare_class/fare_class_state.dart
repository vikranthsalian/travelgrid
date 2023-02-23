part of 'fare_class_bloc.dart';


@immutable
abstract class FareClassState {
  MetaFareClassListResponse? response ;
  BlocEventState eventState;
  String message;
  FareClassState({this.response, this.message="", this.eventState=BlocEventState.LOADING});
}

class FareClassInitialState extends FareClassState {
  FareClassInitialState() : super(eventState: BlocEventState.LOADING);
}

class FareClassLoadedState extends FareClassState {
  final MetaFareClassListResponse? data;
  FareClassLoadedState({required this.data}) : super(response: data, eventState: BlocEventState.LOADED);
}


class ErrorState extends FareClassState{
  String message;
  ErrorState({required this.message}) : super(eventState:  BlocEventState.ERROR,message: message);
}
