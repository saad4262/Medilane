import 'package:flutter/material.dart';
import 'package:get/get.dart';

class TimeSlotController extends GetxController {
  Rx<TimeOfDay?> selectedTime = Rx<TimeOfDay?>(null);
  Rx<DateTime?> selectedDate = Rx<DateTime?>(null);

  // Simulate booked slots per date (Map of date string -> time strings)
  RxMap<String, List<String>> bookedSlots = <String, List<String>>{}.obs;

  void setSelectedDate(DateTime? date) {
    selectedDate.value = date;
    selectedTime.value = null; // reset time on new date
  }

  void selectTime(TimeOfDay time) {
    final dateKey = _dateKey();
    if (selectedTime.value == time) {
      selectedTime.value = null;
    } else {
      selectedTime.value = time;
      // Simulate storing booked slots if needed
      if (!bookedSlots.containsKey(dateKey)) {
        bookedSlots[dateKey] = [];
      }
      if (!bookedSlots[dateKey]!.contains(formatTime(time))) {
        bookedSlots[dateKey]!.add(formatTime(time));
      }
    }
  }

  bool isBooked(TimeOfDay time) {
    final dateKey = _dateKey();
    return bookedSlots[dateKey]?.contains(formatTime(time)) ?? false;
  }

  String formatTime(TimeOfDay time) {
    final hour = time.hourOfPeriod == 0 ? 12 : time.hourOfPeriod;
    final period = time.period == DayPeriod.am ? 'AM' : 'PM';
    return '$hour:00 $period';
  }

  String _dateKey() {
    final date = selectedDate.value;
    if (date == null) return '';
    return '${date.year}-${date.month}-${date.day}';
  }
}
