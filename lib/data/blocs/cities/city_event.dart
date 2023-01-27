part of 'city_bloc.dart';

@immutable
abstract class CityEvent {}

class GetCityListEvent extends CityEvent {
  GetCityListEvent();
}
