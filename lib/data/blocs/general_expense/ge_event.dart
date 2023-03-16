part of 'ge_bloc.dart';

@immutable
abstract class GeneralExpenseEvent {}

class GetGeneralExpenseListEvent extends GeneralExpenseEvent {
  final int sortID;
  final String filterString;
  GetGeneralExpenseListEvent(this.sortID,this.filterString);
}

class GetGeneralExpenseSummaryEvent extends GeneralExpenseEvent {
  final String recordLocator;
  GetGeneralExpenseSummaryEvent({required this.recordLocator});
}

