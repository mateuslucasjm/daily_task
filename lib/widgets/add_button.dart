import 'package:flutter/material.dart';
import '../theme/app_colors.dart';

class AddButton extends StatelessWidget {
  final VoidCallback onPressed;

  const AddButton({super.key, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      backgroundColor: AppColors.primary,
      elevation: 6,
      onPressed: onPressed,
      child: const Icon(
        Icons.add,
        color: Colors.white,
      ),
    );
  }
}