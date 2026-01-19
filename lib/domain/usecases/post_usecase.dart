import 'package:amk_bank_project/domain/entities/post_entity.dart';
import 'package:amk_bank_project/domain/repositories/post_repository.dart';

class PostUseCase {
  final PostRepository postRepository;

  PostUseCase({required this.postRepository});

  Future<List<PostEntity>> getPosts() async {
    return await postRepository.getPosts();
  }
}
