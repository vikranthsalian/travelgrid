part of 'currency_cubit.dart';

@immutable
abstract class CurrencyState {}

class CurrencyIn extends CurrencyState {
  final List<Data> response;
  CurrencyIn({required this.response});
}
