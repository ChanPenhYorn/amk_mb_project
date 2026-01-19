import 'package:amk_bank_project/data/datasources/post_remote_ds_impl.dart';
import 'package:amk_bank_project/data/models/post_model.dart';
import 'package:amk_bank_project/data/repositories/post_repo_impl.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockPostRemoteDataSource extends Mock implements PostRemoteDataSource {}

void main() {
  late PostRepositoryImpl repository;
  late MockPostRemoteDataSource mockRemoteDataSource;

  setUp(() {
    mockRemoteDataSource = MockPostRemoteDataSource();
    repository = PostRepositoryImpl(postRemoteDataSource: mockRemoteDataSource);
  });

  final tPostModels = [
    PostModel(id: 1, title: 'Test 1', body: 'Body 1'),
    PostModel(id: 2, title: 'Test 2', body: 'Body 2'),
  ];

  group('getPosts', () {
    test(
      'should return remote data when the call to remote data source is successful',
      () async {
        // arrange
        when(
          () => mockRemoteDataSource.getPosts(),
        ).thenAnswer((_) async => tPostModels);

        // act
        final result = await repository.getPosts();

        // assert
        verify(() => mockRemoteDataSource.getPosts());
        expect(result, equals(tPostModels));
      },
    );

    test(
      'should throw an exception when the call to remote data source is unsuccessful',
      () async {
        // arrange
        when(
          () => mockRemoteDataSource.getPosts(),
        ).thenThrow(Exception('API Error'));

        // act
        final call = repository.getPosts;

        // assert
        expect(() => call(), throwsException);
        verify(() => mockRemoteDataSource.getPosts());
      },
    );
  });
}
