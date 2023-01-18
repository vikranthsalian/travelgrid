import 'package:dio/dio.dart';
import 'package:flutter_form_bloc/flutter_form_bloc.dart';
import 'package:travelgrid/common/config/navigator_key.dart';
import 'package:travelgrid/common/dio/dio_client.dart';
import 'package:travelgrid/data/cubits/login_cubit/login_cubit.dart';
import 'package:travelgrid/data/datsources/login_response.dart';

class APIRemoteDatasource{

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

  Future<dynamic> getGeList(pathUrl) async {
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

}