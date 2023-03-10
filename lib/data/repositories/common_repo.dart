import 'package:flutter_form_bloc/flutter_form_bloc.dart';
import 'package:travelgrid/common/config/navigator_key.dart';
import 'package:travelgrid/data/cubits/login_cubit/login_cubit.dart';
import 'package:travelgrid/data/datasources/accom_type_list.dart';
import 'package:travelgrid/data/datasources/approver_list.dart';
import 'package:travelgrid/data/datasources/cities_list.dart';
import 'package:travelgrid/data/datasources/currency_list.dart';
import 'package:travelgrid/data/datasources/fare_class_list.dart';
import 'package:travelgrid/data/datasources/misc_type_list.dart';
import 'package:travelgrid/data/datasources/travel_mode_list.dart';
import 'package:travelgrid/data/datasources/lat_long_distance_model.dart';
import 'package:travelgrid/data/datasources/travel_purpose_list.dart';
import 'package:travelgrid/data/models/success_model.dart';
import 'package:travelgrid/data/remote/remote_datasource.dart';
import 'package:travelgrid/domain/repo_abstract/api_abstract.dart';

class CommonRepository extends CommonAPIAbstract {
  final APIRemoteDatasource apiRemoteDatasource;

  CommonRepository({
    required this.apiRemoteDatasource,
  });


  @override
  Future<MetaCityListResponse> getCities(countryCode,tripType) async {

    Map<String,dynamic> data= {
      "q":"",
      "tripType":tripType,
      "countryCode":countryCode,
    };

    var response = await apiRemoteDatasource.getCommonTypes("getCities",data);

    if(response!=null) {
      MetaCityListResponse modelResponse = MetaCityListResponse.fromJson(response);
      return modelResponse;
    }

      return MetaCityListResponse(status: false);
  }

  @override
  Future<MetaCityListResponse> getCountriesList() async{
    Map<String,dynamic> data= {
      "q":""
    };

    var response = await apiRemoteDatasource.getCommonTypes("getCountries",data);

    if(response!=null) {
      MetaCityListResponse modelResponse = MetaCityListResponse.fromJson(response);
      return modelResponse;
    }

    return MetaCityListResponse(status: false);
  }


  @override
  Future<MetaAccomTypeListResponse> getAccomTypesList() async {

    Map<String,dynamic> data= {};

    var response = await apiRemoteDatasource.getCommonTypes("getAccomodationType",data);

    if(response!=null) {
      MetaAccomTypeListResponse modelResponse = MetaAccomTypeListResponse.fromJson(response);
      return modelResponse;
    }

    return MetaAccomTypeListResponse(status: false);
  }

  @override
  Future<MetaFareClassListResponse> getFareClassList(mode) async {

    Map<String,dynamic> data= {"mode":mode};

    var response = await apiRemoteDatasource.getCommonTypes("getFareClass",data);

    if(response!=null) {
      MetaFareClassListResponse modelResponse = MetaFareClassListResponse.fromJson(response);
      return modelResponse;
    }

    return MetaFareClassListResponse(status: false);
  }

  @override
  Future<MetaMiscTypeListResponse> getMiscTypeList() async {

    Map<String,dynamic> data= {};

    var response = await apiRemoteDatasource.getCommonTypes("te/getMiscellaneousType",data);

    if(response!=null) {
      MetaMiscTypeListResponse modelResponse = MetaMiscTypeListResponse.fromJson(response);
      return modelResponse;
    }

    return MetaMiscTypeListResponse(status: false);
  }

  @override
  Future<MetaTravelModeListResponse> getTravelModeList() async {

    Map<String,dynamic> data= {};

    var response = await apiRemoteDatasource.getCommonTypes("te/getConveyanceMode",data);

    if(response!=null) {
      MetaTravelModeListResponse modelResponse = MetaTravelModeListResponse.fromJson(response);
      return modelResponse;
    }

    return MetaTravelModeListResponse(status: false);
  }

  @override
  Future<MetaApproverListResponse> getApproverTypeList() async {

    Map<String,dynamic> data= {"loginId":appNavigatorKey.currentState!.context.read<LoginCubit>().getLoginID()};

    var response = await apiRemoteDatasource.getCommonTypes("getMaApprovers",data);

    if(response!=null) {
      MetaApproverListResponse modelResponse = MetaApproverListResponse.fromJson(response);
      return modelResponse;
    }

    return MetaApproverListResponse(status: false);
  }


  @override
  Future<SuccessModel> uploadFile(formData,type) async {

    var response = await apiRemoteDatasource.upload("uploadAttachment/"+type,formData);

    if(response!=null) {
      SuccessModel modelResponse = SuccessModel.fromJson(response);
      return modelResponse;
    }

    return SuccessModel(status: false);
  }


  @override
  Future<MetaLatLongDistanceModel> getDistance(origin,destination) async {


    var response = await apiRemoteDatasource.getRoutes(origin,destination);

    if(response!=null) {
      MetaLatLongDistanceModel modelResponse = MetaLatLongDistanceModel.fromJson(response);
      return modelResponse;
    }

    return MetaLatLongDistanceModel();
  }

  @override
  Future<MetaTravelPurposeListResponse> getTravelPurposeList() async{
    Map<String,dynamic> data= {};

    var response = await apiRemoteDatasource.getCommonTypes("getPurposeOfTravel",data);

    if(response!=null) {
      MetaTravelPurposeListResponse modelResponse = MetaTravelPurposeListResponse.fromJson(response);
      return modelResponse;
    }

    return MetaTravelPurposeListResponse(status: false);
  }

  @override
  Future<MetaCurrencyListResponse> getCurrencyList()async{
    Map<String,dynamic> data= {};

    var response = await apiRemoteDatasource.getCommonTypes("getCurrencies",data);

    if(response!=null) {
      MetaCurrencyListResponse modelResponse = MetaCurrencyListResponse.fromJson(response);
      return modelResponse;
    }

    return MetaCurrencyListResponse(status: false);
  }

  @override
  Future<SuccessModel> getExchangeRate(currency, date) async{
    // TODO: implement getExchangeRate
    Map<String,dynamic> data= {
      'currency':currency,
      'calender':date
    };

    var response = await apiRemoteDatasource.getCommonTypes("getMaExchangeRate",data);

    if(response!=null) {
      SuccessModel modelResponse = SuccessModel.fromJson(response);
      return modelResponse;
    }

    return SuccessModel(status: false);
  }


}