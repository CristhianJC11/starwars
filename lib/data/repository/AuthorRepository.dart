
import 'dart:convert';
import 'package:flutter/widgets.dart';
import 'package:starwars/data/model/AuthorResult.dart';
import 'package:starwars/helpers/HttpHelper.dart';
import 'package:starwars/helpers/HttpMethod.dart';

class AuthorRepository{
  final HttpHelper http;
  AuthorRepository({required this.http});

  Future<Map<String,AuthorResult>> getAuthors({ int nextPage = 0}) async {
    String mUrl = "people";
    if(nextPage != 0){
      mUrl+="?page=${nextPage.toString()}";
    }
    final result = await http.requestHttp(
        url: mUrl,
        method: HttpMethod.get,
        headers: {}
    );
    if(result.statusCode > 400){
      debugPrint("Error http ${result.statusCode.toString()}");
    }else{
      final jsonData = jsonDecode(result.body);
      if(jsonData != null){
        return {"Success":AuthorResult.fromJson(jsonData)};
      }
    }
    return {"Error" : AuthorResult()};
  }

}