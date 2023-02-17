part of 'city_bloc.dart';

@immutable
abstract class CityEvent {}

class GetCityListEvent extends CityEvent {
  GetCityListEvent();
}

class SearchCityListEvent extends CityEvent {
  final List<Data>? list;
  SearchCityListEvent({required this.list});
}
