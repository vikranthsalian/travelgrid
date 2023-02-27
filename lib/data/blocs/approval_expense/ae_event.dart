part of 'ae_bloc.dart';

@immutable
abstract class ApprovalExpenseEvent {}

class GetApprovalExpenseTR extends ApprovalExpenseEvent {
  GetApprovalExpenseTR();
}

class GetApprovalExpenseTE extends ApprovalExpenseEvent {
  GetApprovalExpenseTE();
}

class GetApprovalExpenseGE extends ApprovalExpenseEvent {
  GetApprovalExpenseGE();
}

