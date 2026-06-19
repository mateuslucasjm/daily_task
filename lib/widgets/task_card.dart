import 'package:flutter/material.dart';

import '../models/task.dart';
import '../theme/app_colors.dart';

class TaskCard extends StatelessWidget {
  final Task task;
  final VoidCallback onToggle;
  final VoidCallback onDelete;

  const TaskCard({
    super.key,
    required this.task,
    required this.onToggle,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(12),
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
      child: Row(
        children: [
          Checkbox(
            value: task.completed,
            activeColor: AppColors.primary,
            onChanged: (_) => onToggle(),
          ),

          const SizedBox(width: 8),

          Expanded(
            child: Text(
              task.title,
              style: TextStyle(
                fontSize: 16,
                decoration: task.completed ? TextDecoration.lineThrough : null,
                color: task.completed ? Colors.grey : AppColors.textPrimary,
              ),
            ),
          ),

          // 🗑 BOTÃO DE EXCLUIR
          IconButton(
            icon: const Icon(Icons.delete, color: Colors.red),
            onPressed: onDelete,
          ),
        ],
      ),
    );
  }
}
