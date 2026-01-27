import 'package:amk_bank_project/presentation/controllers/post/post_notifier.dart';
import 'package:amk_bank_project/presentation/controllers/post/post_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class PostsView extends ConsumerWidget {
  const PostsView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(postProvider);

    // React to errors
    ref.listen<PostState>(postProvider, (prev, next) {
      if (next.error != null) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text(next.error!)));
      }
    });

    return Scaffold(
      appBar: AppBar(title: const Text("Posts")),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (state.isLoading) const CircularProgressIndicator(),
            if (state.posts.isNotEmpty)
              Expanded(
                child: ListView.builder(
                  itemCount: state.posts.length,
                  itemBuilder: (context, index) {
                    final post = state.posts[index];
                    return ListTile(
                      title: Text(post.title),
                      subtitle: Text(post.body),
                    );
                  },
                ),
              ),
            ElevatedButton(
              onPressed: () => ref.read(postProvider.notifier).getPosts(),
              child: const Text("Fetch Posts"),
            ),
          ],
        ),
      ),
    );
  }
}
