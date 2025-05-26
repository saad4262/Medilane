import 'package:flutter/material.dart';

class Experience extends StatelessWidget {
  final String integers;
  final String xyz;
  final Color integerColor;
  final Color xyzColor;
  const Experience(this.integers, this.xyz, this.xyzColor, this.integerColor, {super.key});

  @override
  Widget build(BuildContext context) {

    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;

    return Container(
      width: width*0.2,
      height: height*0.08,
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10)
      ),
      child: Column(
        children: [
          SizedBox(
            height: height*0.005,
          ),
          Text(integers,style: TextStyle(
            color: integerColor,
            fontSize: 26,
            fontWeight: FontWeight.bold,
          ),),
          Text(xyz,style: TextStyle(
              color: xyzColor,
              fontSize: 13
          ),)
        ],
      ),
    );
  }
}
