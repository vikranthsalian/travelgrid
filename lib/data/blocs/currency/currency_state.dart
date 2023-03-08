part of 'currency_bloc.dart';


@immutable
abstract class CurrencyState {
  MetaCurrencyListResponse? response ;
  SuccessModel? rate ;
  BlocEventState eventState;
  String message;
  CurrencyState({this.response,this.rate, this.message="", this.eventState=BlocEventState.LOADING});
}

class CurrencyInitialState extends CurrencyState {
  CurrencyInitialState() : super(eventState: BlocEventState.LOADING);
}

class CurrencyLoadedState extends CurrencyState {
  final MetaCurrencyListResponse? data;
  CurrencyLoadedState({required this.data}) : super(response: data, eventState: BlocEventState.LOADED);
}

class ExchangeRateLoadedState extends CurrencyState {
  final SuccessModel? data;
  ExchangeRateLoadedState({required this.data}) : super(rate: data, eventState: BlocEventState.LOADED);
}

class ErrorState extends CurrencyState{
  String message;
  ErrorState({required this.message}) : super(eventState:  BlocEventState.ERROR,message: message);
}
