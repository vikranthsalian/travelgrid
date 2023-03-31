import 'package:travelgrid/data/datasources/summary/te_summary_response.dart';
import 'package:travelgrid/data/datasources/list/te_list_response.dart';
import 'package:travelgrid/data/models/success_model.dart';
import 'package:travelgrid/domain/repo_abstract/api_abstract.dart';

class TeUseCase {
  final TeAPIAbstract apiAbstract;
  TeUseCase(this.apiAbstract);
  Future<TEListResponse> callApi() async => apiAbstract.callList();

  Future<TESummaryResponse> getSummary(id) async => apiAbstract.getTE(id);

  Future<SuccessModel> createTe(data,body) async => apiAbstract.createTE(data,body);

  Future<SuccessModel> takeBackTE(data) async => apiAbstract.takeBackTE(data);

  Future<SuccessModel> approveGE(id,comment) async => apiAbstract.approveTE(id,comment);

  Future<SuccessModel> rejectTE(id,comment) async => apiAbstract.rejectTE(id,comment);
}