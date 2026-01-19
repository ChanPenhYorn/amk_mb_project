import 'package:amk_bank_project/data/datasources/post_remote_ds_impl.dart';
import 'package:amk_bank_project/data/models/post_model.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  late PostRemoteDataSourceImpl dataSource;

  setUp(() {
    dataSource = PostRemoteDataSourceImpl();
  });

  group('getPosts', () {
    test('should return a list of PostModel from the simulated API', () async {
      // act
      final result = await dataSource.getPosts();

      // assert
      expect(result, isA<List<PostModel>>());
      expect(result.length, 5);
      expect(result[0].id, 1);
      expect(result[0].title, 'Post 1');
    });
  });
}
