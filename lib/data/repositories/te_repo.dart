import 'package:travelgrid/data/datasources/te_summary_response.dart';
import 'package:travelgrid/data/datasources/travel_expense_list.dart';
import 'package:travelgrid/data/models/success_model.dart';
import 'package:travelgrid/data/remote/remote_datasource.dart';
import 'package:travelgrid/domain/repo_abstract/api_abstract.dart';

class TeRepository extends TeAPIAbstract {
  final APIRemoteDatasource apiRemoteDatasource;

  TeRepository({
    required this.apiRemoteDatasource,
  });


  @override
  Future<TEListResponse> callList() async {

    var response = await apiRemoteDatasource.getTEList("te/telist");
    if(response!=null) {
      TEListResponse modelResponse = TEListResponse.fromJson(response);
      return modelResponse;
    }

      return TEListResponse(status: false);
  }


  @override
  Future<TESummaryResponse> getTE(id) async {

    var response = await apiRemoteDatasource.getTESummary("Te/TESummaryDetails",id);
    if(response!=null) {
      TESummaryResponse modelResponse = TESummaryResponse.fromJson(response);
      return modelResponse;
    }

    return TESummaryResponse(status: false);
  }

  @override
  Future<SuccessModel> createTE(data,body) async {

    var response = await apiRemoteDatasource.createTE("Te/submitMaTeneralExpense",data,body);

    if(response!=null) {
      SuccessModel modelResponse = SuccessModel.fromJson(response);
      return modelResponse;
    }

    return SuccessModel(status: false);
  }

}