import 'package:amk_bank_project/data/models/name_model.dart';
import 'package:amk_bank_project/domain/repositories/pay_to_repository.dart';

class PayToUseCase {
  final PayToRepository repository;

  PayToUseCase({required this.repository});

  Future<List<NameModel>> getAccounts() async {
    return repository.getAccounts();
  }

  Future<List<NameModel>> getPurposes() async {
    return repository.getPurposes();
  }
}
