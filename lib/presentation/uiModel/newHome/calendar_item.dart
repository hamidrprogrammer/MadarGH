import 'dart:ui';

class CalendarItem {
  final int id;
  final String name, assessment, date;
  Color color;

  CalendarItem({
    required this.id,
    required this.name,
    required this.assessment,
    required this.date,
    required this.color,
  });
}
