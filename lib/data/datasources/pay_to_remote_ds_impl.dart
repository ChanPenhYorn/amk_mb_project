import 'package:amk_bank_project/data/models/name_model.dart';

abstract class PayRemoteDataSource {
  Future<List<NameModel>> getAccounts();

  Future<List<NameModel>> getPurposes();
}

class PayToRemoteDSImpl implements PayRemoteDataSource {
  @override
  Future<List<NameModel>> getAccounts() {
    return Future.delayed(
      const Duration(seconds: 2),
      () => [
        NameModel(id: 1, name: '507 685 45 | KHR'),
        NameModel(id: 2, name: '507 685 45 | USD'),
      ],
    );
  }

  @override
  Future<List<NameModel>> getPurposes() {
    return Future.delayed(
      const Duration(seconds: 2),
      () => [
        NameModel(id: 1, name: 'Shop'),
        NameModel(id: 2, name: 'Transfer'),
        NameModel(id: 3, name: 'Pay'),
      ],
    );
  }
}
