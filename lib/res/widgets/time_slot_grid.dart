import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../view_models/lab_vm/lab_vm.dart';

class TimeSlotGrid extends StatelessWidget {
  final List<String> times = [
    "11:00 AM", "12:00 PM", "1:00 PM", "2:00 PM",
    "3:00 PM", "4:00 PM", "5:00 PM", "6:00 PM"
  ];

  final TimeSlotController controller = Get.find<TimeSlotController>();

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;

    return Obx(() {
      return Wrap(
        spacing: width * 0.03,
        runSpacing: height * 0.015,
        children: List.generate(times.length, (index) {
          final timeStr = times[index];
          final time = _stringToTimeOfDay(timeStr);
          final isSelected = controller.selectedTime.value?.hour == time.hour &&
              controller.selectedTime.value?.minute == time.minute;

          return GestureDetector(
            onTap: () {
              if (isSelected) {
                controller.selectedTime.value = null; // Deselect
              } else {
                controller.selectedTime.value = time; // Select
              }
            },
            child: Container(
              height: height * 0.045,
              width: width * 0.2,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                color: isSelected ? const Color(0xFF234F68) : Colors.grey[300],
              ),
              child: Center(
                child: Text(
                  timeStr,
                  style: TextStyle(
                    color: isSelected ? Colors.white : Colors.black,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ),
          );
        }),
      );
    });
  }

  TimeOfDay _stringToTimeOfDay(String timeStr) {
    final format = TimeOfDayFormat.a_space_h_colon_mm;
    final dateTime = TimeOfDay(
      hour: int.parse(timeStr.split(":")[0]) +
          (timeStr.contains("PM") && !timeStr.startsWith("12") ? 12 : 0),
      minute: int.parse(timeStr.split(":")[1].split(" ")[0]),
    );
    return dateTime;
  }
}
