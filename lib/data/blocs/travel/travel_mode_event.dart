part of 'travel_mode_bloc.dart';

@immutable
abstract class TravelModeEvent {}

class GetTravelModeListEvent extends TravelModeEvent {
  GetTravelModeListEvent();
}
