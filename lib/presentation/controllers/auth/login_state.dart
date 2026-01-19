import 'package:amk_bank_project/data/models/user_model.dart';

class LoginState {
  final UserModel? user;
  final bool isLoading;
  final String? error;

  LoginState({this.user, this.isLoading = false, this.error});

  LoginState copyWith({UserModel? user, bool? isLoading, String? error}) {
    return LoginState(
      user: user ?? this.user,
      isLoading: isLoading ?? this.isLoading,
      error: error ?? this.error,
    );
  }
}
