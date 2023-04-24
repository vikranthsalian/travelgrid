import 'package:aad_oauth/aad_oauth.dart';
import 'package:aad_oauth/model/config.dart';
import 'package:dio/dio.dart';
import 'package:flutter_form_bloc/flutter_form_bloc.dart';
import 'package:travelgrid/common/config/azure_sso.dart';
import 'package:travelgrid/common/config/navigator_key.dart';
import 'package:travelgrid/common/dio/dio_client.dart';
import 'package:travelgrid/common/utils/loader_hud.dart';
import 'package:travelgrid/data/cubits/login_cubit/login_cubit.dart';
import 'package:travelgrid/data/datasources/others/accom_type_list.dart';
import 'package:travelgrid/data/datasources/others/cities_list.dart';
import 'package:travelgrid/data/datasources/login_response.dart';

class APIRemoteDatasource{

  Future<dynamic> ssoSignIn() async
  {
    Config config = AzureSSO().getConfig();
    AadOAuth oauth = new AadOAuth(config);
  //  config.loginHint = email;
    await oauth.login();
    final accessToken = await oauth.getAccessToken();

    final graphResponse = await await CustomDio().getWrapper().get(
        "https://graph.microsoft.com/oidc/userinfo ",
        loadingMessage:"Logging In...",
       // queryParameters:data,
        options:Options(
          headers: {
            "Authorization": "Bearer" + "$accessToken",
            "Content-Type": "application/json"
          })
    );
    print(graphResponse);
  }

  Future<dynamic> loginRequest(Map<String, String> data,pathUrl) async {
    try {
      final responseJson = await CustomDio().getWrapper().post(
          pathUrl,
          loadingMessage:"Logging In...",
          queryParameters:data,
          noBearer:true
      );
      return responseJson.data;
    } on DioError catch (e) {
      print("DioError"+e.toString());
     return MetaLoginResponse(status: false);

    }catch(e){
      print("CatchError"+e.toString());
      return MetaLoginResponse(status: false);
    }

  }

  Future<dynamic> getList(pathUrl) async {
    try {
      final responseJson = await CustomDio().getWrapper().get(
          pathUrl,
          loadingMessage:"Loading Data...",
          queryParameters:{"token":appNavigatorKey.currentState!.context.read<LoginCubit>().getLoginToken()},
      );
      return responseJson.data;
    } on DioError catch (e) {
      print("DioError"+e.toString());
      return MetaLoginResponse(status: false);

    }catch(e){
      print("CatchError"+e.toString());
      return MetaLoginResponse(status: false);
    }

  }

  Future<dynamic> getTRSummary(pathUrl,id) async {
    try {
      final responseJson = await CustomDio().getWrapper().get(
        pathUrl,
        loadingMessage:"Loading Data...",
        queryParameters:{
          "token":appNavigatorKey.currentState!.context.read<LoginCubit>().getLoginToken(),
          "tripID":id,
        },
      );
      return responseJson.data;
    } on DioError catch (e) {
      print("DioError"+e.toString());
      return MetaLoginResponse(status: false);

    }catch(e){
      print("CatchError"+e.toString());
      return MetaLoginResponse(status: false);
    }

  }
  Future<dynamic> getSummary(pathUrl,id) async {
    try {
      final responseJson = await CustomDio().getWrapper().get(
        pathUrl,
        loadingMessage:"Loading Data...",
        queryParameters:{
          "token":appNavigatorKey.currentState!.context.read<LoginCubit>().getLoginToken(),
          if(pathUrl=="te/getTEDetails")
            "tripID":id
          else
          "recordLocator":id,
        },
      );
      return responseJson.data;
    } on DioError catch (e) {
      print("DioError"+e.toString());
      return MetaLoginResponse(status: false);

    }catch(e){
      print("CatchError"+e.toString());
      return MetaLoginResponse(status: false);
    }

  }

  Future<dynamic> create(pathUrl,data,body) async {
    data["token"]=appNavigatorKey.currentState!.context.read<LoginCubit>().getLoginToken();
    try {
      final responseJson = await CustomDio().getWrapper().post(
        pathUrl,
        data:body,
        loadingMessage:"Loading Data...",
        queryParameters:data,
      );
      return responseJson.data;
    } on DioError catch (e) {
      print("DioError :====>"+e.toString());
      return MetaLoginResponse(status: false);

    }catch(e){
      print("CatchError :====>"+e.toString());
      return MetaLoginResponse(status: false);
    }

  }

  Future<dynamic> takeBack(pathUrl,data) async {
    data["token"]=appNavigatorKey.currentState!.context.read<LoginCubit>().getLoginToken();
    try {
      final responseJson = await CustomDio().getWrapper().post(
        pathUrl,
        loadingMessage:"Loading Data...",
        queryParameters:data,
        data:{}
      );
      return responseJson.data;
    } on DioError catch (e) {
      print("DioError :====>"+e.toString());
      return MetaLoginResponse(status: false);

    }catch(e){
      print("CatchError :====>"+e.toString());
      return MetaLoginResponse(status: false);
    }

  }

  Future<dynamic> approve(pathUrl,data, {msg="Approving Expense..."}) async {
    data["token"]=appNavigatorKey.currentState!.context.read<LoginCubit>().getLoginToken();
    try {
      final responseJson = await CustomDio().getWrapper().post(
        pathUrl,
        loadingMessage:msg,
        queryParameters:data,
      );
      return responseJson.data;
    } on DioError catch (e) {
      print("DioError :====>"+e.toString());
      return MetaLoginResponse(status: false);

    }catch(e){
      print("CatchError :====>"+e.toString());
      return MetaLoginResponse(status: false);
    }

  }


  Future<dynamic> getAllCities(pathUrl,Map<String,dynamic> data) async {

    data["token"]=appNavigatorKey.currentState!.context.read<LoginCubit>().getLoginToken();

    try {
      final responseJson = await CustomDio().getWrapper().get(
        pathUrl,
        loadingMessage:"Loading Data...",
        queryParameters:data,
      );
      return responseJson.data;
    } on DioError catch (e) {
      print("DioError"+e.toString());
      return MetaCityListResponse(status: false);

    }catch(e){
      print("CatchError"+e.toString());
      return MetaCityListResponse(status: false);
    }

  }

  Future<dynamic> getCommonTypes(pathUrl,Map<String,dynamic> data) async {

    data["token"]=appNavigatorKey.currentState!.context.read<LoginCubit>().getLoginToken();

    try {
      final responseJson = await CustomDio().getWrapper().get(
        pathUrl,
        loadingMessage:"Loading Data...",
        queryParameters:data,
      );
      return responseJson.data;
    } on DioError catch (e) {
      print("DioError"+e.toString());
      return MetaAccomTypeListResponse(status: false);

    }catch(e){
      print("CatchError"+e.toString());
      return MetaAccomTypeListResponse(status: false);
    }

  }

  Future<dynamic> upload(pathUrl,formData) async {

    CustomDio().addMultipartHeaders();

    try {
      final responseJson = await CustomDio().getWrapper().post(
        pathUrl,
        data:formData,
        loadingMessage:"Uploading File...",
        queryParameters:{
                "token" :appNavigatorKey.currentState!.context.read<LoginCubit>().getLoginToken()
        },
      );
      return responseJson.data;
    } on DioError catch (e) {
      print("DioError"+e.toString());
      return MetaAccomTypeListResponse(status: false);

    }catch(e){
      print("CatchError"+e.toString());
      return MetaAccomTypeListResponse(status: false);
    }finally{
      CustomDio().addHeaders();
    }

  }

  Future<dynamic> getRoutes(origin,dest) async {

    MetaProgressHUD.showLoading(text: "Calculating Distance,hang on...");

    try {
      Response   responseJson = await Dio().get("https://router.hereapi.com/v8/routes",
          queryParameters: {
            "transportMode":"car",
            "origin":origin,
            "destination":dest,
            "return":"summary",
            "apikey":"uFtVTpwklW1Np_0CdVKXSHOdVhiSFHz6nCMwv1Vt3yQ",
          });
      print(responseJson.data.toString());
      return responseJson.data;
    } on DioError catch (e) {
      print("DioError"+e.toString());
      return MetaAccomTypeListResponse(status: false);

    }catch(e){
      print("CatchError"+e.toString());
      return MetaAccomTypeListResponse(status: false);
    }finally{
      MetaProgressHUD.dismiss();
    }

  }

}