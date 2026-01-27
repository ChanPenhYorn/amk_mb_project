import 'package:amk_bank_project/data/models/post_model.dart';

class PostState {
  final bool isLoading;
  final List<PostModel> posts;
  final String? error;

  PostState({this.isLoading = false, this.posts = const [], this.error});

  PostState copyWith({bool? isLoading, List<PostModel>? posts, String? error}) {
    return PostState(
      isLoading: isLoading ?? this.isLoading,
      posts: posts ?? this.posts,
      error: error ?? this.error,
    );
  }
}
