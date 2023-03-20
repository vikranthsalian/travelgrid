import 'package:travelgrid/data/datasources/summary/te_summary_response.dart';
import 'package:travelgrid/data/datasources/list/te_list_response.dart';
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

    var response = await apiRemoteDatasource.getList("te/teList");
    if(response!=null) {
      TEListResponse modelResponse = TEListResponse.fromJson(response);
      return modelResponse;
    }

      return TEListResponse(status: false);
  }


  @override
  Future<TESummaryResponse> getTE(id) async {

    var response = await apiRemoteDatasource.getSummary("te/getTEDetails",id);
    if(response!=null) {
      TESummaryResponse modelResponse = TESummaryResponse.fromJson(response);
      return modelResponse;
    }

    return TESummaryResponse(status: false);
  }

  @override
  Future<SuccessModel> createTE(data,body) async {

    var response = await apiRemoteDatasource.create("te/submitMaTravelExpense",data,body);

    if(response!=null) {
      SuccessModel modelResponse = SuccessModel.fromJson(response);
      return modelResponse;
    }

    return SuccessModel(status: false);
  }

  @override
  Future<SuccessModel> takeBackTE(data) async {

    var response = await apiRemoteDatasource.takeBack("te/takeBack",data);

    if(response!=null) {
      SuccessModel modelResponse = SuccessModel.fromJson(response);
      return modelResponse;
    }

    return SuccessModel(status: false);
  }

  @override
  Future<SuccessModel> approveTE(id, comment) async{

    Map<String,dynamic> data= {
      "recordLocator":id,
      "action":"Approve",
      "comments":comment
    };

    var response = await apiRemoteDatasource.approve("/teApproveAction",data);

    if(response!=null) {
      SuccessModel modelResponse = SuccessModel.fromJson(response);
      return modelResponse;
    }

    return SuccessModel(status: false);
  }

}
