import 'package:amk_bank_project/data/models/name_model.dart';

abstract class CountryRepository {
  Future<List<NameModel>> getCountries();
}
