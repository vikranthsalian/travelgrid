part of 'ae_bloc.dart';

@immutable
abstract class ApprovalExpenseEvent {}

class GetApprovalExpenseTR extends ApprovalExpenseEvent {
  final int sortID;
  final String filterString;
  GetApprovalExpenseTR(this.sortID,this.filterString);
}

class GetApprovalExpenseTE extends ApprovalExpenseEvent {
  final int sortID;
  final String filterString;
  GetApprovalExpenseTE(this.sortID,this.filterString);
}

class GetApprovalExpenseGE extends ApprovalExpenseEvent {
  final int sortID;
  final String filterString;
  GetApprovalExpenseGE(this.sortID,this.filterString);
}

