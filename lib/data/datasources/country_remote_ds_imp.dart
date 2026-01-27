import 'package:amk_bank_project/data/models/name_model.dart';

abstract class CountryRemoteDataSource {
  Future<List<NameModel>> getCountries();
}

class CountryRemoteDataSourceImp implements CountryRemoteDataSource {
  @override
  Future<List<NameModel>> getCountries() {
    List<NameModel> countries = [
      NameModel(id: 1, name: 'Cambodia'),
      NameModel(id: 2, name: 'Thailand'),
      NameModel(id: 3, name: 'Vietnam'),
    ];

    return Future.delayed(const Duration(seconds: 2), () => countries);
  }
}
