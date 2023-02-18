part of 'te_bloc.dart';

@immutable
abstract class TravelExpenseEvent {}

class GetTravelExpenseListEvent extends TravelExpenseEvent {
  GetTravelExpenseListEvent();
}

class GetTravelExpenseSummaryEvent extends TravelExpenseEvent {
  final String recordLocator;
  GetTravelExpenseSummaryEvent({required this.recordLocator});
}
