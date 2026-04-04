

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wedding_witness_app/features/wedding/domain/entities/song.dart';
import 'package:wedding_witness_app/features/wedding/presentation/controller/song_controller.dart';
import 'package:wedding_witness_app/features/wedding/presentation/widgets/music.widget.dart';

class SongsScreen extends ConsumerWidget {
  const SongsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final songs = ref.watch(songControllerProvider);

    return Scaffold(
      body: songs.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, stack) => Center(child: Text('Erreur : $error')),
        data: (songs) {
          final grouped = _groupByMoment(songs);
          final moments = grouped.keys.toList()..sort();

          return ListView.builder(
            padding: const EdgeInsets.symmetric(vertical: 8),
            itemCount: moments.length,
            itemBuilder: (context, idx) {
              final moment = moments[idx];
              final momentSongs = grouped[moment]!;
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.fromLTRB(16, 16, 16, 4),
                    child: Text(
                      moment.isEmpty ? 'Autres' : moment,
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                    ),
                  ),
                  const Divider(height: 1),
                  ...momentSongs.map((song) => ListTile(
                        leading: const Icon(Icons.music_note),
                        title: Text(song.title),
                        subtitle: Text(song.fileName),
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => MusicPlayerScreen(song: song),
                            ),
                          );
                        },
                      )),
                ],
              );
            },
          );
        },
      ),
    );
  }

  Map<String, List<Song>> _groupByMoment(List<Song> songs) {
    final map = <String, List<Song>>{};
    for (final song in songs) {
      (map[song.moment] ??= []).add(song);
    }
    return map;
  }
}
