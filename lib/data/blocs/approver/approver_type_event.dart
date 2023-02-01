part of 'approver_type_bloc.dart';

@immutable
abstract class ApproverTypeEvent {}

class GetApproverTypeListEvent extends ApproverTypeEvent {
  GetApproverTypeListEvent();
}
