import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wedding_witness_app/features/wedding/presentation/controller/task_controller.dart';

class ChecklistScreen extends ConsumerWidget {
  const ChecklistScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final tasks = ref.watch(taskControllerProvider);

    return Scaffold(
      body: tasks.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, stack) => Center(child: Text('Erreur : $error')),
        data: (tasks) {
          return ListView.builder(
            itemCount: tasks.length,
            itemBuilder: (context, index) {
              final task = tasks[index];
              return CheckboxListTile(
                title: Text(task.title),
                value: task.isCompleted,
                onChanged: (value) {
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
