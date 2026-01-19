import 'package:amk_bank_project/data/datasources/post_remote_ds_impl.dart';
import 'package:amk_bank_project/data/repositories/post_repo_impl.dart';
import 'package:amk_bank_project/domain/repositories/post_repository.dart';
import 'package:amk_bank_project/domain/usecases/post_usecase.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final postRemoteDataSourceProvider = Provider<PostRemoteDataSource>((ref) {
  return PostRemoteDataSourceImpl();
});

final postRepositoryProvider = Provider<PostRepository>((ref) {
  return PostRepositoryImpl(
    postRemoteDataSource: ref.read(postRemoteDataSourceProvider),
  );
});

final postUseCaseProvider = Provider<PostUseCase>((ref) {
  return PostUseCase(postRepository: ref.read(postRepositoryProvider));
});
