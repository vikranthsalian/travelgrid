part of 'flight_bloc.dart';

@immutable
abstract class FlightEvent {}

class GetFlightListEvent extends FlightEvent {
  String? from;
  String? to;
  String? date;
  String? fare;
  String? paxCount;
  GetFlightListEvent({this.from,this.date,this.to,this.fare,this.paxCount});
}

class FlightSearchEvent extends FlightEvent {
  String? key;
  FlightSearchEvent({this.key});
}
