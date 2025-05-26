import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../res/widgets/date_selector.dart';
import '../../res/widgets/expandable_text.dart';
import '../../res/widgets/experience.dart';
import '../../res/widgets/time_slot_grid.dart';
import '../../view_models/lab_vm/lab_vm.dart';


class AppointmentScreen extends StatefulWidget {
  final String name;
  final String speciality;

  const AppointmentScreen(this.name, this.speciality ,{super.key});

  @override
  State<AppointmentScreen> createState() => _AppointmentScreenState();
}

class _AppointmentScreenState extends State<AppointmentScreen> {

  final TimeSlotController timeController = Get.put(TimeSlotController());

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(title: Text('Appointment'), centerTitle: true),
      body: SafeArea(
        child: Padding(
          padding:  EdgeInsets.symmetric(horizontal: width*0.05),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Center(
                  child: CircleAvatar(
                    radius: 50,
                    backgroundImage: AssetImage('assets/images/mi.jpeg'),
                  ),
                ),
                SizedBox(height: height * 0.01),
                Text(widget.name, style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold
                )),
                Text(widget.speciality,style: TextStyle(
                    fontSize: 16
                ),),

                SizedBox(
                  height: height*0.02,
                ),

                Container(
                  height: height * 0.12,
                  decoration: BoxDecoration(
                      color: Color(0XFF234F68),
                      borderRadius: BorderRadius.circular(30)
                  ),
                  child: Stack(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          // First Box
                          Center(
                              child:Experience('350+', 'Patients',Color(0XFF8A96BC),Color(0XFFB28CFF))
                          ),

                          // Second Box
                          Experience('15+', 'Exp. years', Color(0XFF8A96BC), Color(0XFF9DEAC0)),

                          // Third Box
                          Experience('284+', 'Reviews', Color(0XFF8A96BC), Color(0XFFFF9A9A)),
                        ],
                      )
                    ],
                  ),
                ),

                Row(mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    SizedBox(
                      width: width*0.02,
                    ),
                    SizedBox(
                      height: height*0.05,
                    ),
                    Text('About Doctor',style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold
                    ),)
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    SizedBox(
                      width: width*0.02,
                    ),
                    ExpandableText(
                      text: "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Praesent varius magna at libero facilisis accumsan. Sed eu dolor ac nisi tempus convallis vitae. Etiam ultricies magna at mauris facilisis, ac tempor ipsum sollicitudin. Pellentesque habitant morbi tristique senectus et netus et malesuada fames ac turpis egestas.",
                      style: TextStyle(
                        fontSize: 16.0,
                        height: 1.5,
                        color: Colors.black87,
                      ),
                      maxLines: 3,
                    ),
                  ],
                ),

                SizedBox(
                  height: height*0.01,
                ),

                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    SizedBox(
                      width: width*0.02,
                    ),
                    Text('Schedules',style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 22
                    ),),
                  ],
                ),
                SizedBox(
                  height: height*0.01,
                ),
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      DateSelector(
                        defaultColor: Colors.white,
                        selectedColor: Color(0xFF234F68),
                        onDateSelected: (selectedDate) {
                          timeController.setSelectedDate(selectedDate);

                        },
                      )

                    ],
                  ),
                ),

                SizedBox(
                  height:height*0.03 ,
                ),

                TimeSlotGrid(),

                SizedBox(
                  height: height*0.02,
                ),

                InkWell(
                  onTap: (){

                  },
                  child: Container(
                    height: height*0.06,
                    width: double.infinity,
                    decoration: BoxDecoration(
                        color: Color(0xFF8BC83F),
                        borderRadius: BorderRadius.circular(24)
                    ),
                    child: Center(
                      child: Text('Book Appointment',style: TextStyle(
                        color: Colors.white,
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                      ),),
                    ),
                  ),
                )


              ],
            ),
          ),
        ),
      ),
    );
  }
}





