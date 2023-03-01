part of 'tr_bloc.dart';

@immutable
abstract class TravelRequestEvent {}

class GetTravelRequestListEvent extends TravelRequestEvent {
  GetTravelRequestListEvent();
}

class GetTravelRequestSummaryEvent extends TravelRequestEvent {
  final String recordLocator;
  GetTravelRequestSummaryEvent({required this.recordLocator});
}

