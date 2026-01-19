import 'package:amk_bank_project/presentation/controllers/theme/theme_stat.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'theme_notifier.g.dart';

@riverpod
class ThemeNotifier extends _$ThemeNotifier {
  @override
  ThemeState build() {
    return ThemeState(isDarkMode: false);
  }

  void toggleTheme() {
    state = state.copyWith(isDarkMode: !state.isDarkMode!);
  }
}
