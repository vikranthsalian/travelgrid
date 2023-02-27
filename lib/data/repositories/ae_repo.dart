import 'package:travelgrid/data/datasources/general_expense_list.dart';
import 'package:travelgrid/data/datasources/te_approval_list.dart';
import 'package:travelgrid/data/datasources/te_summary_response.dart';
import 'package:travelgrid/data/datasources/travel_expense_list.dart';
import 'package:travelgrid/data/models/success_model.dart';
import 'package:travelgrid/data/remote/remote_datasource.dart';
import 'package:travelgrid/domain/repo_abstract/api_abstract.dart';

class AeRepository extends AeAPIAbstract {
  final APIRemoteDatasource apiRemoteDatasource;

  AeRepository({
    required this.apiRemoteDatasource,
  });


  @override
  Future<GEListResponse> callGEList(path) async {

    var response = await apiRemoteDatasource.getTEList(path);
    if(response!=null) {
      GEListResponse modelResponse = GEListResponse.fromJson(response);
      return modelResponse;
    }

      return GEListResponse(status: false);
  }


  @override
  Future<TEApprovalList> callTEList(path) async {

    var response = await apiRemoteDatasource.getTEList(path);

    if(response!=null) {
      TEApprovalList modelResponse = TEApprovalList.fromJson(response);

      return modelResponse;
    }

    return TEApprovalList(status: false);
  }

}
