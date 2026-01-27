import 'package:amk_bank_project/presentation/controllers/auth/signup_state.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'signup_notifier.g.dart';

@riverpod
class SignupNotifier extends  _$SignupNotifier {

  @override

  SignupState build() {
    return const SignupState(
      user: null,
      isLoading: false,
      error: null,
    );
  }
  

  Future<void> signup(String name, String phone, String password, String confirmPassword) async {
    state = state.copyWith(isLoading: true, error: null);

    try {
      // Simulate API call
      await Future.delayed(const Duration(seconds: 2));
      
      // Mock validation or logic
      if (password != confirmPassword) {
         throw Exception('Passwords do not match');
      }

      // Success
      state = state.copyWith(isLoading: false);
    } catch (e) {
      state = state.copyWith(isLoading: false, error: e.toString());
    }
  }
}
