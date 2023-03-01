import 'package:travelgrid/data/datasources/list/ge_list_response.dart';
import 'package:travelgrid/data/datasources/te_approval_list.dart';
import 'package:travelgrid/data/datasources/te_summary_response.dart';
import 'package:travelgrid/data/datasources/list/te_list_response.dart';
import 'package:travelgrid/data/models/success_model.dart';
import 'package:travelgrid/domain/repo_abstract/api_abstract.dart';

class AeUseCase {
  final AeAPIAbstract apiAbstract;

  AeUseCase(this.apiAbstract);

  Future<GEListResponse> callGEApi(api) async => apiAbstract.callGEList(api);

  Future<TEApprovalList> callTEApi(api) async => apiAbstract.callTEList(api);

}