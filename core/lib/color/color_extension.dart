import 'dart:ui';

extension ColorsExtension on String {
  Color toColor() {
   return Color(int.parse(substring(1, 7), radix: 16) + 0xFF000000);
  }
}
