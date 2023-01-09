import 'package:dio/dio.dart';
import 'package:travelgrid/common/dio/dio_client.dart';

class APIRemoteDatasource{

  Future<dynamic> loginRequest(Map<String, String> data,pathUrl) async {

    String pathParams = 'loginId=${data['loginId']}&password=${data['password']}&domain=172.104.189.54&enterpriseName=NH';

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
     // return SuccessResponse(isSuccess: false);

    }catch(e){
      print("CatchError"+e.toString());
    //  return SuccessResponse(isSuccess: false);
    }

  }

}