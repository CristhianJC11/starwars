
import 'Film.dart';

class FilmResult{
  int? count;
  String? next;
  String? previous;
  List<Film>? results;

  FilmResult({this.count, this.next, this.previous, this.results});

  factory FilmResult.fromJson(Map<String, dynamic> json) {
    return FilmResult(
        count : json['count'],
        next: json['next'],
        previous: json['previous'],
        results: json['results'] != null ? List<Film>.from(json["results"].map((x) => Film.fromJson(x))) : [],
    );
  }
}