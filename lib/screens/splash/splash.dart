import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:google_fonts/google_fonts.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    //double screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      body: Container(
        height: double.maxFinite,
        width: double.maxFinite,
        decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage("assets/dawat_bg.jpg"), fit: BoxFit.cover)),
        child: Stack(
          alignment: Alignment.center,
          children: [
            Positioned(
                top: screenHeight * 0.4,
                child: Animate(
                  child: Image.asset(
                    "assets/dawat_logo.png",
                    scale: 1.4,
                  ).animate().fadeIn(delay: Duration(seconds: 1),curve: Curves.easeInOut).shake(delay: Duration(seconds: 2),duration:Duration(milliseconds: 350)),
                )),
            Positioned(
                top: screenHeight * 0.6,
                child: Text("Dawat Dhaba",
                    style: GoogleFonts.dancingScript(
                        fontSize: 35,
                        fontWeight: FontWeight.w900,
                        color: Colors.brown[800])).animate().fadeIn(delay: Duration(seconds: 2))),
            Positioned(
                bottom: screenHeight * 0.095,
                child: Icon(
                  Icons.keyboard_double_arrow_up_outlined,
                  size: 35.0,
                  color: Colors.grey.shade800
                )),
            Positioned(
                bottom: screenHeight * 0.07,
                child: Icon(
                  Icons.keyboard_double_arrow_up_outlined,
                  size: 35.0,
                  color: Colors.grey.shade800
                )),
            Positioned(
                bottom: screenHeight * 0.05,
                child: Text(
                  "Swipe up to dine in",
                  style: TextStyle(fontSize: 15, fontWeight: FontWeight.w400,color: Colors.black87),
                ))
          ],
        ),
      ),
    );
  }
}
