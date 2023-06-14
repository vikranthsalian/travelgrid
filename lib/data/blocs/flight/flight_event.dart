part of 'flight_bloc.dart';

@immutable
abstract class FlightEvent {}

class GetFlightListEvent extends FlightEvent {
  String? from;
  String? to;
  String? date;
  GetFlightListEvent({this.from,this.date,this.to});
}
