
import 'package:flutter/cupertino.dart';
import 'package:starwars/data/model/Film.dart';
import 'package:starwars/data/repository/FilmRepository.dart';
import 'package:starwars/helpers/HttpHelper.dart';

class FilmViewModel extends ChangeNotifier{
  final HttpHelper http;
  FilmViewModel({ required this.http});

  late final FilmRepository _filmRepository = FilmRepository(http: http);

  /// List films
  List<Film> _listFilms = [];
  List<Film> get listFilms => _listFilms;
  set listFilms(List<Film> value) {
    _listFilms = value;
    notifyListeners();
  }

  /// Loading
  bool _isLoading = false;
  bool get isLoading => _isLoading;
  set isLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  void getFilms(List<String> films) async{
    listFilms = [];
    isLoading = true;
    String idFilm = "";
    for (var film in films) { 
      idFilm = film.split("films/").last;
      if(idFilm.isNotEmpty){
        final resul = await _filmRepository.getFilm(idFilm);
        if(resul["Success"] != null){
          isLoading = false;
          listFilms = [
            ...listFilms,
            resul["Success"]!
          ];
        }
      }
    }
    isLoading = false;
  }
  
}