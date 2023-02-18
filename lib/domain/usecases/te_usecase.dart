import 'package:travelgrid/data/datasources/te_summary_response.dart';
import 'package:travelgrid/data/datasources/travel_expense_list.dart';
import 'package:travelgrid/data/models/success_model.dart';
import 'package:travelgrid/domain/repo_abstract/api_abstract.dart';

class TeUseCase {
  final TeAPIAbstract apiAbstract;
  TeUseCase(this.apiAbstract);
  Future<TEListResponse> callApi() async => apiAbstract.callList();

  Future<TESummaryResponse> getSummary(id) async => apiAbstract.getTE(id);

  Future<SuccessModel> createTe(data,body) async => apiAbstract.createTE(data,body);
}