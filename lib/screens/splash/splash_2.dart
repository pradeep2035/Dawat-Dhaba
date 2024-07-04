import 'package:flutter/material.dart';

class Splash2 extends StatefulWidget {

  const Splash2({super.key});

  @override
  State<Splash2> createState() => _Splash2State();
}

class _Splash2State extends State<Splash2> {
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
   // double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      body: Container(
        height: double.maxFinite,
        width: double.maxFinite,
        child: Stack(
          children: [
            AnimatedPositioned(
              width: selected?screenWidth:80,
              height:selected?250:100,
              duration: Duration(seconds: 1),
              curve: Curves.fastEaseInToSlowEaseOut,
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