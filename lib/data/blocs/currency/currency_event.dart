part of 'currency_bloc.dart';

@immutable
abstract class CurrencyEvent {}

class GetCurrencyListEvent extends CurrencyEvent {
  GetCurrencyListEvent();
}


class GetExchangeRateEvent extends CurrencyEvent {
  String? currency;
  String? date;
  GetExchangeRateEvent({this.currency,this.date});
}
