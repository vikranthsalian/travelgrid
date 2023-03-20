import 'package:travelgrid/data/datasources/list/tr_list_response.dart';
import 'package:travelgrid/data/datasources/summary/tr_summary_response.dart';
import 'package:travelgrid/data/models/success_model.dart';
import 'package:travelgrid/domain/repo_abstract/api_abstract.dart';

class TrUseCase {
  final TrAPIAbstract apiAbstract;
  TrUseCase(this.apiAbstract);
  Future<TRListResponse> callApi() async => apiAbstract.callList();

  Future<TRSummaryResponse> getSummary(id) async => apiAbstract.getTR(id);

  Future<SuccessModel> createTR(data,body) async => apiAbstract.createTR(data,body);

  Future<SuccessModel> checkOverlapped(data) async => apiAbstract.checkOverlapped(data);

  Future<SuccessModel> approveTR(id,comment) async => apiAbstract.approveTR(id,comment);
}