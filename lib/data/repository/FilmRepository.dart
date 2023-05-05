
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:starwars/data/model/Film.dart';
import 'package:starwars/helpers/HttpHelper.dart';
import 'package:starwars/helpers/HttpMethod.dart';

class FilmRepository{
  final HttpHelper http;
  FilmRepository({required this.http});

  Future<Map<String,Film>> getFilm(String idFilm) async {
    final result = await http.requestHttp(
        url: "films/$idFilm",
        method: HttpMethod.get,
        headers: {}
    );
    if(result.statusCode > 400){
      debugPrint("Error http ${result.statusCode.toString()}");
    }else{
      final jsonData = jsonDecode(result.body);
      if(jsonData != null){
        return {"Success":Film.fromJson(jsonData)};
      }
    }
    return {"Error" : Film()};
  }
}