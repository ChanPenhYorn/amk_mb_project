// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'country_notifier.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(CountryNotifier)
final countryProvider = CountryNotifierProvider._();

final class CountryNotifierProvider
    extends $NotifierProvider<CountryNotifier, CountryState> {
  CountryNotifierProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'countryProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$countryNotifierHash();

  @$internal
  @override
  CountryNotifier create() => CountryNotifier();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(CountryState value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<CountryState>(value),
    );
  }
}

String _$countryNotifierHash() => r'cea94cefef04242f4247908fb8440052651e2a56';

abstract class _$CountryNotifier extends $Notifier<CountryState> {
  CountryState build();
  @$mustCallSuper
  @override
  void runBuild() {
    final ref = this.ref as $Ref<CountryState, CountryState>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<CountryState, CountryState>,
              CountryState,
              Object?,
              Object?
            >;
    element.handleCreate(ref, build);
  }
}
