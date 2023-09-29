import 'package:travelex/data/datasources/summary/ge_summary_response.dart';
import 'package:travelex/data/datasources/list/ge_list_response.dart';
import 'package:travelex/data/models/success_model.dart';
import 'package:travelex/domain/repo_abstract/api_abstract.dart';

class GeUseCase {
  final GeAPIAbstract apiAbstract;
  GeUseCase(this.apiAbstract);
  Future<GEListResponse> callApi() async => apiAbstract.callList();

  Future<GESummaryResponse> getSummary(id) async => apiAbstract.getGE(id);

  Future<SuccessModel> createGE(data,body) async => apiAbstract.createGE(data,body);

  Future<SuccessModel> takeBackGE(data) async => apiAbstract.takeBackGE(data);

  Future<SuccessModel> approveGE(id,comment) async => apiAbstract.approveGE(id,comment);

  Future<SuccessModel> rejectGE(id,comment) async => apiAbstract.rejectGE(id,comment);

  Future<SuccessModel> getGeGroup(data) async => apiAbstract.getGeGroup(data);
}