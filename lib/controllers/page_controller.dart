import 'package:dawat_dhaba/screens/home_page.dart';
import 'package:dawat_dhaba/screens/splash/splash.dart';
import 'package:flutter/material.dart';

class SwipeController extends StatefulWidget {
  const SwipeController({super.key});

  @override
  State<SwipeController> createState() => _SwipeControllerState();
}

class _SwipeControllerState extends State<SwipeController> {
  final _controller = PageController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        scrollDirection: Axis.vertical,
        controller:_controller,
        children: [
         SplashScreen(),
         HomePage(),
         //HomePage(),
        ],
      ),
    );
  }
}