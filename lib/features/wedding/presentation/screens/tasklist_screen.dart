import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wedding_witness_app/features/wedding/presentation/controller/song_controller.dart';
import 'package:wedding_witness_app/features/wedding/presentation/controller/task_controller.dart';
import 'package:wedding_witness_app/features/wedding/presentation/widgets/music.widget.dart';

class ChecklistScreen extends ConsumerWidget {
  const ChecklistScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final tasks = ref.watch(taskControllerProvider);
    final songs = ref.watch(songControllerProvider);

    return Scaffold(
      body: tasks.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, stack) => Center(child: Text('Erreur : $error')),
        data: (tasks) {
          final songMap = {
            for (final s in songs.asData?.value ?? []) s.id: s,
          };
          return ListView.builder(
            itemCount: tasks.length,
            itemBuilder: (context, index) {
              final task = tasks[index];
              final startTime = task.startTime ?? '';
              final title = task.title ?? '';
              final linkedSong =
                  task.songId != null ? songMap[task.songId] : null;

              return CheckboxListTile(
                title: Text("$startTime $title"),
                value: task.isCompleted,
                secondary: linkedSong != null
                    ? IconButton(
                        tooltip: 'Jouer : ${linkedSong.title}',
                        icon: const Icon(Icons.play_circle_outline),
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) =>
                                  MusicPlayerScreen(song: linkedSong),
                            ),
                          );
                        },
                      )
                    : null,
                onChanged: (_) {
                  ref
                      .read(taskControllerProvider.notifier)
                      .toggleTaskCompletion(task);
                },
              );
            },
          );
        },
      ),
    );
  }
}
