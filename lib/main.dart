import 'package:flutter/material.dart';
import 'package:formvalidation/views/screens/login_screen.dart';
import 'package:formvalidation/views/screens/sign_up_screen.dart';
import 'package:get/get.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(debugShowCheckedModeBanner: false,
    initialRoute: '/login_screen',
    getPages: [
      GetPage(name: '/login_screen', page: ()=> const LoginScreen()),
      GetPage(name: '/signup_screen', page: ()=> const SignUpScreen()),
    ],);
  }
}


