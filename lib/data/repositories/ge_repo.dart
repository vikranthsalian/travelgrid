import 'package:travelgrid/data/datasources/ge_summary_response.dart';
import 'package:travelgrid/data/datasources/general_expense_list.dart';
import 'package:travelgrid/data/datasources/login_response.dart';
import 'package:travelgrid/data/models/success_model.dart';
import 'package:travelgrid/data/remote/remote_datasource.dart';
import 'package:travelgrid/domain/repo_abstract/api_abstract.dart';

class GeRepository extends GeAPIAbstract {
  final APIRemoteDatasource apiRemoteDatasource;

  GeRepository({
    required this.apiRemoteDatasource,
  });


  @override
  Future<GEListResponse> callList() async {

    var response = await apiRemoteDatasource.getGeList("ge/gelist");
    if(response!=null) {
      GEListResponse modelResponse = GEListResponse.fromJson(response);
      return modelResponse;
    }

      return GEListResponse(status: false);
  }


  @override
  Future<GESummaryResponse> getGE(id) async {

    var response = await apiRemoteDatasource.getGeSummary("ge/geSummaryDetails",id);
    if(response!=null) {
      GESummaryResponse modelResponse = GESummaryResponse.fromJson(response);
      return modelResponse;
    }

    return GESummaryResponse(status: false);
  }

  @override
  Future<SuccessModel> createGE(data,body) async {

    var response = await apiRemoteDatasource.createGE("ge/submitMaGeneralExpense",data,body);

    if(response!=null) {
      SuccessModel modelResponse = SuccessModel.fromJson(response);
      return modelResponse;
    }

    return SuccessModel(status: false);
  }

  @override
  Future<SuccessModel> approveGE(id, comment) async{

    Map<String,dynamic> data= {
      "recordLocator":id,
      "action":"Approve",
      "comments":comment
    };

    var response = await apiRemoteDatasource.approve("/ge/geApproveAction",data);

    if(response!=null) {
      SuccessModel modelResponse = SuccessModel.fromJson(response);
      return modelResponse;
    }

    return SuccessModel(status: false);
  }

}