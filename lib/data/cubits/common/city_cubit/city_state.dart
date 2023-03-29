part of 'city_cubit.dart';

@immutable
abstract class CityState {}

class CityIn extends CityState {
  final List<Data>? response;
  final List<Data>? responseCountry;
  final List<cn.Data>? countryList;
  CityIn({this.response,this.responseCountry,this.countryList});
}
