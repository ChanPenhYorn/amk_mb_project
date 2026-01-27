import 'package:amk_bank_project/core/utils/app_logger.dart';
import 'package:amk_bank_project/data/models/name_model.dart';
import 'package:amk_bank_project/presentation/controllers/country/country_provider.dart';
import 'package:amk_bank_project/presentation/controllers/country/country_state.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'country_notifier.g.dart';

@riverpod
class CountryNotifier extends _$CountryNotifier {
  @override
  CountryState build() {
    loadCountries();
    return CountryState(countries: []);
  }

  Future<void> loadCountries() async {
    try {
      final countries = await ref.read(countryUseCaseProvider).getCountries();
      state = state.copyWith(
        countries: countries,
        selectedCountry: countries.first,
      );
    } catch (e) {
      // Handle error if necessary
      AppLogger.logError('Error loading countries: $e');
    }
  }

  void selectCountry(NameModel country) {
    state = state.copyWith(selectedCountry: country);
  }
}
