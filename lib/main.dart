import 'package:dawat_dhaba/controllers/page_controller.dart';
import 'package:dawat_dhaba/firebase_options.dart';
import 'package:dawat_dhaba/shared_pref.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SharedPreferencesHelper.init();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return const GetMaterialApp(
      title: 'Dawat Dhaba',
      debugShowCheckedModeBanner: false,
      home: SwipeController(),
    );
  }
}
