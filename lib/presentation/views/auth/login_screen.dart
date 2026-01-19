import 'package:amk_bank_project/presentation/views/home/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:amk_bank_project/presentation/controllers/auth/login_notifier.dart';

class LoginScreen extends ConsumerWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(loginProvider);

    ref.listen(loginProvider, (previous, next) {
      if (next.user != null && !next.isLoading) {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const HomeScreen()),
        );
      }
    });

    return Scaffold(
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (state.isLoading) const CircularProgressIndicator(),
            if (state.error != null) Text(state.error!),
            if (!state.isLoading)
              ElevatedButton(
                onPressed: () => ref
                    .read(loginProvider.notifier)
                    .login('test@amk.com', 'password123'),
                child: const Text('Login'),
              ),
          ],
        ),
      ),
    );
  }
}
