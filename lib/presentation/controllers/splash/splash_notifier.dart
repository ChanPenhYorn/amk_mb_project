import 'package:amk_bank_project/presentation/controllers/splash/splash_state.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'splash_notifier.g.dart';

@riverpod
class SplashNotifier extends _$SplashNotifier {
  @override
  FutureOr<SplashState> build() async {
    return const SplashState(isLoading: true);
  }

  Future<void> init() async {
    // Wait for 3 seconds to show splash
    await Future.delayed(const Duration(seconds: 3));
    state = AsyncData(const SplashState(isLoading: false));
  }
}
