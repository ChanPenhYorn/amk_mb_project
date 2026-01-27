import 'package:amk_bank_project/data/datasources/pay_to_remote_ds_impl.dart';
import 'package:amk_bank_project/data/repositories/pay_to_rep_impl.dart';
import 'package:amk_bank_project/domain/usecases/pay_to_usecase.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final payRemoteDataSourceProvider = Provider<PayRemoteDataSource>((ref) {
  return PayToRemoteDSImpl();
});

final payRepositoryProvider = Provider<PayToRepositoryImpl>((ref) {
  return PayToRepositoryImpl(
    payRemoteDataSource: ref.read(payRemoteDataSourceProvider),
  );
});

final payToUseCaseProvider = Provider<PayToUseCase>((ref) {
  return PayToUseCase(repository: ref.read(payRepositoryProvider));
});
