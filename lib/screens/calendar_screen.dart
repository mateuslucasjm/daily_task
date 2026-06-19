import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';

import '../services/auth_service.dart';
import '../theme/app_colors.dart';
import '../widgets/custom_button.dart';
import 'login_screen.dart';
import 'tasks_screen.dart';

class CalendarScreen extends StatefulWidget {
  const CalendarScreen({super.key});

  @override
  State<CalendarScreen> createState() => _CalendarScreenState();
}

class _CalendarScreenState extends State<CalendarScreen> {
  DateTime selectedDay = DateTime.now();
  DateTime focusedDay = DateTime.now();

  final AuthService _authService = AuthService();

  Future<void> _logout() async {
    await _authService.logout();

    if (!mounted) return;

    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (_) => const LoginScreen()),
      (route) => false,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        toolbarHeight: 90,
        title: const Padding(
          padding: EdgeInsets.only(top: 12),
          child: Text(
            'Calendário',
            style: TextStyle(
              fontSize: 28,
              fontWeight: FontWeight.bold,
              color: Color(0xFF448AFF),
            ),
          ),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(top: 8),
            child: IconButton(
              icon: const Icon(Icons.logout),
              tooltip: 'Sair',
              onPressed: _logout,
            ),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Container(
              decoration: BoxDecoration(
                color: AppColors.card,
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.08),
                    blurRadius: 20,
                    offset: const Offset(0, 10),
                  ),
                ],
              ),
              padding: const EdgeInsets.all(12),
              child: TableCalendar(
                locale: 'pt_BR',
                firstDay: DateTime(2024),
                lastDay: DateTime(2030),
                focusedDay: focusedDay,
                selectedDayPredicate: (day) => isSameDay(selectedDay, day),
                onDaySelected: (selected, focused) {
                  setState(() {
                    selectedDay = selected;
                    focusedDay = focused;
                  });
                },
                headerStyle: const HeaderStyle(
                  formatButtonVisible: false,
                  titleCentered: true,
                ),
                calendarStyle: const CalendarStyle(
                  selectedDecoration: BoxDecoration(
                    color: AppColors.primary,
                    shape: BoxShape.circle,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 30),
            CustomButton(
              text: "Selecionar o dia",
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => TasksScreen(selectedDate: selectedDay),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
