import 'package:travelgrid/data/datasources/summary/ge_summary_response.dart';
import 'package:travelgrid/data/datasources/list/ge_list_response.dart';
import 'package:travelgrid/data/models/success_model.dart';
import 'package:travelgrid/domain/repo_abstract/api_abstract.dart';

class GeUseCase {
  final GeAPIAbstract apiAbstract;
  GeUseCase(this.apiAbstract);
  Future<GEListResponse> callApi() async => apiAbstract.callList();

  Future<GESummaryResponse> getSummary(id) async => apiAbstract.getGE(id);

  Future<SuccessModel> createGE(data,body) async => apiAbstract.createGE(data,body);

  Future<SuccessModel> takeBackGE(data) async => apiAbstract.takeBackGE(data);

  Future<SuccessModel> approveGE(id,comment) async => apiAbstract.approveGE(id,comment);

  Future<SuccessModel> rejectGE(id,comment) async => apiAbstract.rejectGE(id,comment);
}