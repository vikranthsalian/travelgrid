import 'package:travelex/data/datasources/list/ge_list_response.dart';
import 'package:travelex/data/datasources/list/tr_list_response.dart';
import 'package:travelex/data/datasources/list/te_approval_list.dart';
import 'package:travelex/data/remote/remote_datasource.dart';
import 'package:travelex/domain/repo_abstract/api_abstract.dart';

class AeRepository extends AeAPIAbstract {
  final APIRemoteDatasource apiRemoteDatasource;

  AeRepository({
    required this.apiRemoteDatasource,
  });

  @override
  Future<TRListResponse> callTRList(path) async {

    var response = await apiRemoteDatasource.getList(path);
    if(response!=null) {
      TRListResponse modelResponse = TRListResponse.fromJson(response);
      return modelResponse;
    }

    return TRListResponse(status: false);
  }

  @override
  Future<GEListResponse> callGEList(path) async {

    var response = await apiRemoteDatasource.getList(path);
    if(response!=null) {
      GEListResponse modelResponse = GEListResponse.fromJson(response);
      return modelResponse;
    }

      return GEListResponse(status: false);
  }


  @override
  Future<TEApprovalList> callTEList(path) async {

    var response = await apiRemoteDatasource.getList(path);

    if(response!=null) {
      TEApprovalList modelResponse = TEApprovalList.fromJson(response);

      return modelResponse;
    }

    return TEApprovalList(status: false);
  }

}
