import 'package:travelex/data/datasources/list/tr_list_response.dart';
import 'package:travelex/data/datasources/list/tr_upcoming_response.dart';
import 'package:travelex/data/datasources/summary/tr_summary_response.dart';
import 'package:travelex/data/models/success_model.dart';
import 'package:travelex/domain/repo_abstract/api_abstract.dart';

class TrUseCase {
  final TrAPIAbstract apiAbstract;
  TrUseCase(this.apiAbstract);
  Future<TRListResponse> callApi() async => apiAbstract.callList();

  Future<MetaUpcomingTRResponse> upcomingApi() async => apiAbstract.upcomingApi();

  Future<TRSummaryResponse> getSummary(id) async => apiAbstract.getTR(id);

  Future<SuccessModel> createTR(data,body) async => apiAbstract.createTR(data,body);

  Future<SuccessModel> takeBackTR(data) async => apiAbstract.takeBackTR(data);

  Future<SuccessModel> updateTR(data,body) async => apiAbstract.updateTR(data,body);

  Future<SuccessModel> checkOverlapped(data) async => apiAbstract.checkOverlapped(data);

  Future<SuccessModel> checkFireFareClassRule(data) async => apiAbstract.checkFireFareClassRule(data);

  Future<SuccessModel> approveTR(id,comment) async => apiAbstract.approveTR(id,comment);

  Future<SuccessModel> rejectTR(id,comment) async => apiAbstract.rejectTR(id,comment);
}