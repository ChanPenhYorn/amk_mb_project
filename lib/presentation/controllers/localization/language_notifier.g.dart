// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'language_notifier.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(LanguageNotifier)
final languageProvider = LanguageNotifierProvider._();

final class LanguageNotifierProvider
    extends $AsyncNotifierProvider<LanguageNotifier, LanguageState> {
  LanguageNotifierProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'languageProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$languageNotifierHash();

  @$internal
  @override
  LanguageNotifier create() => LanguageNotifier();
}

String _$languageNotifierHash() => r'7e6b4e88814c85f8031017cd0e21bfb98a7357fd';

abstract class _$LanguageNotifier extends $AsyncNotifier<LanguageState> {
  FutureOr<LanguageState> build();
  @$mustCallSuper
  @override
  void runBuild() {
    final ref = this.ref as $Ref<AsyncValue<LanguageState>, LanguageState>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<LanguageState>, LanguageState>,
              AsyncValue<LanguageState>,
              Object?,
              Object?
            >;
    element.handleCreate(ref, build);
  }
}
