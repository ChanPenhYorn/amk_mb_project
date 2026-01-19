import 'package:amk_bank_project/data/models/post_model.dart';

abstract class PostRemoteDataSource {
  Future<List<PostModel>> getPosts();
}

class PostRemoteDataSourceImpl implements PostRemoteDataSource {
  @override
  Future<List<PostModel>> getPosts() async {
    await Future.delayed(const Duration(seconds: 2)); // simulate API
    return List.generate(
      5,
      (index) => PostModel(
        id: index + 1,
        title: 'Post ${index + 1}',
        body: 'This is the body of post ${index + 1}',
      ),
    );
  }
}
