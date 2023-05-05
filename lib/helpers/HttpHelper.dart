
import 'dart:convert';

import 'package:starwars/helpers/HttpMethod.dart';
import 'package:http/http.dart' as http;

class HttpHelper {
  String baseUrl;
  // Constructor
  HttpHelper({required this.baseUrl});

  // Method to parse body
  dynamic _parseBody(dynamic body){
    try{
      return jsonEncode(body);
    }catch(_){
      return body;
    }
  }

  Future<http.Response> requestHttp(
      { required String url,
        required HttpMethod method,
        required Map<String, String> headers,
        Map<String, dynamic> queryParameters = const {},
        Map<String, dynamic> body = const {}
      }
    ) async {
    Uri finalUrl = Uri.parse("$baseUrl/$url");
    http.Response response;

    // check headers
    if(headers.isEmpty || headers["Content-Type"] == null){
        headers.addAll({"": "application/json; charset=UTF-8"}); // add Content type
    }

    // Check parameters
    if(queryParameters.isNotEmpty){
      finalUrl = finalUrl.replace(
          queryParameters: {
            ...finalUrl.queryParameters,
            ...queryParameters // add query parameters
          }
      );
    }

    // type method
    switch(method){
      case HttpMethod.get:
        response = await http.get(finalUrl,headers: headers);
        break;
      case HttpMethod.post:
        response = await http.post(finalUrl,headers: headers,body: _parseBody(body));
        break;
      case HttpMethod.put:
        response = await http.put(finalUrl,headers: headers,body: _parseBody(body));
        break;
      case HttpMethod.delete:
        response = await http.delete(finalUrl,headers: headers,body: _parseBody(body));
        break;
    }

    return response;

  }


}