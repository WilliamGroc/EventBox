import 'package:wedding_witness_app/features/wedding/domain/entities/song.dart';
import 'package:wedding_witness_app/features/wedding/domain/repositories/song_repository.dart';

class DownloadSong {
  final SongRepository repository;

  DownloadSong(this.repository);

  Future<void> call(Song song) async {
      await repository.downloadSong(song);
  }
}