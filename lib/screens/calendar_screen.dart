import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';
import 'package:tasks/models/task.dart';
import 'package:tasks/services/task_service.dart';
import 'package:tasks/widgets/task_item.dart';

class CalendarScreen extends StatefulWidget {
  const CalendarScreen({super.key});

  @override
  State<CalendarScreen> createState() => _CalendarScreenState();
}

class _CalendarScreenState extends State<CalendarScreen> {
  DateTime _selectedDate = DateTime.now();

  @override
  Widget build(BuildContext context) {
    final taskService = Provider.of<TaskService>(context);

    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          FutureBuilder<List<Task>>(
            future: taskService.getTasksForDate(_selectedDate),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const SizedBox(
                  height: 300,
                  child: Center(child: CircularProgressIndicator()),
                );
              }

              if (snapshot.hasError) {
                return SizedBox(
                  height: 300,
                  child: Center(child: Text('Error: ${snapshot.error}')),
                );
              }

              final tasks = snapshot.data ?? [];

              return SizedBox(
                height: 300,
                child: SfCalendar(
                  view: CalendarView.month,
                  initialDisplayDate: _selectedDate,
                  onTap: (calendarTapDetails) {
                    if (calendarTapDetails.targetElement == CalendarElement.calendarCell) {
                      setState(() {
                        _selectedDate = calendarTapDetails.date!;
                      });
                    }
                  },
                  monthViewSettings: const MonthViewSettings(
                    showAgenda: true,
                    agendaViewHeight: 100,
                  ),
                  dataSource: TaskDataSource(tasks),
                ),
              );
            },
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            child: Text(
              'Tasks for ${DateFormat('MMM dd, yyyy').format(_selectedDate)}',
              style: Theme.of(context).textTheme.titleLarge,
            ),
          ),
          Expanded(
            child: FutureBuilder<List<Task>>(
              future: taskService.getTasksForDate(_selectedDate),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                }

                if (snapshot.hasError) {
                  return Center(child: Text('Error: ${snapshot.error}'));
                }

                final tasks = snapshot.data ?? [];

                if (tasks.isEmpty) {
                  return Center(
                    child: Text(
                      'No tasks for this day',
                      style: Theme.of(context).textTheme.bodyLarge,
                    ),
                  );
                }

                return ListView.builder(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  itemCount: tasks.length,
                  itemBuilder: (context, index) {
                    final task = tasks[index];
                    return Padding(
                      padding: const EdgeInsets.only(bottom: 12),
                      child: TaskItem(task: task),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

class TaskDataSource extends CalendarDataSource {
  TaskDataSource(List<Task> tasks) {
    appointments = tasks;
  }

  @override
  DateTime getStartTime(int index) {
    return appointments![index].dueDate;
  }

  @override
  DateTime getEndTime(int index) {
    return appointments![index].dueDate.add(const Duration(hours: 1));
  }

  @override
  String getSubject(int index) {
    return appointments![index].title;
  }

  @override
  Color getColor(int index) {
    return appointments![index].isCompleted ? Colors.green : Colors.blue;
  }
}
