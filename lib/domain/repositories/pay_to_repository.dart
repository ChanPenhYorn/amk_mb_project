import 'package:amk_bank_project/data/models/name_model.dart';

abstract class PayToRepository {
  Future<List<NameModel>> getAccounts();
  Future<List<NameModel>> getPurposes();
}
