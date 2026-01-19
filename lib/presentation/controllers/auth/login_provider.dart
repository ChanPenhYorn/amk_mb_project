import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:amk_bank_project/data/datasources/auth_remote_ds_impl.dart';
import 'package:amk_bank_project/data/repositories/auth_repo_impl.dart';
import 'package:amk_bank_project/domain/repositories/auth_repository.dart';
import 'package:amk_bank_project/domain/usecases/login_usecase.dart';

final authRemoteDataSourceProvider = Provider<AuthRemoteDataSource>((ref) {
  return AuthRemoteDataSourceImpl();
});

final authRepositoryProvider = Provider<AuthRepository>((ref) {
  final remote = ref.read(authRemoteDataSourceProvider);
  return AuthRepositoryImpl(authRemoteDataSource: remote);
});

final loginUseCaseProvider = Provider<LoginUseCase>((ref) {
  final repo = ref.read(authRepositoryProvider);
  return LoginUseCase(authRepository: repo);
});
