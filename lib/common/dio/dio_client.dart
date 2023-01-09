import 'package:dio/dio.dart';
import 'package:flutter_pretty_dio_logger/flutter_pretty_dio_logger.dart';
import 'package:travelgrid/common/constants/flavour_constants.dart';
import 'package:travelgrid/common/dio/dio_wrapper.dart';
import 'package:travelgrid/common/utils/show_alert.dart';
List noErrorEndpointTags = ['app_usage_metric'];

class CustomDio {
  static final CustomDio _singleton = CustomDio._internal();
  String authTokens="";
  factory CustomDio() {
    return _singleton;
  }

  CustomDio._internal();
  Dio _dio = Dio(BaseOptions(
    baseUrl: FlavourConstants.apiHost,
    connectTimeout: 45000, // 45 secs
    receiveTimeout:
    45000, // 5 secs Note: This is not the receiving time limitation. Only Error.
  ));

  getWrapper(){
    return MetaDioWrapper(_dio);
  }

  setDio({bool isLogin =false})   {

    _dio =  addInterceptors(_dio);

    _dio.interceptors.add(InterceptorsWrapper(
        onRequest: (RequestOptions options, RequestInterceptorHandler handler) async {
          // Handle trial version patient app
          return handler.next(options);
        }, onResponse: (Response response, ResponseInterceptorHandler handler) async {
      // Do something with response data
      print("=========> RESPONSE SUCCESS");
      return handler.next(response);
    }, onError: (DioError e, ErrorInterceptorHandler handler) async {
      // Do something with response error
      if (!shouldShowError(e.requestOptions.path)) {
        return handler.next(e);
      }
      if (e.response == null && shouldShowError(e.requestOptions.path)) {
        MetaAlert.showErrorAlert(
          title: 'Network Failure',
          message: 'Please check your network connectivity!',
        );
      }
      return handler.next(e);
    }));
    print("Adding Token");
    addHeaders();
    //addMultipartHeaders();
    // if (authTokens != null && authTokens.isNotEmpty) {
    //   // options.headers["AUTHORIZATION"] = accessToken;
    //   _dio.options.headers = {
    //     'Authorization': 'Bearer $authTokens',
    //     'Accept': 'application/json',
    //     'Content-Type': 'multipart/form-data',
    //   };
    // }
    if(isLogin){
      _dio.options.headers={};
    }


    return MetaDioWrapper(_dio);
  }

  Dio addPrettyInterceptors(Dio dio) {
    dio.interceptors.add(
      PrettyDioLogger(
        requestHeader: true,
        requestBody: true,
        responseBody: true,
        responseHeader: true,
        error: true,
        canShowLog: true,
        // logPrint: dio.
        //  compact: true,
        // maxWidth: 90,
      ),
    );
    return dio;
  }

   addInterceptors(Dio dio) {

    if (FlavourConstants.showNetworkLogs) {
      _dio = addPrettyInterceptors(_dio);
      print("added PrettyInterceptors");
    }
    print("HEADERS : "+ dio.options.headers.toString() );


    return dio;
  }

  addHeaders() {
    print("Adding headers");
    _dio.options.headers={};
    if (authTokens != null && authTokens.isNotEmpty) {
      _dio.options.headers = {
        'Authorization': 'Bearer $authTokens',
        'Accept': 'application/json',
      };
    }


  }

  addMultipartHeaders() {
    print("Adding Multipart Headers");
    if (authTokens != null && authTokens.isNotEmpty) {
      _dio.options.headers = {
        'Authorization': 'Bearer $authTokens',
        'Accept': 'application/json',
        'Content-Type': 'multipart/form-data',
      };
    }
  }


  bool shouldShowError(String url) {
    for (var tag in noErrorEndpointTags) {
      if (url.contains(tag)) return false;
    }
    return true;
  }

}
