import 'package:amk_bank_project/data/datasources/auth_remote_ds_impl.dart';
import 'package:amk_bank_project/data/models/user_model.dart';
import 'package:amk_bank_project/domain/repositories/auth_repository.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDataSource authRemoteDataSource;

  AuthRepositoryImpl({required this.authRemoteDataSource});

  @override
  Future<UserModel> login(String email, String password) {
    return authRemoteDataSource.login(email, password);
  }
}
