part of 'city_bloc.dart';

@immutable
abstract class CityEvent {}

class GetCityListEvent extends CityEvent {
  String? tripType;
  String? countryCode;
  GetCityListEvent({this.tripType="D",this.countryCode="IN"});
}

class GetCountryListEvent extends CityEvent {
  String? tripType;
  String? countryCode;
  GetCountryListEvent({this.tripType="O",this.countryCode=""});
}
