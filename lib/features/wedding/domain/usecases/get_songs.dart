import 'package:wedding_witness_app/features/wedding/domain/entities/song.dart';
import 'package:wedding_witness_app/features/wedding/domain/repositories/song_repository.dart';

class GetSongs {
  final SongRepository repository;

  GetSongs(this.repository);

  Future<List<Song>> call() async {
    List<Song> songs = await repository.getSongs();

    await Future.wait(songs.map((song) => repository.downloadSong(song)));

    return songs;
  }
}
