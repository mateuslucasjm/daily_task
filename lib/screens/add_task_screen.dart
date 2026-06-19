import 'package:flutter/material.dart';

import '../models/task.dart';
import '../services/task_service.dart';
import '../theme/app_colors.dart';

class AddTaskScreen extends StatefulWidget {
  final DateTime selectedDate;

  const AddTaskScreen({super.key, required this.selectedDate});

  @override
  State<AddTaskScreen> createState() => _AddTaskScreenState();
}

class _AddTaskScreenState extends State<AddTaskScreen> {
  final TextEditingController _controller = TextEditingController();

  void _addTask() async {
    final text = _controller.text.trim();

    if (text.isEmpty) return;

    final taskService = TaskService();

    await taskService.addTask(widget.selectedDate, Task(title: text));

    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,

      appBar: AppBar(
        backgroundColor: AppColors.background,
        elevation: 0,
        iconTheme: const IconThemeData(color: AppColors.textPrimary),
        centerTitle: true,
        toolbarHeight: 90,
        title: const Padding(
          padding: EdgeInsets.only(top: 12),
          child: Text(
            'Nova Tarefa',
            style: TextStyle(
              fontSize: 28,
              fontWeight: FontWeight.bold,
              color: Color(0xFF448AFF),
            ),
          ),
        ),
      ),

      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              decoration: BoxDecoration(
                color: AppColors.card,
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.05),
                    blurRadius: 10,
                    offset: const Offset(0, 5),
                  ),
                ],
              ),
              child: TextField(
                controller: _controller,
                maxLines: 10,
                decoration: const InputDecoration(border: InputBorder.none),
                style: const TextStyle(fontSize: 16),
              ),
            ),

            const SizedBox(height: 25),

            SizedBox(
              width: double.infinity,
              height: 55,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primary,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                  elevation: 6,
                ),
                onPressed: _addTask,
                child: const Text(
                  'Adicionar tarefa',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
