part of 'te_bloc.dart';

@immutable
abstract class TravelExpenseEvent {}

class GetTravelExpenseListEvent extends TravelExpenseEvent {
  final int sortID;
  final List<String> filterString;
  GetTravelExpenseListEvent(this.sortID,this.filterString);
}

class GetTravelExpenseSummaryEvent extends TravelExpenseEvent {
  final String recordLocator;
  GetTravelExpenseSummaryEvent({required this.recordLocator});
}
