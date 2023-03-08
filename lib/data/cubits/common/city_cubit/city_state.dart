part of 'city_cubit.dart';

@immutable
abstract class CityState {}

class CityIn extends CityState {
  final List<Data>? response;
  final List<Data>? responseCountry;
  CityIn({this.response,this.responseCountry});
}
