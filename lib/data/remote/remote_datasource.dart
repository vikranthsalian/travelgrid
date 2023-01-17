import 'package:dio/dio.dart';
import 'package:travelgrid/common/dio/dio_client.dart';
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

}