import 'package:flutter_form_bloc/flutter_form_bloc.dart';
import 'package:travelgrid/common/config/navigator_key.dart';
import 'package:travelgrid/data/cubits/login_cubit/login_cubit.dart';
import 'package:travelgrid/data/datasources/others/accom_type_list.dart';
import 'package:travelgrid/data/datasources/list/approver_list.dart';
import 'package:travelgrid/data/datasources/others/cities_list.dart';
import 'package:travelgrid/data/datasources/others/countries_list.dart';
import 'package:travelgrid/data/datasources/others/currency_list.dart';
import 'package:travelgrid/data/datasources/others/employee_list.dart';
import 'package:travelgrid/data/datasources/others/fare_class_list.dart';
import 'package:travelgrid/data/datasources/others/flight_list.dart';
import 'package:travelgrid/data/datasources/others/misc_type_list.dart';
import 'package:travelgrid/data/datasources/others/non_employee_list.dart';
import 'package:travelgrid/data/datasources/others/travel_mode_list.dart';
import 'package:travelgrid/data/datasources/others/lat_long_distance_model.dart';
import 'package:travelgrid/data/datasources/others/travel_purpose_list.dart';
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
  Future<MetaCountryListResponse> getCountriesList() async{
    Map<String,dynamic> data= {
      "q":""
    };

    var response = await apiRemoteDatasource.getCommonTypes("getCountries",data);

    if(response!=null) {
      MetaCountryListResponse modelResponse = MetaCountryListResponse.fromJson(response);
      return modelResponse;
    }

    return MetaCountryListResponse(status: false);
  }

  @override
  Future<MetaEmployeeListResponse> getEmployeesList() async{
    Map<String,dynamic> data= {
      "employeeCode":"",
      "employeeName":"",
      "requestType":""

    };

    var response = await apiRemoteDatasource.getCommonTypes("onBehalfEmp",data);

    if(response!=null) {
      MetaEmployeeListResponse modelResponse = MetaEmployeeListResponse.fromJson(response);
      return modelResponse;
    }

    return MetaEmployeeListResponse(status: false);
  }

  @override
  Future<MetaNonEmployeeListResponse> getNonEmployeesList() async{
    Map<String,dynamic> data= {
      "nonEmployeeName":"vinoth",
      "nonEmployeeContact":"",
      "nonEmployeeEmail":""
    };

    var response = await apiRemoteDatasource.getCommonTypes("onBehalfNonEmp",data);

    if(response!=null) {
      MetaNonEmployeeListResponse modelResponse = MetaNonEmployeeListResponse.fromJson(response);
      return modelResponse;
    }

    return MetaNonEmployeeListResponse(status: false);
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
    Map<String,dynamic> data= {
      'currency':currency,
      'calendar':date
    };

    var response = await apiRemoteDatasource.getCommonTypes("getMaExchangeRate",data);

    if(response!=null) {
      SuccessModel modelResponse = SuccessModel.fromJson(response);
      return modelResponse;
    }

    return SuccessModel(status: false);
  }

  @override
  Future<SuccessModel> logOut() async{
    Map<String,dynamic> data= {};
    var response = await apiRemoteDatasource.getCommonTypes("logout",data);

    if(response!=null) {
      SuccessModel modelResponse = SuccessModel.fromJson(response);
      return modelResponse;
    }

    return SuccessModel(status: false);
  }

  @override
  Future<MetaFlightListResponse> getFlightList(data) async{
    var response = await apiRemoteDatasource.getCommonTypes("searchFlightsMobile",data);

    if(response!=null) {
      MetaFlightListResponse modelResponse = MetaFlightListResponse.fromJson(response);
      return modelResponse;
    }

    return MetaFlightListResponse(status: false);
  }


}