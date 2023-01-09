import 'package:dio/dio.dart';
import 'package:travelgrid/common/constants/string_constants.dart';
import 'package:travelgrid/common/utils/loader_hud.dart';
import 'package:travelgrid/common/utils/show_alert.dart';

abstract class BaseDioWrapper {
  Future<Response<T>> get<T>(
      String path, {
        Map<String, dynamic> queryParameters,
        Options options,
        CancelToken cancelToken,
        ProgressCallback onReceiveProgress,
        bool showLoader,
        String loadingMessage,
      });

  Future<Response<T>> post<T>(
      String path, {
        data,
        Map<String, dynamic> queryParameters,
        Options options,
        CancelToken cancelToken,
        ProgressCallback onSendProgress,
        ProgressCallback onReceiveProgress,
        bool showLoader,
        bool noBearer,
        String loadingMessage,
      });

  // Future<Response> getUri(
  //     Uri uri, {
  //       Options options,
  //       CancelToken cancelToken,
  //       ProgressCallback onReceiveProgress,
  //       bool showLoader,
  //       String loadingMessage,
  //     });

  Future<Response> patch(
      String path, {
        data,
        Map<String, dynamic> queryParameters,
        Options options,
        CancelToken cancelToken,
        ProgressCallback onSendProgress,
        ProgressCallback onReceiveProgress,
        bool showLoader,
        String loadingMessage,
      });

  Future<Response<T>> put<T>(
      String path, {
        data,
        Map<String, dynamic> queryParameters,
        Options options,
        CancelToken cancelToken,
        ProgressCallback onSendProgress,
        ProgressCallback onReceiveProgress,
        bool showLoader,
        String loadingMessage,
      });

  Future<Response> delete(
      String path, {
        data,
        Map<String, dynamic> queryParameters,
        Options options,
        CancelToken cancelToken,
        bool showLoader,
        String loadingMessage,
      });
}

class MetaDioWrapper implements BaseDioWrapper {
  final Dio _dio;

  MetaDioWrapper(this._dio);

  void showHUD({required String? message}) {
    MetaProgressHUD.showLoading(text: message.toString());
  }

  void hideHUD() {
    MetaProgressHUD.dismiss();
  }

  void showErrorHUD({required String message}) {
    MetaProgressHUD.showErrorAndDismiss(text: message);
  }

  @override
  Future<Response<T>> get<T>(
      String path, {
        Map<String, dynamic>? queryParameters,
        Options? options,
        CancelToken? cancelToken,
        ProgressCallback? onReceiveProgress,
        bool showLoader = false,
        String? loadingMessage,
      }) async {
    if (showLoader) showHUD(message: loadingMessage);
    try {
      Response<T> response = await _dio.get(
        path,
        queryParameters: queryParameters,
        options: options,
        cancelToken: cancelToken,
        onReceiveProgress: onReceiveProgress,
      );
      return response;
    } on DioError catch (e, stackTrace) {
      print("PARSE ERROR RESPONSE===========> "+e.response.toString());
      parseErrorResponse(e);
      // Logger.captureException(e, stackTrace: stackTrace);
      rethrow;
    } catch (e, stackTrace) {
      // Logger.captureException(e, stackTrace: stackTrace);
      rethrow;
    } finally {
      if (showLoader) hideHUD();
    }
  }

  @override
  Future<Response<T>> post<T>(
      String path, {
        data,
        Map<String, dynamic>? queryParameters,
        Options? options,
        CancelToken? cancelToken,
        ProgressCallback? onSendProgress,
        ProgressCallback? onReceiveProgress,
        bool? showLoader = true,
        bool? noBearer = false,
        String? loadingMessage,
      }) async {
    if (showLoader!) showHUD(message: loadingMessage);

    if (noBearer!) options=null;

    try {
      Response<T> response = await _dio.post(
        path,
        data: data,
        queryParameters: queryParameters,
        options: options,
        cancelToken: cancelToken,
        onSendProgress: onSendProgress,
        onReceiveProgress: onReceiveProgress,
      );

      Map<String,dynamic> dataMap = response.data as Map<String, dynamic>;
      try {
        MetaAlert.showSuccessAlert(
          message: dataMap["message"],
        );
      }catch(e){

      }

      return response;
    } on DioError catch (e, stackTrace) {
      print("PARSE ERROR RESPONSE===========> "+e.response.toString());
      parseErrorResponse(e);
      // Logger.captureException(e, stackTrace: stackTrace);
      rethrow;
    } catch (e, stackTrace) {
      // Logger.captureException(e, stackTrace: stackTrace);
      rethrow;
    } finally {
      if (showLoader) hideHUD();
    }
  }

  @override
  Future<Response> patch(
      String path, {
        data,
        Map<String, dynamic>? queryParameters,
        Options? options,
        CancelToken? cancelToken,
        ProgressCallback? onSendProgress,
        ProgressCallback? onReceiveProgress,
        bool? showLoader = true,
        String? loadingMessage,
      }) async {
    if (showLoader!) showHUD(message: loadingMessage);
    try {
      final response = await _dio.patch(
        path,
        data: data,
        queryParameters: queryParameters,
        options: options,
        cancelToken: cancelToken,
        onSendProgress: onSendProgress,
        onReceiveProgress: onReceiveProgress,
      );
      return response;
    } on DioError catch (e, stackTrace) {
      parseErrorResponse(e);
      // Logger.captureException(e, stackTrace: stackTrace);
      rethrow;
    } catch (e, stackTrace) {
      // Logger.captureException(e, stackTrace: stackTrace);
      rethrow;
    } finally {
      if (showLoader) hideHUD();
    }
  }

  @override
  Future<Response<T>> put<T>(
      String path, {
        data,
        Map<String, dynamic>? queryParameters,
        Options? options,
        CancelToken? cancelToken,
        ProgressCallback? onSendProgress,
        ProgressCallback? onReceiveProgress,
        bool? showLoader = true,
        String? loadingMessage,
      }) async {
    if (showLoader!) showHUD(message: loadingMessage);
    try {
      Response<T> response = await _dio.put(
        path,
        data: data,
        queryParameters: queryParameters,
        options: options,
        cancelToken: cancelToken,
        onSendProgress: onSendProgress,
        onReceiveProgress: onReceiveProgress,
      );


      Map<String,dynamic> dataMap = response.data as Map<String, dynamic>;

      MetaAlert.showSuccessAlert(
        message: dataMap["message"],
      );

      return response;
    } on DioError catch (e, stackTrace) {
      print("PARSE ERROR RESPONSE===========> "+e.response.toString());
      parseErrorResponse(e);
      // Logger.captureException(e, stackTrace: stackTrace);
      rethrow;
    } catch (e, stackTrace) {
      // Logger.captureException(e, stackTrace: stackTrace);
      rethrow;
    } finally {
      if (showLoader) hideHUD();
    }
  }

  @override
  Future<Response> delete(
      String path, {
        data,
        Map<String, dynamic>? queryParameters,
        Options? options,
        CancelToken? cancelToken,
        bool? showLoader = true,
        String? loadingMessage,
      }) async {
    if (showLoader!) showHUD(message: loadingMessage);
    try {
      final response = await _dio.delete(
        path,
        data: data,
        queryParameters: queryParameters,
        options: options,
        cancelToken: cancelToken,
      );
      return response;
    } on DioError catch (e, stackTrace) {
      parseErrorResponse(e);
      // Logger.captureException(e, stackTrace: stackTrace);
      rethrow;
    } catch (e, stackTrace) {
      // Logger.captureException(e, stackTrace: stackTrace);
      rethrow;
    } finally {
      if (showLoader) hideHUD();
    }
  }

  // @override
  // Future<Response> getUri(
  //     Uri uri, {
  //       Options? options,
  //       CancelToken? cancelToken,
  //       ProgressCallback? onReceiveProgress,
  //       bool? showLoader = false,
  //       String? loadingMessage,
  //     }) async {
  //   if (showLoader!) showHUD(message: loadingMessage);
  //   try {
  //     final response = await _dio.getUri(
  //       uri,
  //       options: options,
  //       cancelToken: cancelToken,
  //       onReceiveProgress: onReceiveProgress,
  //     );
  //     return response;
  //   } on DioError catch (e, stackTrace) {
  //     parseErrorResponse(e);
  //     if (showLoader) hideHUD();
  //   }
  // }
  void parseErrorResponse(DioError e) async {
    // if (ignoreStatusCodes.contains(e.response!.statusCode)) {
    //   return;
    // }
    String errorMessage = e.response!.data['message'];
    print("parseBadRequestError : "+errorMessage);
    if (errorMessage.isEmpty || errorMessage == "") {
      MetaAlert.showErrorAlert(
        title: StringConstants.serverError,
        message: StringConstants.somethingWentwrong,
      );
    } else {
      MetaAlert.showErrorAlert(
        message: errorMessage,
      );
    }
  }
  static String parseBadRequestError(dynamic errorObj) {
    Map errors = {};
    String errorMessage = "";
    try {
      if (errorObj is Map) {
        errorObj.forEach((k, v) {
          print('${k}: ${v}');
          if (v is String) {
            errorMessage += "${k}: ${v} \n";
          } else if (v is List) {
            errorMessage += "${k}: ${v.join(",")} \n";
          }
        });
      } else if (errorObj is List) {
        errorObj.forEach((v) {
          if (v is String) {
            errorMessage += "${v} \n";
          } else if (v is List) {
            errorMessage += "${v.join(",")} \n";
          }
        });
      } else if (errorObj is String) {
        errorMessage = errorObj;
      }
    } catch (e, stackTrace) {

      // Do nothing
    }

    if (errorMessage.isEmpty) {
      errorMessage = "Invalid Request!";
    }
    return errorMessage;
  }
}