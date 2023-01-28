part of 'travel_mode_cubit.dart';

@immutable
abstract class TravelModeState {}

class TravelModeIn extends TravelModeState {
  final List<Data> response;
  TravelModeIn({required this.response});
}
