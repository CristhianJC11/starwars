
import 'package:flutter/material.dart';
import 'package:starwars/data/model/Author.dart';
import 'package:starwars/data/model/AuthorResult.dart';
import 'package:starwars/data/repository/AuthorRepository.dart';
import 'package:starwars/helpers/HttpHelper.dart';

class AuthorsViewModel extends ChangeNotifier{
  final HttpHelper http;
  AuthorsViewModel({required this.http});

  late final AuthorRepository _authorRepository = AuthorRepository(http: http);

  /// List authors
  List<Author> _listAuthors = [];
  List<Author> get listAuthors => _listAuthors;
  set listAuthors(List<Author> value) {
    _listAuthors = value;
    notifyListeners();
  }
  List<Author> _originList = [];

  /// Filter
  FilterAuthor _filterSelected = FilterAuthor.none;
  FilterAuthor get filterSelected => _filterSelected;
  set filterSelected(FilterAuthor value) {
    _filterSelected = value;
    notifyListeners();
  }

  /// Pagination values
  int _nextPage= 0;
  int get nextPage => _nextPage;
  set nextPage(int value) {
    _nextPage = value;
    notifyListeners();
  }

  /// Loading pagination
  bool _isLoadingNext = false;
  bool get isLoadingNext => _isLoadingNext;
  set isLoadingNext(bool value) {
    _isLoadingNext = value;
    notifyListeners();
  }

  /// Is loading values
  bool _isLoadingList = false;
  bool get isLoadingList => _isLoadingList;
  set isLoadingList(bool value) {
    _isLoadingList = value;
    notifyListeners();
  }

  /// Is error Values
  bool _isNetworkError = false;
  bool get isNetworkError => _isNetworkError;
  set isNetworkError(bool value) {
    _isNetworkError = value;
    notifyListeners();
  }

  Future<AuthorResult> _getAuthors({bool loadNextPage = false}) async{
    final tempResult = await _authorRepository.getAuthors(nextPage: loadNextPage? nextPage : 0);
    if(tempResult["Error"] != null){
      if(!loadNextPage) {
        isNetworkError = true;
      }
    }else {
      isNetworkError = false;
    }
    return tempResult["Success"]??AuthorResult();
  }

  void getListAuthors() async{
      filterSelected = FilterAuthor.none;
      isLoadingList = true;
      final result = await _getAuthors(loadNextPage: false);
      if (result.results != null) {
        listAuthors = result.results ?? [];
        nextPage = int.tryParse((result.next ?? "")
            .split("page=")
            .last) ?? 0;
      }
      isLoadingList = false;
  }

  void loadNextPage() async{
    if(filterSelected == FilterAuthor.none) {
      isLoadingNext = true;
      final result = await _getAuthors(loadNextPage: true);
      if (result.results != null) {
        listAuthors = [
          ...listAuthors,
          ...result.results ?? []
        ];
        nextPage = int.tryParse((result.next ?? "")
            .split("page=")
            .last) ?? -1;
      }
      isLoadingNext = false;
    }
  }

  void filterListAuthors({FilterAuthor filterAuthor = FilterAuthor.none}) async{
    filterSelected = filterAuthor;
    if(_originList.isEmpty){
      _originList = listAuthors;
    }
    if(filterAuthor != FilterAuthor.none){
      listAuthors = _originList.where((author) => (author.gender??"") == filterAuthor.name).toList();
    }else{
      listAuthors = _originList;
      _originList = [];
    }
  }

}
enum FilterAuthor {
  male, female, none
}