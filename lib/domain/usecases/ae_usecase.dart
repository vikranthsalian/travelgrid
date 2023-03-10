import 'package:travelgrid/data/datasources/list/ge_list_response.dart';
import 'package:travelgrid/data/datasources/list/tr_list_response.dart';
import 'package:travelgrid/data/datasources/te_approval_list.dart';
import 'package:travelgrid/domain/repo_abstract/api_abstract.dart';

class AeUseCase {
  final AeAPIAbstract apiAbstract;

  AeUseCase(this.apiAbstract);

  Future<TRListResponse> callTRApi(api) async => apiAbstract.callTRList(api);

  Future<GEListResponse> callGEApi(api) async => apiAbstract.callGEList(api);

  Future<TEApprovalList> callTEApi(api) async => apiAbstract.callTEList(api);

}