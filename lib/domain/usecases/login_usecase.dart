import 'package:amk_bank_project/domain/entities/user_entity.dart';
import 'package:amk_bank_project/domain/repositories/auth_repository.dart';

class LoginUseCase {
  final AuthRepository authRepository;

  LoginUseCase({required this.authRepository});

  Future<UserEntity> call(String email, String password) {
    return authRepository.login(email, password);
  }
}
