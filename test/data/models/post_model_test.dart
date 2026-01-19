import 'package:amk_bank_project/data/models/post_model.dart';
import 'package:amk_bank_project/domain/entities/post_entity.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  final tPostModel = PostModel(id: 1, title: 'Test Title', body: 'Test Body');

  test('should be a subclass of PostEntity', () async {
    // assert
    expect(tPostModel, isA<PostEntity>());
  });

  group('fromJson', () {
    test('should return a valid model when the JSON is correct', () async {
      // arrange
      final Map<String, dynamic> jsonMap = {
        'id': 1,
        'title': 'Test Title',
        'body': 'Test Body',
      };

      // act
      final result = PostModel.fromJson(jsonMap);

      // assert
      expect(result.id, tPostModel.id);
      expect(result.title, tPostModel.title);
      expect(result.body, tPostModel.body);
    });
  });
}
