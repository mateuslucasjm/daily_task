import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../models/task.dart';
import '../services/task_service.dart';
import '../widgets/add_button.dart';
import '../widgets/empty_state.dart';
import '../widgets/task_card.dart';
import 'add_task_screen.dart';

class TasksScreen extends StatefulWidget {
  final DateTime selectedDate;

  const TasksScreen({super.key, required this.selectedDate});

  @override
  State<TasksScreen> createState() => _TasksScreenState();
}

class _TasksScreenState extends State<TasksScreen> {
  final TaskService service = TaskService();

  Future<void> addTask() async {
    final result = await Navigator.push<Task>(
      context,
      MaterialPageRoute(builder: (_) => AddTaskScreen(selectedDate: widget.selectedDate)),
    );

    if (result != null) {
      await service.addTask(widget.selectedDate, result);
    }
  }

  List<Task> sortTasks(List<Task> tasks) {
    final pending = tasks.where((t) => !t.completed).toList()
      ..sort((a, b) => a.title.compareTo(b.title));

    final done = tasks.where((t) => t.completed).toList()
      ..sort((a, b) => a.title.compareTo(b.title));

    return [...pending, ...done];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F7FB),

      appBar: AppBar(
        backgroundColor: const Color(0xFFF5F7FB),
        elevation: 0,
        centerTitle: true,
        toolbarHeight: 90,
        title: Padding(
          padding: const EdgeInsets.only(top: 12),
          child: Text(
            "Tarefas - ${DateFormat('dd/MM/yyyy').format(widget.selectedDate)}",
            style: const TextStyle(
              fontSize: 28,
              fontWeight: FontWeight.bold,
              color: Color(0xFF448AFF),
            ),
          ),
        ),
      ),

      body: Padding(
        padding: const EdgeInsets.all(16),
        child: StreamBuilder<List<Task>>(
          stream: service.streamTasks(widget.selectedDate),
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return const Center(child: CircularProgressIndicator());
            }

            final tasks = snapshot.data!;

            if (tasks.isEmpty) {
              return const EmptyState();
            }

            final sortedTasks = sortTasks(tasks);

            return ListView.builder(
              itemCount: sortedTasks.length,
              itemBuilder: (context, index) {
                final task = sortedTasks[index];

                return TaskCard(
                  task: task,
                  onToggle: () {
                    task.completed = !task.completed;
                    service.updateTask(widget.selectedDate, task);
                  },
                  onDelete: () {
                    service.deleteTask(widget.selectedDate, task.id!);
                  },
                );
              },
            );
          },
        ),
      ),

      floatingActionButton: AddButton(onPressed: addTask),
    );
  }
}
