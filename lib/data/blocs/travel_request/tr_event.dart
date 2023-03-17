part of 'tr_bloc.dart';

@immutable
abstract class TravelRequestEvent {}

class GetTravelRequestListEvent extends TravelRequestEvent {
  final int sortID;
  final String filterString;
  GetTravelRequestListEvent(this.sortID,this.filterString);

}

class GetTravelRequestSummaryEvent extends TravelRequestEvent {
  final String recordLocator;
  GetTravelRequestSummaryEvent({required this.recordLocator});
}

