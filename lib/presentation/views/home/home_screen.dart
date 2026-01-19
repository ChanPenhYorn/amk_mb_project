import 'package:amk_bank_project/presentation/controllers/theme/theme_notifier.dart';
import 'package:amk_bank_project/presentation/views/post/post_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(themeProvider);
    return Scaffold(
      appBar: AppBar(title: const Text('Home')),
      body: Center(
        child: Column(
          children: [
            Text("Home Screen"),

            Text(
              state.isDarkMode == true ? "Dark Mode ON" : "Dark Mode OFF",
              style: const TextStyle(fontSize: 18),
            ),
            ElevatedButton(
              onPressed: () => ref.read(themeProvider.notifier).toggleTheme(),
              child: const Text('Toggle Theme'),
            ),

            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const PostsView()),
                );
              },
              child: const Text('Posts'),
            ),
          ],
        ),
      ),
    );
  }
}
