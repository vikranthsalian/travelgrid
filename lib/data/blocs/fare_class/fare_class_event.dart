part of 'fare_class_bloc.dart';

@immutable
abstract class FareClassEvent {}

class GetAirFareClassListEvent extends FareClassEvent {
  GetAirFareClassListEvent();
}

class GetRailFareClassListEvent extends FareClassEvent {
  GetRailFareClassListEvent();
}

class GetRoadFareClassListEvent extends FareClassEvent {
  GetRoadFareClassListEvent();
}

