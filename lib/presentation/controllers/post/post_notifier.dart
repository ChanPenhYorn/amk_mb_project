import 'package:amk_bank_project/data/models/post_model.dart';
import 'package:amk_bank_project/presentation/controllers/post/post_provider.dart';
import 'package:amk_bank_project/presentation/controllers/post/post_state.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'post_notifier.g.dart';

@riverpod
class PostNotifier extends _$PostNotifier {
  @override
  PostState build() {
    return PostState();
  }

  Future<void> getPosts() async {
    state = state.copyWith(isLoading: true, error: null);

    try {
      final postUseCase = ref.read(postUseCaseProvider);
      final posts = await postUseCase.getPosts();

      if (posts.isEmpty) {
        state = state.copyWith(posts: [], isLoading: false);
      } else {
        state = state.copyWith(
          posts: posts as List<PostModel>,
          isLoading: false,
        );
      }
    } catch (e) {
      state = state.copyWith(isLoading: false, error: e.toString());
    }
  }
}
