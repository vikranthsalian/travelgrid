import 'package:travelgrid/data/datsources/ge_summary_response.dart';
import 'package:travelgrid/data/datsources/general_expense_list.dart';
import 'package:travelgrid/data/datsources/login_response.dart';
import 'package:travelgrid/data/models/success_model.dart';
import 'package:travelgrid/domain/repo_abstract/api_abstract.dart';

class GeUseCase {
  final GeAPIAbstract apiAbstract;
  GeUseCase(this.apiAbstract);
  Future<GEListResponse> callApi() async => apiAbstract.callList();

  Future<GESummaryResponse> getSummary(id) async => apiAbstract.getGE(id);

  Future<SuccessModel> createGE(data,body) async => apiAbstract.createGE(data,body);
}