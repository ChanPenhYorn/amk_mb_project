// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'pay_notifier.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(PayNotifier)
final payProvider = PayNotifierProvider._();

final class PayNotifierProvider
    extends $NotifierProvider<PayNotifier, PayState> {
  PayNotifierProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'payProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$payNotifierHash();

  @$internal
  @override
  PayNotifier create() => PayNotifier();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(PayState value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<PayState>(value),
    );
  }
}

String _$payNotifierHash() => r'8fa966b932fb7fd46cdf5f44beaa86755036daa6';

abstract class _$PayNotifier extends $Notifier<PayState> {
  PayState build();
  @$mustCallSuper
  @override
  void runBuild() {
    final ref = this.ref as $Ref<PayState, PayState>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<PayState, PayState>,
              PayState,
              Object?,
              Object?
            >;
    element.handleCreate(ref, build);
  }
}
