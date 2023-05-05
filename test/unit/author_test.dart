
import 'package:flutter_test/flutter_test.dart';
import 'package:starwars/data/model/Author.dart';

void main(){
  group("AuthorModel Test", () {

    Map<String, dynamic> authorModelAsJson = {
      "name": "John Doe",
      "height": "254",
    };
    Author authorModel = Author(
        name: "John Doe",
        height: "254"
    );

    test('Test using json - Done', () {
      expect(Author.fromJson(authorModelAsJson).name, authorModel.name);
    });

    authorModelAsJson = {
      "name": "John Doe",
      "height": 254,
    };
    authorModel = Author(
        name: "John Doe",
        height: "254"
    );

    test('Test numeric value', () {
      expect(Author.fromJson(authorModelAsJson).height, authorModel.height);
    });

  });
}