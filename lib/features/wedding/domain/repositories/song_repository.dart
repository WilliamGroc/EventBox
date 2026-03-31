import 'package:wedding_witness_app/features/wedding/domain/entities/song.dart';

abstract class SongRepository {
  Future<List<Song>> getSongs();
  Future<String> downloadSong(Song song);
}
