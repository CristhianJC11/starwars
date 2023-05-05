import 'package:flutter_test/flutter_test.dart';
import 'package:starwars/data/model/Author.dart';
import 'package:starwars/helpers/HttpHelper.dart';
import 'package:starwars/viewmodel/AuthorsViewModel.dart';

void main() {
  group("AuthorViewModel Test", () {
    final provider = AuthorsViewModel(http: HttpHelper(baseUrl: ""));

    test("Get authors - Done", () async {
      provider.listAuthors = [Author(name: "John", gender: null)];
      expect(provider.listAuthors.isNotEmpty, equals(true),
          reason: "Test status");
      expect(provider.listAuthors.first.name, equals("John"));
    });

    test("Get authors - Empty result", () async {
      provider.listAuthors = [];
      provider.isNetworkError = true;
      expect(provider.listAuthors.isEmpty, equals(true), reason: "Test status");
      expect(provider.isNetworkError, equals(true));
    });

    test("Get authors - Loading status", () async {
      provider.isLoadingList = true;
      expect(provider.isLoadingList, equals(true), reason: "Test status");
      provider.isLoadingList = false;
      expect(provider.isLoadingList, equals(false), reason: "Test status");
    });


  });
}
