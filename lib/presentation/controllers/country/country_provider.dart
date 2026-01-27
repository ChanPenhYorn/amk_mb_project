import 'package:amk_bank_project/data/datasources/country_remote_ds_imp.dart';
import 'package:amk_bank_project/data/repositories/country_repo_impl.dart';
import 'package:amk_bank_project/domain/repositories/country_repsoitory.dart';
import 'package:amk_bank_project/domain/usecases/country_usecase.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final countryRemoteDataSourceProvider = Provider<CountryRemoteDataSource>((
  ref,
) {
  return CountryRemoteDataSourceImp();
});

final countryRepositoryProvider = Provider<CountryRepository>((ref) {
  return CountryRepositoryImp(
    countryRemoteDataSource: ref.read(countryRemoteDataSourceProvider),
  );
});

final countryUseCaseProvider = Provider<CountryUseCase>((ref) {
  return CountryUseCase(countryRepository: ref.read(countryRepositoryProvider));
});
