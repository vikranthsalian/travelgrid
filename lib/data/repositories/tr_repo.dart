import 'package:travelgrid/data/datasources/list/tr_list_response.dart';
import 'package:travelgrid/data/datasources/summary/tr_summary_response.dart';
import 'package:travelgrid/data/models/success_model.dart';
import 'package:travelgrid/data/remote/remote_datasource.dart';
import 'package:travelgrid/domain/repo_abstract/api_abstract.dart';

class TrRepository extends TrAPIAbstract {
  final APIRemoteDatasource apiRemoteDatasource;

  TrRepository({
    required this.apiRemoteDatasource,
  });


  @override
  Future<TRListResponse> callList() async {

    var response = await apiRemoteDatasource.getList("trlist");
    if(response!=null) {
      TRListResponse modelResponse = TRListResponse.fromJson(response);
      return modelResponse;
    }

      return TRListResponse(status: false);
  }


  @override
  Future<TRSummaryResponse> getTR(id) async {

    var response = await apiRemoteDatasource.getTRSummary("getTRDetails",id);
    if(response!=null) {
      TRSummaryResponse modelResponse = TRSummaryResponse.fromJson(response);
      return modelResponse;
    }

    return TRSummaryResponse(status: false);
  }

  @override
  Future<SuccessModel> createTR(data,body) async {

    var response = await apiRemoteDatasource.create("submitMaTravelRequest",data,body);

    if(response!=null) {
      SuccessModel modelResponse = SuccessModel.fromJson(response);
      return modelResponse;
    }

    return SuccessModel(status: false);
  }

  @override
  Future<SuccessModel> approveTR(id, comment) async{

    Map<String,dynamic> data= {
      "recordLocator":id,
      "action":"Approve",
      "comments":comment
    };

    var response = await apiRemoteDatasource.approve("approveAction",data);

    if(response!=null) {
      SuccessModel modelResponse = SuccessModel.fromJson(response);
      return modelResponse;
    }

    return SuccessModel(status: false);
  }

  @override
  Future<SuccessModel> checkOverlapped(data) async{
    var response = await apiRemoteDatasource.getCommonTypes("getOverlappedTr",data);

    if(response!=null) {
      SuccessModel modelResponse = SuccessModel.fromJson(response);
      return modelResponse;
    }

    return SuccessModel(status: false);
  }

}