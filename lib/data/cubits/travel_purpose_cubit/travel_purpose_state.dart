part of 'travel_purpose_cubit.dart';

@immutable
abstract class TravelPurposeState {}

class TravelPurposeIn extends TravelPurposeState {
  final List<Data> response;
  TravelPurposeIn({required this.response});
}
