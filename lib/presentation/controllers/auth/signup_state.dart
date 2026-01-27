

import 'package:amk_bank_project/data/models/user_model.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'signup_state.freezed.dart';

@freezed
abstract class SignupState with _$SignupState {
  const factory SignupState({
    required UserModel? user,
    required bool isLoading,
    required String? error,
  }) = _SignupState;
}
