// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'song_controller.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(SongController)
final songControllerProvider = SongControllerProvider._();

final class SongControllerProvider
    extends $AsyncNotifierProvider<SongController, List<Song>> {
  SongControllerProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'songControllerProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$songControllerHash();

  @$internal
  @override
  SongController create() => SongController();
}

String _$songControllerHash() => r'dae2f301f795af427c9ad08ddfb7fbfa62851b98';

abstract class _$SongController extends $AsyncNotifier<List<Song>> {
  FutureOr<List<Song>> build();
  @$mustCallSuper
  @override
  void runBuild() {
    final ref = this.ref as $Ref<AsyncValue<List<Song>>, List<Song>>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<List<Song>>, List<Song>>,
              AsyncValue<List<Song>>,
              Object?,
              Object?
            >;
    element.handleCreate(ref, build);
  }
}
