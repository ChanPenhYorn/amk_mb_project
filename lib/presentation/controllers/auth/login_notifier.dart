import 'package:amk_bank_project/data/models/user_model.dart';
import 'package:amk_bank_project/presentation/controllers/auth/login_provider.dart';
import 'package:amk_bank_project/presentation/controllers/auth/login_state.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'login_notifier.g.dart';

@riverpod
class Login extends _$Login {
  @override
  LoginState build() {
    return LoginState();
  }

  Future<void> login(String email, String password) async {
    state = state.copyWith(isLoading: true, error: null);

    try {
      final loginUseCase = ref.read(loginUseCaseProvider);
      final user = await loginUseCase(email, password);
      state = state.copyWith(user: user as UserModel, isLoading: false);
    } catch (e) {
      state = state.copyWith(isLoading: false, error: e.toString());
    }
  }
}
