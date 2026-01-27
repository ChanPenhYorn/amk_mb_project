import 'package:amk_bank_project/data/models/name_model.dart';
import 'package:amk_bank_project/domain/repositories/country_repsoitory.dart';

class CountryUseCase {
  final CountryRepository countryRepository;

  CountryUseCase({required this.countryRepository});

  Future<List<NameModel>> getCountries() {
    return countryRepository.getCountries();
  }
}
