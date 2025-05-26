import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../media-queries/media_query.dart';

class DateSelectorController extends GetxController {
  RxnInt selectedIndex = RxnInt(); // Nullable reactive int

  void toggleDateSelection(int index) {
    if (selectedIndex.value == index) {
      selectedIndex.value = null; // Unselect if same index is clicked
    } else {
      selectedIndex.value = index; // Select new index
    }
  }
}

class DateSelector extends StatelessWidget {
  final Function(DateTime?)? onDateSelected;
  final Color defaultColor;
  final Color selectedColor;
  final DateSelectorController controller = Get.put(DateSelectorController());

  DateSelector({
    Key? key,
    this.onDateSelected,
    this.defaultColor = Colors.white,
    this.selectedColor = const Color(0xFF234F68),
  }) : super(key: key);

  final List<DateTime> dates = List.generate(5, (index) {
    final now = DateTime.now();
    return DateTime(now.year, now.month, now.day + index);
  });

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    final mediaQuery = MediaQueryHelper(context);


    return SizedBox(
      height: height * 0.09,
      width: mediaQuery.width(90),
      child: Obx(() => Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: List.generate(dates.length, (index) {
          final isSelected = controller.selectedIndex.value == index;
          final date = dates[index];

          return Expanded(
            child: GestureDetector(
              onTap: () {
                controller.toggleDateSelection(index);
                if (onDateSelected != null) {
                  // If unselected, pass null
                  onDateSelected!(
                      controller.selectedIndex.value != null ? date : null);
                }
              },
              child: DateBox(
                date: date,
                isSelected: isSelected,
                defaultColor: defaultColor,
                selectedColor: selectedColor,
              ),
            ),
          );
        }),
      )),
    );
  }
}

class DateBox extends StatelessWidget {
  final DateTime date;
  final bool isSelected;
  final Color defaultColor;
  final Color selectedColor;

  const DateBox({
    Key? key,
    required this.date,
    required this.isSelected,
    required this.defaultColor,
    required this.selectedColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    String dayName = DateFormat('EEE').format(date);
    String dayNumber = DateFormat('d').format(date);

    return Container(
      width: 65,
      margin: const EdgeInsets.symmetric(horizontal: 3),
      decoration: BoxDecoration(
        color: isSelected ? selectedColor : defaultColor,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: Colors.grey.withOpacity(0.3),
          width: 1,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            dayName,
            style: TextStyle(
              color: isSelected ? Colors.white : Colors.grey,
              fontWeight: FontWeight.w500,
              fontSize: 14,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            dayNumber,
            style: TextStyle(
              color: isSelected ? Colors.white : Colors.black87,
              fontWeight: FontWeight.bold,
              fontSize: 20,
            ),
          ),
        ],
      ),
    );
  }
}
