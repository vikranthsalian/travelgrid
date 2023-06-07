part of 'flight_bloc.dart';

@immutable
abstract class FlightEvent {}

class GetFlightListEvent extends FlightEvent {
  GetFlightListEvent();
}
