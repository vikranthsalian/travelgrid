part of 'accom_type_cubit.dart';

@immutable
abstract class AccomTypeState {}

class AccomTypeIn extends AccomTypeState {
  final List<Data> response;
  AccomTypeIn({required this.response});
}
