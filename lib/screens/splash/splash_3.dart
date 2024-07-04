import 'package:flutter/material.dart';

class Splash3 extends StatefulWidget {
  const Splash3({super.key});

  @override
  State<Splash3> createState() => _Splash3State();
}

class _Splash3State extends State<Splash3> {
  bool selected=false;

   @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      // Start the animation automatically when the page is displayed
      setState(() {
        selected = true;
      });
    });
  }
  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      body:
      Container(
        height: double.maxFinite,
        width: double.maxFinite,
        child: Stack(
          children: [
            AnimatedPositioned(
              width: selected?screenWidth:screenWidth,
              height:selected?screenHeight:250,
              duration: Duration(seconds:1),
              curve: Curves.fastOutSlowIn,
              child: Container(
                  decoration: BoxDecoration(
                    color: Colors.amber
                  ),
                ) ,
              )
          ],
        ),
      ),
    );
  }
}