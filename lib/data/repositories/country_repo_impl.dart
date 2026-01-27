import 'package:amk_bank_project/data/datasources/country_remote_ds_imp.dart';
import 'package:amk_bank_project/data/models/name_model.dart';
import 'package:amk_bank_project/domain/repositories/country_repsoitory.dart';

class CountryRepositoryImp implements CountryRepository {
  final CountryRemoteDataSource countryRemoteDataSource;

  CountryRepositoryImp({required this.countryRemoteDataSource});

  @override
  Future<List<NameModel>> getCountries() {
    return countryRemoteDataSource.getCountries();
  }
}
