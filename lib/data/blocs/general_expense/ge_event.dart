part of 'ge_bloc.dart';

@immutable
abstract class GeneralExpenseEvent {}

class GetGeneralExpenseListEvent extends GeneralExpenseEvent {
  GetGeneralExpenseListEvent();
}

class GetGeneralExpenseSummaryEvent extends GeneralExpenseEvent {
  final String recordLocator;
  GetGeneralExpenseSummaryEvent({required this.recordLocator});
}

