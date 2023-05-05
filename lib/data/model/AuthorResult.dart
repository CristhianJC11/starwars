
import 'Author.dart';

class AuthorResult{
  int? count;
  String? next;
  String? previous;
  List<Author>? results;

  AuthorResult({this.count, this.next, this.previous, this.results});

  factory AuthorResult.fromJson(Map<String, dynamic> json) {
    return AuthorResult(
      count : json['count'],
      next: json['next'],
      previous: json['previous'],
      results: json['results'] != null ? List<Author>.from(json["results"].map((x) => Author.fromJson(x))) : [],
    );
  }
}