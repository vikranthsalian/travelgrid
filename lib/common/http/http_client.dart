import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:travelgrid/common/constants/flavour_constants.dart';

class HttpClient {
  static final HttpClient _instance = HttpClient.internal();
  HttpClient.internal();
  factory HttpClient() => _instance;
  String baseUrl = FlavourConstants.apiHost;

  Future<dynamic> postQuery(String url,String body,ogContent, [ bool useToken = true, String? languageCode ]) async {

    Map<String, String> headers = {"Content-Type": "text/html"};
    print(baseUrl);
    http.Response response = await http.post(
      Uri.parse(baseUrl),
      body: body,
      headers: headers,
    );
    return response.body;

  }


  // dynamic _response(http.Response response) {
  //   try {
  //     switch (response.statusCode) {
  //       case 200:
  //       case 201:
  //         return _jsonDecoder.convert(response.body);
  //       case 401:
  //         throw SessionException(
  //             errorId: '401',
  //             errorMessage: "Constants.sessionExpiredPleaseLoginAgain");
  //       case 400:
  //       case 403:
  //       case 422:
  //       case 404:
  //         throw AuthException(response.statusCode,
  //             _jsonDecoder.convert(response.body)["message"]);
  //       case 500:
  //         throw AuthException(
  //             response.statusCode, StringConstants.somethingWentWrong);
  //       default:
  //         throw AuthException(
  //             response.statusCode, StringConstants.somethingWentWrong);
  //         // return Exception(
  //         //     'Error occured while Communication with Server with StatusCode : ${response
  //         //         .statusCode}');
  //     }
  //   }
  //   catch(e) {
  //     if(e is AuthException) {
  //       return e;
  //     }
  //     return AuthException(-1, e.toString());
  //   }
  // }


}



