// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'post_notifier.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(PostNotifier)
final postProvider = PostNotifierProvider._();

final class PostNotifierProvider
    extends $NotifierProvider<PostNotifier, PostState> {
  PostNotifierProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'postProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$postNotifierHash();

  @$internal
  @override
  PostNotifier create() => PostNotifier();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(PostState value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<PostState>(value),
    );
  }
}

String _$postNotifierHash() => r'e75ea7c931c45ab31d049cf44ca9fc6363ebe621';

abstract class _$PostNotifier extends $Notifier<PostState> {
  PostState build();
  @$mustCallSuper
  @override
  void runBuild() {
    final ref = this.ref as $Ref<PostState, PostState>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<PostState, PostState>,
              PostState,
              Object?,
              Object?
            >;
    element.handleCreate(ref, build);
  }
}
