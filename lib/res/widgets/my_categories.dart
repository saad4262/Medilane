import 'package:flutter/material.dart';

class MyCategories extends StatelessWidget {
  final String imagePath;
  final String categoryName;
  const MyCategories(this.categoryName, this.imagePath , {super.key});

  @override
  Widget build(BuildContext context) {

    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;

    return Column(
      children: [
        Material(
          elevation: 3, // controls shadow depth
          borderRadius: BorderRadius.circular(30),
          color: Colors.transparent, // keeps background transparent, so Container's color shows
          child: Container(
              height: height * 0.085,
              width: width * 0.2,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(30),
              ),
              child: Center(child: Image.asset(imagePath,scale: 3,))
          ),
        ),
        SizedBox(
          height: height*0.01,
        ),
        Text(categoryName)
      ],
    );
  }
}
