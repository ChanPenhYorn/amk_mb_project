import 'package:amk_bank_project/data/models/name_model.dart';

class CountryState {
  final List<NameModel> countries;
  final NameModel? selectedCountry;

  CountryState({required this.countries, this.selectedCountry});

  CountryState copyWith({
    List<NameModel>? countries,
    NameModel? selectedCountry,
  }) {
    return CountryState(
      countries: countries ?? this.countries,
      selectedCountry: selectedCountry ?? this.selectedCountry,
    );
  }
}
