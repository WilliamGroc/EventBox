import 'package:wedding_witness_app/features/wedding/data/datasources/song_datasource.dart';
import 'package:wedding_witness_app/features/wedding/domain/entities/song.dart';
import 'package:wedding_witness_app/features/wedding/domain/repositories/song_repository.dart';

class SongRepositoriesImpl implements SongRepository {
  final SongDataSource localDataSource;

  SongRepositoriesImpl({required this.localDataSource});

  @override
  Future<List<Song>> getSongs() async {
    return await localDataSource.getSongs();
  }

  @override
  Future<String> downloadSong(Song song) async {
    return await localDataSource.downloadSong(song);
  }
}