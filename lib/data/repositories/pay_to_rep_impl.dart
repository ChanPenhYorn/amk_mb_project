import 'package:amk_bank_project/data/datasources/pay_to_remote_ds_impl.dart';
import 'package:amk_bank_project/data/models/name_model.dart';
import 'package:amk_bank_project/domain/repositories/pay_to_repository.dart';

class PayToRepositoryImpl implements PayToRepository {
  final PayRemoteDataSource payRemoteDataSource;

  PayToRepositoryImpl({required this.payRemoteDataSource});

  @override
  Future<List<NameModel>> getAccounts() {
    return payRemoteDataSource.getAccounts();
  }

  @override
  Future<List<NameModel>> getPurposes() {
    return payRemoteDataSource.getPurposes();
  }
}
