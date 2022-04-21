import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:sibhat_tiktok/constants.dart';
import 'package:sibhat_tiktok/controllers/auth_controller.dart';
import 'package:sibhat_tiktok/views/screens/auth/add_video_screen.dart';
import 'package:sibhat_tiktok/views/screens/auth/home_screen.dart';
import 'package:sibhat_tiktok/views/screens/auth/login_screen.dart';
import 'package:sibhat_tiktok/views/screens/auth/signup_screen.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:get/get.dart';
import 'package:sibhat_tiktok/views/screens/auth/vidoe_screen.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp().then((value) {
    Get.put(AuthController());
  });
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'TikTok Clone',
      theme: ThemeData.dark().copyWith(
        scaffoldBackgroundColor: backgroundColor,
      ),
      home:HomeScreen(),
    );
  }
}
