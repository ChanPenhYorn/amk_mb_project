import 'package:amk_bank_project/data/datasources/post_remote_ds_impl.dart';
import 'package:amk_bank_project/data/models/post_model.dart';
import 'package:amk_bank_project/domain/repositories/post_repository.dart';

class PostRepositoryImpl implements PostRepository {
  final PostRemoteDataSource postRemoteDataSource;

  PostRepositoryImpl({required this.postRemoteDataSource});

  @override
  Future<List<PostModel>> getPosts() async {
    return await postRemoteDataSource.getPosts();
  }
}
